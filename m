Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12FED20248
	for <e@80x24.org>; Tue,  9 Apr 2019 06:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfDIGgI (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 02:36:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40586 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIGgI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 02:36:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so19236403wre.7
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 23:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=g9n0sXr2OpgaBo1b/dievmmDG2ohsO0d/nwP2COLoTw=;
        b=X4H5SWG1ffxnrF3exwoR9ld5aOzJ9gQoJtQ9yQowK18meFYS6ySRcRFKAaFPyql0P+
         4VBf9LtFtUuLhmqDpNXS86uTq3E029BM1eaiX5qqFZ6D5rr8tlVRRAoZdxrymlUwgvlc
         Mz1yLu8eTo28gAB/5X5iP30X9wT9u+Pc7UTyLWbEYZHy9RxoJmrdCU3lqGiVW9VuHmHq
         fmBHRkueIPKtzOUPwSeauQh7gNaOqageYEvbnKBiwiUbdmnbryjsEC1NVzzoFEbjApIx
         UkVa0Iex4PwVeVWdgNVhB3EMWRWbGf8x3C8r2qeHXXcr7DApiihIvgKixlYkWVi1Hs9p
         zqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=g9n0sXr2OpgaBo1b/dievmmDG2ohsO0d/nwP2COLoTw=;
        b=VpDyfmQP245I2NaGF7nnZ/O6MACeoTWUXUcKU7zATPWzC+7/t7XDcsmx2AwpRLYdpF
         QbYcVhu6OiGQt+k5gsHaVG5aBwcNZ/H2SLUUaG7bfEYESs49EBzcxIWHCEuJJokWHyzQ
         DCgCQnoSu/cN0+QvHKyrGXjuIgNkxumAjLApKBQMNuqpVGq+fCN1w73LEXMNAFZKeNjQ
         SB8sWfVdLlOO4Xr/v1TjDwGNZjxeye7sZfwEpDVLjC+oqM4QBD+6b6NY/2CoNmBCyhkm
         XvtQQ25iKz8XXjanYwU5mJ9lC08ix5Y1JiEvFWYy6pg6m0O+JoShs2lv0qIZvYtk/cmS
         HgJQ==
X-Gm-Message-State: APjAAAV8jgM9tzVf2R7j49zMBUbLJbEQBiMOFs81sR2wW+7X+1Ob+lB3
        XDAaJRxPhYYQKK0ZI9Ranw8=
X-Google-Smtp-Source: APXvYqxtlBDNTr7M3Y0ci/u9hGBqLauTcP4FKwqaesWQpUi6FhaurgXg39jTuavZ1g0AwUzGTb+X1g==
X-Received: by 2002:adf:afd7:: with SMTP id y23mr20714897wrd.254.1554791766434;
        Mon, 08 Apr 2019 23:36:06 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w130sm18158028wma.36.2019.04.08.23.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 23:36:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fixup! diff: batch fetching of missing blobs
References: <CACsJy8CgXLZxqab4vcP1jh3OMCGh1i=easb5BpCs1J8Uf_jsxw@mail.gmail.com>
        <20190405170934.20441-1-jonathantanmy@google.com>
        <CACsJy8AjyY1Azbf4VfnJMA3O8NNBV1P16dZRrHOUJdsYQHUu4g@mail.gmail.com>
        <xmqqmul1b0pg.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BHqaqOHVbwtONU5=RiG7Q8WNNAN5EGV_nm7NyNWeyuiQ@mail.gmail.com>
Date:   Tue, 09 Apr 2019 15:36:05 +0900
In-Reply-To: <CACsJy8BHqaqOHVbwtONU5=RiG7Q8WNNAN5EGV_nm7NyNWeyuiQ@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 8 Apr 2019 16:58:35 +0700")
Message-ID: <xmqq36mr8z3e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I feel lost (and the answer "go read partial clone code!" is perfectly
> acceptable) but why would we need to diff trees of two different
> repositories?

It's just a speculation into far future to open possibilities of
what we cannot do right now.  There is no *NEED*, just like there is
no need for a single process of git to be working in multiple
repositories at the same time (you can just fork another one into
the other repository).


>> It is likely
>> that a caller with such a need would simply make sure that objects
>> in both repositories are available by using the in-core alternate
>> object store mechanism, making it a more-or-less moot point to be
>> able to pass a repository instance through the callchain X-<.  We
>> probably should make it, and spell it out somewhere in a long term
>> vision shared among the developers, an explicit goal to get rid of
>> the internal (ab)use of the alternate object store mechanism.
>
> I think submodule code so far is doing this way. Though I don't see
> any reason we need it for submodule code. Objects are not supposed to
> be shared between the super- and the sub-repo.

Yup, that is why I made that comment---if we were to pass repository
pointer throughout all the codepaths, one of the goal (eh, rather, a
useful yardstick to measure how close we are to the goal) should be
that we use less and less of that pattern to access objects from
random repositories using the in-core alternate mechanism.
