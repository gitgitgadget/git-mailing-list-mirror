Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05CBD1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 03:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeJVMH5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 08:07:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34960 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeJVMH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 08:07:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so43211126wrt.2
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 20:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FuIvzDGaFf2e2IY2QVf8jamJrzNtlEP7sID/tdSiukg=;
        b=E3381a7UfCVpfnD5jCE04twwHj1h33TKv4VuTaoAe7j0G6oL55tBHnYZSWMggcmbIE
         b0Mzo48XjlkPICjl0vCzHWi6aizLM4RAKuYQZy8ZFiMKNGy9mbXhXoyouLUPsfKLegww
         SREFwu1zFoUiV8jVyQc+5/cc7CK9NXDB1VzmyWc933hhc6ziKCn/m4Lq1Io1vwT9VaLm
         Gf6FZMDJbSr4n/ph1AwUVe9nKTCjupmWkl5PoRMbLLuUFiVr61dZRuByTm6XT/AhZ+Ah
         +qnTMoA31ztdPmifCLFqcEGZx/HI5ylq2T3NZlThnw9kXgDEQA8rY5060Lao7vUS0a5M
         MJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FuIvzDGaFf2e2IY2QVf8jamJrzNtlEP7sID/tdSiukg=;
        b=U+v+CGYT5qLfyZPJQX0gthJUsZ8cTOYgC9tQ2aLuDIRTeOj39so9+CWXsLloRy51En
         icgm9xqP/aN23iTsggSIC3mwg3wzRxPVqCNo83m9WkJtgvyB0IHsFkAt96IZrvGZqXQi
         C+YfnxMEFkF9HiiolUdhOJtu+Lfg18d1cLLG95rbPX3aJHI2tmYDW5BhaoQXTqORi9bK
         wYO/Hbs2SrVa7nI7alEnOudN0be2PBRQiD7Hd23DdzRKsj3sO1Ir9NtZ+CgppzqZGD7F
         x76+1uOPInpV5z4XrzMMrJ9kFWck3Su9CfIQCuRyDaq2v7CBdHEbkzDG/B9ulIb8ED0i
         /qjQ==
X-Gm-Message-State: ABuFfog4/hQHljVsO7qdpID2Zb+RqEA5mUvJLJ1Tbx4hUev/yduLIUyR
        VVzJYJ3q8TdKdyCnnzaV4qg=
X-Google-Smtp-Source: ACcGV62ifhtE9HBTJtzTSyUNmroXDAqVUBVBp+S9k7l4KxEYQwfE48NOKIZIMcriPX0q+Mg3IiRX8Q==
X-Received: by 2002:adf:93e6:: with SMTP id 93-v6mr43434713wrp.81.1540180272053;
        Sun, 21 Oct 2018 20:51:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g76-v6sm9748483wmd.25.2018.10.21.20.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 20:51:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion: fix __gitcomp_builtin no longer consider extra options
References: <20181021083731.8009-1-pclouds@gmail.com>
Date:   Mon, 22 Oct 2018 12:51:10 +0900
In-Reply-To: <20181021083731.8009-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sun, 21 Oct 2018 10:37:31 +0200")
Message-ID: <xmqqr2giwsep.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> __gitcomp_builtin() has the main completion list provided by
>
>     git xxx --git-completion-helper
>
> but the caller can also add extra options that is not provided by
> --git-completion-helper. The only call site that does this is "git
> difftool" completion.
>
> This support is broken by b221b5ab9b (completion: collapse extra
> --no-.. options - 2018-06-06), which adds a special value "--" to mark
> that the rest of the options can be hidden by default. The commit
> forgets the fact that extra options are appended after
> "$(git xxx --git-completion-helper)", i.e. after this "--", and will
> be incorrectly hidden as well.
>
> Prepend the extra options before "$(git xxx --git-completion-helper)"
> to avoid this.

Thanks for a clear analysis.  How did you find it?  Got annoyed that
completion of difftool got broken, or discovered while trying to
apply the same trick as difftool completion uses to another one and
seeing that the technique does not work?

Will queue.  Thanks.

>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index db7fd87b6b..c8fdcf8644 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -400,7 +400,7 @@ __gitcomp_builtin ()
>  	if [ -z "$options" ]; then
>  		# leading and trailing spaces are significant to make
>  		# option removal work correctly.
> -		options=" $(__git ${cmd/_/ } --git-completion-helper) $incl "
> +		options=" $incl $(__git ${cmd/_/ } --git-completion-helper) "
>  		for i in $excl; do
>  			options="${options/ $i / }"
>  		done
