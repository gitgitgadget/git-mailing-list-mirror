Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBE6C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 18:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJJSIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 14:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJJSIn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 14:08:43 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCFA6EF2E
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:08:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bv10so14611632wrb.4
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OgwFMLtAk7b+11sfaGBMIthat8Z5OyhshHxNszTh1A=;
        b=YMOR4geLY5U7r1W0HEfONnSulDlXoty9zVxP0F+h71jgmVMQSX/ykvHG5kBazd2Yzh
         EqFvSWN6UtQrNDF4uI8343oWe03tqDBunchL6AsXy6NSqex8gz+OsFLPdK+ix1q9egtp
         MmGorxDybHDiXSNSBxX34iHc+vUBlVAYS3PdsJs6n///hk/FAocPpNZ5fW9+nWX2zW/3
         7OD2SwzgQZyhpQdzMDtOawHEU6rRbYQqcdsctZhmpdoHz+D0W93tLXJrU//x7VmOEvBa
         swUpuCSSUFN3D6SNghwQ9U0L5yD0WsdDToYydlYwLj7HyIvR1juB/pngT+uZ+gSf9RNG
         q5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OgwFMLtAk7b+11sfaGBMIthat8Z5OyhshHxNszTh1A=;
        b=Fmfeb20dgYM/Z7mhS3hURyUV4yjYnOz70TzE0h/WOXhcOwyDVCmodAwH+f8aaGYAtC
         BDy8tN8NQa/VTtQZhI6grx6ztQ/8TyYbf5i6eHEs9kPHub1KlxDFqvCQTYf158tuKDsK
         vUfql4dpQosEAvqDjG0RxgV3ESOEjMfbtJ2hXWsKl/qJth1nxl4IG7huiQ8PD8XDMSac
         XahbVSttIyX90UF0r/+f+gSHT7g05DytGycSBe87rQAqyjXWjoTX3qzlN4kUwoy1lqAl
         fLx3md5uKxpoJi4rWCm2YLdvwZugS0urAwxAcXsF0tRdNcdzRM2fBgXvWA5vaz15S1jD
         1UBg==
X-Gm-Message-State: ACrzQf0h0yP6YJieXtRF4Zs+o2SFOJLnQ12x/AFcvcNKOr5U675YYJ/x
        3Gs07U8AxQOZupK8Cc7BtYc=
X-Google-Smtp-Source: AMsMyM6uzBtnwq0f+SrMOTnTJwAmpiFL0WUzNPmLJBGI5Vnc8BFqcbTAVhmZibLuAVtP/Te+PAtJ7Q==
X-Received: by 2002:a5d:5a15:0:b0:22e:7771:3a07 with SMTP id bq21-20020a5d5a15000000b0022e77713a07mr12070299wrb.662.1665425318820;
        Mon, 10 Oct 2022 11:08:38 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003c3c2df83ddsm9633463wmo.26.2022.10.10.11.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 11:08:38 -0700 (PDT)
Subject: Re: [PATCH v5] branch: support for shortcuts like @{-1}, completed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
 <de200fa0-379d-c1ce-8446-9e4292d0b66a@gmail.com> <xmqqa6647qx2.fsf@gitster.g>
 <dacb1f40-2765-5978-1131-f78ba919e6e6@gmail.com> <xmqq4jwc5x7y.fsf@gitster.g>
 <bf4a45cb-2f44-88bd-e12e-98ca31d5bbd4@gmail.com> <xmqqzge34nzp.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <7d51d297-7a18-de05-0da8-a93276455471@gmail.com>
Date:   Mon, 10 Oct 2022 20:08:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqzge34nzp.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/22 18:55, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
>>> If we have a big common clean-up after each operation, then, falling
>>> through in the success case might be good, but that is not what I am
>>> seeing here.  So...
>>>
>>
>> I would like to see some kind of free(head) in a clean-up to not get
>> distracted with that.  Not a proper leak though and the leak checkers
>> does not refer to that as leak.  So not important.  We can go with the
>> unconditional return and let the dust settle.
> 
> "head" is not leaking, as a pointer to it is head in a location that
> is still in scope (namely, a file-scope global variable) when the
> program exits.
> 
> In fact, the only thing the code before or after this patch does
> after leaving this top-level if/elseif/else cascade is to return 0
> and doing nothing else.  Inserting free(head) would be an unneeded
> distraction for human developers (doing such a patch, reviewing, and
> even worse, having to read the resulting code in the coming years)
> and waste of computer resources (exiting the process will reclaim
> such a piece of memory just fine).
> 

Just to say that I truly agree.

Un saludo.
