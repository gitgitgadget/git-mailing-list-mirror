Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 437161F404
	for <e@80x24.org>; Mon, 17 Sep 2018 15:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeIQVFE (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 17:05:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55327 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbeIQVFE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 17:05:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id f21-v6so10181528wmc.5
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=71AwKBA2jU9cMn9XoCyJzyVpDKzcqUmcGFnAh9WpX4w=;
        b=nhiJH9PDtdPfOvmSDHLx7OGM+/KsRTlNqjqZnFzYHn13DJobgli4PVfFhj+Xgqmy3w
         ENh0ECpmFSzVqjLNnxBEcvq+NIGeSvrN7QrpDvAvN+pbvzDUZvuLrVIgGhPIG5ZkXrjl
         hgbdY18wHjk8oInIMIEISzJa2d8E8xL3V7PS0LhTLk8o2fuGKDoinIr1u2KTgbB0d+bo
         AV5mXJwRy0UjwOEcfas7I6dOobWOwcPDfQJ/LM36HgTZWnuCdQFouzNR8st8fSyJX68t
         D+HoLHJIP/SbMLtzF2Y+At9O4ysLfQ3g2E3Bm9b1w6zNdysbYdwkkErcWTeCcHKz8oGD
         Xu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=71AwKBA2jU9cMn9XoCyJzyVpDKzcqUmcGFnAh9WpX4w=;
        b=BY+h36DAYTQTV1BfAxxTk5417JduiJVzyvhgbRpOqlioczyjZ8q71tOfAuoL4DhYdZ
         17W/vORZGtmhdqDSX2zLir2crOh75slNpF8+aQgUDQFI5UF56Y+b0U8+gUs2LSQkIZ+6
         KI0sSw+grxxCGt5ZNoEv4yXVJdLr5YlDX0U/ok3pjmtjGmXO2asByi7lEKBgSdgUxZ7D
         /1KbJDBkMMfpC+dTwYyskol7erCnmkRvcmLbxNkxb+NCMom0CUhbmpwLUuZxZlRfAXqO
         P9NhZKf6JUlxOGol3KAXARZYks1wwEHVewkk4zr3oxLvG9dQtF9Iixeru/UZMK+WTUu6
         pBpw==
X-Gm-Message-State: APzg51CN6so1Weu1zMfsgJHxQRDkmw+bbirFw62/+TPNmGPKrzlRbj0k
        04timplcjVLOUBw3xcDIeUw=
X-Google-Smtp-Source: ANB0VdaWt1vuWw59zd8Bn/4OCd75DXo47w04aAEXGMFLtUiudpcNn1n150uUoeY6QTNkvK8mpccN8Q==
X-Received: by 2002:a1c:c3:: with SMTP id 186-v6mr12196716wma.126.1537198630394;
        Mon, 17 Sep 2018 08:37:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q16-v6sm10531592wrw.2.2018.09.17.08.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 08:37:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH v4 1/3] Add support for nested aliases
References: <20180905085427.4099-1-timschumi@gmx.de>
        <20180907224430.23859-1-timschumi@gmx.de>
        <CACsJy8BnHgaphwy3beCCquFjU=SZebR2GvDCkFgh1_snxDBTRQ@mail.gmail.com>
        <aede75a5-d2ba-5a95-434d-aa70f7270fd7@gmx.de>
Date:   Mon, 17 Sep 2018 08:37:09 -0700
In-Reply-To: <aede75a5-d2ba-5a95-434d-aa70f7270fd7@gmx.de> (Tim Schumacher's
        message of "Sun, 16 Sep 2018 09:46:58 +0200")
Message-ID: <xmqqva7487a2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tim Schumacher <timschumi@gmx.de> writes:

> On 08.09.18 15:28, Duy Nguyen wrote:
>> On Sat, Sep 8, 2018 at 12:44 AM Tim Schumacher <timschumi@gmx.de> wrote:
>>> +               /*
>>> +                * It could be an alias -- this works around the insanity
>>>                   * of overriding "git log" with "git show" by having
>>>                   * alias.log = show
>>>                   */
>>
>> I think this comment block is about the next two lines you just
>> deleted. So delete it to instead of fixing style.
>
> I think that comment is talking about the code that is handing the alias,
> so it still would be valid.

"this" in "this works around" refers to the fact that we first check
the builtins and on-GIT_EXEC_PATH commands before trying an alias,
which is an effective way to forbid an alias from taking over
existing command names.  So it is not about a particular code but is
about how the two sections of code are laid out.

It probably will make it clear if we reworded and made it a comment
about the whole while() loop may make sense, i.e.

	/*
	 * Check if av[0] is a command before seeing if it is an
	 * alias to avoid the insanity of overriding ...
	 */
	while (1) {
		...

but that can be done after the dust settles as a clean-up, I would
think.
