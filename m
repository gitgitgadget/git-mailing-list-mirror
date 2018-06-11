Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75751F517
	for <e@80x24.org>; Mon, 11 Jun 2018 17:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932768AbeFKRfo (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 13:35:44 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34469 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932682AbeFKRfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 13:35:42 -0400
Received: by mail-wr0-f195.google.com with SMTP id a12-v6so21283795wro.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 10:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=v4nyeuMDL9FncA1qd6kMpPInhQF+/EJPiiKNddV1g1M=;
        b=eU2vFRTN3qqy2LneVS/gbIgGoKLGU9i5Lvp1cAB0uRPpjt9a++JpcCmPJgFrUKgPCv
         /+y3SNw0p4yjL/aCKThXShes/SL6/pkXHIobF/nUjmQVaJenVJxPkBfr07MgGqKWpU6F
         AslJrIhizUUB6eQLSTXqhOq13lgHydBQtkOF0mf7Lr8A19RYS7g3f3UxykgOvdoOXZ7L
         bMvfxq1BUwXMNs0OwcMszo+ynA+pzFjN9+BSrxcYIdWAnr+Z0LfXpeQAf6JTSLOT16DI
         /WyCmXavkpmWLLjrMaKvmCSZoYEdgJNip/DxHhE5Vuz3vvlDdys1636gEqFFSIXd46CL
         /g1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=v4nyeuMDL9FncA1qd6kMpPInhQF+/EJPiiKNddV1g1M=;
        b=rSI/mz7nDVBGsaEbD/afLSApFvlATjsoZbOSTtD6YZ7ZKVhubxsqeUkjHA7gUbvtDb
         D5qxgVjNgmexbkqkPjEhTF53LTxkzzAlZu0JBzbgX2rMVkGgKiY0CF1K+gEV3gGflz0S
         tHt7SrYsyesGojVO+dzBWabnu7BQjDQktbi+jT24JuY8T1w+uBLE2TEtLehdALhEMK5o
         /CU2HDQotfnv1KkE9jCmN3Y43a67NWxt0bKe5fV7GrC6oyURfFtcEmrlR8dwWCM0HskG
         pN5DtVJIaW+eEBSEVul2dBNtItHcyr0YMV892+lIQAe4KxiHrQADNEIAw6rzeNG/HAdo
         X6+g==
X-Gm-Message-State: APt69E3RVMcSRe1ub99qNeitMWBEfeFjQrg2MPmfol20Me4qsnMXpq4q
        MOGrjr2KIBCbUrjlXK56kIA=
X-Google-Smtp-Source: ADUXVKI3zgp5vCNeX7FH0M6kzhSMvjC6rthIlZYPreMStpF11F1nW46ud6cEr1jXgJlZPXweI0XrVA==
X-Received: by 2002:adf:b310:: with SMTP id j16-v6mr63406wrd.207.1528738541489;
        Mon, 11 Jun 2018 10:35:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 72-v6sm62925001wrb.22.2018.06.11.10.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 10:35:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sean Hunt <seandhunt_7@icloud.com>, git@vger.kernel.org
Subject: Re: Where is git checkout --orphan implemented at.
References: <2ED916AA-3E6A-4E22-9B9B-13C3B687B357@icloud.com>
        <20180605175435.GA22321@sigill.intra.peff.net>
Date:   Mon, 11 Jun 2018 10:35:40 -0700
In-Reply-To: <20180605175435.GA22321@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 5 Jun 2018 13:54:36 -0400")
Message-ID: <xmqqa7s1cjkj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If you don't even have symbolic-ref handy, you can do:
>
>   echo "ref: refs/heads/new-branch" >.git/HEAD
>
> That's not generally recommended, since future versions of Git may
> change the ref storage format, but it would work with any current
> version of Git.

Makes one wonder if it really "works" if .git/HEAD was created by
older version of Git or in a repository where prefer-symlink-refs is
enabled, though ;-)
