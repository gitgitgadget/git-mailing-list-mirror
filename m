From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] cat-file: add --follow-symlinks to --batch
Date: Fri, 8 May 2015 15:51:51 -0400
Message-ID: <CAPig+cQ2p439dtMwbUEpWdxFB4gf3iuaataab=ghJ6Jm1Snv6w@mail.gmail.com>
References: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
	<1431108819-6831-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 08 21:51:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqoJQ-0001Ih-Qh
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 21:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbbEHTvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 15:51:52 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34060 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbbEHTvv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 15:51:51 -0400
Received: by iedfl3 with SMTP id fl3so80067538ied.1
        for <git@vger.kernel.org>; Fri, 08 May 2015 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=H1hf0ORf1rUnebcR1DtmffKar9dfA3q4W9vjXxM3JcM=;
        b=QQYD/65/R2DYPuQJoD52WYTwOom8KvU0zIQELmrnsToh+pVxcc9RWKPyc5o7Nn13/C
         yJGB+rYZNRPAl6KLGxKzoQ6bP53hGTJfbrZStQQ894AX7YGfGzdDyawZzRY1oaJYuiOk
         6rS3RBNlgroc91/mHPdZwCBC79gh1x5+ymB7XuyfFx04b6iYr5UcZ2yVPs1u2E/sRJLA
         lAK2QRcdxpnANsf5kozyUfWR2Qkx01FmJIkAAmHPfulq+vTctHM7qcmvLKSCAR5Lpsjc
         KeLr6IVqpBw4aVAdIbhVGmi4YtAjb+MRv+IAI0iT3fS/9Ohivxoju66XXSyPPXtt9ThP
         uEdQ==
X-Received: by 10.107.3.163 with SMTP id e35mr7020365ioi.92.1431114711233;
 Fri, 08 May 2015 12:51:51 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 8 May 2015 12:51:51 -0700 (PDT)
In-Reply-To: <1431108819-6831-3-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: H-zesWx_HBfErTBKw_i9SI4EDZo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268653>

On Fri, May 8, 2015 at 2:13 PM,  <dturner@twopensource.com> wrote:
> This wires the in-repo-symlink following code through to the cat-file
> builtin.  In the event of an out-of-repo link, cat-file will print
> the link in a new format.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index df99df4..277af32 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -369,6 +377,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>                 OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
>                 OPT_SET_INT(0, "textconv", &opt,
>                             N_("for blob objects, run textconv on object's content"), 'c'),
> +               OPT_SET_INT(0, "follow-symlinks", &batch.follow_symlinks,
> +                       N_("Follow in-repo symlinks; report out-of-repo symlinks (requires --batch or --batch-check)"),
> +                           1),

Capitalization is not used for descriptions of the other options.

>                 { OPTION_CALLBACK, 0, "batch", &batch, "format",
>                         N_("show info and content of objects fed from the standard input"),
>                         PARSE_OPT_OPTARG, batch_option_callback },
