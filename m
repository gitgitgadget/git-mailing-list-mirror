From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] rev-list: refuse --first-parent combined with --bisect
Date: Sun, 8 Mar 2015 17:58:24 -0400
Message-ID: <CAPig+cROEyWvJDW7uf1D7owdL-FwLHMtEBwWSNwS1M=vMcozLQ@mail.gmail.com>
References: <1425824339-8036-1-git-send-email-me@ikke.info>
	<1425827005-9602-1-git-send-email-me@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Sun Mar 08 22:58:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUjDS-0003AO-Gx
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 22:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbbCHV60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 17:58:26 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:37392 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbbCHV6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 17:58:25 -0400
Received: by yks20 with SMTP id 20so1037435yks.4
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uWKgkkbR96uDUnDB1XAmkjRf9KYrOCo/SlSxwoFfIao=;
        b=QsP6MD4kwNAgA7rWBTlplexLynes55zKE8rYVnnNvNqBTfXkaiSowUYWR+ZZKlxQgx
         cM80Q7rD2a5iz6rYgxfu2NgpfaH6ExDzu3yENl27EphdCPteF03Le2LnFwV1sYRwZ56c
         g+ubnd0eT6Gi4hGo/5hH/SiLcSKBbQ33FYQOv19K5/ytHMA501Hlox+F1kX+06oaTHc2
         fugoZIiMVVhG0z65i7hKlqtXfKZOvxWGU7/vyeUvsS/i1EkZg82vUmhgh3N8i4qLqQDv
         tHyCH+Nk7yQMPH5STOxGHCF+B+0Qz7kDpfa4hqVmsugUx6TIwIxESgxR6uJqcjuh448X
         tKNg==
X-Received: by 10.236.63.6 with SMTP id z6mr24359606yhc.65.1425851904725; Sun,
 08 Mar 2015 14:58:24 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 8 Mar 2015 14:58:24 -0700 (PDT)
In-Reply-To: <1425827005-9602-1-git-send-email-me@ikke.info>
X-Google-Sender-Auth: 0d3MHw8yodLdga7Nb_fwI6sh7FI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265111>

On Sun, Mar 8, 2015 at 11:03 AM, Kevin Daudt <me@ikke.info> wrote:
> rev-list --bisect is used by git bisect, but never together with
> --first-parent. Because rev-list --bisect together with --first-parent
> is not handled currently, and even leads to segfaults, refuse to use
> both options together.
>
> Signed-off-by: Kevin Daudt <me@ikke.info>
> Suggested-by: Junio C. Hamano <gitster@pobox.com>

It's customary for your sign-off to be last.

> ---
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 4ed8587..05c3f6d 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -123,7 +123,8 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
>         because merges into a topic branch tend to be only about
>         adjusting to updated upstream from time to time, and
>         this option allows you to ignore the individual commits
> -       brought in to your history by such a merge.
> +       brought in to your history by such a merge. Cannot be
> +       combined with --bisect.

A couple questions:

Should the documentation for ---bisect be updated to mention this
restriction also?

Should this change be protected by a "ifndef::git-rev-list[]" as are
all other mentions of "bisect" in rev-list-options.txt?

>  --not::
>         Reverses the meaning of the '{caret}' prefix (or lack thereof)
