From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] builtin/apply: get rid of useless 'name' variable
Date: Tue, 22 Mar 2016 14:20:42 -0700
Message-ID: <xmqq7fgugqfp.fsf@gitster.mtv.corp.google.com>
References: <1458680322-17681-1-git-send-email-chriscool@tuxfamily.org>
	<1458680322-17681-2-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 22:20:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiTjN-0002yj-PX
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 22:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbcCVVUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 17:20:46 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751368AbcCVVUp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 17:20:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1128E4F745;
	Tue, 22 Mar 2016 17:20:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wo/Jgcyd4s9iNLzZX9agYvO08k0=; b=yMFjll
	pScYnoFkxiNHQo6FBueT1uD5u7GGfnfpHs7ILw0YpgeNjZE/vmqaGsNAXgN+VuyT
	+ixpgBnctozxfvciQVjdLBRo4OG+t+cDJQs8MDzfgk1J/0IM3rZLN1jhbxdzK8Nf
	2AmR4D3uZvLrNOkWrbj9cxuR8NEMNoFkhEqOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fMDnISsoyHRStGAOGQzi4hNWl1rfih2p
	G6VCuOn71jchoQNuMyH8h5qABO2sq6pt0L3p2Hb3iLIDf1zY5GyGQGMs0Lb+AKb3
	hyqCSs9B4IdOFHVHbY6WXBQfpvD6uWXO8MenciFhXRmduyrlW5qHCS8f97ie69tK
	+3+nj7FN+rI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 07D284F744;
	Tue, 22 Mar 2016 17:20:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7A6F34F743;
	Tue, 22 Mar 2016 17:20:43 -0400 (EDT)
In-Reply-To: <1458680322-17681-2-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Tue, 22 Mar 2016 21:58:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EF866D6C-F073-11E5-A960-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289564>

Christian Couder <christian.couder@gmail.com> writes:

> While at it put an 'else' on the same line as the previous '}'.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 42c610e..465f954 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -931,22 +931,19 @@ static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name,
>  		return find_name(line, NULL, p_value, TERM_TAB);
>  
>  	if (orig_name) {
> -		int len;
> -		const char *name;
> +		int len = strlen(orig_name);
>  		char *another;
> -		name = orig_name;
> -		len = strlen(name);
>  		if (isnull)
> -			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"), name, linenr);
> +			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
> +			    orig_name, linenr);
>  		another = find_name(line, NULL, p_value, TERM_TAB);
> -		if (!another || memcmp(another, name, len + 1))
> +		if (!another || memcmp(another, orig_name, len + 1))
>  			die((side == DIFF_NEW_NAME) ?
>  			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
>  			    _("git apply: bad git-diff - inconsistent old filename on line %d"), linenr);
>  		free(another);
>  		return orig_name;
> -	}
> -	else {
> +	} else {
>  		/* expect "/dev/null" */
>  		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
>  			die(_("git apply: bad git-diff - expected /dev/null on line %d"), linenr);

Looks correct; back when 1e3f6b6e (git-apply: more consistency
checks on gitdiff filenames, 2005-05-23) introduced this function,
the variable "name" was in the outer scope, and a subsequent update
narrowed its scope at ea56188a (Update git-apply to use C-style
quoting for funny pathnames., 2005-10-16) but it could have removed
the variable at the same time.
