Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5021F453
	for <e@80x24.org>; Thu, 14 Feb 2019 20:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394551AbfBNUQZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 15:16:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38453 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387876AbfBNUQY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 15:16:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id v26so7382788wmh.3
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 12:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=isijROdyAIsmAlsHOW1ycvtjJCEHtLJEC6MkwqM31nc=;
        b=ltxs4QENAfI9+9T43ku+sBkHeq/wNNVSV6hUrso7OHGSHS72fk77/f5wCQXbsex8nF
         BC18g5+VvXuRq5+MvrwL36+lUt9lbljB5L1NdoGYjY85vVH9ic8XOAnAx2/JbO1+FKnD
         vdW/1LDf062X4XY3sZP4Y8Pze0cijhbdiEamg+HAOkVuP1TipthPU4ZHHIpYqAleiMq6
         Ci5cymVGFSoYvipqUWjzCf40926w7Y97h6voDvOPcoketIYaguIhBYltRXHEoY76hWpa
         p0CbprrdAXdSuFLeTFcQ2z2CLIrPTNltLnGvUJpxDKOtBXiC1A+U4COyJPkBp37DnWJX
         Okgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=isijROdyAIsmAlsHOW1ycvtjJCEHtLJEC6MkwqM31nc=;
        b=UIUxLHQ2IY2SPqeyeJENR0NmMz9J2KMH+ukmm3Aqa+BldYoE+3BQ0ZbMMo0aBsf4NH
         g+7CsmIxInYj7YMlmjOyezgDLwuQG8/VOjOHnaiO09h/dGIFDKwyj3A5zL438NN7OQky
         0OINNYl3529UH1ylXdTB33qafr8+HeTfcNjupXepUiusirbu3qkHyqLdVyOifsPvytc/
         imimDXw+j9N6ZzBq1kxKY1l0SfK3r1Oi8+UkPcDe8XZ4R0UrwkJ0GUTEWK4CVBzOBQPR
         IzwY7yVCXlf907m6iDhehNg65Z8KGW31B5VNJVU3qXmq/cpTyGdDlt0nplcWRlCk4rPO
         L9Qw==
X-Gm-Message-State: AHQUAuZxeFgy8P5LQ4r9cHQRuIGztIhQizWIGo6II66CYpoQZO4QRN32
        YH1olXP61KnFpd2mwn8JHK8=
X-Google-Smtp-Source: AHgI3IY6yNT72UiJgSQnicTvmbPV7CSZQYe4Rat+DCiJh9oCeOjqJ5Td9/nOkE7VkyYqus0WGP3NQQ==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr3828603wmh.43.1550175381674;
        Thu, 14 Feb 2019 12:16:21 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i13sm5778154wrm.86.2019.02.14.12.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 12:16:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re* [Breakage] 2.20.0-rc0 t1404: test_i18ngrep reports 1 instead of 0 on NonStop in one case
References: <000801d4c174$05b76860$11263920$@nexbridge.com>
        <CACsJy8Bn+2zY6y_QqCjbB3qWM-F=3d0H5vgWj4az=md2FZ8RhA@mail.gmail.com>
        <xmqqftsughks.fsf@gitster-ct.c.googlers.com>
        <20190212002705.GD13301@sigill.intra.peff.net>
Date:   Thu, 14 Feb 2019 12:16:20 -0800
In-Reply-To: <20190212002705.GD13301@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 11 Feb 2019 19:27:05 -0500")
Message-ID: <xmqqef8a86sr.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Feb 11, 2019 at 01:07:15PM -0800, Junio C Hamano wrote:
>
>> >> test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File exists" err
>> >
>> > The message does not match, does it? Here we grep for "File exists"
>> > but the message you showed says "File already exists".
>> 
>> Hmph, this is from strerror(), right?
>> 
>> The question is if we should be using grep to match on strerror()
>> result in the C locale.
>
> Yeah, I agree that's questionable. And I'm mildly surprised it hasn't
> been a problem before now.
>
>> Do we really care that the reason of the
>> failure is due to EEXIST for this particular test?
>
> Hmm. We care to _some_ degree, since that's the condition we set up for
> making sure that update-ref cannot take the lock. But it would probably
> be fine to just confirm that we failed to take the lock. And there,
> checking for just "Unable to create $Q.*packed-refs.lock" would be
> sufficient.

Yup.

As this came from 6a2a7736 ("t1404: demonstrate two problems with
reference transactions", 2017-09-08), that is as old as Git 2.15,
I'd throw it into "not so urgent" pile.

-- >8 --
Subject: [PATCH] t1404: do not rely on the exact phrasing of strerror()

Not even in C locale, it is wrong to expect that the exact phrasing
"File exists" is used to show EEXIST.

Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
Helped-by: Duy Nguyen <pclouds@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    I've grepped in t/ directory for the exact phrases of all errno on a
    recent Debian box, and this was the only hit it found.  There
    are two other hits but both in the comments.

 t/t1404-update-ref-errors.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 51a4f4c0ac..f95a64c911 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -614,7 +614,7 @@ test_expect_success 'delete fails cleanly if packed-refs file is locked' '
 	test_when_finished "rm -f .git/packed-refs.lock" &&
 	test_must_fail git update-ref -d $prefix/foo >out 2>err &&
 	git for-each-ref $prefix >actual &&
-	test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File exists" err &&
+	test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q:" err &&
 	test_cmp unchanged actual
 '
 
