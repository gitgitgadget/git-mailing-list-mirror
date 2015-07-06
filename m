From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added ability to scip patch hunk with an empty filename.
Date: Mon, 06 Jul 2015 11:36:24 -0700
Message-ID: <xmqqy4ityvyv.fsf@gitster.dls.corp.google.com>
References: <1436202974-7624-1-git-send-email-evgen.druzhynin@gmail.com>
	<1436202974-7624-2-git-send-email-evgen.druzhynin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Evgen Druzhynin <evgen.druzhynin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 20:36:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCBG9-0004PA-36
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 20:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbbGFSgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 14:36:37 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35062 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbbGFSge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 14:36:34 -0400
Received: by igcqs7 with SMTP id qs7so16400663igc.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 11:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=CD5WxQ0U3jHt8RRKiL/6ZZ+c9fy3yC22TC1hLjzqT8Q=;
        b=NuEDWP8afhmJMt7iHAf+fsDyiWiALbHowbpMHZDrU1VASpqz9E8ioURjNaSPtbHzVu
         LdPXG2iKNMnvubj90H98IqQ3zaUeDegIqrlMALwLXzpuJxDwPeotCM9on3AzeiknhVSP
         ABFc+z2GKBhQKhqd55lL4pB4+nHKBoH4peJpmk2T5oHodnm+UDGsAUxw86lT8GM9Qaha
         vZDNHo47dZNiQ21QtAIXf7uv1/CISvuJbtoYpQ5WWqo11XhzeghFJRGsyks1cBp3BTJU
         Kzta4q/NDFWoVJsXqXYxwFLRo1UwX+pePTntVcyc1pYsnHZwM3APPLFJkQUGi2gOF9oa
         K3Mg==
X-Received: by 10.107.154.129 with SMTP id c123mr440331ioe.22.1436207794144;
        Mon, 06 Jul 2015 11:36:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id o140sm12952321ioe.27.2015.07.06.11.36.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 11:36:25 -0700 (PDT)
In-Reply-To: <1436202974-7624-2-git-send-email-evgen.druzhynin@gmail.com>
	(Evgen Druzhynin's message of "Mon, 6 Jul 2015 20:16:14 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273448>

Evgen Druzhynin <evgen.druzhynin@gmail.com> writes:

This space is for you to explain why it is a good idea to do this
change.  What problem does it solve, how often does that problem
appear, what other workarounds exist if any and why they are not
satisfactory, etc, etc?

> ---

Above this line, we would want you to sign-off your patch,
certifying that you read DCO (see Documentation/SubmittingPatches)
and you wrote it or otherwise have the right to pass it on as an
open-source patch.

>  builtin/apply.c | 16 +++++-----------
>  po/bg.po        | 15 ---------------
>  po/ca.po        | 15 ---------------
>  po/de.po        | 15 ---------------
>  po/fr.po        | 15 ---------------
>  po/git.pot      | 11 -----------
>  po/it.po        | 11 -----------
>  po/pt_PT.po     |  7 -------
>  po/ru.po        | 12 ------------
>  po/sv.po        | 16 ----------------
>  po/vi.po        | 12 ------------
>  po/zh_CN.po     | 11 -----------

We do not want anybody who is not doing the i18n/l10n to touch any
po/* files.  The i18n/l10n team will adjust their translations
accordingly when the code changes.

>  12 files changed, 5 insertions(+), 151 deletions(-)

> diff --git a/builtin/apply.c b/builtin/apply.c
> index 54aba4e..e4481b4 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1488,17 +1488,11 @@ static int find_header(const char *line, unsigned long size, int *hdrsize, struc
>  			int git_hdr_len = parse_git_header(line, len, size, patch);
>  			if (git_hdr_len <= len)
>  				continue;
> -			if (!patch->old_name && !patch->new_name) {
> -				if (!patch->def_name)
> -					die(Q_("git diff header lacks filename information when removing "
> -					       "%d leading pathname component (line %d)",
> -					       "git diff header lacks filename information when removing "
> -					       "%d leading pathname components (line %d)",
> -					       p_value),
> -					    p_value, linenr);
> -				patch->old_name = xstrdup(patch->def_name);
> -				patch->new_name = xstrdup(patch->def_name);
> -			}
> +
> +			/* pass this hunk if the filename length is zero */
> +			if (!patch->old_name && !patch->new_name) 
> +				return -1;				

Please explain why this is a good idea.

This can happen only when (1) the user gave too large a number to
the -p option or (2) the original patch was corrupt.  In either
case, we would want to stop and give the user a chance to correct
it, either by specifying the correct -p number, or editing the
corrupt patch to state the right path the patch applies to.
Silently dropping the patch is never a good thing to do, is it?

Thanks.
