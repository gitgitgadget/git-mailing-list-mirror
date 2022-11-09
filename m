Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F37C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 07:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiKIHGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 02:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKIHGN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 02:06:13 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EE01EADE
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 23:06:12 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i3so15876841pfc.11
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 23:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVQ0aAafEcS3BTGXeTrsuUf4jP7vEch2QOLtqFhlmmE=;
        b=ldVrjsXo+0MdnKgTMWtAWUvraxyCaBjt//8KekfYsthuwh3VWTkuEjdWjihZSMDlwn
         3FdNM6ChgnwfLCo2ex40aQyjfRNDM2Jah+cNX8H3ZJxfI3o5A0ZaZZQ7wrPZFOiGmrr2
         Lyzqa2tEO2m9N67QNzP//gv2ZBPt4RhUllCMZ2s/136Z377ooi2L6UbKMLz1pvVUIJDx
         XdvWgLEJi8CGS3LIk8lBdrFbLYEh0E7X6ixFMu9YrA7KO7L5q2wOjnGF8Fycyb7aNLT7
         LEu7V2aYF1Qc3ftgV8JnuO1cdFOtnSnJNndZzHy/LKYv2SDcNCijZ7jj4o2APQALz76i
         Qr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVQ0aAafEcS3BTGXeTrsuUf4jP7vEch2QOLtqFhlmmE=;
        b=KfbXDLvAPHuJ8AQ1lOc//8cw+rYZd2VE6FhH0HHaHndPbeGxE7X0bn1pHtlKPnsh9k
         XBH2+t27q5LaA7hfMv3WlKRzLjqmEKXB1+HZ8rDKZv7k2DZGNF48fUWGGf171HS+cgF2
         BW3uqVdNp238xFnAuuD70SHTyJ2UIw5I7dBbsVTiaoCfklRlVJZmXoR0+utIkE7U+vzX
         2Eri9Dq4E6XVHqCRZ/jWl5GmUdhk3I7WJ+VdwZdfVtZsTlyvEpzeUgBy/i+eu/dOfac+
         zakZwf1DbrDF50wMoJ/ovEHCOyFHryjtPEI3JYnuQnqAF+weSL2es6HMSqnFP/72VYva
         PLoQ==
X-Gm-Message-State: ANoB5pkn5ZqS67SYzov83hKM90BnKjG/uoH2jsUNbCmg5sv7Mh37UpIb
        8U7ejqTqSlK5yf6OefVrL8af5tG+VFuWUfZE
X-Google-Smtp-Source: AA0mqf4AZh16S33UIfNFMR6ZsooozAYNA99vADJzZxjaXKclhttiLpuWwke4tlzfza3HSvw71T/B2w==
X-Received: by 2002:a63:cd0c:0:b0:470:5d16:8941 with SMTP id i12-20020a63cd0c000000b004705d168941mr17224852pgg.610.1667977572129;
        Tue, 08 Nov 2022 23:06:12 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.63])
        by smtp.gmail.com with ESMTPSA id w69-20020a627b48000000b00545f5046372sm7450078pfc.208.2022.11.08.23.05.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2022 23:05:45 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 0/3] notes.c: introduce "--blank-line" option
Date:   Wed,  9 Nov 2022 15:05:26 +0800
Message-Id: <20221109070526.94055-1-tenglong.tl@alibaba-inc.com>
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
