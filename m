Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FF6C5519F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 17:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3151D21D40
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 17:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaH6ol0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgKLRkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 12:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgKLRkG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 12:40:06 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85393C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 09:40:06 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id u16so303840vkb.1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 09:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKBq+HSK3AA7MGk5LwDUhDCnWOUEIO47C+bSrRTu99A=;
        b=CaH6ol0wN4vIBNqSuV28h3qkKVSW+oPNiMOBBJmziQl2OC2KZF18pBu2zI1UXdJaEJ
         yn//1guyWwNXUJn7DlACSixyLrP9MNH27OLSeXtnMSj2B3yBDtzDJ56fjXij2N20oTqS
         zswdAnSoNyQ5bTqmu6Gyf9Fyiu+2CJ/02XDpL5Y/JlHuC+N3B8c1nW0IPWY63Bo9rw4n
         GzMsvG3tyPabnqUhd07/5aE/VBySu0rAL/OTi7jcMQdx2tPFk83knph7Or1S9AG2ywmn
         PAALX6HWlkuMMF2sGz/HpaSwkgxCIGiq2JB3WPZTsHZ3/PnNVBa0i69ojvVX+1/yYVHY
         xWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKBq+HSK3AA7MGk5LwDUhDCnWOUEIO47C+bSrRTu99A=;
        b=WF4eZVmqtT0VTlq6bheD6EvImjAUoxdAFPNh4qlKq7UxKep8VLQHTheB1BYKFduk8n
         tJk0P4ShPb98LdcdLP1uPzZXFFljU+FecW8mDlUQr8hxn2lZVL02orq7QvllIPPUiQ6N
         /DMUc30ycXEzc2GJ5Go57unE95YgFHH5UWMrI4WiBtDxrOU9YM8WAVus1I0pdXnDztnO
         e156YRc7ZCFXI4furFxerte05AMTGqqMQDQr08vt0NMokotXLuJlus5Sjx195phEVTUw
         yinJqJqy0KGZS89GsFVKXAJRpkdV5d4/Lvub8fIlaOnGW97gm47AwcDhwNU807hJsexY
         dgpA==
X-Gm-Message-State: AOAM533r3EpEFaqCAmw+XXMYR/47+j6gkwGdvInpwu1BFXtHl4+C0PEg
        eeSLtIHb5Srcn60SumtphUWCPxnCtaaToF52TK0=
X-Google-Smtp-Source: ABdhPJzgNAef+63VWrquw9xntOAidw1Qo3CdpS7Zmalj3Ix92wFl1LDkug3aasUY8nZ1c9dDZfyrUC8yQqd/G/NiZoU=
X-Received: by 2002:a1f:1b92:: with SMTP id b140mr989706vkb.7.1605202805765;
 Thu, 12 Nov 2020 09:40:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605123652.git.me@ttaylorr.com> <c59fcbcc67556c5c9c5a22a2ee745a2f58234efd.1605123652.git.me@ttaylorr.com>
In-Reply-To: <c59fcbcc67556c5c9c5a22a2ee745a2f58234efd.1605123652.git.me@ttaylorr.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 12 Nov 2020 18:39:53 +0100
Message-ID: <CAN0heSoVS0MhEN_91da5Uv=jimLRcEu+EX1mocm2+quB559vsQ@mail.gmail.com>
Subject: Re: [PATCH 02/23] pack-bitmap: fix header size check
To:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor/Peff,

On Wed, 11 Nov 2020 at 20:43, Taylor Blau <me@ttaylorr.com> wrote:
>
> This meant we were overly strict about the header size (requiring room
> for a 32-byte worst-case hash, when sha1 is only 20 bytes). But in
> practice it didn't matter because bitmap files tend to have at least 12
> bytes of actual data anyway, so it was unlikely for a valid file to be
> caught by this.

Good catch.

> +       size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
>
> -       if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
> +       if (index->map_size < header_size)
>                 return error("Corrupted bitmap index (missing header data)");

I wondered if the "12" in the commit message shouldn't be "32". We used
to count the hash bytes twice: first 32 that are included in the
`sizeof()` and then another 20 or 32 on top of that. So we'd always
count 32 too many.

Except, what the addition of `the_hash_algo->rawsz` tries to account for
is the hash aaaaall the way at the end of the file -- not the one at the
end of the header. That's my reading of the state before 0f4d6cada8
("pack-bitmap: make bitmap header handling hash agnostic", 2019-02-19),
anyway. So with that in mind, "12" makes sense.

I think we should actually check that we have room for the footer
hash. I'll comment more on the next patch.

> -       index->map_pos += sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
> +       index->map_pos += header_size;

Makes sense.

Martin
