Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B190C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 07:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiKIHGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 02:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKIHG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 02:06:29 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534A91EAD5
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 23:06:27 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y13so15888236pfp.7
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 23:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVQ0aAafEcS3BTGXeTrsuUf4jP7vEch2QOLtqFhlmmE=;
        b=Lu9XygPz5iREG1ILL9RWTl+vRDRHUQypXga65CAzo/Uq5npSfDqg5SD6owSF5rEjgt
         6a9u4CABQxUORi0mPx68uof0VobQxrbJkS1SOk4/smiX23BEHq7FebQTfaKMxV3aVP7b
         346AN54gZVPIe+LvcI3C25hFC+ZIPl4GKKEzSsOyyqce3JlSMQxT4GAON/94NwgykE8Z
         s1N64XmGO1epYMHUD3o5BeRcAMv+yISOiH9at6/UDMiUX31iDNA4JbcFqeHTX7HFwvFg
         V9XFgaHsbzfi7dq6MMrJot2DX7QcHhHE80maSugTNip+EX139mm6FpxyrJkFoI0ym6fx
         aYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVQ0aAafEcS3BTGXeTrsuUf4jP7vEch2QOLtqFhlmmE=;
        b=d+72gyF9vqhhabf5BigdrjwJBUjysdZwtrbc3fZG4qkxIpRHcZIZjzNBLsig8eyaR5
         RD/7IKrGT6BDDbwllM7x32QTU/0vZKD+9hVkxumZ1pTqVokGi+6LArztw5dYnjUaEWYz
         6RlFCc5SAm/0wV8S9IBbxswMhIX1ms3NLdaG54CBiMDrO8gVcV4aX7qkhqHI+gHJA4oG
         k0e7mygeepchsl1Lw9y5b/I5KAj9YXB5wpwwlox9S9csVDIEL8cfuHuGrdn6CN3PP8hq
         EglVp9+5AcaCtDZWujgOted3HyvavrDvMdOcDwZYcxQUia1JP3h7F3p/ffHcRShVswc2
         An2w==
X-Gm-Message-State: ACrzQf0N9y+98402vGu6waj4l/Ky/z1bNkV6pbk+rT+mjlufNTFHkJ1j
        H/1Jg0cNtmHUsaF/9yFrWSo=
X-Google-Smtp-Source: AMsMyM7dVncxaxLofQya20bJTbYp3yrYmLoASxF+SFJedX0jpat+kjyRZruyxY0U+i7/JBJKzSUhlg==
X-Received: by 2002:a05:6a00:2446:b0:52b:e9a8:cb14 with SMTP id d6-20020a056a00244600b0052be9a8cb14mr59568787pfj.32.1667977586787;
        Tue, 08 Nov 2022 23:06:26 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.63])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902758700b0017f7e0f4a4esm8226047pll.35.2022.11.08.23.06.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2022 23:06:12 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 0/3] notes.c: introduce "--blank-line" option
Date:   Wed,  9 Nov 2022 15:06:01 +0800
Message-Id: <20221109070601.94086-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.386.g72e528ee3df.dirty
In-Reply-To: <221107.86zgd2vma6.gmgdl@evledraar.gmail.com>
References: <221107.86zgd2vma6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ævar Arnfjörð Bjarmason" <avarab@gmail.com> writes:

> > From: Teng Long <dyroneteng@gmail.com>
> > [...]
> > * drop unreachable code in "append_edit()". Ævar found that some code has been
> > unreachable in patch v1. I think it's because, after the commit "notes.c: fixed
> > tip when target and append note are both empty", for example in this patch, the
> > situation of "removing an existing note" should be impossible unless a BUG when
> > trying to do append. The tests are passed, but I'm not sure I fully understand
> > the original design.
>
> I suggested squashing that BUG() in 3/3 into 2/3, but reading this again
> I think it should come first.
>
> I.e. this seems to me like the code in cd067d3bf4e (Builtin-ify
> git-notes, 2010-02-13) might have just been blindly carried forward to
> both "create" and "edit" in 52694cdabbf (builtin/notes: split
> create_note() to clarify add vs. remove logic, 2014-11-12).
>
> But it would be good to have confirmation, e.g. if you check out
> 52694cdabbf and remove that "Removing note" branch from add() does it
> fail tests at the time, but not in the case of append_edit()?

Thanks for mention that. I look back to 52694cdabbf and remove "Removing note"
will make the test fail, because the notes operation "append" is different with
"add", the latter supports to overwrite the existing note then let the
"removing" happen (e.g. execute `git notes add -f -F /dev/null` on an existing
note), but the former will not because it only does "appends" but not doing
"overwrites".

So, I think may just remove the "Removing note" code in append_edit() is OK.

Thanks.
