Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF83C77B75
	for <git@archiver.kernel.org>; Tue,  9 May 2023 00:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjEIAD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 20:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjEIAD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 20:03:57 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3042B7D95
        for <git@vger.kernel.org>; Mon,  8 May 2023 17:03:57 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-643990c534eso2578313b3a.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 17:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683590636; x=1686182636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHyO74QXT6E8WzE0VYa55ISbOoFERpoWCZX6hf1xet0=;
        b=Uw+E6mg0q/iWzoKzEmN78Eq/uVZbpfymQyMxkUaQ4ONX109mX5wVKRUrWJ2UtbZejo
         BGFDQFC6o9dd6ttSoOIemWsjpz5fERK+bArl2Bln54MLFbxhwhA0FeL0/2jzz+ZAA5eQ
         +HewDVWO7QZ3FjDd13LRfJNdZKuTX5ojHn65w0HPgyd2sMhXmhX1Dtvi48UloaM8L4fh
         zr0FbCC7rX+ALPk4NzURoXcu7HGbZLPsdhKvKnc9IyjqJuUdT/HDW0ds8h5qC0zzp0EH
         9dyG2PR6F9kFWOJ3toDzu1ycDZ6BnUctY0GEjN4stHsWaqFhxaja/6g6f2QF55CgDmTx
         WMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590636; x=1686182636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHyO74QXT6E8WzE0VYa55ISbOoFERpoWCZX6hf1xet0=;
        b=ODD1xLVPGvFMcNomdbNz0qQtwyVCSKRIlORdrFlif38BN+BuSOCF/Rc0tWHVg2JZZg
         sKvCut0pvkL8rAORbk/OJrrEkX2gcDWQhEcYh6cEU1eDjXLBfKudXFJwvJk2B1/PpkNb
         ECCHcU5uYot+68+hxOL3sW2XnDXBuA0fR5dKgyGdTqKUA/Z6k16tlKwn4aO804TFHG6k
         oM3bwzJAtftFPd3p+0Ghz5Cf/2Uj/GE5wYYFn5RK1l3/smbcphxKbMo6rL+gonHmMuuN
         cbsCU9lNxcWHNERnrAznn4lry+RyVmF81plMurWk3vagy1ehm+pxoYThmjf22X2Mx/Yv
         Cccg==
X-Gm-Message-State: AC+VfDwJS0PDblgB4r0RI58v1NY8t3JwUf/yy2WatN8pB1up7WuERiOV
        gMjB0vZMaK5p69VbgmJoJns9slOsFUBJaw==
X-Google-Smtp-Source: ACHHUZ62KaP01USx/ofR+dRqHsn+WISiUDymfGY5lZFTQZ9dC57pgXDl7uo1BajvZFOEPUijMF0yXPHVQMbJcg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:be4:b0:643:7916:16ec with SMTP
 id x36-20020a056a000be400b00643791616ecmr3236351pfu.3.1683590636639; Mon, 08
 May 2023 17:03:56 -0700 (PDT)
Date:   Mon, 08 May 2023 17:03:54 -0700
In-Reply-To: <e132d9494ee7d8c4eb3a7a82b6420743c8c7a9b0.1683113177.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <cover.1683113177.git.ps@pks.im> <e132d9494ee7d8c4eb3a7a82b6420743c8c7a9b0.1683113177.git.ps@pks.im>
Message-ID: <kl6lednq1ic5.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 8/8] fetch: introduce machine-parseable "porcelain"
 output format
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> +--porcelain::
> +	Print the output to standard output in an easy-to-parse format for
> +	scripts. See section OUTPUT in linkgit:git-fetch[1] for details.
> ++
> +This is incompatible with `--recurse-submodules=[yes|on-demand]`.
> +

We should probably specify that this will override any setting of
"fetch.output" (and perhaps add a test for it). Most readers will
probably guess that this is the case, but the extra clarity wouldn't
hurt.
