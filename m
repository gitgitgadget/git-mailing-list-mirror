From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GIT-VERSION-GEN: Do not require tags to be annotated
Date: Fri, 06 Sep 2013 14:40:41 -0700
Message-ID: <xmqqeh91wrvq.fsf@gitster.dls.corp.google.com>
References: <522A36AA.3050701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 23:40:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI3lv-0007Cj-9B
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 23:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855Ab3IFVkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 17:40:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40577 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758Ab3IFVks (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 17:40:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5285E3FEEB;
	Fri,  6 Sep 2013 21:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E2duB6Ic8G5R2x27dVMMj3Rj39w=; b=izNGjn
	jOVN92on30uEgbmWF4/bV2L0Q/DjarsmOpx+ERfVE6dpgHBnKNlmJemKNpEhuizO
	A/vqraxq8zM+AUvG6TSCiPtHgP2euCaLiE7xZH5XRBkzqkVvUwwvS87B5Ia40Awu
	beL/9OKVleyMDs5bSQhlEVot62y1sOn33lKSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BQF01kv6bQJlNcG2x5j2GCS1B7xLL3ma
	fGMZNHbX7Fsl/W/TYxS6sz3s9UzYn8XrL+23tEScaKYGgueF3PdvA0FpF4gXt5sL
	6Hc4c60EKbMmxvF69rkns5TXC3OsMFb6fqollFODCFP1mpHso7zmqvn9TVDfwOHF
	3/IRFXJxwKI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 126053FEE9;
	Fri,  6 Sep 2013 21:40:47 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 357E33FEE5;
	Fri,  6 Sep 2013 21:40:44 +0000 (UTC)
In-Reply-To: <522A36AA.3050701@gmail.com> (Sebastian Schuberth's message of
	"Fri, 06 Sep 2013 22:10:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FBFFE5A4-173C-11E3-9F3C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234099>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> For custom builds of Git it sometimes is inconvenient to annotate tags
> because there simply is nothing to say, so do not require an annotation.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---

Hmmmm, personally I'd actually want this to stay the way it is, or
even require a valid signed tag, in order to make sure I won't
mistakenly creating a lightweight tag.

If you want to give build a custom name,

    echo buildname >version

should be sufficient, no?

I dunno.


>  GIT-VERSION-GEN | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index b444c18..68b61e3 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -12,7 +12,7 @@ if test -f version
>  then
>  	VN=$(cat version) || VN="$DEF_VER"
>  elif test -d ${GIT_DIR:-.git} -o -f .git &&
> -	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
> +	VN=$(git describe --tags --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
>  	case "$VN" in
>  	*$LF*) (exit 1) ;;
>  	v[0-9]*)
