From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-receive-email: suppress error if description file
 missing
Date: Wed, 02 Feb 2011 10:36:43 -0800
Message-ID: <7vbp2uxozo.fsf@alter.siamese.dyndns.org>
References: <20110202174242.GA12470@atcmail.atc.tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Hemmecke <hemmecke@gmail.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 19:37:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkhZo-0000Ob-3j
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 19:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab1BBSgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 13:36:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab1BBSgy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 13:36:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 610052863;
	Wed,  2 Feb 2011 13:37:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R8zusJ1/KRA/2hPwtM/xgXFlWJw=; b=tiVU6K
	8880KgE5ZmnbaH0gqfnC+7CNHxoUBD7cnXXvLyJf1GLuBussZFfhsgxSfTwTIOu9
	OXTuzukaqJWvCMN2Y1Lz37IxZKhcElXOMmbDQWs7XA3r0YeTChPzM6ySA36SQ/Pp
	tESazKqKwUR/xjVAJ2P26x0oUNEr9ysdl8Yzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=idxVizE3lCBHWiJsJW43GtVq/ZVVrtrJ
	ba0lY2lPhDInlrAdEHENTZ+wsp8bCSwC+OwoU+m0In/ogbYu0kyjDkQ3lFusxDEY
	C4FOGoesd1qW53Eqw9TKHVi//A+JIzjX1sIJHiqsR5D303Qpi3MECPdC82SBi4eE
	kXiv/mdfEs8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 317552862;
	Wed,  2 Feb 2011 13:37:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 216EF2860; Wed,  2 Feb 2011
 13:37:38 -0500 (EST)
In-Reply-To: <20110202174242.GA12470@atcmail.atc.tcs.com> (Sitaram Chamarty's
 message of "Wed\, 2 Feb 2011 23\:12\:42 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8572560A-2EFB-11E0-AA2A-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165924>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> ---
>  contrib/hooks/post-receive-email |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> index f99ea95..71f2b47 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -709,7 +709,7 @@ if [ -z "$GIT_DIR" ]; then
>  	exit 1
>  fi
>  
> -projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
> +projectdesc=$(sed -ne '1p' "$GIT_DIR/description 2>/dev/null")

I suspect that you would want to have the redirection outside the dq pair,
but other than that, well spotted.

You forgot to sign-off, though ;-)

>  # Check if the description is unchanged from it's default, and shorten it to
>  # a more manageable length if it is
>  if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
> -- 
> 1.7.3.4
