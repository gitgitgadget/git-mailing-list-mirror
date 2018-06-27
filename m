Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADDC31F516
	for <e@80x24.org>; Wed, 27 Jun 2018 16:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965832AbeF0Qyr (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 12:54:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51229 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965107AbeF0Qyq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 12:54:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id w137-v6so6637693wmw.1
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 09:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kjibJmYe6qQQbAqjCWIkdoHBnG10039JA8Zb1tSD6D0=;
        b=rpKR6sQ7AdMSGbIipC9YgO8HP97AAu9UrJWPmUYvQtBG8zpjmwUrfR2OPbxeUVCTmq
         LXx16UBvPsBurMTifn7snZnrak+CgaYj7m1Pgj2ldyS+3yzf6pwi7jSrXOeo8HF1cC1A
         b43sd5AmL+mMK92njAz30gZ32WCA/Brl9jFmBohQfUsUQNJc61qNVsy/rMtwCYo2cIFh
         xcD/Jxp/DD4ZMtEfsrQCax3WedyhB+fzFUKYkJYTAc3eGNw4MSPZO2L/k272GGtpATfr
         aUxtuRmcPWyrNWqjR/tz6phoxZYYFLXGhwhfRFkJUTV/EUIe6hUmvlXQDwhuhtEKk0iH
         oKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kjibJmYe6qQQbAqjCWIkdoHBnG10039JA8Zb1tSD6D0=;
        b=XbvLs6vG0Dq/zDciuL8DgSzIT5rSFoMkDs9WmpgEkWbz7BjvheX2dp7Qi4WKelxyah
         wTKf/6Z5iUYHGcx4T9Y5fZXIM8UiDBOEeZsh3Kj38wKQjC6HkUeXXNjoKrpENCGhfCbc
         7872cJHJxPodmr3BnowKM7s95o2AcTjCF+CMlmmbE46IQ+mScZVcIWcMY83fqAlgOqug
         Tki1Z4E7hyi8d67VIQxK24zT+W+p/BFzqfI1ocCe+VB7EqeltCSqpqsiNf/HobQ+QaNL
         Oj2Btl91XVaD/QHccG5exoAM6VHPi7/VyDGgByp+PQNWRpUbkzY3hglEHDKEqCMBGJcq
         1O/w==
X-Gm-Message-State: APt69E0TzWaaCGD+W0k7clr4JxwHnMSoczxpUCjQT5wbEmbQGF6k6qy/
        oz5DYEfmyw4iwG1p/VxwY7o=
X-Google-Smtp-Source: AAOMgpefqrTyWxjC/L3XNBquevmGIB1eJ6QUuuINDIrCEGMdPnOXxR+LtP/rhQILcVXPGxZCLS0sZA==
X-Received: by 2002:a1c:2544:: with SMTP id l65-v6mr5664478wml.131.1530118485251;
        Wed, 27 Jun 2018 09:54:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g18-v6sm4438234wrm.34.2018.06.27.09.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 09:54:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/2] t3418: add testcase showing problems with rebase -i and strategy options
References: <20180607050845.19779-1-newren@gmail.com>
        <20180627073623.31725-1-newren@gmail.com>
        <20180627073623.31725-2-newren@gmail.com>
        <CAPig+cTwwuqPgF2NtGRgpcdjFqJK22+FFDV2c-20oQXFLEPaWQ@mail.gmail.com>
        <CABPp-BFkjF5z6axqW-v=zPq9U9sOQGpUKK+WvLknkkGzX-F4rA@mail.gmail.com>
Date:   Wed, 27 Jun 2018 09:54:43 -0700
In-Reply-To: <CABPp-BFkjF5z6axqW-v=zPq9U9sOQGpUKK+WvLknkkGzX-F4rA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 27 Jun 2018 00:49:22 -0700")
Message-ID: <xmqqh8logofg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>> +       chmod +x test-bin/git-merge-funny &&
>>> +       (
>>> +               PATH=./test-bin:$PATH
>>
>> Broken &&-chain (in subshell).
>>
>>> +               test_must_fail git rebase -i -s funny -Xopt -Xfoo master topic
>>> +       ) &&
>>> +       test -f funny.was.run &&
>>> +       rm funny.was.run &&
>>> +       echo "Resolved" >F2 &&
>>> +       git add F2 &&
>>> +       (
>>> +               PATH=./test-bin:$PATH
>>
>> Ditto.
>>
>
> I'm just trying to prove how important your other patch series is.  ;-)

Actually, this shows why the other patch series, especially its last
step, is problematic a bit.  The above assignments are followed by a
single command, i.e.

+	(
+		PATH=./test-bin:$PATH
+		test_must_fail git rebase -i -s funny -Xopt -Xfoo master topic
+	) &&

+	(
+		PATH=./test-bin:$PATH
+		git rebase --continue
+	) &&

and it would be reasonable to assume that these variable assignments
would not fail.  IOW, there is no BUG in breaking &&-chain at these
two places.  It is merely that the automated mechanism introduced by
step 29/29 of that other series does not understand that (which is
expected).  It is not wrong to have && at the end of the assignment,
though.

Having said that, it would be simpler for at least the latter to
write it using a single-shot environment assignment, perhaps?  I.e.

	PATH=./test-bin:$PATH git rebase --continue &&

without running in a subshell?
