Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39EDD1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 22:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbeJIFdG (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:33:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40838 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIFdG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 01:33:06 -0400
Received: by mail-ed1-f66.google.com with SMTP id r1-v6so4466234edd.7
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 15:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3rPXMizg5KFfp0RL8LbALDUPSwumHzkQdANPX07Tss=;
        b=vux/+K4XHW9xjOi63X7f4EFmiNm1puC4TxU+1pDW5rpjCY8T8rqvZhKiWQMNWl+jvf
         YNFKb1qQ27xYbx6pMvFgCo0Ttj2HdePNy7DTpKObzpM9ZNkv0l2zKmdSsYKfA2cV23mB
         oTc3kvsGFe+k9QieMxePJig8WtbwOFt4iX8dMX10hat6POjFmmV/svGS5vJ6A+pXnPJX
         0QUo3VrmilvRC7grffXQho7fbKrE8dnwfudmRA1azEFxxczG9kh/GVryiIMYW00OXNNC
         1lBxr6QCIDkK+jwmodIYdCzBv6Ox9jETNPCbxULT5pnwTABMawDZUrs0Jk8QeoGMD7Tg
         VYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3rPXMizg5KFfp0RL8LbALDUPSwumHzkQdANPX07Tss=;
        b=hlY/9ULaP/vjlgGAl3NvXnn8aLgRt5Rcegu7ZHRms7y84GF1ZtyxK99/Sj8R0T6Uta
         ZD7ucLP2yixeQVSSnz5FNdSmSpb3ML8FTWfLXh6cC0FWd6qJ0g61F6uwjM+sez6VC3Hj
         ryYIBijuLBQFfKgaZKaN+UkT6i6LvE/CaAMh1A6KW92ZZ1MIIDPxSVYF89iat+OO0wvX
         ZyOeQxOEhBboIDsupBIeb5g9ioxYok7hP1g6IkY/olBMgvteoErihl2AHCEMaqLHVYWs
         0sueICWs8Br6KcrnbXaWUFGYLyDZc05GUpxRoQcEi5mveSTHguWk2It/8jyDh9gZueeM
         RTvA==
X-Gm-Message-State: ABuFfog1zhU/Rl88CwD2sh5A2rMjt/u3hQLkzP+V9h2WEYnrsaJmrCW8
        NVIEsKJC5N9/1W6sH4I2u9N9RUEmqFqTAyM21AkWsQ==
X-Google-Smtp-Source: ACcGV61vOsB6g+IYeqYU30gFMpuVHkzSOcOdaDJNFbVxMn7otHqqM+tDISxhE7mfAIz4SzMkYp4Ae4+N+Zv0N9miBD4=
X-Received: by 2002:a50:9931:: with SMTP id k46-v6mr31465886edb.85.1539037151735;
 Mon, 08 Oct 2018 15:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181005130601.15879-1-ao2@ao2.it> <20181005130601.15879-10-ao2@ao2.it>
In-Reply-To: <20181005130601.15879-10-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Oct 2018 15:19:00 -0700
Message-ID: <CAGZ79kZTQB29SuB52Efk-j7jX11BRU_RFiX+znttvP2tFRaNvg@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] submodule: support reading .gitmodules when it's
 not in the working tree
To:     Antonio Ospite <ao2@ao2.it>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +test_expect_success 'not writing gitmodules config file when it is not checked out' '
> +        test_must_fail git -C super submodule--helper config submodule.submodule.url newurl

This only checks the exit code, do we also want to check for

    test_path_is_missing .gitmodules ?

> +test_expect_success 'initialising submodule when the gitmodules config is not checked out' '
> +       git -C super submodule init
> +'
> +
> +test_expect_success 'showing submodule summary when the gitmodules config is not checked out' '
> +       git -C super submodule summary
> +'

Same for these, is the exit code enough, or do we want to look at
specific things?

> +
> +test_expect_success 'updating submodule when the gitmodules config is not checked out' '
> +       (cd submodule &&
> +               echo file2 >file2 &&
> +               git add file2 &&
> +               git commit -m "add file2 to submodule"
> +       ) &&
> +       git -C super submodule update

git status would want to be clean afterwards?
