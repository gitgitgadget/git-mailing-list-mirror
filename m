Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9F3C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 21:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjBBVzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 16:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBBVze (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 16:55:34 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7179250860
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 13:55:33 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o13so3196741pjg.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 13:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD/pyF9DSkibS/HBC0R/+UKq5ebxpJd6FLDBy1ChHiw=;
        b=RWX0QCRtSA141IyvbWx6XMkvr4Wt6VYLeoxqSd+imqFcIP531UcvWU9iUp5Y3vUjDL
         2EpmV81T2iR1luyb+/ID8ngpnU/sozP71MzFA3ZK4NuSw/dl81f7g2R8FqnO3+Mxngpf
         87E/9mOk1MPr7fOday2x4Hf52XMHIZ2YggJRzN1VAYpuQ4vefengNS+SZCYVWdM2swwO
         KBUVsbgB6wfuYARt+BPHB/tF4qv9eDIMwr3wOrBpKjibEMlQHDLWbv4H1QNusB3tapVO
         33ttkdVHYoRdI3qbpTMfknm/8m8Vbs24v0rKtnJnAnUc3TCUSo4IaU5uCus9UNhfJFy0
         EljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BD/pyF9DSkibS/HBC0R/+UKq5ebxpJd6FLDBy1ChHiw=;
        b=wpzDSpQ0xK3Q21ordoAHitGtdK6ldRp9Ede0+kGkwzHb1ET7yd+tRCgio13FR7hrRH
         Nbbzmss5HxXmB86NtHEUzouqxEy6ekKc02HUQpEsscnqfDpivbwilPxwCr6yabJUc+cY
         f0MqYwg2b3Az6vvZAswmQvgMAMGQIBw/4MRZsza+M86XVVTaFmavKpghCvAaBPmYu9Fc
         u8i0qsB6esyEyGtFXeqxJPHnUFLWUEqVvSYqGKr7e1fNb4+9Dx5dfiMFlIjPqgziFTT2
         jBBaw3XMyuGA5krzjhsMclkfUcbPrJElFvwtC9mNLigRUgTF6/epGTcmjJobDcpPMzkL
         188w==
X-Gm-Message-State: AO0yUKW/10ALXW4mGS89TEInJO7HXNt9lI+dk7m9oA5in7dC/Us6ofen
        C47EUIdi2JTAP3tXEo38Kx308nlCBqA=
X-Google-Smtp-Source: AK7set9egvbPIXB4T++9hu0XdtgButQno2qW+UD1jXo56Yjn0L4zUU5PBC1zZub+kih+1p3AXYodJg==
X-Received: by 2002:a05:6a20:4282:b0:bf:51a0:2a06 with SMTP id o2-20020a056a20428200b000bf51a02a06mr9081047pzj.10.1675374932805;
        Thu, 02 Feb 2023 13:55:32 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id f17-20020a639c11000000b00478c48cf73csm236839pge.82.2023.02.02.13.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:55:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v6 17/19] receive-pack: free() the "ref_name" in "struct
 command"
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
        <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
        <patch-v6-17.19-4b2db91f5cb-20230202T094704Z-avarab@gmail.com>
Date:   Thu, 02 Feb 2023 13:55:31 -0800
In-Reply-To: <patch-v6-17.19-4b2db91f5cb-20230202T094704Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Feb
 2023 10:52:48
        +0100")
Message-ID: <xmqqo7qbspf0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Fix a memory leak that's been with us since this code was introduced
> in 575f497456e (Add first cut at "git-receive-pack", 2005-06-29). See
> eb1af2df0b1 (git-receive-pack: start parsing ref update commands,
> 2005-06-29) for the later change that refactored the code to add the
> "ref_name" member.

The above description does not really match what the patch does,
though.  Yes, command.ref_name[] member held varying number of bytes
in it, but the code was leaking a singly linked list of the entire
command structure, not just ref_name[] member.  And the patch makes
sure we will release the resource held by the entire chain, not just
the ref_name flex-array member.
