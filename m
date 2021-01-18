Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8682FC433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 19:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D8622C9E
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 19:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437200AbhARTfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 14:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390409AbhARTen (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 14:34:43 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A06C061574
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 11:33:42 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id q4so9160484plr.7
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 11:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:from:to:subject:date
         :message-id:in-reply-to;
        bh=p8YnxgPbKQ2gySl7K/yHVnYWdii7qZNtEB/6ioDZrAE=;
        b=EZtUsxvpg9pc0SusCpHr1UdksrDAfhRSpKqaN1MnMwVMXYMz4RquTrqo+ZKYyL+taI
         DptqIYPvd5VpyPRho9EDoWfm8o4L8oOBWz3ovQFrlK5pHDghXFguoCrFmmPcJP1hpr4t
         gATJxLlY3Np4agSr8FPDVfv5eBlfFuP/++Fxmu12eXE72QhUy5ciUMwMkybJk9G3CDbB
         7G8WFAbwJeoyUKoLS9s4CASj+RDd0Mydm4NFd2+5pCaYkqeurg2RnAG2RMqXuwmsR/bi
         4xSRichLbRluL7Xfhi6PpHvsZb3GtQlBv5K83WbO4nJkIfAT+9/6pGyDVnmEvLws/gjc
         JQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:from:to
         :subject:date:message-id:in-reply-to;
        bh=p8YnxgPbKQ2gySl7K/yHVnYWdii7qZNtEB/6ioDZrAE=;
        b=AxoO/issPjoV1pg95se8TNMAM69IasJoMQZOqiW6vPZPIM1q5XdQnlyqRgq8JgwwhI
         dCv13NQHfiDvZfbqCSdTUGRE7XfsAeqegRYaduzsrJsiabSTR3yuSXXg3fbqUH9mzAv9
         1H2HwOURu29Cluplqt/aok1C0+k5JCB3M1sn9ay3yVIkW3wQ/4zgwAYiXxSSXQWy+v6v
         N5QEDOXfB+JbwucDE0Lsj9R1qhl8hsMFLn3sUhpD1MkvXbCq2nhxcInK67ALDHAjJ/qf
         GHEUD5LlRtpRUmpQl0934YAV5xB/flxE+HqXsGTGU7FpDRAJ6ICBdoQrgTX5YiZBigCG
         EiFQ==
X-Gm-Message-State: AOAM5303sqi8uW+ntG2AINK2mENjF+eFsaboFSSwVV4DZjey64aqG7X5
        DI3wbOvYi4Tjk7HFBIc5ILs=
X-Google-Smtp-Source: ABdhPJyyS86wksFw4dStxrbiNJp3tmh2VZ6ESTgzJfa+W/DRg3k8RY4BTdr3MuwJa0O4K1nTokGVMA==
X-Received: by 2002:a17:90b:257:: with SMTP id fz23mr918645pjb.162.1610998420622;
        Mon, 18 Jan 2021 11:33:40 -0800 (PST)
Received: from localhost ([193.37.32.44])
        by smtp.gmail.com with ESMTPSA id y67sm688997pfb.211.2021.01.18.11.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 11:33:40 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
From:   "Aiyee Bee" <shane.880088.supw@gmail.com>
To:     <git@vger.kernel.org>
Subject: Re: DEVEL: Help with feature implementation
Date:   Mon, 18 Jan 2021 19:31:08 +0000
Message-Id: <C8MJ83LNOZ1Q.OCQKHOTGHKWF@localhost>
In-Reply-To: <60516c8b-adc0-18a5-ac26-b147b1857016@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antonio and Derrick!

> I think what you really want is --full-history --simplify-merges [1]. Thi=
s
> will show the merges that "fork" the history into parallel tracks where
> at least two of them contain interesting commits.

It doesn't look like the implementation of --simplify-merges helps much
here. That makes its decision on basis of the parents of the commit, which =
is
simple to do as it's information attached freely to each commit. I think th=
e
problem here would be figuring out, given any commit, how many of its child=
ren
are "relevant" commits.

> I'm actually working on something that does the opposite---it ignores
> the fork point when drawing the graph.  (I'm currently dog-fooding a
> partial implementation of this.)

That's a pretty interesting coincidence :)

Just to throw ideas out there, maybe we could attach another commit_list,
children, to the commit metadata, so that all this becomes a little easier.
But I guess that's be pretty impractical and inefficient.

Maybe a more practical (but still pretty unusual) solution would be adding
counters to each commit that tell us how many times they have been traverse=
d
Through various histories?
