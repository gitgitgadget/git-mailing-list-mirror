Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311B0C636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 17:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjBUR0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 12:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjBUR0W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 12:26:22 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4C32ED76
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:26:03 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id bh1so5827197plb.11
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UH+MyeAVi0fvCQuaSZT2JkFaEZlP29n5ukNuY6IJ2Hg=;
        b=FBReEXe033jgwCh7FMOVp5chA/wz7uGZwwfulBZ+gecg4WSR3HbF2rf6Ei3lYfZtAs
         vvP1dfPh8bVenqIKOSkd56X9rfKmGhH1zyPmkyi9L5XQKyGaPrrtgnNYhkI3hbVLs8D2
         NsHqI84YewCQMSbWueUKHf62F7SJul251lsVsNv2s+kpl6sNZ8hE40C15OMZMK8aOtzt
         C7ZncNUfFANg3LjpgxYilqfNlu8HHcXPaId36FsgQ01icYkIw0sWeXhTJsfA5KtazXVl
         NkNyfGCDAMyARYnOs1Yj8MvMfjJhg6KzKd3TSklh9CkOQwypqFer3mWsJv8gCZ9dHmYS
         l9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UH+MyeAVi0fvCQuaSZT2JkFaEZlP29n5ukNuY6IJ2Hg=;
        b=XwF0o8Vt/yehIgZi912wMnlLBu8b8VhNUz9NNmJjNoG+5qzi0nOzp52hhkzBac2j6a
         dBjKccL5/DEz0rcCv/LAcKWoKjI0lKynygyZ91uhrjrDTZ4BrrQPbv2G96MK1WU53Aqo
         VpUQV5kAjD8snl74RIrjmf5+Mp11j5laKy0JlILCCCyOMgkh1UClnoAMgpN5xXPtB/Wv
         BtqOlXEC/Cc1W01OYRqWgIUkTw+emJqwXg6WlGUsmEIjs+SEOJuQV5yKi+FXqIC+RZHA
         tG3ePo9AEOLKR2Y22I84eCq/RYGg31XD1IvKdCdOLwuggjuUwB7NfJ1QFm9V1wzk/7jH
         ucew==
X-Gm-Message-State: AO0yUKX0KfxPZyTj9JjbbxyjUSF2U23ABP3gLwkJ4iQ/USjpD8Px2+C/
        Yzpv6PM6ohKCzbZKuPiaQ14=
X-Google-Smtp-Source: AK7set8mGaYlFX7M/tomOPx884zUHZnu/Y59NlUsaR2MVPhqf3ne1YwbR/siaNquRKncemnjRd4akg==
X-Received: by 2002:a17:902:ea07:b0:19a:f9b5:2f2f with SMTP id s7-20020a170902ea0700b0019af9b52f2fmr5541238plg.55.1677000362904;
        Tue, 21 Feb 2023 09:26:02 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id bh4-20020a170902a98400b0019ab58f47a6sm3100494plb.105.2023.02.21.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:26:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] rebase -i: check labels and refs when parsing todo list
References: <pull.1482.git.1676644675638.gitgitgadget@gmail.com>
        <pull.1482.v2.git.1676902774366.gitgitgadget@gmail.com>
        <f99d7043-7757-2e19-d1e1-4ee9b887af1f@github.com>
        <09ba35c3-1434-ac23-7ac0-1295dd8aca60@dunelm.org.uk>
Date:   Tue, 21 Feb 2023 09:26:01 -0800
In-Reply-To: <09ba35c3-1434-ac23-7ac0-1295dd8aca60@dunelm.org.uk> (Phillip
        Wood's message of "Tue, 21 Feb 2023 16:29:59 +0000")
Message-ID: <xmqqa617gcba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> (The "check_refname_format()" line is correct in your patch, but the
>> lines above it are not, for some reason.)
>
> Yes you're right, I'm not sure what happened there. I'll re-roll

Nah, thanks, both.  I've applied with reformatting plus Derrick's
Acked-by.

