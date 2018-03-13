Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4609E1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 22:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbeCMWwl (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 18:52:41 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:42217 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbeCMWwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 18:52:40 -0400
Received: by mail-wr0-f177.google.com with SMTP id s18so2514430wrg.9
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 15:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XXFH4ztJUs/6y8Wk7mRj4DYi+uYQMthPrXd8hPpnsLE=;
        b=u5Bvk0DPdTcG3R3EYgB/BsQFDHoX/06YJJRNysl+95yJJwibvFBTmA5ncf10K2KXhT
         LlwHKI5UFCHys03lw57ffv9jw9Nybs8WJn0sJZOKkKD8M/Y3e0RzXs/KUgVKMsIP5y+W
         PoPyodStPsG3vupwruXm6ICOglUYrfMO+wXlMyawULnCgxPCFV3b1cKNzsiNpl9QkHJn
         xoL0R0cUJSthIm+3rylmadI57OK/WfWRTtJjRgfmRuloxSakcW/D7GRYoxxgLf4mi53l
         EjhAmynsyboLN6UvuQ56u9mpbvrkc4s+bdkJ979A4HOxvq5Y4Y03XuJj4ZwuBV/fYBKk
         oQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XXFH4ztJUs/6y8Wk7mRj4DYi+uYQMthPrXd8hPpnsLE=;
        b=WIA2P9Zev9leoCpWOasWnYHeu0X9PsFLf6rQkSh19x/p3zsSSOOuedF4Qp6KVvGpAS
         Qq2Wo7qXiSxGGH7bp+A2R6xQPHDAIPkeeLjpYKsVAPvgAm9amJDoHq5nxdflfavo9SLX
         4zQHE81xeOMcq/jlagjQxmek2UXa0mhSwwY1/CJuJt9NNV+YUhlh8/XabEgEF7vKr/Qo
         N4OqWjtX+9+asoKkqHAGV5voH7hrXwvRgC8KaFxt9o9QUZuaU/u8oMLEYNxIUQZePdJs
         IxuMiCf7fNd6h0RI2/RGf75X1ufBr9FQJydfG9w1T/khnTJR84meUHZgviZrMHNkV7Am
         mXWw==
X-Gm-Message-State: AElRT7HMAC7qIM9Rr9fpcQ3xjxD6RuDa0y2zUx6IMQgM8UyRfAsGKJxJ
        T+frnWj9o+S7DlBNm36XKR/3hQKw
X-Google-Smtp-Source: AG47ELsEXCvgD32IfxWeBHl+XQC1JYxFKIlt+ARdW3IeYBnwS9qB2PeYActwUDczeeQSGXSHNSCZvQ==
X-Received: by 10.223.192.76 with SMTP id c12mr1845421wrf.177.1520981559119;
        Tue, 13 Mar 2018 15:52:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x82sm1371508wmg.7.2018.03.13.15.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 15:52:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Opinions on changing add/add conflict resolution?
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
        <20180312184734.GA58506@aiede.svl.corp.google.com>
        <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
        <CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com>
        <CABPp-BF-LnGPx6vKzCNaFNi_fkxK-CpenatOVa2fvJRZHd0hZw@mail.gmail.com>
        <xmqqbmfr1uj3.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGXdBJSi5EUyeom0PcgRXvwNy4EBA71MP3FZK9xsw-jdA@mail.gmail.com>
Date:   Tue, 13 Mar 2018 15:52:38 -0700
In-Reply-To: <CABPp-BGXdBJSi5EUyeom0PcgRXvwNy4EBA71MP3FZK9xsw-jdA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 13 Mar 2018 15:42:54 -0700")
Message-ID: <xmqq7eqf1tc9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> However, my question here about what to write to the working tree for
> a rename/rename(2to1) conflict in one particular corner case still
> remains.

Hmph, is it a bad idea to model this after what recursive merge
strategy does?  I think what is written out from that codepath to
the working tree has the nested conflict markers (with a bit of
tweak to the marker length, IIRC) in it.


