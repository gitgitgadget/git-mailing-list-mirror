Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BD7C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 07:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiBJHVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 02:21:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiBJHVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 02:21:09 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BD9C56
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 23:21:11 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so5404273oov.3
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 23:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Zb+L76FvyPFIRvO4TZLbp8nJXC51FTKad0J/+u05ik=;
        b=lyImeXAOWVWzgRfsblx4Y3Ntcnq2h7ed91b/GobL/I7e0SI8SkR5BoQSI7/q1YLMSI
         Bpc4jSoamlcl/w7+Bv29zRBC068FMcgMwt9q3GCbnPxGFVf/Yvb8KuFjyZWAy/OH7Fm5
         W/a+CwBWLoFnYUXSDq32WwKYdJfvsp1is+oc+/ZWnogK/wBxNW2DkJ0Khfrdlrawi5Ze
         bTMY5i11+kclvWGZbQgOam86UdAQ7hClgsbcT4wQ3L/zyzVnY8HyfwBxv6D9B/GPB6uX
         P3DEcWWf9gqoN24H1yw9NMR92jImHiu8TKK24eCcOV0WKSps1P92qiIu48QaQd+qqYQO
         6hTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Zb+L76FvyPFIRvO4TZLbp8nJXC51FTKad0J/+u05ik=;
        b=svoSseAeC+diGX5KnuOItD4Hqmp9hyh4IrO539xQr//xbCyu2KlZGpOM8VuVnAjP40
         NKKccOQ1d3AnjQVkxXdVj6bmfyCnL+zeKjHNDtjA9vowacbeKDuJge99nH/MWdXf9EAe
         OwGhsy7SiboXUPsMowY9O3R8lHt56NnfCBoet/qqVSgM6O2BAzSEyGN39BAk/FrdgHpY
         q7bCVJ+W282jsa4PzP2RtTJNDqvehX0ESyZPKgyX9dkjiyg/zA0whBYuVyYI37n1RS4Q
         5RZNdgPpwi+bQjpBAMS5CVG8N29OlqOpGXngZNyXSb0obudRPkrUszdAKJKcyvSOzYZ7
         lOGA==
X-Gm-Message-State: AOAM5327rshobG6uU487GlYP9b/hEX7btult4Wo5+xpht9V5+SxXGH51
        nH5MXjPPtuYoIFyHBL58hY4QDOQlShasSgoCESrh+FG2ybE=
X-Google-Smtp-Source: ABdhPJw7EZ3a9Dpy4Uh0DTyLgxIemFSvmfCyaKoQobqK2kfxgIiU36P0VZ9aLNSrxpxE49vBJ8w0withRmfqhZZ/ZNU=
X-Received: by 2002:a05:6870:d452:: with SMTP id j18mr403585oag.174.1644477670946;
 Wed, 09 Feb 2022 23:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20220121102109.433457-1-shaoxuan.yuan02@gmail.com>
 <20220121102109.433457-2-shaoxuan.yuan02@gmail.com> <Yer/oEZK6TBFSsde@nand.local>
 <xmqqr190g6gd.fsf@gitster.g> <CAJyCBORHE2+UMKYFfKArgK68fAT=pKVabVmfifzg--rHAFkaqg@mail.gmail.com>
 <xmqqo83fw5yc.fsf@gitster.g>
In-Reply-To: <xmqqo83fw5yc.fsf@gitster.g>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Thu, 10 Feb 2022 15:21:00 +0800
Message-ID: <CAJyCBOTBcvgAcSaQ4xs-V=M-im_Umf3ymsWzCAGEmrj6b38pEA@mail.gmail.com>
Subject: Re: [GSoC] [PATCH 1/1] t0001: replace "test [-d|-f]" with
 test_path_is_* functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 10, 2022 at 3:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:
>
> > Since I didn't see this change in seen or next, do you plan to apply it?
>
> I actually wasn't, as my understanding of it was primarily your
> practice.

Understood, thanks for the reply.

--
Thanks,
Shaoxuan
