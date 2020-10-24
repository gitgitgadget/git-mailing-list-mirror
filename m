Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB4BC2D0A3
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 14:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3FA21D43
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 14:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603550801;
	bh=ZjES2b5i81e0GHosZtEERZJ3k6ymnIpYSqC30fdhg/c=;
	h=Date:From:To:Subject:List-ID:From;
	b=fCReu06RZQT9oy7+CvSSTOPQFJOoE8MuvcYdVIBqhrj8aDnZTGWTdCjl6v2gtwdit
	 np+lU4OvB0s8y/Yvi2NalJUUc9IsvOkF1ICtgpIpDD5pRofsFRJwFzBO+IFMKGhJ7s
	 NafjWTdZHGI7Wg5ZiC5h4+g/f6ZL/W6+EX2wdYAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756548AbgJXOql (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 10:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461515AbgJXOqk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 10:46:40 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E01C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 07:46:40 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b18so687449qkc.9
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 07:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=f8HROQJVwgim8zptYspECM/cYy7Qkj2S/EbhqrwVOfk=;
        b=RZnkgJazGj45vn/NPkSUy20EkFfzpz1WgAVgfPW22FWk8GvQSUfQQvihqcQEPALOtA
         kVB7vLgXY/ynmYoqwz8ywv/SVIP0hiToaSjOzNwh3lYKk4nXupkx8H049980GqwbAHMH
         9e1r1Dbi61I7Jq8qKUj3jW2reKvaak8TEWRvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=f8HROQJVwgim8zptYspECM/cYy7Qkj2S/EbhqrwVOfk=;
        b=G4R2B/tTaz3oWgs04V0jsO934KcJULY3bIC66bpQkK5RU1NVdgViRyFYZtOPfIUsdE
         Yqlgfk558jiVmhjJoM/ahopMCJctPjMyJhQ2gJlrppg7P063HShoUOCkzlI1+ZZ9NKv5
         6T4x3TNDO7j0c2amFi+93Iun/PxNlLGC/roboWIji4HffwoJV0j9nSkYNN2YvnRh/hh7
         CVuVWPIMQ9OhA/L4bBn6qOOOKpfA25mw2LdRIg9dlFm/6J4iU94907sKS4r2nh3vukQj
         y+XjBN2eqws34ai07g4XmOYaplQ41FFrZyEQ/TS3PAAqdXyVsrOH4wbNbj37fBzoe7cv
         Eh3w==
X-Gm-Message-State: AOAM530WmKsn4JJoXP7gJgOiiudf6HLyAW5lvc3Q8xUNBqzDlZZFQJeT
        RSqw76Zsylrp6YKlZ3LcigIBdamvjzRvlczc
X-Google-Smtp-Source: ABdhPJwFGYh7EddM5aXia+FSkU9ua7trX61Paa54rMc0E9cpeRDNhe1YMxXav5oex6UMU5XsEFs1mA==
X-Received: by 2002:a37:686:: with SMTP id 128mr7349375qkg.421.1603550799387;
        Sat, 24 Oct 2020 07:46:39 -0700 (PDT)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id j8sm2990007qke.38.2020.10.24.07.46.38
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 07:46:38 -0700 (PDT)
Date:   Sat, 24 Oct 2020 10:46:37 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: Do porcelain command require lock management?
Message-ID: <20201024144637.cvwa22f2y4tvfn4z@chatter.i7.local>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello:

A script I'm writing performs a succession of porcelain commands to 
create a commit in a bare git repository:

git hash-object
git mktree
git commit-tree
git update-ref

Do I need to manage external locking around these commands to avoid any 
concurrency problems, or will git take care of that?

-K
