Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFEA520374
	for <e@80x24.org>; Sun, 21 Apr 2019 23:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfDUXib (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 19:38:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36599 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfDUXib (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 19:38:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id b1so2601619wru.3
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 16:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ECAt2dXf9knDaa1wVSU3gJlIYW11tY1bOnbaTOs5bt0=;
        b=Jz03puYW4YIdhBt0iug8Apl2Kbq+RR8VZavFMNBApDQ77jtMg6bhdOAjNVl9dJNsKG
         WzIs1mlBeMDehmnn3KnCz8tXWp6zRcFNi532NRU6OvgsxuOpKHHPHae9H4dRiXa3tgex
         zrSUApdF1Okbz0JXVjIkvkQnEMokBv1sKYj2XH6wajZEJ6RwZwKnMVBQjiBabKBylrPM
         M1UCpbfiRDnduWi3T+ppYGzZCE2Hp1EGiezrx7NEvxrH+nW6SoqVtjNkjsqiz0Q3BcxS
         oc1BVvpttPOh29h8VpFHOdLTzQm73yJyThnPUQhjEbhSyxAOs1CC5ToPdIwOunHHGmlE
         RsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ECAt2dXf9knDaa1wVSU3gJlIYW11tY1bOnbaTOs5bt0=;
        b=hZkkTVNDwYMUGfGtQuukjhKQl8OnImUBBqRO2R9tkXHmYr3fwQrDfEQL+VeUvCDMC6
         2UgGyftzr3JP8Exy8+VwMf5/LRLxAgKwQNMlZym9J1E/t5B3yOyWygK5yL9vVe51NpM/
         uHP9nukM6T9m5eMV4Jk0RSYPDlxOccZ8+sE9Y3l36XPJaQwiWF9vexAfk8pj3qtLjpNl
         i8bt3r5GAhR/XAenTbdcMb/j/IUF2lmvQdvaf5cqFbzJUft6nPGYt/clS0/mt3KTuWlT
         9jmTa4TWznPr6AIQ6bX09Nj/GCA072uB4a94ntH0ZPgW561lAcAHLbP2f3aVEoqFS8OC
         IQzQ==
X-Gm-Message-State: APjAAAUwxyFMHoHCJ8ViFny1nN6xewZ7gbeb87L5hKko4TC3nKBziF8Z
        J94Q1l/wWmlxwC1P46xb5NA=
X-Google-Smtp-Source: APXvYqwSk12u3jf7ug8bLEMhyuIikjBVwVNEAxNpZ4V9tXbW3K+36HFWgUpwpEeaIlggHgJkYwMvHg==
X-Received: by 2002:a5d:698b:: with SMTP id g11mr10780381wru.65.1555889908767;
        Sun, 21 Apr 2019 16:38:28 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t15sm9953324wrx.22.2019.04.21.16.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 16:38:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        sunshine@sunshineco.com
Subject: Re: [PATCH v2] Give git-pull a --reset option
References: <20190421040823.24821-1-alexhenrie24@gmail.com>
        <xmqqftqbdijl.fsf@gitster-ct.c.googlers.com>
        <20190421211833.GC6316@genre.crustytoothpaste.net>
Date:   Mon, 22 Apr 2019 08:38:26 +0900
In-Reply-To: <20190421211833.GC6316@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 21 Apr 2019 21:18:33 +0000")
Message-ID: <xmqqftqb9bf1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> It may be helpful to point out that this is essentially the workflow I
> had ...
> I'm not sure if this email is an argument for or against this option,
> but maybe it provides some helpful perspective.

I think you and Phillip misread me.

I did not question if the workflow is common the message you are
responding to.  I've done my fair share of "I know what I have on my
laptop is stale as I pushed it out to elsewhere to continue working
on it, so let's get rid of it from the updated upstream and start
afresh" myself.

What I questioned was if it is sensible to ensure that it stays
common.

We'd be encouraging the dangerous workflow, instead of analysing the
situation where people employ it and trying to give them a better
alternative to deal with the situation.  That is what we'd be doing
with "pull --reset", i.e. an easier to type short-hand that robs the
chance to double check in the middle of "fetch && inspect && reset"
sequence.

As to where the feature should go, if we decide that it is a good
idea to promote this workflow element as a supported feature, I
agree with Alex's design in the patch that it makes sense to have it
as "pull --reset".  Existing "pull --merge" and "pull -rebase" are
"fetch and then integrate by merging theirs into ours" and "fetch
and then integrate by rebasing our stuff on top of theirs"; the new
"pull --reset" would fit well sitting next to them with its "fetch
and then treat our stuff as valueless and replace it with theirs"
semantics.
