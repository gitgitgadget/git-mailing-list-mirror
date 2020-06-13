Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59A2C433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 18:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3278207DD
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 18:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0p/VTfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgFMSAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 14:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgFMSAv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 14:00:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E04C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 11:00:51 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x13so13035583wrv.4
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EQWrsx+BZlcczE6DOLw9Lyn8xq2mhTE/YjDJmO5bGw0=;
        b=F0p/VTfivMWGcpWBnpArK+riRlETpINGa4tB5+z7Hhbkc67a+pPn+T9CiO2HGM5RJ4
         eL3Ogiecg9DTAGcLE29YIS3I8c8GNmLAU40us3FfLX5cTAC0MXl2qiSPkfDLhbicade+
         q3vTJDPMmVYX2vMqoWX0kueoeuUsaYLzUeSYsSKs2h3SEI5ps1W3zxqDnAHqKmnXshH0
         gaGTLHG03v7Z3WEBqwScU8bhpJ3z/XufnfTeKvf7NGfKnDMjTpzqMsx2eVgl8CrrLUXn
         DeQSG0MgmCs+N5eduUU5YEElYD3y0aquYxY6nrBqts4fmc8eBswSeklbhypSGfhTVwdE
         tX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EQWrsx+BZlcczE6DOLw9Lyn8xq2mhTE/YjDJmO5bGw0=;
        b=bmQJ0Wx3EMZB0v/vKKcrW0MtBiVMvPdy/Xiv5lFjNwrQTTedeCrag2ogSAD1MFNI3x
         FerfGTRqjic4rQjB/2v28LIhuc1tECz7krJpWhAkivrOWR5P52wY2Sr0baYK5HLDbOZF
         d1tgQ3BqR/Ey8u0ncQadQtnjyNXckpuPZItKwg0IuentNRmN9js6bG14/Zdci6NewQtS
         ONeg5o8r4zi1WhhfmXeUEYFLGhJgKzLq4yJd5SBpO4SS8LxiEYb8BNYcy+XUiXl7/JKe
         SeRJj+uAiHPIhV2KqHA0TMYOsrLyEfCKk5CzuKE+rqzrBWp3OM5lz/n5l3moYs9UN5O5
         jPTQ==
X-Gm-Message-State: AOAM5334d8Md5gLczM1KDKtEZ1eJdZ0pYpikj2O6hzn6OBSCh7uZcJMg
        D1Al8V68JHKiYb6sYTNN2hRRghdq
X-Google-Smtp-Source: ABdhPJw+MIfE3UxvmVM5GM9+GIm1x0x6HPUV2bgGXcul0lgS44/yLc8J1RDTvXCYFkeKfLdy8/ifiw==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr19478581wrm.44.1592071247860;
        Sat, 13 Jun 2020 11:00:47 -0700 (PDT)
Received: from [192.168.0.104] (abayonne-651-1-44-79.w92-156.abo.wanadoo.fr. [92.156.149.79])
        by smtp.gmail.com with ESMTPSA id y5sm16502663wrs.63.2020.06.13.11.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 11:00:47 -0700 (PDT)
Subject: Re: [RFC PATCH v1 2/6] stash: remove the second index in
 stash_working_tree()
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
 <20200505104849.13602-3-alban.gruin@gmail.com>
 <CAP8UFD1aT4dmuNkEz95eDFTE7sY+4eK_TwbTD-Vw8U7KyyZ-DA@mail.gmail.com>
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
Message-ID: <2158eec0-9332-fe10-3636-95550a66f05d@gmail.com>
Date:   Sat, 13 Jun 2020 20:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1aT4dmuNkEz95eDFTE7sY+4eK_TwbTD-Vw8U7KyyZ-DA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

Le 13/06/2020 à 10:52, Christian Couder a écrit :
> On Tue, May 5, 2020 at 12:56 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>>
>> This removes the second index used in stash_working_tree() to simplify
>> the code.  It also help to avoid issues with the split-index: when
> 
> s/help/helps/
> 
>> stash_working_tree() is called, the index is at `i_tree', and this tree
>> is extracted in a second index for use in a subcommand.  This is not a
>> problem in the non-split-index case, but in the split-index case, if the
>> shared index file has expired and is removed by a subcommand, the main
>> index contains a reference to a file that no longer exists.
> 
> As this is fixing a bug and there is no test, it might help if you can
> at least give an example of something that used to fail before this
> patch and doesn't after it. You are talking about stash subcommands
> but it is not very clear which one for example can trigger the bug.
> 
>> The calls to set_alternative_index_output() are dropped to extract
>> `i_tree' to the main index, and `GIT_INDEX_FILE' is no longer set before
>> starting `update-index'.  When it exits, the index has changed, and must
>> be discarded.
> 
> That makes sense.
> 
>> The call to reset_tree() becomes useless:
> 
> Your patch doesn't remove any call to reset_tree(), but actually adds
> one. So the above is difficult to understand.
> 
> Do you want to say that in a later patch it will be possible to remove
> the call to reset_tree()? Or do you want to say that the call to
> write_index_as_tree() becomes useless?
> 

No, I meant that with this commit, reset_tree() does not need to be
called at the beginning of stash_working_tree(), because it is only
called by do_create_stash(), which sets the index at `i_tree', and
save_untracked_files() does not change the main index.  But it will
become useful again down the line, when save_untracked_file() will be
rewritten to use the "main" index, so I did not remove it.

I hope it makes more sense now.

>> the only caller of
>> stash_working_tree() is do_create_stash(), which creates `i_tree' from
>> its index, calls save_untracked_files() if requested (but as it also
>> works on a second index, it is unaffected), then calls
>> stash_working_tree().  But when save_untracked_files() will be modified
>> to stop using another index, it won't reset the tree, because
>> stash_patch() wants to work on a different tree (`b_tree') than
>> stash_working_tree().
>>
>> At the end of the function, the tree is reset to `i_tree'.

Alban

