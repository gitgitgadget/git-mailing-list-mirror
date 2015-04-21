From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Performance regression due to #33d4221: write_sha1_file: freshen existing objects
Date: Tue, 21 Apr 2015 10:05:26 -0700
Message-ID: <xmqqiocpif8p.fsf@gitster.dls.corp.google.com>
References: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
	<20150417140315.GA13506@peff.net>
	<CADoxLGOPXDgb0LBcSBm+xRDhbnGV_y-TXENyPV7oK_+KZzPKRQ@mail.gmail.com>
	<20150420195337.GA15447@peff.net>
	<xmqq1tjelg78.fsf@gitster.dls.corp.google.com>
	<20150420200956.GA16249@peff.net>
	<CADoxLGOdvJVgjRFrC81nM6A4=PRABSiL_EGOUtN7d-MAKXrzzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Stefan Saasen <ssaasen@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:05:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykbc6-0002Na-N1
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 19:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935AbbDURF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 13:05:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755938AbbDURF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 13:05:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CE7F49F58;
	Tue, 21 Apr 2015 13:05:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lAG1HDd/n7b1CvEwbm7c8ktwd6k=; b=NDVIpt
	r+1NFeYJUWG06draIS7PGPdkBLVorr8eDFMgVNjHXKfMFjRqlreiF0YzuWJGFrdC
	Cy5OJMtIzkeO6Z48K3NZBTjlkr65NuPyBZgr8aZizSC/ucdT+sxxVWrlZQLXNpMq
	thzC8AYO3VNW39YTI2rDkP+pbKzd/pjUDRIDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OB9dWAmvWHIdygfhb9Cjz/Vh+e+4UoQt
	0Ryx1FZNcdmm/1RDgR6q7o8QHYLjejorGgXEzOS+fLsOnIiEsdjK3ZGhYGOg0sEv
	kB4EN7TtVGwFrOQRd/cTVHfgtXK4MW+AsusWf+ezbXaCKwokVFf87T7Zu9sa6DzW
	QaBEfETyjEQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5498F49F57;
	Tue, 21 Apr 2015 13:05:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD82C49F55;
	Tue, 21 Apr 2015 13:05:27 -0400 (EDT)
In-Reply-To: <CADoxLGOdvJVgjRFrC81nM6A4=PRABSiL_EGOUtN7d-MAKXrzzg@mail.gmail.com>
	(Stefan Saasen's message of "Tue, 21 Apr 2015 11:49:33 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9BD87E82-E848-11E4-95A6-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267533>

Stefan Saasen <ssaasen@atlassian.com> writes:

> I've noticed Peff's patches on pu which suggest they will be available
> in git 2.5?

Being on 'pu' (or 'next' for that matter) is not a suggestion for a
change to appear in any future version at all, even though it often
means that it would soon be merged to 'master' and will be in the
upcoming release to be on 'next' in early part of a development
cycle.  Some larger topics would stay on 'next' for a few cycles.

> Do you Junio, have plans to merge them to maint (2.3.x) and/or next (2.4)?

The topic will hopefully be merged to 'master' after 2.4 final is
released end of this month, down to 'maint' early May and will ship
with 2.4.1, unless there is unforeseen issues discovered in the
change while people try it out while it is in 'next' (which will
happen today, hopefully).
