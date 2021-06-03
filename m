Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7635BC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 07:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5746101C
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 07:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFCHUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 03:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFCHUq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 03:20:46 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43760C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 00:18:56 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id x18so4607062ila.10
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 00:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3wlHuX9ejmeRWXexOQdD5epm9xI/XG8N894NWly5JD8=;
        b=rCXvd2Qw6r6TvOKOdrJ8a5G8qdyrUqnd3trZ0YOMPt3R4r81G4WgqQdPvGmLexHq+C
         AkYzA3uF5QaPYU7WgvmwAjLzm7IK9JEwGC54dEPMIo3LugzTWMSwOOwEcIMuy7hXKY2B
         CrwzmRFC8XG4mzeoTPRXlGqri9ghCBuUujk6kQFbl6BTZ2PHg01fz0EaxD2EYgEkpQS8
         MHGEg81nFcyM3bkzxBynQ+RSFzX7q05mvcqKWvRrs9dRf9OvBuTYXTD2hfvBp5iSEh/b
         HW5Juo1NZOcGIl7VwtHAVasxbWuagXqlI933DP0hHYxsGZD7ldSCdv93LitHLm9ts3ct
         zpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3wlHuX9ejmeRWXexOQdD5epm9xI/XG8N894NWly5JD8=;
        b=tTyBDIExUJE7a1x3/74/LW2v19188UbzgQ6x2hcTZ7y5kmqBUpxOIUSYWi+V8B0KX4
         OCT7dyqPZfl+oEJPCLdXpFxBQRW7wWnF6rPLUJQ25bwBEXY9ImFbf6o7SK9L7hGC3Frx
         aVDaICH7Ff2oYq39g0ISxiB5m0u/n4IeuBJCjES0FP199rzuShw67y7B3VuP0jDIfHeq
         SYhmdBlKbQhyI1G3PE+aOS9MaKB87AbtsIt7TuM3tzCtci9s91F2VHO2ejw/eSZeULe+
         0bLOU4OVj7lQiYo/iMXkoSa9740cIfFMrlgNltN+CqAEBApJ8BTWIPosv0WiXrlcgpgV
         bo2A==
X-Gm-Message-State: AOAM532TxZd0yPIZHSS5m28RiOC6caA6Jx2g1BhndtgK5xffQM22Neb2
        iAoVxUCXvHHRsSHUO2b20P/Z1CLvNoqkl8+wHc0=
X-Google-Smtp-Source: ABdhPJwd1qmxrlaZjjhNsGczoAzavRkKGlOo+BOf3b4DMPP0FqXBdO5dOrE5Sgm2locdKTUO6hvzYJ7wDCFQvbVlTTU=
X-Received: by 2002:a05:6e02:1063:: with SMTP id q3mr18387513ilj.259.1622704735636;
 Thu, 03 Jun 2021 00:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
 <495cd90dbaf43e957d03edd2fdc7449b39eee53a.1622558157.git.gitgitgadget@gmail.com>
 <YLZXyBJ5YgGfmkKv@coredump.intra.peff.net> <CAOLTT8SCeKy74cVO3K5zJ5n=0s=o9zk2ipV5wM6CHQPzRoMi5Q@mail.gmail.com>
 <YLfjexczp1/HILWj@coredump.intra.peff.net>
In-Reply-To: <YLfjexczp1/HILWj@coredump.intra.peff.net>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 3 Jun 2021 15:18:43 +0800
Message-ID: <CAOLTT8QMpMV=7A4ZP2k5YUrqjznBwh_uDv+qvC7Meq3pwvZt1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] [GSOC] cat-file: fix --batch report changed-type bug
To:     Jeff King <peff@peff.net>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2021=E5=B9=B46=E6=9C=883=E6=97=A5=E5=91=
=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:01=E5=86=99=E9=81=93=EF=BC=9A
>
>   This assumption was broken by 845de33a5b (cat-file: avoid noop calls
>   to sha1_object_info_extended, 2016-05-18). That commit skips the call
>   to oid_object_info_extended() entirely when --batch-all-objects is in
>   use, and the custom format does not include any placeholders that
>   require calling it.
>

Or when the custom format only include placeholders like %(objectname) or
%(rest), oid_object_info_extended() will not get the type of the object.

>   This results in an error when we try to confirm that the type didn't
>   change:
>
>     $ git cat-file --batch=3Dbatman --batch-all-objects
>     batman
>     fatal: object 000023961a0c02d6e21dc51ea3484ff71abf1c74 changed type!?
>
>   and also has other subtle effects (e.g., we'd fail to stream a blob,
>   since we don't realize it's a blog in the first place).
>
>   We can fix this by flipping the order of the setup. The check for "do
>   we need to get the object info" must come _after_ we've decided
>   whether we need to look up the type.
>
> -Peff

--
ZheNing Hu
