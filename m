Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917DEC4361B
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5556022262
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 16:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392500AbgLLQnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 11:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgLLQnH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Dec 2020 11:43:07 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5E0C0613CF
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:42:26 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id q25so11327598otn.10
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 08:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6vE8+xTCZL/ZWdEauIt3sQrbPNP1qfsP8qU2LFRUibs=;
        b=kBjI85r+OEY+Qirxs2krACdaNkeEkp+tGtYXS00K9/zdDutDAAaPcF9cLUvwRxdoB+
         Vw/76iMw3EVCp5DbH2LO7NJsUh8Uv8lETgucMDBh2OrDEKTgxadd88Ewdh7q3sj8Ybkk
         7JgO0C71VbqYT/19o9ZEuqByo1PbPlCEaNwqRMdKHF44yclTJ3iG5K2OmiekhbEZF+LE
         Cl/QQbXwbxlKTz+87QaJbK4zTYxs41/nIymFPeg4d/8xCaTYctcRN87JHx2+8e6yTNK9
         3WJLBrcsMh3iMdTQxch8ENO0St+9vuy+tokRvjiDX5KwCcmsqanEUtznfI5K9SIKo3ie
         xYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6vE8+xTCZL/ZWdEauIt3sQrbPNP1qfsP8qU2LFRUibs=;
        b=jUMJ7/OLXvtJPL66V4GQ/nV49Bajn8lp/pRzFRjLp2Qf2LmMWNuck6iA85ylmVJNBj
         c9IAjflZdpkKn8DX0DS0aQHHwfsBZHrjuk/+QlYAeKRn30cZvmtf/o8HL5NXdNz8/Ktc
         skrY8+d44EHrmovOrJ1htob3fNt42sQhWn1dCWLuleK1Th03xWR59HXSCA5ZF95iykE/
         OY8sC9L3Z2OV8BtJ+2l5EOUndzjKZ3w9uUuZHzjipUOF8tGSjzlmMyprJ9neoVhCWbFP
         ZhIZk4K+sfJOVeEbeetd1nFZYnBYt2fVSpn5E8VXN0KRJh909F5BmNSXTTvRswz0er60
         1zQA==
X-Gm-Message-State: AOAM531dh4XA3FQIIukfUSmD6jGjX/r1TSywaWd1l3AfDrhd+6hVVhvP
        dvYU1sI89NOTUgMJI+PbWzg=
X-Google-Smtp-Source: ABdhPJx+A004jKfNniymwEQXubeyRIVx5XBJTuUpPUl3OD/xlzRcnJiroPkGCBFIc+7Z3zifOdRcCw==
X-Received: by 2002:a9d:4c8d:: with SMTP id m13mr11743210otf.229.1607791346270;
        Sat, 12 Dec 2020 08:42:26 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s23sm2721447otr.59.2020.12.12.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:42:25 -0800 (PST)
Date:   Sat, 12 Dec 2020 10:42:24 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Message-ID: <5fd4f2f03f28e_bc1eb20890@natae.notmuch>
In-Reply-To: <CAMP44s170qZuZqmh_gVLGgJJ5005HzDM0fdQKQamjHkZCOu7_Q@mail.gmail.com>
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
 <20201210100538.696787-3-felipe.contreras@gmail.com>
 <xmqqy2i4ltnv.fsf@gitster.c.googlers.com>
 <CAMP44s170qZuZqmh_gVLGgJJ5005HzDM0fdQKQamjHkZCOu7_Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] pull: move default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:
> On Fri, Dec 11, 2020 at 12:54 AM Junio C Hamano <gitster@pobox.com> wrote:

> >  - by introducing a local variable in cmd_pull() and passing a
> >    pointer to it to config_get_rebase(), we can easily avoid having
> >    to rely on an extra global variable.
> >
> > I'd suggest addressing the above along the following lines.
> 
> ...
> 
> > to possibly cause it to set to true, and use that instead of the
> > global variable to decide if we want to give the help text.
> 
> Yeah, there's only 38 global variables. We wouldn't want another one
> which makes the code pretty straightforward.

Another thing that I mentioned in another version of the patch series
but not on this one (since the relevant patch was removed) is that this
variable is only needed temporarily; it can be removed by further code
reorganization.

So, I don't think it makes sense to change more code than necessary for
the sake of this variable (that might very well disappear).

-- 
Felipe Contreras
