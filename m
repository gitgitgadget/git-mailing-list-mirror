Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 375821F803
	for <e@80x24.org>; Thu, 10 Jan 2019 18:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfAJSjT (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 13:39:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38792 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfAJSjT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 13:39:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so46009wml.3
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 10:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+8506NcONT1RurQzmcHub3e8TfAFqqhgatCRkRec+Po=;
        b=jdlDomgBFOoB2vnDIixapo4pbfvARapt96iN/bP2BMFOu/X8tvrkzyy0CF//9Az16x
         8sAVO98cwCTecEJrpJ975exo362XCZ3tDI5PgUwwjbXp2dYA5ASmndYq5siH20dDqh8j
         onABGraGtddtXB+w8pONVwd/9bk84OjRt54Aid5RbZmZMh3bPncYTe5CrrMN0AnRmPzw
         /B7oQEfTWwWFHSa8FOL6IKOPSXVzWC7c2ijQg68mewnJCENtiW40zfQfWxFjY2a2hEeY
         oCjG2zrrpSedValRUgcsIiNg+29DQ8k9yEj76xdHMsRtH94xh6KHtLdXWvi7TD966AUN
         0vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+8506NcONT1RurQzmcHub3e8TfAFqqhgatCRkRec+Po=;
        b=thvP5wq/czfa19xzv8ZK8dn1b1912YtggwO8hEUur2pZWjaCccL0FQV7sYVJOYDi+S
         Vh8SNQdkBi0YLfZlFGEA7IJ3THdAbnvePzjpiI5Ip3n0rW9H1NyYqJQwMMqEBXdWRGeW
         zQcAuVeqbZjkp2AxJl3p+xgP1K+fG0TIlgWLDu4UX2Js4d+r31GfcmuzRuL6CFnpkJL+
         buDFOigBLz0PDMiA/o7bkqH2FBtwLcCJqoLzMBOt7naIcbrvBT+SY+OFa7qu+gAnCpCL
         F0FbN3IPoR0K+EdXJFBVSggdIvxO5HxbJZKfB5WQ5noLXs238PmjL/nHJ8Ax0mPtOuWr
         1W3g==
X-Gm-Message-State: AJcUukeLpXzcnPvClcflIhou8Zl5LhehBgLQBpg82+sI/a03yMNxn7QG
        nfFbK31sLIVX0Hw8d1fmQLPKOjxp
X-Google-Smtp-Source: ALg8bN5DVn0jWVWtXpYn3f7d/1DAkx0oEuy39e32xbdPdDQH7WxHhXHH7efqlPCHjxCmfII+sM90gA==
X-Received: by 2002:a1c:c64e:: with SMTP id w75mr59448wmf.46.1547145556688;
        Thu, 10 Jan 2019 10:39:16 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h1sm12617103wmb.0.2019.01.10.10.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 10:39:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/9] diff --color-moved-ws fixes and enhancment
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
        <20181123111658.30342-1-phillip.wood@talktalk.net>
        <402b9c01-cd7c-79f3-9fde-55907f03c406@talktalk.net>
        <xmqqh8ej57d1.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZBfkKc6L5o4rCJoSw63q49YZwn7QRedNmFr=-nd=GbMw@mail.gmail.com>
Date:   Thu, 10 Jan 2019 10:39:15 -0800
In-Reply-To: <CAGZ79kZBfkKc6L5o4rCJoSw63q49YZwn7QRedNmFr=-nd=GbMw@mail.gmail.com>
        (Stefan Beller's message of "Wed, 9 Jan 2019 16:37:27 -0800")
Message-ID: <xmqq5zuw2w8c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Jan 8, 2019 at 10:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>
>> > I just wanted to check that these patches are on your radar as they
>> > haven't made it into pu yet.
>>
>> Sorry, but they were not on my radar.  I was waiting for comments to
>> come in on them before doing anything, and now it is more than a
>> month ago X-<.
>
> I have reviewed the whole series again, and still have
> no comment on them, i.e. the series as-is in v2 is
>     Reviewed-by: Stefan Beller <sbeller@google.com>
> if that helps.

Thanks.
