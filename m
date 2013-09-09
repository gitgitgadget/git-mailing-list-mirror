From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] version-gen: cleanup
Date: Sun, 08 Sep 2013 23:03:45 -0700
Message-ID: <7vppsiila6.fsf@alter.siamese.dyndns.org>
References: <1378702889-21638-1-git-send-email-felipe.contreras@gmail.com>
	<1378702889-21638-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 08:03:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIuZl-0005Zr-OD
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 08:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919Ab3IIGDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 02:03:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795Ab3IIGDt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 02:03:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5DEE3A5D1;
	Mon,  9 Sep 2013 06:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TkqTTTYeLB5V8nyKL1dKLN7lD68=; b=UoMlml
	UqJ9XQ07LSaPrT1mUelKKx8Cc5s2Un8Vis2X3iPZyKeUMo4DuU2Ra3gD2R9TwTF7
	rLhx2Xvyo4+RgJ3PEM1WSiOFbfe3GgNKWVCCjXfvdccxwScHquYLHR7g/a2jd3iv
	0UUESu8o+a9AZ165ecScxZQbVHdKAUUY/s9pU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lnvqZjg56MNHLOgjwE7MU0/XsM06XQbW
	+DEUDczREJWQMWyWiCBcxiT0Yw1ltPczVIybe5yVEvpC05RFOOAb+PlRSJGIU5gO
	o01L2DFj7N9LMF9v7RGGOl3sGUmE0p3T3A3o4gR9sKoPXOUwW3h7RkwNjsI4KdB8
	m+8them9EcA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C801D3A5D0;
	Mon,  9 Sep 2013 06:03:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F7B13A5CC;
	Mon,  9 Sep 2013 06:03:47 +0000 (UTC)
In-Reply-To: <1378702889-21638-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 9 Sep 2013 00:01:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9756F824-1915-11E3-A9F5-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234314>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> No functional changes.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  GIT-VERSION-GEN | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 06026ea..b0db139 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -7,21 +7,24 @@ LF='
>  '
>  
>  # First see if there is a version file (included in release tarballs),
> -# then try git-describe, then default.
> +# then try 'git describe', then default.
>  if test -f version
>  then
>  	VN=$(cat version) || VN="$DEF_VER"
>  elif test -d ${GIT_DIR:-.git} -o -f .git &&
> -	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
> +	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null)
> +then
>  	case "$VN" in
> -	*$LF*) (exit 1) ;;
> +	*$LF*)
> +		exit 1

The funnily written "false" is misleading and a clean-up may be a
good idea to turn it to a straight "false".

I however think this actually changes the behaviour.

In any case, if you want to keep this step a "no functional change"
rewrite, this section has to be part of the condition of this "elif"
(because it logically is).  If describe couldn't describe HEAD, or
even if it could, if its output was multi-line for any reason, we
wanted to punt and let the DEF_VER in the last "else" clause kick
in.

After the update, describe output that is not a single-liner will
fail the entire script, instead of falling back to DEF_VER.  I
actually think it is a good change to fail it (even though it is
unlikely that the "describe" command give above would give more than
one line).

> +		;;
>  	v[0-9]*)
>  		git update-index -q --refresh
>  		test -z "$(git diff-index --name-only HEAD --)" ||
> -		VN="$VN-dirty" ;;
> +		VN="$VN-dirty"
> +		;;
>  	esac
> -then
> -	VN=$(echo "$VN" | sed -e 's/-/./g');
> +	VN=$(echo "$VN" | sed -e 's/-/./g')
>  else
>  	VN="$DEF_VER"
>  fi
