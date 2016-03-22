From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] (exit 1) is silly
Date: Tue, 22 Mar 2016 09:16:31 -0700
Message-ID: <xmqq8u1ajxnk.fsf@gitster.mtv.corp.google.com>
References: <1458661671-3793-1-git-send-email-izaberina@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: izabera <izaberina@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 17:16:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiOz1-0001jP-2s
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 17:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbcCVQQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 12:16:36 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751365AbcCVQQe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 12:16:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5146E4EF5F;
	Tue, 22 Mar 2016 12:16:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qh+hV8uj7D289lJbboNcfHh9+8Q=; b=V+kZDV
	m3ubT8hIgBe6Q79Q1I6ZsHbyb0g7tQACKkWoCsJHbfSIPRZi4eXc94WI7RLcIKts
	4ICyfCHJHpxtq6iHyrt9/63SkntiUKU/8KXqpzIBEe/umRKehSC6PS05RxVRtQ+H
	d+AK2SSbiFPcBV/vN5208Y39OS9xxrVKQDZJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TmeFkdmwOT1icAGDaw5jy7vVEkOStJwH
	AEfebfmYy+Vsu5FrRy763U+Tw2QLNDlX91Zv5wC+VGhA4W3eLF0xtMwbb1Wz/Qk3
	2EBkgGPO4Dhzx97MFwdpBfuH4K3R2/SOry2Sd/oqVjsF5RO42kw+fSLm5OpRkjuJ
	qojQA2AukzM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 470804EF5E;
	Tue, 22 Mar 2016 12:16:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9EB974EF5D;
	Tue, 22 Mar 2016 12:16:32 -0400 (EDT)
In-Reply-To: <1458661671-3793-1-git-send-email-izaberina@gmail.com> (izabera's
	message of "Tue, 22 Mar 2016 16:47:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 712BF240-F049-11E5-BDF3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289513>

izabera <izaberina@gmail.com> writes:

> Signed-off-by: izabera <izaberina@gmail.com>
> ---
>  GIT-VERSION-GEN | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index b5072a2..17b6ef4 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -14,7 +14,7 @@ then
>  elif test -d ${GIT_DIR:-.git} -o -f .git &&
>  	VN=$(git describe --match "v[0-9]*" --abbrev=7 HEAD 2>/dev/null) &&
>  	case "$VN" in
> -	*$LF*) (exit 1) ;;
> +	*$LF*) false ;;
>  	v[0-9]*)
>  		git update-index -q --refresh
>  		test -z "$(git diff-index --name-only HEAD --)" ||

IMO, this is such a minor thing that once it _is_ in the tree, it's
not really worth the patch noise to go and fix it up.
