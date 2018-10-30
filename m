Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02F6C1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 02:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbeJ3LMR (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 07:12:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51294 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeJ3LMR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 07:12:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so10109781wmf.1
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 19:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tkKErOgQNxnmQ4ZFR2s94pz0FSolNXWx0vqgUmdIQ+o=;
        b=K0ehaetSM25msjdD1doDZJ32keYp1FHLdmK5WVXEwOHD1Si0roDP1YcdODALCTHOvE
         nlrLVFmejzJdbDpXF4PtAaptjo1box81eK63ERLzZbl/Ahqk/7JAENtsMuSAm5YyAhv4
         IcSGorC5fwrA5QuQKpnPR7G2n0DukqvCT3ZItnvcrMpfHTpqedDhwL2OnkFUBY9fz78Z
         cgRpm8bHHS05Naeug0hFankwU0TqUeplK90cn/ysYb/NXFr+3OjZjgD0KsX8K43hN/UH
         uVlro2Sd+Frg8xU6EYnaEPU7DNKUvzqv6Ts/hNJ/FY0vgccbj9h5AEfyyuxIWxk3+0Y/
         tTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tkKErOgQNxnmQ4ZFR2s94pz0FSolNXWx0vqgUmdIQ+o=;
        b=i/iCv6D8X+xiyQP3HCDBz0Wkz6DVV0+hnWCb+dpPIauFZo5/g62/Pf7giF+Rl58DNl
         Xe2OHiDrG7uzpdE3ztiSDUoh0NlxsWvXtaoQlw6p5XdQr2DnSmB6vRRSzvmQl+Jx0jQh
         9VUqh9WkBmuOab1u3qiOLx4ZkJdk0LXUxcDPpdLj0cvNf1HJ9kM8j2v89qBq0/me6+m8
         ZwdPCG2Ss4VA0b/vndXCZnMA2gpWCOwIq2AE73UPJGoSYle8ZqY/eBCaZL1VBfFTCjdk
         ILUOOhi5lRTmwBXVrF0Uut92qIZIABJN2bTrSYeqHrDBaZfhBM2NXMdzsk+sYUmSMXEp
         +BMQ==
X-Gm-Message-State: AGRZ1gL4wy+A4WB5wH3UmX619VMEaWqD0PBhrVzHcfG4xSNA+delc24m
        9Y38bLhdnP2InydmGiSVhbo=
X-Google-Smtp-Source: AJdET5cKkL9FoK1GcxhNU4MyYzRxgXMThncTkBPwy7zzeKFr25WyVMSCzt65mxdy+7MVQP50xjLqQw==
X-Received: by 2002:a1c:f4e:: with SMTP id 75-v6mr170108wmp.79.1540866047424;
        Mon, 29 Oct 2018 19:20:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c18-v6sm15195132wrr.74.2018.10.29.19.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 19:20:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, anmolmago@gmail.com, briankyho@gmail.com,
        david.lu97@outlook.com, shirui.wang@hotmail.com
Subject: Re: [PATCH] completion: use builtin completion for format-patch
References: <31160e8c63399e8c866eef40462d0b699bae9b59.1540835698.git.liu.denton@gmail.com>
Date:   Tue, 30 Oct 2018 11:20:45 +0900
In-Reply-To: <31160e8c63399e8c866eef40462d0b699bae9b59.1540835698.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 29 Oct 2018 13:57:55 -0400")
Message-ID: <xmqqbm7c2n0i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

We saw a similar change proposed and then found out it was not such
a good idea in:

https://public-inbox.org/git/CACsJy8DUrVJu0HN7kuCeo4iV5aimWbYtr+E-7kenPVDx90DpGw@mail.gmail.com/

It seems that this one loses options like --full-index, --no-prefix,
etc. compared to the earlier effort?

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index d63d2dffd..da77da481 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1531,15 +1531,6 @@ _git_fetch ()
>  	__git_complete_remote_or_refspec
>  }
>  
> -__git_format_patch_options="
> -	--stdout --attach --no-attach --thread --thread= --no-thread
> -	--numbered --start-number --numbered-files --keep-subject --signoff
> -	--signature --no-signature --in-reply-to= --cc= --full-index --binary
> -	--not --all --cover-letter --no-prefix --src-prefix= --dst-prefix=
> -	--inline --suffix= --ignore-if-in-upstream --subject-prefix=
> -	--output-directory --reroll-count --to= --quiet --notes
> -"
> -
>  _git_format_patch ()
>  {
>  	case "$cur" in
> @@ -1550,7 +1541,7 @@ _git_format_patch ()
>  		return
>  		;;
>  	--*)
> -		__gitcomp "$__git_format_patch_options"
> +		__gitcomp_builtin format-patch
>  		return
>  		;;
>  	esac
