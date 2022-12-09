Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B649C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 08:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiLIIBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 03:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiLIIBj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 03:01:39 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96AB55AA4
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 00:01:38 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id s7so4125498plk.5
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 00:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sik2byz+Mek1zi5MKhGqGwlAn7dfxtlogj3Mxf23SE=;
        b=fdfpSHAn2kJIG7aZSJyRgo80HBtq/129uRtQdM/pTgTN6nNKKGEVuenUAfp/LO63KB
         7nRAXS3+OgdNpAVhpCvgddQpSCcXA6TCD6BR88Ib0o/VjMA2gmIFTxsk1JDqKzOX/2Yj
         ZvOYzU4vDoFip67obM9PwYOFiE/2HU8/3s85felUpUUGqlgOPA4dJ0mQA+IlZqGJrWyp
         COdUcntAXTx51Gi+X4tG3wIjvYlWEJTU9JtjzDFXoRg5qpvCrs0z58CMwGVWBSWcZpKZ
         dSr01vyXXpVkDDEDyFEmSYC8En+aC1ybSqvOcDAJTr8JKtHDug4O/2ZRYRWLg9NweWlp
         9/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2sik2byz+Mek1zi5MKhGqGwlAn7dfxtlogj3Mxf23SE=;
        b=JXfH11S15RsjdlkPNaywzESeMErrKyRxcTFjbVJQ78kvaV565gT2VV9LV578+F1aWZ
         lo1XPE9b4p/fFvmPKJB3FD2+V8rsW4vIMftB3WmzPZyfgqvryfNVcM5lly9owJSlaP5r
         uG9DBz+wnRKCCoqgjdRQzq0eT4yDcdeo22LW8OktNitgS3R1yB+0ZC780mFzmE/NA8UZ
         LPWtCZCxmcreZzW8GRqpvQXJ/fkr7bMvoEaEEvCyHUeivINk2Yjw8Wnh+bscmIIRiv/P
         Xs3QVaZ1lq/uZZSuDQhhp9B8LOzEjfHs6XIkZlSNLGDfcGS+wSAoBLmbuJhVjPDskXIa
         d37g==
X-Gm-Message-State: ANoB5pnfcZMgY29Wka46pF+rPOwNcfoBX7X6EYvZc5IeXblaPvy/IlQS
        LyogiMxu7Ysphc5goyg2krQ=
X-Google-Smtp-Source: AA0mqf597D9rBGzlagm04Iv/X62ehRMa2lqp1S5f+J1wy8bd1llj76jONi96FDXCuqBxD6rhGrlrZA==
X-Received: by 2002:a17:902:e851:b0:189:a6b4:91ed with SMTP id t17-20020a170902e85100b00189a6b491edmr6663677plg.17.1670572898227;
        Fri, 09 Dec 2022 00:01:38 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b00187022627d7sm732020plw.36.2022.12.09.00.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 00:01:37 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Eric Musser <eric.musser@snowflake.com>, git@vger.kernel.org
Subject: Re: rebase update-refs can delete ref branch
References: <CAGW=zr_BD=7d5dZi+yO4cpufFi=jEjH=wQoTndDLfTi14UresQ@mail.gmail.com>
        <8edcef4f-4438-e07a-a6fb-698b6179fcc4@github.com>
Date:   Fri, 09 Dec 2022 17:01:37 +0900
In-Reply-To: <8edcef4f-4438-e07a-a6fb-698b6179fcc4@github.com> (Victoria Dye's
        message of "Thu, 8 Dec 2022 23:50:36 -0800")
Message-ID: <xmqq1qp90zvi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> I believe this is the same bug as one reported back in October [1], where
> deleting all 'update-ref' lines from the 'rebase-todo' inadvertently causes
> the rebase to delete those refs. The bug was fixed in 44da9e0841 (rebase
> --update-refs: avoid unintended ref deletion, 2022-11-07), so you shouldn't
> see the issue anymore in Git that's built from newer revisions (e.g., the
> latest pre-release v2.39.0-rc2 or the upcoming final v2.39.0).

Thanks for digging the history.  It is unfortunate that, even though
the fix exactly identifies b3b1a21d (sequencer: rewrite update-refs
as user edits todo list, 2022-07-19) as the culprit and it is trivial
to see that was shipped as part of Git 2.38, the fix was not queued
to allow merging 44da9e0841 into 2.38.x maintenance track, so it is
unlikely to appear in any 2.38.x maintenance releases we might issue
in the future.

But if the users can afford to update to 2.38.x or 2.39.0, picking
the latter is always better, as the newer feature release has longer
shelf life ;-)

