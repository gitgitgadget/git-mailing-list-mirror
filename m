Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3BEF1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 02:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeDPCaF (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 22:30:05 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34943 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbeDPCaE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 22:30:04 -0400
Received: by mail-wr0-f193.google.com with SMTP id w3so4986387wrg.2
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 19:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=hMChZEmZFPjarlSbkOl/LQTLNcbTQS2f7ptW38EY7mo=;
        b=i5synEvJF7uLJ2UoA7VzhIkpZnNeOCHCg3Xtun4on/d9WILTn96uImdvJdTXOyRDC3
         14y85rlvZJQVh4C1Ue0ZnaeUkMMFCUiHN5H43ejZEasROOerBcjz+F5LbzPopQzuMmzR
         XlgYw1EqROI+Sm5IaA4wpK2N/1KQZKYyW9+NrdDXGefvOLltV6oxr/kZwqw8whm9I1nq
         UwgthAfv5sTxw42zZhE8UYI3+ZqI2HzJCDPa0IUgIeaIDDlJGTnGVs+D3KIkx/zi99vu
         kFOURCeefI+pvB6YUs6dWqAwlMSA0jJbEP3tpqb25EL4WflndxZQsGIqFRXLNogGVF8s
         i5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=hMChZEmZFPjarlSbkOl/LQTLNcbTQS2f7ptW38EY7mo=;
        b=WIqZHb3FDbkAXVWM/+G6CWLtOnciBJJ2XZkpGTBIg7+dnUgfN8DlafYdnB2tctqLsP
         p8M4iXxUZE5nPXLtnFaJpRUIa3XhZQcANK3obWBkJsv+Y+4mXJxaN9alpnF8SpoBrbrS
         gbhVldXz4jNexK7vlWqUxQCk0C6myWNW90SZ2HpcEjVgIg40q51AP1JqpLdyRsh9DsPp
         mvcvAhdf502u4eVsWmNeejdt3Z8f1cV8JvVWiTJ2Be9VrZRo/QRGqNw2lobEBobwvYAS
         y1THLk2XfOrnGxPpXwzOgs76FZArgS+uU8itPxTTI+C+7SblXX0x1kEcN6pOu+FwrKPB
         Sckw==
X-Gm-Message-State: ALQs6tB0KNc8H2u8eNT8kst47+XIHNIASmhDkl7cyTsQ01kHzD3mga6s
        odtmoJM6X/rkkfXEDajN9Ws=
X-Google-Smtp-Source: AIpwx49ZS9dFTAhQkEoYnUndZo6adFsBprqeV2sLwcw/blb7lgLMShxLsY8+JhqJAmA2kVLfnNG7Kg==
X-Received: by 10.28.53.194 with SMTP id c185mr9538398wma.27.1523845803237;
        Sun, 15 Apr 2018 19:30:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n20sm6138972wmc.24.2018.04.15.19.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 19:30:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, philipoakley@iee.org
Subject: Re: [PATCH v2 2/6] git.c: implement --list-cmds=all and use it in git-completion.bash
References: <20180326165520.802-1-pclouds@gmail.com>
        <20180415164238.9107-1-pclouds@gmail.com>
        <20180415164238.9107-3-pclouds@gmail.com>
Date:   Mon, 16 Apr 2018 11:30:00 +0900
In-Reply-To: <20180415164238.9107-3-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sun, 15 Apr 2018 18:42:34 +0200")
Message-ID: <xmqqy3hnyjbr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  contrib/completion/git-completion.bash |  2 +-
>  git.c                                  |  2 ++
>  help.c                                 | 18 ++++++++++++++++++
>  help.h                                 |  1 +
>  4 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 3556838759..a5f13ade20 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -839,7 +839,7 @@ __git_commands () {
>  	then
>  		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
>  	else
> -		git help -a|egrep '^  [a-zA-Z0-9]'
> +		git --list-cmds=all
>  	fi
>  }

To those of us who install a copy of git-completion.bash somewhere
in $HOME and forget about it, while installing different versions of
Git all the time for testing, may see breakage caused by an invalid
combination of having new completion script with Git that does not
know about --list=cmds=<all> option.  I do not think it matters too
much, though ;-)

> +void list_all_cmds(void)
> +{
> +	struct cmdnames main_cmds, other_cmds;
> +	int i;
> +
> +	memset(&main_cmds, 0, sizeof(main_cmds));
> +	memset(&other_cmds, 0, sizeof(other_cmds));
> +	load_command_list("git-", &main_cmds, &other_cmds);
> +
> +	for (i = 0; i < main_cmds.cnt; i++)
> +		puts(main_cmds.names[i]->name);
> +	for (i = 0; i < other_cmds.cnt; i++)
> +		puts(other_cmds.names[i]->name);
> +
> +	clean_cmdnames(&main_cmds);
> +	clean_cmdnames(&other_cmds);
> +}
> +

OK.

By reusing load_command_list(), the duplicate-removal logic at its
end that is used for "help -a" kicks in; the above looks good.
