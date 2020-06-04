Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB851C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 12:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1920206E6
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 12:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qmb1MyrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgFDMHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbgFDMHc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 08:07:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C0AC03E96D
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 05:07:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so5830928wrt.5
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 05:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6r8PHYiA6v6C5qnvBXXY1+PF9Mgj6nDLDXz4VOY4bhs=;
        b=Qmb1MyrRKMR4pyvDUZvC8hBkZ1Vx5jiIALV3fwOQe66hZHcJmhI65ACPBm+C27VuCn
         k9FHAGuJmWUBqCELqY1hwvq7fhWzwtZRdt0At+ysizs1LqAKIUcJS3KgPs2HAg+Ctwrp
         15B3ZsC/TQQ7sixuex/cWf9HLYEopyV6YoAiRuL5FXhmgv19FlklZvarK4y+P/BYjIBo
         qR549sZd+kNysrqKQgiu/88gqb2HWNihVLa7w9rLuwfVjWRg6jLTlUNCh5gySB1DW1Fe
         6hafmsriPnqW9rcnbtvK5Ww/ogtKldYBREaMIIHvX7mcRO3E7oqWXGUqxC488+HPXFYT
         WT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6r8PHYiA6v6C5qnvBXXY1+PF9Mgj6nDLDXz4VOY4bhs=;
        b=JubTew+X6EJ1+m8Ve3AdRJ94O1GCNzoN02l1+taJUMTi8KXSwZQH7b7K8BFWndT8GW
         E8f7lEoipzmQ3u0CK95rd7Hk38G/ofDWGvp5zxMAo4TAPV2xMhpQ+TH1O/MDSdGgxAeM
         Nf06GbkzTLu4pxH6l84iQnV29SrTCqMgh0cJwdw7iUwPe+P4zF0AxsyrGEk4IvDKIXtX
         Gke5abNiK0VnbXyPiG6NlFZbqhfppaU80BJKE6cTQOJieFJjkW4ZbOKGkttWKWe3G0/U
         TdxCcyKXL6T66ngbJ/7JI+LGK18ugoUzspqJNmv3L6OUim+TqOq9Vd2fAzaJvTpBEJE6
         YyTQ==
X-Gm-Message-State: AOAM530Xm0FkbG76KsrhomtUYIVAIYPO3VJPwGcBR9aPsYkVTZ6j4mZ3
        0zEJPO5+rpHdsAKq+sDjsqs=
X-Google-Smtp-Source: ABdhPJw/T7xDbweh73tVnvKEH+DySAbVeVNKaoA2r+RsvI2e4u8OhohjMgwnkUTWF7mG3/e+KbPoFA==
X-Received: by 2002:adf:ff83:: with SMTP id j3mr4185418wrr.264.1591272451031;
        Thu, 04 Jun 2020 05:07:31 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-378-234.w86-199.abo.wanadoo.fr. [86.199.233.234])
        by smtp.gmail.com with ESMTPSA id u7sm7863904wrm.23.2020.06.04.05.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 05:07:29 -0700 (PDT)
Subject: Re: [RFC PATCH v1 0/6] stash: drop usage of a second index
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
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
Message-ID: <c0a31a63-824b-d256-4811-c9307e87092c@gmail.com>
Date:   Thu, 4 Jun 2020 14:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200505104849.13602-1-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 05/05/2020 à 12:48, Alban Gruin a écrit :
> The old scripted `git stash' used to create a second index to save
> modified and untracked files, and restore untracked files, without
> affecting the main index.  This behaviour was carried on when it was
> rewritten in C, and here, most operations performed on the second index
> are done by forked commands (ie. `read-tree' instead of reset_tree(),
> etc.).  This works most of the time, except in some edge case with the
> split-index when the split file has expired and is deleted by a forked
> command: the main index may still contain a reference to the now-deleted
> file, and subsequent operations on the index will fail [0].
> 
> The goal of this series is to modernise (a bit) builtin/stash.c, and to
> fix the aforementionned edge case.
> 
> I have to admit that I don't really know how to test this.
> GIT_TEST_SPLIT_INDEX failed on me (gdb showed me that it does not enable
> the split-index at all, at least in `git stash' and its forks), and I'm
> reluctant to add explicits tests on `git stash' about the split-index,
> when nothing in its code explicitly does unusual things with the index
> once this series is applied.  If anyone wants to share opinions about
> this, I would be happy to read them.
> 
> This series is based on b34789c0b0 ("The sixth batch", 2020-05-01).
> 
> The tip of this series is tagged as "stash-remove-second-index-v1" at
> https://github.com/agrn/git.
> 
> [0] https://lore.kernel.org/git/EED2CFF1-5BEF-429D-AB99-AD148A867614@gmail.com/
> 
> Alban Gruin (6):
>   stash: mark `i_tree' in reset_tree() const
>   stash: remove the second index in stash_working_tree()
>   stash: remove the second index in stash_patch()
>   stash: remove the second index in save_untracked_files()
>   stash: remove the second index in restore_untracked()
>   stash: remove `stash_index_path'
> 
>  builtin/stash.c | 151 +++++++++++++++---------------------------------
>  1 file changed, 46 insertions(+), 105 deletions(-)
> 

I’m afraid this series fell through the cracks.

Alban

