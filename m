Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB19BC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 01:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C99AF60F11
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 01:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhHKBp2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 21:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhHKBp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 21:45:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9256C061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 18:45:05 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so7130781pjb.3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 18:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uJYg0VcI6izMpykIfLqzYGY5DZujx4/3UQ8Gn6f8Bg=;
        b=gwtmUq4kq6IAyrDrSIhbwfGqjwxPYNI2Y5YIDr77blVfAZor3Fs+G9vFEe0Yhcmw49
         q94f5nIKMp1Duk5TsM9Ks73n+YPks78m85ipr1WTw3dDDiPvE8PrpfO5fKV3YEl4nFiO
         H6VYi1uLmVOzml6vXddLIqZl1wwEIS4XS9rMSY+4cgctYrIrR5pvF85CVuR0L8HVxFPU
         Pyv6fC5wpo+Mo8UwN9QaZE3MtvDw4Uen0pn2cB3+pDfTQMg3La2yp3kC0A2SUIdWZF8+
         s0AQEOsnMoed0nbCymjh1rgFMpP4CBLGyX9Xav+gy4jiyfowCeuSBIcmJMoJ2jpGDwF/
         Tunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uJYg0VcI6izMpykIfLqzYGY5DZujx4/3UQ8Gn6f8Bg=;
        b=EQuFcT9oKQO4Umtu2TpMeXgGoUsrfpRyH9wMEab231czyhQlqauZVpnJ9EK3Q+Pmcn
         8kcHeXNz9MS+GVG6x57ge2GSncpfOz65JGGZc6H1Cyzq+/x6KtLGsHGtg0GuHLp/WEu+
         HG0FjaXVlGzmyC+tXoGfFyWS+Do1BOPwHp/PoY5USflOnfgq3e0i9flbKtGdHmSj3Xhf
         shMaOLDXHZwnbFQveovJo/RugNiAu7clb6vAe340Fo9XS9JGp00axquZ2ECSnvq8VnBR
         HdWfijdu4DDq4W9uJAG5M1EBpaKK5cqn6RVQdLDgJ9mF+SSaWDGNPMRspa5EIOxEWEzf
         aWrw==
X-Gm-Message-State: AOAM531rO3fr+jUGYHO5U1t6FDPJPPkZJdHcagDg9MCDtZ1YPBBufUbd
        8q4oqAu16zhkwaTCYnrkZmM=
X-Google-Smtp-Source: ABdhPJwL1BOcP+i4BrUlGzYGfJU+adb9/jhn/N6lTQQ+M6j1nZo6F7pQmMS/HkxhQ5HyB9UUAkrLFg==
X-Received: by 2002:a17:902:848c:b029:12c:daf3:94f1 with SMTP id c12-20020a170902848cb029012cdaf394f1mr2177706plo.50.1628646305385;
        Tue, 10 Aug 2021 18:45:05 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.155])
        by smtp.gmail.com with ESMTPSA id j23sm4529769pjn.12.2021.08.10.18.45.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Aug 2021 18:45:04 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 1/3] packfile-uris: support for excluding commit objects
Date:   Wed, 11 Aug 2021 09:44:57 +0800
Message-Id: <20210811014457.15318-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.449.gb2aa5456a8.dirty
In-Reply-To: <xmqqbl6pj60y.fsf@gitster.g>
References: <xmqqbl6pj60y.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Please avoid adjectives that express subjective values, like
>> "sophisticated".  Readers will expect a lot more sophistication than
>> your code actually offers and will be disappointed ("wow, that would
>> be wonderful if we can say 'exclude commits made by bots, and those
>> older than 3 months'---eh, you cannot do that?  where is your
>> sophistication then?").

I use it("sophisticated") from "packfile-uri.txt", but i agree with you.
Documentation will also remove/replace the subjective word in the next
patch.

>> Please avoid "should" without first describing the background for
>> "why it should".  It would help if you briefly describe what we
>> currently have and its limitation before this first paragraph
>> (i.e. your "we can already exclude only blob objects" would become
>> major part of the explanation, but you'd need to present in what
>> situations it would help to be able to exclude other types).

Agree.
Commit message will be appended with backgroud description.

>> This commit is probalby doing too many things at once.  For example,
>> refactoring like creation of match_packfile_uri_exclusions() helper
>> function out of existing code (there probably are others) can and
>> should be done as separate preparatory steps before the API gets
>> modified (e.g. process-object callbacks gain an e xtra parameter) in
>> tree-wide way.
>>
>> And by slimming the primary step that introduces the new feature,
>> there will be a space to also add documentation and test in the same
>> step, which would help reviewers.  With the current structure of the
>> series, with a code dump in the first step with only a vague promiss
>> of "sophistication" without documentation updates, reviewers cannot
>> even tell how the "commit object" is used easily.

Agree.
The current commit will be splitted for more clear reponsibilities, 
documentation and tests ditto.

Thank you.
