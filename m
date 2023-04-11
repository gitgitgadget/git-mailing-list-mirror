Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA975C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 15:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjDKP6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 11:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjDKP6q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 11:58:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACCE4ED6
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 08:58:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 20so10091501plk.10
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681228725; x=1683820725;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+vleOt+IniUGPr0jN9ZkaC9Cgi5AFK5EuanjFrpiac=;
        b=m3/zEXK+7Z5jUeuJMmuPZXkaqypZV9U3rRzdfI3OhCd4uueDSMi41tqUBQJ8eLUAD0
         a73AjwVsIN+Gn6qVGkoY5cmYM6SiwyiDErxgG1txOI6UQXCMbLfPlAx6oD6NXii0a4jq
         fODdoF/3z0XY/+xR8IlyH3Af+VotdFLlMlHiIw9zmX6Six6Is+tb82kOIc+Q+0qU4oWW
         p63+Ik30KIcn4icWu3qg0/ykx6CswDlf9VsToOlIqdv8g7am3lQQtIEmNwU0nDsMN1J9
         /hejWfGK9XxuMUOzCkulkKc4CfuA9hTWSDtqHopvcYiILX0WwXIzJ64z3q4GcAx4XAQA
         67pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681228725; x=1683820725;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l+vleOt+IniUGPr0jN9ZkaC9Cgi5AFK5EuanjFrpiac=;
        b=OvUML/3c0c1+Pz9nY8HE2YnG5ziGTRNvC8SthWDgF3XvOLY/4pyUKylE3f6qN8F3xB
         5Gx+mJULLKp4NdWAKOK/wZBErnLyK8Je1+ZK0gxLM6ugnw4PLH+/flxdrMbgK2YZLpZK
         K/ON7BzPjvzPCtBWVOqih9jUDmfFKGXtnpgqLT8hqP1hFl1Sp5RtVPd2g1SMk91qUW8B
         SpYsKj2dmaoBr/BN0g2XsBG7+BkhBtFbjKXYqaGiAUTI/OPSVN4dLFNerjxStgEzVPbo
         jDFgBnTF3ykiv2igouFNkcXC+Le/EjkMXzdh/ABG6Kze25YI1ExYPPcVAlAN0BUg3V6Z
         KSKg==
X-Gm-Message-State: AAQBX9dE5EuO7Ec6SJhEytxMYkrow0LiqfvBy2Ewiqh0BzN1Q2t70qS1
        dMVNQF57ozo7m+E3n36OjJk=
X-Google-Smtp-Source: AKy350aOUVae1AymAY2J1eCIm2nWq0Zy13mUltcWwwT+yW31algD9a76kiqJr+xOVSYn8+VK6J63fg==
X-Received: by 2002:a17:90b:4f44:b0:246:818c:d8e4 with SMTP id pj4-20020a17090b4f4400b00246818cd8e4mr5043722pjb.11.1681228724660;
        Tue, 11 Apr 2023 08:58:44 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902690300b001a19f2f81a3sm3978953plk.175.2023.04.11.08.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 08:58:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Robin Jarry <robin@jarry.cc>, git@vger.kernel.org,
        Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
Subject: Re: [PATCH v2] hooks: add sendemail-validate-series
References: <20230402185635.302653-1-robin@jarry.cc>
        <20230405231305.96996-1-robin@jarry.cc>
        <230406.868rf5tkzs.gmgdl@evledraar.gmail.com>
        <9b8d6cc4-741a-5081-d5de-df0972efec37@gmail.com>
Date:   Tue, 11 Apr 2023 08:58:41 -0700
In-Reply-To: <9b8d6cc4-741a-5081-d5de-df0972efec37@gmail.com> (Phillip Wood's
        message of "Tue, 11 Apr 2023 10:58:05 +0100")
Message-ID: <xmqqo7nubeby.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> A hook that wants to check some property of the whole series needs to
> know which patch is the final one. We could pass that via the
> environment as we do for external diff commands with
> GIT_DIFF_PATH_COUNTER and GIT_DIFF_PATH_TOTAL.

Ahh, I forgot that we added them to deal with "I am called
repeatedly, where is the end of the series of calls?" question,
which exactly is the same issue.  Glad that you brought it up.

Thanks.
