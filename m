From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/19] teach remote-testgit to import non-HEAD refs
Date: Wed, 08 Jun 2011 16:48:23 -0700
Message-ID: <7vei3328c8.fsf@alter.siamese.dyndns.org>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-5-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 01:48:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUSUO-0005hp-T9
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 01:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663Ab1FHXsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 19:48:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab1FHXsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 19:48:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C7C050B9;
	Wed,  8 Jun 2011 19:50:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LRvF43WrY+vELk/zm87QzoMFK3U=; b=n9R6aR
	yBgOrzRW3JL+gdEt3c+O6QfbBaSKS5DqY1+MRonxf2Y91Y6z+SgxmniXTzYF2212
	mIKPT9deh9+iNcDsSF1BOO1nfw/eifLcphlRh5E/PGkuxGdDsagrsx5M78wTBMuX
	Z1XxwSTUQ8PrHf2U+J5Egd0Vu1Ian8XeIxsZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mVx0ri919I5qcbyZkB1mTXirGUM8pzUS
	XH80Agto8Y6YD5ala7H0bxJv0xXbwKtefoB0bQTli8VnAUpk2a7QILbDtH4H6krl
	Je64xUAOr70s19Dm0atOfWJlPaDqyU7ER4Q1yhVqgl0vaS7l6TH8OQn9Rz8cbzZi
	a3Gs/a7ajTo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BD57350B6;
	Wed,  8 Jun 2011 19:50:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E6FA650B5; Wed,  8 Jun 2011
 19:50:33 -0400 (EDT)
In-Reply-To: <1307558930-16074-5-git-send-email-srabbelier@gmail.com> (Sverre
 Rabbelier's message of "Wed, 8 Jun 2011 20:48:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E5CEFBA-922A-11E0-A36D-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175474>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> Upon receiving an "import" command, the testgit remote
> helper would ignore the ref asked for by git and generate a
> fast-export stream based on HEAD. Instead, we should
> actually give git the ref it asked for.
>
> This requires adding a new parameter to the export_repo
> method in the remote-helpers python library, which may be
> used by code outside of git.git. We use a default parameter
> so that callers without the new parameter will get the same
> behavior as before.
>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
>
>   Unchanged from Peff's series.

This seems to be slightly different from what was sent to the list,
though.  Using refs=None as default and assigning ["HEAD"] is more in line
with the standard Python practice, so the implementation is better.

But "do we still append HEAD after --import-marks?" still stands.
