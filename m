Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA44E81E1E
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 18:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjJFSCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 14:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjJFSCp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 14:02:45 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24ACB6
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 11:02:43 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bffd6c1460so28374821fa.3
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 11:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696615362; x=1697220162; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oTVnsQfZzfCGpOCP3ZeoHbZ4MdqJyHKYmhpZBpwrTGA=;
        b=S6qn9CBfO5IOZ5RXgmTRLc9WFK55DyUgkli+s5QgN6LmdrF9I/S46yVczIRa9AIMyS
         97eRfbJLEPLUniG9JTOczWvOJZu1TBU8sjmuFb8ksLC/JC4wgci1uORhLnzCBL4jILNR
         SYuIhEVfbV/87PFCn/FyQtdKi0ObtLni5lyMPmrVslzw4RkYW+lJ/fek4OC4mpUN6aHp
         3Dv2y0CTGqsE1rvFarETbcPWpVOudWHdTDy3cODi/rPxTnG/beccVcluy3I5IkwOrBYa
         eukHm2TyFrCN9Ue8sAef72iJxrZMuw0i4/qGwEbpo0uGg6eUh95WcHha4H2mhm6wuVyG
         8qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615362; x=1697220162;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTVnsQfZzfCGpOCP3ZeoHbZ4MdqJyHKYmhpZBpwrTGA=;
        b=p135L5G910C0HgRxY2QXIdEz44wCYoikXnkWdSadLnjU9PxSWYBnxSO+qX2FOtb+DX
         woJzFLM/L56+hio5V9WR3v9eJEvjR+yaeMI4evUeSBQkYWiomCQ1fgi01H2WHRj5fFHl
         r1uOFnlxHRBPwpDwYOGRU8BuyXOpnxrQUqoj83yxQ6Nz2aMk2CKi53hOnCkyWVckQop7
         9Nlcc5Fmd65KmeBYAFIaeN9EVnelGRUf0UdlKFHu5rZVIVt0dAM1/1hpxqrDjAIRHoyi
         2IlPaOkJtQ+O4GNACI7/iB9DNh5ZX359GT7epCM1A104Xupsf9wHWeJquFQICJ0xmqTz
         XQ4g==
X-Gm-Message-State: AOJu0YxiL/qU30A/vtixuKbMSg/Di9lZ3d7P8TmTS9TojZh4Qekn4+rY
        AEk81t8n9GiUMTQBDgJhMWtgow07GBI=
X-Google-Smtp-Source: AGHT+IGRo8mNVHWVCI8Rm/SH2sLJIj2zYiO4UXOUl96HO+X5BQhIRs0qSFpGnu3jTRAjy5/anoOFmw==
X-Received: by 2002:a2e:8310:0:b0:2c0:a99:68e7 with SMTP id a16-20020a2e8310000000b002c00a9968e7mr8040337ljh.19.1696615361557;
        Fri, 06 Oct 2023 11:02:41 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k19-20020a2e2413000000b002bcdeeecd11sm836969ljk.66.2023.10.06.11.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:02:41 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #01; Mon, 2)
References: <xmqqedic35u4.fsf@gitster.g> <871qecgpg1.fsf@osv.gnss.ru>
        <xmqq34yr3btn.fsf@gitster.g> <874jj7lh7x.fsf@osv.gnss.ru>
        <xmqqo7hessro.fsf@gitster.g> <871qeay6tz.fsf@osv.gnss.ru>
        <xmqqjzs1mkma.fsf@gitster.g> <87lecgeqfu.fsf@osv.gnss.ru>
        <xmqqh6n4eo7n.fsf@gitster.g>
Date:   Fri, 06 Oct 2023 21:02:40 +0300
In-Reply-To: <xmqqh6n4eo7n.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        05 Oct 2023 14:47:24 -0700")
Message-ID: <87il7jr5mn.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Overall, as an example, I'd understand if you had deflected the patch
>> with "let's rather use -d for '--decorate=short', or '--date=relative'",
>> or something like that, but you don't, leaving me uncertain about your
>> actual worries and intentions.
>
> Oh, I would be very much more sympathetic if somebody wanted to make
> a short-and-sweet single-letter option to stand for "--first-parent
> -p", if they come with the "first-parent chain is special---it is
> the trunk history of the development" world view.  And the resulting
> behaviour would be "give me the diffs" in their world view, so I
> would understand if they wanted to use "-d" for such an operation.
>
> However, to folks who do not subscribe to "the first parent chain is
> the trunk history" world view, "give me the diffs" is not an
> explanation of the resulting behaviour, because in "-d" there is no
> trace of hint that it is also about first-parent traversal.  
>
> So "-d" may not be a perfect fit for it, either.  But at least it is
> based on a more consistent world view, I would think, than
> "--diff-merges=1 -p", whose behaviour becomes unexplainable when it
> hits "reverse" merges in a world where the first parent chain is not
> necessarily the trunk.
>
> Anyway, I've tentatively queued the "--dd" round.  Naming is hard,
> I cannot tell what "dd" stards for, and I suspect no user can X-<.

Thanks, it stands for diff-diff (for both merges and regulars), and got
inspired by --cc as well. Also selected as being fairly easy to type.

Should I add this to the commit message?

-- Sergey Organov
