Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1BEC46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 18:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjAPSoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjAPSnk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 13:43:40 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD4D265BD
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 10:39:19 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id dw9so28526807pjb.5
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 10:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wUVw3x/2ag8uuX1tD/AVl+GS8YI9GX+McA2TEOJnfio=;
        b=MM2GLA0rDCNgENKjbGG2r5M1sS2LIQsG+blcTkxt87KnV7CHOCytEGobMMPXFJXtuR
         fU/aTy9pMxBh1PHTMa0dcbQeISbMmCodqSeVZEupwNnb2QvPTT7lVLEb9UGt5KJyN/Pb
         +X6zSH825wHZ48xsk6Ylqb7RZf5CoaZBprGab9xN61d+5UBqPvhaLpYAMEES6joKnmpt
         Q+RbdZ403A0QHKUOxv5pVO8y5UAhHVo0kXXSjVFENuHmcEov0Snltw5AqS+k32YOK6Kr
         fG5E5+mF1ObQb3iahEulvjO9DPHIyHIsNujVvhNjNO1HdOtMc0+7Oq+IxSyQdE/b9FHj
         KFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUVw3x/2ag8uuX1tD/AVl+GS8YI9GX+McA2TEOJnfio=;
        b=WmOlzM31+CKW0HnfBbLjMSckIZDZMp+oU70YHQ5UjH2Nz+c6tR9rhUMnoq4SJpsbFW
         lb6uY8WIsKy4FuCm59Us5qH8zqH5M6hRgI17JU8tTeGUyJrLQfFUiCqIXQKOX6d4UNct
         jJawaQ9KxlLid2+oAbPYrNe62GisE+FTWW0qSsQMwBBAMCXSNM5o3XsAiXBE7QoapBR3
         oFsmMoepf8PQ2k6cPjH1VONlFDTi2uGiYJwTNyBuFzLsjPgBaCWidUUehwgTJLegIoqG
         lGsdWHtYKhpLpMqz7iRCXpqGdpn8JjE7CHAwHvd8VjcRWq72DU5dWXdmvG08Slo0aNLd
         //0g==
X-Gm-Message-State: AFqh2kpWSueYCmpzVhov/fSVsOzDdJYCHZ6m2D5bUb8Yl1H2o8k2Zxq1
        G/IOP6Saw66p9XtIetg8jno=
X-Google-Smtp-Source: AMrXdXvxhJE8Dmv9b3bsUkYcJhIHmMT+f58j6O8BvI91feySsZcpZ7LH/8/RlRuBI7KnzrarU5KfJA==
X-Received: by 2002:a17:902:e009:b0:189:db2b:ac1a with SMTP id o9-20020a170902e00900b00189db2bac1amr18503908plo.36.1673894359141;
        Mon, 16 Jan 2023 10:39:19 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ecca00b001891a17bd93sm19763752plh.43.2023.01.16.10.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 10:39:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 0/6] cache API: always have a "istate->repo"
References: <cover-0.5-00000000000-20230110T060340Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230112T124842Z-avarab@gmail.com>
        <xmqqtu0u2q9u.fsf@gitster.g>
        <230116.86a62izjg5.gmgdl@evledraar.gmail.com>
        <b2eca967-4c52-3f8d-f3fe-b1ed41b06280@iee.email>
Date:   Mon, 16 Jan 2023 10:39:18 -0800
In-Reply-To: <b2eca967-4c52-3f8d-f3fe-b1ed41b06280@iee.email> (Philip Oakley's
        message of "Mon, 16 Jan 2023 16:53:41 +0000")
Message-ID: <xmqqlem2coix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 16/01/2023 13:38, Ævar Arnfjörð Bjarmason wrote:
>> On Fri, Jan 13 2023, Junio C Hamano wrote:
>>
>>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>>
>>>> The "struct index_state" contains a "repo" member, which should be a
>>>> pointer to the repository for that index, but which due to us
>>>> constructing such structs on an ad-hoc basis in various places wasn't
>>>> always available.
>>> I'd exclude 6/6 for now, as it seems to depend on some changes only
>>> in 'next'.  Feel free to resend only that step with reduced scope so
>>> that it applies to 'master', and send in incremental updates when
>>> each of these topics that are only in 'next' graduates.
>> Okey, the 6/6 requires ds/omit-trailing-hash-in-index. As both it and
>> the 1-5/6 of this are in "next" now I think it's best that I just submit
>> the 6/6 stand-alone after both of those have graduated.
>>
> micro-nit: The commit message of 5/6 starts "As we'll see in a
> subsequent commit..", which may need a slight tweak if 6/6 becomes 'far
> away' in the commit tree.

Indeed.  

I'd use 

	Hopefully in some not so distant future, we'll get
	advantages from always initializing the "repo" member ...

for now.
