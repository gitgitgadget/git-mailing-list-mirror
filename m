Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF668C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95103224B1
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502639AbgLNTn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 14:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502558AbgLNTnY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 14:43:24 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA44C0613D6
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 11:42:44 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id q25so20496473oij.10
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 11:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=D35EWQ1ebIenCbtPvK1J65nHSlt5NzgKqFX0LH22wgU=;
        b=nr0OcJ4l7fysJdpvs49M4b+SQiSQye+7PyQCggPm1Zfi8IAqj0VX4t9WJ4LEAfDpOo
         KmHfihGU10oCPWpfN6eVTusnm12Z9XAHvq35c5DoMLTGupEvGH4NO43SoTDBHM07WXgn
         M/fE0f9MIMm4ckDvEcICeIsYoi9hlkyNdyi8+wkfsMHf3JVYvnP+6QLDrkEhQWzBMrpU
         +azEg/Iw7fRR8ZwarMWvLwuJ4uHyTvQM8YQ0Ux664xcEB3pQNbFCmB5i0kytwuPOY47f
         u6WJIfBcAN0zPX6SJfiBFyDmPyHHPZ1adx7KxvfbkF7MhXgd2cHH1UqcKopGm9reMsHW
         ca5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=D35EWQ1ebIenCbtPvK1J65nHSlt5NzgKqFX0LH22wgU=;
        b=RHV9ooxljuleTDic7EOOxhnhyuhmxLn/azLPowc9z4z32FRR4Uk8FwYkUKR9HaKOvL
         KtNTmgevApTSNmY/9eaSLSPAnu8EP0kmLILo50B+qAgMbQlAqcbXpi27TlWnIAAC95vD
         PFA5S6FGnLVbv6yqpo9Rhno79wsmor/j6joWQ1/tZIF3rK7w/TRAaoVNq0GB7+4R5Sx7
         I8prGmsPdPm4Z4phOer8HXX4F3ySe41wVJQ6cuRHAzcujllbXQ25vaH7CR3q5ZI5CGyh
         ozKUtCmOIC5BCc40GJzW6SNsnhaSbQKeevKb9St/iLN1w/dQ2hz28h07baiudScgfQO3
         xRMw==
X-Gm-Message-State: AOAM5306WhoGiUceG33O9dm6au9iim/wAwH8sqSeoGI9igTl24WjHuvz
        ats6Qf9X50sxwNqxKXkxNOw=
X-Google-Smtp-Source: ABdhPJzFJ60XX+QRVyZTMudCI/W45sxNImVdJsVlcBOX/aL3YSH+7g7kLLCDQwdsW+stsZqj/UACwg==
X-Received: by 2002:aca:3cc5:: with SMTP id j188mr19615389oia.100.1607974963433;
        Mon, 14 Dec 2020 11:42:43 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id o49sm4533927ota.51.2020.12.14.11.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:42:42 -0800 (PST)
Date:   Mon, 14 Dec 2020 13:42:41 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Message-ID: <5fd7c03160b1c_d3c9c20853@natae.notmuch>
In-Reply-To: <20201214192534.3105508-1-jonathantanmy@google.com>
References: <87blewwoil.fsf@evledraar.gmail.com>
 <20201214192534.3105508-1-jonathantanmy@google.com>
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:
> > But shouldn't there at least be a corresponding "fetch" option? On init
> > we'll create head, but "git fetch --clobber-my-idea-of-HEAD-with-remote
> > ..."?
> 
> I think that it's OK for "clone" to create HEAD, but not OK for "fetch"
> to modify HEAD.

Not the local HEAD, the remote HEAD.

See my proposal to update the remote head in different scenarios:

https://lore.kernel.org/git/20201118091219.3341585-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
