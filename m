Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBF1EB64DD
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 05:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjHGFh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 01:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHGFh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 01:37:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE95910EC
        for <git@vger.kernel.org>; Sun,  6 Aug 2023 22:37:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5734d919156so35100567b3.3
        for <git@vger.kernel.org>; Sun, 06 Aug 2023 22:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691386675; x=1691991475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gk7QTNrE94M3W1KQVEcE7NRtOPwpBa2Ig17RqbawF9w=;
        b=X3Q1RqFKS8zo+2AsaVkVFNCjRr4patxg8zz7VFmllyScdK5P19QFRFg45gH2/3vqg4
         Na8pOgHpv623P1+bLke7zwEXpKvoGL1PvBvAsf0+qJHovSNjvan0xOoHsSlac6rKeqzj
         QZ31fSLVaGXUdK4/8wcw/eQ5Xiwff2JOhpbJlZfH2pFMP4Zh3NVRgXEbRn1SlAzZDN01
         +x5MFDmbMDsIiYxg00/rp9CHzXZXvSOvsnvYeLF7401ezW+xMgdwP5bcFJBOeV0hMhbW
         hbvcC1Mo1ev7qpUukeS5Si19kKU8JmZcCqBnQi6ONrp+jPsRh+YW7s8Y82KimwenOtyT
         Luuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691386675; x=1691991475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gk7QTNrE94M3W1KQVEcE7NRtOPwpBa2Ig17RqbawF9w=;
        b=Zs93jsBgcers1xF9+7cC5glguiyiu7Qmb65npS3r6AvFsH5RFgWPnBJ0ntxvmXeKg/
         ZOFMWhNdbzYPCPnh6zL12iQfl7/2NQzkfnFm6g1wJw98B3G4V7lvkhAMRqWaEK1An5hb
         Zsdrf5rhmrcZFCbzlqYadmpkSSr58QsjivjTuIvRlmjXxWc3NtmicJ5YpNru97m9iowk
         5gCp7VxkrbT/6VBd/2lU0uYpP2L4D3ZwJvbrJGQYbAVnzAMfB6ejfMzGDJrvhiG0GCLt
         onc+RK4vFcsBN+JgCu1ry2DLdWEPRjUV84CMvomQaJ2s4FD0hoStsflJMlmWktvvCXF7
         VP1g==
X-Gm-Message-State: AOJu0YxelJWzxPmt+o3tCkP+KXREOCKdGAha92UWLblwQ2zTWKWq0O2I
        uoA3X0+gvg30VwieqXr+aBNgNaSTfqA=
X-Google-Smtp-Source: AGHT+IEV/77HGFN3dKbsEHHsBtGCIf6p5yjW6XXHhFY1lbhHZryg8I+vBfmenLMbJOTJ1B+SBX5tD+dnGfs=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:dbcf:0:b0:d01:60ec:d0e with SMTP id
 g198-20020a25dbcf000000b00d0160ec0d0emr53019ybf.9.1691386675763; Sun, 06 Aug
 2023 22:37:55 -0700 (PDT)
Date:   Sun, 06 Aug 2023 22:37:54 -0700
In-Reply-To: <owlyfs4vbeus.fsf@fine.c.googlers.com>
Mime-Version: 1.0
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
 <6b427b4b1e82b1f01640f1f49fe8d1c2fd02111e.1691210737.git.gitgitgadget@gmail.com>
 <xmqqjzu7irhw.fsf@gitster.g> <owlyfs4vbeus.fsf@fine.c.googlers.com>
Message-ID: <owlycyzzbefh.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 3/5] trailer: add tests to check defaulting behavior with
 --no-* flags
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> So if I configure this like
>
>    git config trailer.ack.key "Acked-by" &&
>

Oops, I meant just

    git config trailer.ack.key "Acked-by"

without the trailing "&&".
