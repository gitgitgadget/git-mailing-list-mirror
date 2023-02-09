Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4C5C05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 01:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjBIB5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 20:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBIB5C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 20:57:02 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C38F18173
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 17:57:01 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s8so628869pgg.11
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 17:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1rye2qiKt+L/tIfQmL5A5uTwQMdwoWOidEQ39mrNOM=;
        b=hirnm4+K9VUVw3t5RLa0bkwfO3BQe4HKW2ZBV88YqzbnUaFVyXaxcbDjtx7LUBF3Xa
         YV35ttgMhT6wcCdvC7lHzRRxJv0HtLb2Mxo3FFezgXlShCUl+lc2Kcai8gQ0HbWKOMxU
         5/VZTVqNJCmYn1NGhOk4/21dwjXw+bl60XrmZifDqGdULGjcLRXT/yScmScXJBdxQTrF
         dd1IvhVZAYRC9bCfGdnpspH05KCGpvtddyB/asQKH0hsgXpALt7aC7XrqPg/BrE7kwZS
         0MQv52KbredzvVZPCw0y5DTFvfkabC0N33QZwqCPT/WGWl5CIlS01MgstCIop37IiONv
         684g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1rye2qiKt+L/tIfQmL5A5uTwQMdwoWOidEQ39mrNOM=;
        b=1ZxwoRvjXWX/HrbB9v7UkZxON5y3hppYrjaHrS1dY1OwEwq9+8mySt2gLVQb8yI3u/
         J2WTBnZ7AWuQIxCSa66bEEEXoadn3mNSTKUs79Ecqlu2BUEU/IQ0gthaqxMF9LIQ3Edx
         p0RtWs6FqRISXfxFUyxaKM7yrXZyNQ+aOyhJ5e8+yfsXuIOjzYNLByK4rgQDvZjyhYqj
         kVKkP5JwfwIlCTKNrqOXKiB5d+3WZo4a3SCnzi88m0v7cBwI3uFOiKJqtJNbcnXihs6+
         QjJ0CvqLe7cyYnfDqIt0XIFETPtlv/A7RHI2dzel+AQtQS3PSGMwyNiTK3EKX5DZxQTs
         CbYw==
X-Gm-Message-State: AO0yUKV5bf2oghWN5q9tCH+Re1BYKIHFml4t8Qr2B0gH6j2khLgeqs4a
        d/Oo6vhSSmBBBMPxQ/bOoZ8=
X-Google-Smtp-Source: AK7set9DKJ8AOG0zf3MBYZr3iI26SsbvsCY3VA5U61DpuEN8JehsSnStPx5wXG80yiAQJ54wvWMqQw==
X-Received: by 2002:a62:53c6:0:b0:594:15fd:895e with SMTP id h189-20020a6253c6000000b0059415fd895emr8272533pfb.31.1675907820535;
        Wed, 08 Feb 2023 17:57:00 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7814f000000b00593ce7ebbaasm84110pfn.184.2023.02.08.17.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 17:57:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test: make SYMLINKS prerequisite more robust
References: <xmqqwn4sq73f.fsf@gitster.g>
        <230209.86k00rzqsz.gmgdl@evledraar.gmail.com>
Date:   Wed, 08 Feb 2023 17:56:59 -0800
In-Reply-To: <230209.86k00rzqsz.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 09 Feb 2023 00:09:46 +0100")
Message-ID: <xmqqbkm3ppn8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> I wonder if something like this is in order?
>
> I don't have much to contribute on that front, but this is really
> missing some "why", this worked before, why is it failing now? Do we
> have any idea.

Your guess is as good as mine.  I do not do Windows.

Thanks for independently noticing the uninitialized strbuf.  What I
have queued has it fixed already locally but there isn't much point
to send another copy out to the list ;-).

> All in all a simple helper, but isn't this redundant to "test_readlink"?

Not at all.  We need to avoid the Perl one for this purpose.  What
matters is whether "git" considers if symlink is working.

Perhaps our readlink(3) emulation we have in compat/ may hardcode
our "knowledge" that symlink is not available in Windows, which may
not match what the POSIX XCU emulation in our Windows environment
offers, which apparently ran "ln -s x y && test -h y" successfully,
and who knows what test_readlink that is written in Perl thinks?  We
are testing "git" with the test suite, so even if with some magic
that is still unknown to compat/mingw.h it knows how to read what
"ln -s x y" left in "y", until compat/mingw.h::readlink() learns the
same trick, asking Perl to decide SYMLINKS prerequisite would not
help our test scripts at all.

> 	echo x >expect &&
> 	test-tool readlink y >actual &&
> 	test_cmp expect actual
>
> If you're trying to avoid leaving litter or cleaning up that's not
> needed anymore with these lazy prereqs for a while now (they get their
> throw-away temporary directory).

Indeed, I just did not want to add another cruft, but 'x' and 'y'
are already such crufts, so I could have just done

	ln -s x y &&
	test -h y &&
	test-tool readlink y >x &&
	test $(cat x) = x

to use one of them ;-)
