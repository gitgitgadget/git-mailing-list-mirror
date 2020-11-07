Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C40C388F7
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 15:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6C6207C3
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 15:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5YRphwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgKGPJI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Nov 2020 10:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgKGPJH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Nov 2020 10:09:07 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661A3C0613CF
        for <git@vger.kernel.org>; Sat,  7 Nov 2020 07:09:07 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id f16so4176733otl.11
        for <git@vger.kernel.org>; Sat, 07 Nov 2020 07:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BMfz+NzXpxqyRRKUvLZT3w74Q1Iqo1Zx2SHHrjTLRO0=;
        b=D5YRphwJ+4PSApBZGjdn7EcqOxkRJq/xqBKN+t/cFzkqQyX/7wUEEitVkx2xtTKtyB
         uNfQs6/fhLyv4Kd/NBVG/ZjRyZnaoAkIqe3iEDLErBUrqa3WwjbaNg7QGnZnMr/qIR5H
         P7HoRjso1kIUlcwZvV0HxYZ4iye6dT6u9ddwzlX1+F8OXQ32gAFT6b6+v/CZCzg+jdu/
         9sH8QR8ysERuqgnLKR6e5n/vL4+Y7mX3tgZSIKZu7XlM30Q/3zkepvqWhz+yklconzDT
         ZZJOngvT9vnLUPmBkmSJrW8nxrIid5j0kEGzjOg/HtJwgNFtmn6mdGV6Au516d1AKZYL
         AOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BMfz+NzXpxqyRRKUvLZT3w74Q1Iqo1Zx2SHHrjTLRO0=;
        b=uXgoInYrz6hvuXFsCnL3+fool+Efnqz9p0vTUN5SKmrOKO1pkRgCrujsfMMzcpwYV9
         0+B9fUoTkZtDvpbgyMbta3sghfd/yecZYIx+l4m8cD3Z0cj6xnh/oiQ1KnNLcerYHBGK
         7PLOasT5HwRvcJ4YkHa1f2le+K5mCdhhBKzwtCXsTyIcHIIYh+wyRJ1/+eVrbm13BCVK
         q/CcgXqQaA89V0xW3/AiQziGnuYzg+Vww99tT26iQLdg7YLITtiAjMsYDdNagHd57j7v
         HkO9GCUB84XffvpcEXG0SEVU4poU2j68btbjEuG2H9AWPpBhOZFmp6QEr4LxRogtUeLf
         ahAA==
X-Gm-Message-State: AOAM533aznRwm/wyZPUdLqggHbfQfGDSkraRjcqf7XbyT9FInTx6TMzJ
        KHKWYzGZW4P7ahPyRIQQhd9yQNf38QGW6g==
X-Google-Smtp-Source: ABdhPJz+mVwSSBXbgvLIljSnHALKhJt81rrBjjoU4k0Wxp0HgSxzs7TTKT3dqYKBRJSC2tGZKDGl2Q==
X-Received: by 2002:a05:6830:22d2:: with SMTP id q18mr4167512otc.305.1604761746500;
        Sat, 07 Nov 2020 07:09:06 -0800 (PST)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:f594:492d:8ff8:3649])
        by smtp.gmail.com with ESMTPSA id i8sm1093701otl.60.2020.11.07.07.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 07:09:05 -0800 (PST)
Subject: Re: [PATCH v2] doc: clarify that --abbrev=<n> is about the minimum
 length
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <CAF7CYk51BC0KcsBb0KjKWAj17AMU2c9Y6Y81ddwX6oOAFYhT8w@mail.gmail.com>
 <xmqqk0v1q60l.fsf@gitster.c.googlers.com>
 <xmqqblgdq4k0.fsf_-_@gitster.c.googlers.com>
 <b7d6ea51-6aaa-bf74-2e19-1d1283001489@gmail.com>
 <xmqq8sbglr26.fsf_-_@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <98710644-c060-c64e-8c0c-a27bfa0e58fb@gmail.com>
Date:   Sat, 7 Nov 2020 10:09:04 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <xmqq8sbglr26.fsf_-_@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/4/20 5:01 PM, Junio C Hamano wrote:
> Early text written in 2006 explains the "--abbrev=<n>" option to
> "show only a partial prefix", without saying that the length of the
> partial prefix is not necessarily the number given to the option to
> ensure that the output names the object uniquely.
> 
> Update documentation for the diff family of commands, "blame",
> "branch --verbose", "ls-files" and "ls-tree" to stress that the
> short prefix must uniquely refer to an object, and <n> is merely
> the mininum number of hexdigits used in the prefix.
> 
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Thanks for your suggestion.  I decided to use "the shortest
>    prefix that is at least <n> hexdigits long".

I like this version. Thanks!

-Stolee

