Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96D7C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 02:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhKWCPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 21:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhKWCPj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 21:15:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667DCC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 18:12:32 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r11so85209922edd.9
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 18:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=PTIWlXVQ9rBmEyJ+d57n49igwE0itRKz0TjsXxPf6xk=;
        b=cAmunvjz5pKe6mpSXCqVAFO/Rjl2b/6Bv/YWa8pUGTHKYC1lyOdB0VTi7L8NMcO61q
         rRPQYodKrOvpJpaBzp5cUkrvpXee3A70QPr1yltqNFyHRlyrwwqVu+Yeldcjvd6xLs3u
         w8IGGQFeHqG8EQLfCgmZQT9nimZ6PX2P2TV6AT1DmJBRhr2Htz+060EsunCVJ80xWJKx
         KzWL5PTF9gTaNXq7tajz88AA/Je4b4DgjNSergqTAGsscSOlmQy/GU62Z4cLnxNV2y3u
         Kbg0xDE+9G2562B+lBzDL6duOi0LMU5rmD9XnSBsJXgE4vuDQB4fVUOqCh74eP4iAjHv
         CH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=PTIWlXVQ9rBmEyJ+d57n49igwE0itRKz0TjsXxPf6xk=;
        b=wyqZ92oOGIUgK6Y6q01fVy91SjbLsQdPuj8jMaXdT6Sn58fO6qWQShmT+iO7Vd8/Pp
         5lhK3ebO4rdL1pGXPOOb3Qm/+7Z9Gu/950cO05qPzxGQ7+v10EEGLYOG3Ia3GxJSskRP
         VxXl7DzbDsJSLZVvC5+lSEKyg5306EkpFX23GjdKWjjrLk98+AdvOxWb19sujLHH7LUS
         T5MZfAr33qgiUuYSREqV86uRApBEYgmmG1wnDYGroi2SGV13pioVqWYDUQeMYFjrwL/a
         HqImceeRlrxwAvJotfWdDfitxb3bEFh4F8he6w5FUNWyLVR22NKHip4h2g2gJCGa9Xb7
         abrQ==
X-Gm-Message-State: AOAM532xW83lSxGju8b6GrMLETTBFaIUk44qIpa9l0LCvhNM/5IeRGp4
        n4MeEuPjGAFB9rZyzSSbbpfEP3ra4+dJuA==
X-Google-Smtp-Source: ABdhPJxXfxJmjgmHM2FzWzOO06ikP1qeuKSoyJ2bHK5movGQrfbSSYe4xGjiJUDG2y/8BkQDcq443Q==
X-Received: by 2002:a17:907:216e:: with SMTP id rl14mr2685778ejb.368.1637633550707;
        Mon, 22 Nov 2021 18:12:30 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hx21sm4478214ejc.85.2021.11.22.18.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 18:12:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpLIL-001HBL-I1;
        Tue, 23 Nov 2021 03:12:29 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        vdye@github.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/2] ls-files: add --sparse option
Date:   Tue, 23 Nov 2021 03:07:08 +0100
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
Message-ID: <211123.86h7c3wrg2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 16 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> [...]
> +test_expect_success 'ls-files' '
> +	init_repos &&
> +
> +	# Behavior agrees by default. Sparse index is expanded.
> +	test_all_match git ls-files &&
> +
> +	# With --sparse, the sparse index data changes behavior.
> +	git -C sparse-index ls-files --sparse >sparse-index-out &&
> +	grep "^folder1/\$" sparse-index-out &&
> +	grep "^folder2/\$" sparse-index-out &&
> +
> +	# With --sparse and no sparse index, nothing changes.
> +	git -C sparse-checkout ls-files --sparse >sparse-checkout-out &&
> +	grep "^folder1/0/0/0\$" sparse-checkout-out &&
> +	! grep "/\$" sparse-checkout-out &&

I think all of this would be much clearer both in terms of explaining
this change, and also for future test relability if it did away with the
selective grepping, and simply ran tls-files with and without --sparse,
and then test_cmp'd the full output (after munging away the OIDs).

I.e. the sort of output that's in my just-sent reply to the CL:
https://lore.kernel.org/git/211123.86lf1fwrq5.gmgdl@evledraar.gmail.com/

We really don't need to optimize for lines of tests added, and having
~30 lines of plainly understood diff output is IMO preferrable to even 5
lines of tricky positive & negative grep invocations that take some time
to reason about and understand.

I.e. something like:

    cat >expected <<-\EOF &&
     100644 blob OID   e
     100644 blob OID   folder1-
     100644 blob OID   folder1.x
    -040000 tree OID   folder1/
    +100644 blob OID   folder1/0/0/0
    +100644 blob OID   folder1/0/1
    +100644 blob OID   folder1/a
     100644 blob OID   folder10
    -040000 tree OID   folder2/
    +100644 blob OID   folder2/0/0/0
    +100644 blob OID   folder2/0/1
    +100644 blob OID   folder2/a
     100644 blob OID   g
    -040000 tree OID   x/
    +100644 blob OID   x/a
     100644 blob OID   z
    EOF
    git [...] ls-files --sparse >actual.raw &&
    [munge away OIDs] <actual.raw >actual &&
    test_cmp expected actual

Would test everything you're trying to test here and more (would need 2x
of those..), and would be easier to read & understand.
