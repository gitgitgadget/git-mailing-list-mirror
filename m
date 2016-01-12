From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Tue, 12 Jan 2016 10:47:25 -0800
Message-ID: <xmqqtwmitz2a.fsf@gitster.mtv.corp.google.com>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601120939270.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:47:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ3yf-0003z2-H3
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 19:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761829AbcALSr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 13:47:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751820AbcALSr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 13:47:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F337339D60;
	Tue, 12 Jan 2016 13:47:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W9FeHQhnrnDOfnYG9GmC/K82kBw=; b=DlidVr
	beeW6OxmNaSj9XX7Jpv0t1pFZEC/T/0pun2h3oqcwR+dJLOAhZh/7wackYoTK7JY
	Udy5yVcaYPlr7Dyx4uKKzMb+cg/iSaHGUT8v5Wl5pkn3DA2OEuW9RMXwHlMEYKFf
	AeLRLJ4E4O1zLJzwjV25vRtfZop0ORP0GXULg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=It6ViGNB/+bHxuXm3h9ttxNNDnofO73O
	1osncZA2FaaO6+k0QNGbXWP+Lqut2WGUX1sDCk5oMBPmEiVBeX/KVZE0OmJC6NPJ
	LOi6ejBSHb4/wijzaaFdjUGnq2fkI/XhPuPLfobodxkl30JdNiW7v8zLmfGgUtfh
	F/EdaC38B2w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA7B339D5F;
	Tue, 12 Jan 2016 13:47:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8028C39D5E;
	Tue, 12 Jan 2016 13:47:26 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601120939270.2964@virtualbox> (Johannes
	Schindelin's message of "Tue, 12 Jan 2016 09:39:53 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ECC8D4E6-B95C-11E5-9896-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283836>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  Rerolled.
>>  Needs review.
>
> Actually, it waits for a re-roll ;-)

True.

I think strbuf_getline() that handles the payload as "text" without
having _crlf() suffix is an ideal endgame in the longer term, but I
do not think it is a good idea to do that as a flag-day change.  So
I am inclined not to change the function names around that feature
in this series.  Others can do the wholesale rename as a separate
follow-up topic when the tree is quiescent.

The other point "We prepared to be able to use line termination
other than LF and NUL, but in practice nobody uses other values, so
tighten the interface to clarify that we allow only these two
values" you raised is something I think should be done as a
preparatory step for this series, as the correctness of the series
depends heavily on that assumption that nobody ever uses any other
value than LF or NUL.  I am looking at it but haven't published any
progress yet.

Thanks.
