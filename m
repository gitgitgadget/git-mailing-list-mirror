Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C533C200E0
	for <e@80x24.org>; Thu, 29 Dec 2016 09:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbcL2J1k (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 04:27:40 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36290 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbcL2J1j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 04:27:39 -0500
Received: by mail-qk0-f175.google.com with SMTP id n21so261768711qka.3
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 01:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KX8Dru//zJHVmTriHzodxt5N+zupgHuqD8oc50GInaI=;
        b=W1WW8BdphG0f5bEstKeZIvEN+Dn+wKQf6fOkA1vHNPF9GBUQzO5cnrlp8mhHetmBPd
         iSxt1ojSSoM6bf0uUa8nIRtuD7L77T4XjlyILM1lrEUl5OUnUT98M6qmS6SGuzueCJHi
         +pQUo70cPwrOR7lHIHJgNQ6EMbV/jsWOU88cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KX8Dru//zJHVmTriHzodxt5N+zupgHuqD8oc50GInaI=;
        b=XgIEHeB9c7UtmAouLnLHYbf/hz1yUrEOn/JGjSvJAbzfRI4Vl6VkBU/FEhP+WeFYyP
         EHxGGSPjeEFF8ovhTDDOVPFwZy/R9jpjscWrGXTETPLMwvXYQU7Q4LKnY5dhIjDvzVn4
         4TchvmgxCSgNFYrCuRMmKF7QeCKWYtxCmnSiLKpHpHGVnYvczIfyrsZ2Mr74/Owbd9i0
         PigigdcUi/bUEmdeTpTB1Uk2Rn+ivsL1Yfx4wxuryM7URun+I5ygK7lu4sfmfg/YG3pH
         mAXz0W8tKh4ugiPYYYpvKjZiMffXB1QLDbd6frK/rW1P54KXE0evWNJ9gDsMtjI3UrC7
         Pvcg==
X-Gm-Message-State: AIkVDXJcWbOhWXwJE6sORx2aSepVtqdfmGfEidkMzw4b5JkbaGoUvtnlTAFkxQFZ994cQqGdZQMyh/Zg9T+gow==
X-Received: by 10.55.112.65 with SMTP id l62mr45076319qkc.76.1483003228023;
 Thu, 29 Dec 2016 01:20:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.111 with HTTP; Thu, 29 Dec 2016 01:20:27 -0800 (PST)
In-Reply-To: <20161229090533.4717-1-igorkuo@gmail.com>
References: <20161229090533.4717-1-igorkuo@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Thu, 29 Dec 2016 09:20:27 +0000
Message-ID: <CAE5ih78HgKMOgXC82eTC3j-ehLmPXmNd0jQPJLcZebFXhWxOLQ@mail.gmail.com>
Subject: Re: [PATCH] git-p4: do not pass '-r 0' to p4 commands
To:     Igor Kushnir <igorkuo@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Ori Rawlings <orirawlings@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29 December 2016 at 09:05, Igor Kushnir <igorkuo@gmail.com> wrote:
> git-p4 crashes when used with a very old p4 client version
> that does not support the '-r <number>' option in its commands.
>
> Allow making git-p4 work with old p4 clients by setting git-p4.retries to 0.
>
> Alternatively git-p4.retries could be made opt-in.
> But since only very old, barely maintained p4 versions don't support
> the '-r' option, the setting-retries-to-0 workaround would do.
>
> The "-r retries" option is present in Perforce 2012.2 Command Reference,
> but absent from Perforce 2012.1 Command Reference.

That looks like a good fix, thanks.

I feel sad for anyone still using 2012.1.

Luke


>
> Signed-off-by: Igor Kushnir <igorkuo@gmail.com>
> ---
>  Documentation/git-p4.txt | 1 +
>  git-p4.py                | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index bae862ddc..f4f1be5be 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -479,6 +479,7 @@ git-p4.client::
>  git-p4.retries::
>         Specifies the number of times to retry a p4 command (notably,
>         'p4 sync') if the network times out. The default value is 3.
> +       '-r 0' is not passed to p4 commands if this option is set to 0.
>
>  Clone and sync variables
>  ~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/git-p4.py b/git-p4.py
> index 22e3f57e7..e5a9e1cce 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -83,7 +83,9 @@ def p4_build_cmd(cmd):
>      if retries is None:
>          # Perform 3 retries by default
>          retries = 3
> -    real_cmd += ["-r", str(retries)]
> +    if retries != 0:
> +        # Provide a way to not pass this option by setting git-p4.retries to 0
> +        real_cmd += ["-r", str(retries)]
>
>      if isinstance(cmd,basestring):
>          real_cmd = ' '.join(real_cmd) + ' ' + cmd
> --
> 2.11.0
>
