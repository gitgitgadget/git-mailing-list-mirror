Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52FA91F461
	for <e@80x24.org>; Sat, 22 Jun 2019 15:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfFVPDf (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 11:03:35 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33509 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVPDf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 11:03:35 -0400
Received: by mail-vs1-f68.google.com with SMTP id m8so5787824vsj.0
        for <git@vger.kernel.org>; Sat, 22 Jun 2019 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1IEs5z7JHb4Cbcqw4HtGCi+kh7B16HGnfde5tUBYSsE=;
        b=daadLt/JDRLtHC4CWQ/fNC+3ljeJikYYBSFKJ46hWFuBBEr/SVTno8+JAVQCExJMcJ
         4HEs4Pce8J+RWcrTiHVL8fie28X29p3s6xg6gA5346LlHRqCQWb3N7jK7xGZLFx24Y9V
         eoHjYreJuJgSStBTM8SdB9+KMq5FZSyvggTJHDltfrsd3DQwR3ogl0nCLUTY8vApoyKT
         ne1zyW0KcUX189nNLsqYQGEsDEF+/F6pfbdCnnscHqFIv0Rijn0MZ8purD758CWO8x9I
         Dl5+ZkLe0ZotqW5+UZcNRKVrKuVk4IZ/aoAqb9AWzlM2z+lEmAUVaMSrbfqbFepCh1cC
         WGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1IEs5z7JHb4Cbcqw4HtGCi+kh7B16HGnfde5tUBYSsE=;
        b=rIQFGkYvIaggS1RCLUrCTSzi+39iCA616O25MqzJvHVAG2bYpJYp9v1++m2ewyLePt
         TLtWw14Mw5gt5iqRNbf8S8EKRpvG9AWbZvsh5ZifIZ6LDNtj63EJNhksUurUByh5Yvab
         3yLVQpsEC4sU2IRxvubwD9kkzhp6VzqppF5XERuRxhdcGjJjeINZO2IUsC8DdUVfIyzZ
         A04DQotnvNVZCNiYJiDYJyRw6HthDYfipLghLMj1tJKCM8Q3/+Zys90NGgXenWwHVjIf
         TI16QtIYBJA5y67PYevyGrwc+nKI2pnoZg3yJlQdbaXVLX3Ppk4oMNxlE0bI7oy0+/BB
         RoqQ==
X-Gm-Message-State: APjAAAVx0OjHfQyWpPprgriaNLyTVx6ARulXLJaCYTDhwVvT0IF8NIJ2
        zXBU0VNmvc0HDUwe8BH1dFzK3kv/Yq8UC/6UD1TEyAnKGl+mkQ==
X-Google-Smtp-Source: APXvYqwxL99mtKZG4XPGU5RDOaZIg8HIYIyNvaF36ciBCf5guLSL1NgLZ2dd7al09/YJgRRn00WYGrNBXwi7mlXsJKk=
X-Received: by 2002:a67:ecd0:: with SMTP id i16mr30993934vsp.110.1561215813931;
 Sat, 22 Jun 2019 08:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com> <20190621223107.8022-2-felipe.contreras@gmail.com>
In-Reply-To: <20190621223107.8022-2-felipe.contreras@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 22 Jun 2019 10:03:22 -0500
Message-ID: <CAMP44s1ZZu97tbPS6xGi6=i3r-+bA2E=Ug5BeXmzKH9=dWqE8w@mail.gmail.com>
Subject: Re: [PATCH 01/14] completion: zsh: fix __gitcomp_direct()
To:     Git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 5:31 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Many callers append a space suffix, but zsh automatically appends a
> space, making the completion add two spaces, for example:

> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -73,7 +73,7 @@ __gitcomp_direct ()
>
>         local IFS=$'\n'
>         compset -P '*[=:]'
> -       compadd -Q -- ${=1} && _ret=0
> +       compadd -Q -- ${${=1}% } && _ret=0

This is better actually:

compadd -Q -S '' -- ${=1} && _ret=0

-- 
Felipe Contreras
