Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D488FC433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 10:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBC82080C
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 10:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqHTyNfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMKll (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMKll (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 06:41:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F58C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 03:41:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so4790624wrm.12
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 03:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AXp/7Vxl3zD9hE2U0jzb7nJtx9ksbcnHVRRv4gs9NXs=;
        b=BqHTyNfdrCDr3ondRXiih5YYf8b+ZomHcj1xbYeJ9Wx7pqrdi5AbHbmOKdDL/T0IkR
         pG3XoHDPGVTMYEQDJJa1ETFsxJVQplXOA0KS0kgeR/0Lr72/+fR714v8i4cDp4zTUNp/
         dbelebupfCCcYYkIB7/ti1xnKjQJ7uXvRgIVKAXcGLR30q/NxCLz+SWlSck5Fr+FF8Qm
         19+VSW1fpVhYu/gY1uHiCrCbVBv6FcRgFF+wTSr7hMF1zk32r6kSRgT500Y+HRAVtfuj
         XRfAIAAGo+Jv2RfkYDqh3fPFw/fdmmwEViwgnm6PIWm5dGuwaIVeIurBu1iHtP9ebXga
         gdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AXp/7Vxl3zD9hE2U0jzb7nJtx9ksbcnHVRRv4gs9NXs=;
        b=cVHwhKoi73ThHCFPdn0VJ8ZTkCfm8M93PCElAUO/CUanTlr5zh/vPDnxgH562u0HZk
         5NxHPXCGTYMRfBnugxRVowyWaidnUjI5t7dboLEPhprZbDdZd6Xeii/Fmq7IJSHeWntZ
         13mj10xYLk2a4Hlv2YpjUH9+ajmyxPD7zTe9uuhq4PN2z0DUzMZVgW40Ph2jk+9dgLCB
         bjCgLfkQDfjOUu4C8XiiKqqrvqriNThCvJEZetffqdG6b6f4miRgX9qetT8StNffgapr
         iC1oGp4oltJMp6gI4bv2Yj8iFhfZEfqDLmoAVr/um73Mdb7HyzCSCzrxnV/t2HlihZEP
         QDmg==
X-Gm-Message-State: AOAM532uXLcLCSVBbKGK/Lc1EaCrlSlHhy5Wnm8M916k/fF0R7jao3vS
        GyunLVwJyBmZDT1tvESqMzc=
X-Google-Smtp-Source: ABdhPJzMZXUZxo0nwYelwTmySXTLTWSnjKT8khBt/FVYIgztoCJLGicnD5cgVNwGlsev242qT+6DoA==
X-Received: by 2002:a5d:4749:: with SMTP id o9mr3487484wrs.68.1597315298125;
        Thu, 13 Aug 2020 03:41:38 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-294-125.w86-199.abo.wanadoo.fr. [86.199.77.125])
        by smtp.gmail.com with ESMTPSA id g70sm9027938wmg.24.2020.08.13.03.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 03:41:37 -0700 (PDT)
Subject: Re: [PATCH v2] rebase -i: Fix possibly wrong onto hash in todo
To:     =?UTF-8?Q?Antti_Ker=c3=a4nen?= <detegr@rbx.email>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Jussi_Ker=c3=a4nen?= <jussike@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20200812183326.224782-1-detegr@rbx.email>
From:   Alban Gruin <alban.gruin@gmail.com>
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFcsWp4BEAC6dalBNr/CZCvvfeARylnjAaZCxMPwUHXAyf4xotA59sNcyVmaFQ6KxQEs
 R20CSJhO6HqCh4bR9/994vdc4cGuNaWf82eYRYzqCzwFWvFJHj83QgDR2cjtz4frKpj3jSFJ
 No3KBlMmpU8yvSnYaCxjqHxBB+fZwkmmONj/57KdFRU83DvDllQdAxXfxEavL3qUKjVbld29
 o82M2xsN8ZN5KTw7rAMHcigYVnlrgP50euxz3WvfrV+Mky2W7q7m5rTK7eXqOKhewsKcxo0I
 AP+H0Nt91YTmMIAX2Ba25IfHI99kUCLpbHX9xdvj5UH1SZsG84APahdI3CXYibfYIS+qssoo
 72qj7eBIoCFbVS4Q5AINxojio32orGBDE8CaCy3EzTF+vwJ+h4uUKrTX4wyUMy8nXS0UxZqD
 aQsS7Di6LdAHu+4uf064mXdgjehJ2uHAydFnCThMoxckRoSZ70iCPwgconhNrnuTmunJ43BF
 YjAurjg8y3WrMPJuJaI42q0sYbAX21XeayyMI8dzoNwyG6s+v0Udb/uxdYnHhsGx1oXjYCeR
 nyBdVwdMLWFP4XmJH7JueGUZ37TLh719ME6HYRpfM3sh915ywPxKxQYmGC9iXRThXdGK7ipq
 hJM5RtMq4QPGg+/ShgTZaDdFuMnG8Zrq6W+O29h9NB5rQ/UvBwARAQABtCNBbGJhbiBHcnVp
 biA8YWxiYW4uZ3J1aW5AZ21haWwuY29tPokCcAQTAQIAWgIbAwIeAQIXgAULBwgJCgQVCAkK
 BRYAAQIDHxhoa3A6Ly9wb29sLnNrcy1rZXlzZXJ2ZXJzLm5ldC8CGQEWIQS1T1bLFrFdtpxn
 TIMOC58lWpNWKgUCWRSuYAAKCRAOC58lWpNWKoCfEACHmff95NF5OrBKN+GPYo3TOojjgjio
 CREt9BNIU1ltbks33N/84QF1ifjFF5xjK1XpNhZdk2Nxk+Uf3ByAS24i0b7/BM58RX3sJMHd
 mklCbqBGLBTS+bO/3nc+1snb7FPmjoi3IXznQ25ZXiV/9MUABUBZi7odwNhxeI3Hd2PaX/x5
 ZM0BApqhmBrueUd0JKqY7f/7a+0rTJ8fIHV9ml3cVWf72t2BVnxJMeNLSAIT1FaL8Okp8ViO
 t7RfjF0JZsYZouhCcw2fx7U0VxXGu6bONdVGxu07I7G3+vjhd2C/ld0dgRRjx8viA5HecUSf
 bwbviEXlc44TVo8D6tkrKOezctqNTLII498C7gIQZjc+6HmIIQrOzzLX/C27JQbXch+6KtHO
 ThYGzmD0d7EttTRtXnFJFTMbQMMFnc2X+Rh1ubvfp4Zp2U3a7Nh1//4+ikqIAPV8poJcEdQ0
 A6CaGD8pTCMdExDovizfJRU0ZN3AU9UgFsZWkMK7MFyJneRObUf26oXCQH8zVuJEJHrEsYPk
 VHdV1G86d++CdipKqe9iDNBGNa/5Q9IvYEKK6vj4wLS5ZaOwLGfApbsOcDJvFA1ll/KeHvzx
 Ig9dhUnNCtYXKJ1npChigwRbAiAADoTFI2rI69g6ZTTzBd0+9GM4z6RcOJvtGLnViO4tOCmy
 sbwbxA==
Message-ID: <3ba6c005-e71f-3a0d-46ba-a90a68e88d3e@gmail.com>
Date:   Thu, 13 Aug 2020 12:41:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812183326.224782-1-detegr@rbx.email>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antti,

Le 12/08/2020 à 20:33, Antti Keränen a écrit :
> 'todo_list_write_to_file' may overwrite the static buffer, originating
> from 'find_unique_abbrev', that was used to store the short commit hash
> 'c' for "# Rebase a..b onto c" message in the todo editor. This is
> because the buffer that is returned from 'find_unique_abbrev' is valid
> until 4 more calls to `find_unique_abbrev` are made.
> 
> As 'todo_list_write_to_file' calls 'find_unique_abbrev' for each rebased
> commit, the hash for 'c' is overwritten if there are 4 or more commits
> in the rebase. This behavior has been broken since its introduction.
> 
> Fix by storing the short onto commit hash in a different buffer that
> remains valid, before calling 'todo_list_write_to_file'.
> 
> Found-by: Jussi Keränen <jussike@gmail.com>
> Signed-off-by: Antti Keränen <detegr@rbx.email>
> ---
>  sequencer.c                   | 5 +++--
>  t/t3404-rebase-interactive.sh | 6 ++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index fd7701c88a..e2007dbb8c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5178,13 +5178,14 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>  		    struct string_list *commands, unsigned autosquash,
>  		    struct todo_list *todo_list)
>  {
> -	const char *shortonto, *todo_file = rebase_path_todo();
> +	char shortonto[GIT_MAX_HEXSZ + 1];
> +	const char *todo_file = rebase_path_todo();
>  	struct todo_list new_todo = TODO_LIST_INIT;
>  	struct strbuf *buf = &todo_list->buf, buf2 = STRBUF_INIT;
>  	struct object_id oid = onto->object.oid;
>  	int res;
>  
> -	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
> +	find_unique_abbrev_r(shortonto, &oid, DEFAULT_ABBREV);
>  
>  	if (buf->len == 0) {
>  		struct todo_item *item = append_new_todo(todo_list);
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 4a7d21f898..1b4fa0843e 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1760,6 +1760,12 @@ test_expect_success 'correct error message for commit --amend after empty pick'
>  	test_i18ngrep "middle of a rebase -- cannot amend." err
>  '
>  
> +test_expect_success 'todo has correct onto hash' '
> +	GIT_SEQUENCE_EDITOR=cat git rebase -i no-conflict-branch~4 no-conflict-branch >actual &&
> +	onto=$(git rev-parse --short HEAD~4) &&
> +	test_i18ngrep "^# Rebase ..* onto $onto" actual
> +'
> +
>  # This must be the last test in this file
>  test_expect_success '$EDITOR and friends are unchanged' '
>  	test_editor_unchanged
> 

Looks good to me.

  Acked-by: Alban Gruin <alban.gruin@gmail.com>

This makes me wonder if it's worth to do the same change in
todo_list_to_strbuf().  #leftoverbits, perhaps?

Cheers,
Alban

