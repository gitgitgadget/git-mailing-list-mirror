Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 644CA1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 18:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeHVWQw (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 18:16:52 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36752 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeHVWQw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 18:16:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id j192-v6so2918807wmj.1
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 11:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Dji2pU9CzhGgLD0IfPRxq2r+OSoevGAZyuxMhr+UQRM=;
        b=WM4DoaR8f95+iwg18YnFUbRefbItzHzmTT59GHeJsfBODfbfD+JgILj33Irt0m9w37
         n/pXlWBK4Nexd75hwljWnPP0ACtyBDENlJWfXaklWHpiA/gCJT1qshnA32KZ1ERHb7/U
         E4iBdZ8DapqAmIb2guX705Bh4GbXI+cgsDzbqck9UJ71y0oxP+Er4tTUaX7De2IUbX6t
         xw34wU841r6S2+1rpsb9FZ8OlGsUNX0eqpUxHu2pxdA2ZjHLmBd8EBzZU7MsoLlNirDS
         5qmZrBNXkyZKtRqyhUrwnndHn6jF1BcxXsiWA9Nrg9GeGt66E53bzjnx7M0rpBJdevOQ
         Queg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Dji2pU9CzhGgLD0IfPRxq2r+OSoevGAZyuxMhr+UQRM=;
        b=Rc/X6bmf9IszHP2YHweqnqNrAkcZx/uLQJJ69ZElYxKMOCEWBBAnErpXYtmzZpH5Gy
         p2QtsWXju8j8/qBnnJnrz15LmBd5jaPvjopr9a5QmeUuIGSn+PqRt4bEgVX3zVvJpA1t
         OIFKcq4CcT1Xhx6wMMEW6+s+jNzA/I2VVJAF/6EnZM+7U8Nf7TIJOz20SwfOccg1zQ++
         Xgk3m4jCweswrAou66RWKTIJnGUVlobPKwkrqb7PvvbnBCZuRi3WvxQgs1hAk7QOgGRf
         3kjZW/WRTcwNvQgUjmeu85gdw3mtw/DlfSM3ngnkg2j7Z7zZdjJ+fKkg9/O1w2Ts1zjU
         PooA==
X-Gm-Message-State: APzg51AENWz+BSBhW6oh/N+5Cf4oHjOOSmi2d3jJN3fhOQ7gx7brBTb8
        YXynuZVKkNdxOF9ZYVsxh48=
X-Google-Smtp-Source: ANB0VdabNIwdeRFvisUWSnvQ4mzDTz69SMKkqOcA44nCM8zt4L/Wcjnce0QbkmNavmEzicE61ZSwLA==
X-Received: by 2002:a1c:1188:: with SMTP id 130-v6mr3052147wmr.138.1534963847876;
        Wed, 22 Aug 2018 11:50:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u65-v6sm3725046wmd.31.2018.08.22.11.50.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 11:50:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t6018-rev-list-glob: fix 'empty stdin' test
References: <20180727174811.27360-1-avarab@gmail.com>
        <20180822174820.12909-1-szeder.dev@gmail.com>
Date:   Wed, 22 Aug 2018 11:50:46 -0700
In-Reply-To: <20180822174820.12909-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Wed, 22 Aug 2018 19:48:20 +0200")
Message-ID: <xmqqefeqme0p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Redirect 'git rev-list's stdin explicitly from /dev/null to provide
> empty input.  (Strictly speaking we don't need this redirection,
> because the test script's stdin is already redirected from /dev/null
> anyway, but I think it's better to be explicit about it.)

Yes.

>  test_expect_failure 'rev-list should succeed with empty output on empty stdin' '
> -	git rev-list --stdin <expect >actual &&
> +	git rev-list --stdin </dev/null >actual &&
>  	test_must_be_empty actual
>  '

By the way, it may be about time to turn that expect-failure into
expect-success.  It is somewhat unfortunate that 0c5dc743 ("t6018:
flesh out empty input/output rev-list tests", 2017-08-02) removed
the comment that said "we _might_ want to change the behaviour in
these cases" and explained the tests as reminders, anticipating that
the series will change the behaviour for three cases where the
pending list ends up empty to make the discussion moot, but it
changed the behaviour of only two of them, leaving the "--stdin
reads empty" case behind.

It may be just the matter of doing something like the attached
patch.  I won't be committing such a behaviour change during the
pre-release feature freeze, but we may want to consider doing this
early in the next cycle.

 revision.c               | 13 +++++++++++++
 t/t6018-rev-list-glob.sh |  4 ++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index d12e6d8a4a..21fb413511 100644
--- a/revision.c
+++ b/revision.c
@@ -2441,6 +2441,19 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		object = get_reference(revs, revs->def, &oid, 0);
 		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
 	}
+	/* 
+	 * Even if revs->pending is empty after all the above, if we
+	 * handled "--stdin", then the caller really meant to give us
+	 * an empty commit range.  Just let the traversal give an
+	 * empty result without causing a "no input?  do you know how
+	 * to use this command?" failure.
+	 *
+	 * NOTE!!!  Because "--stdin </dev/null --default HEAD" should
+	 * default to HEAD, this must come _after_ the above block
+	 * that deals with revs->ref fallback.
+	 */
+	if (read_from_stdin)
+		revs->rev_input_given = 1;
 
 	/* Did the user ask for any diff output? Run the diff! */
 	if (revs->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT)
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 02936c2f24..db8a7834d8 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -255,8 +255,8 @@ test_expect_success 'rev-list accumulates multiple --exclude' '
 	compare rev-list "--exclude=refs/remotes/* --exclude=refs/tags/* --all" --branches
 '
 
-test_expect_failure 'rev-list should succeed with empty output on empty stdin' '
+test_expect_success 'rev-list should succeed with empty output on empty stdin' '
 	git rev-list --stdin </dev/null >actual &&
 	test_must_be_empty actual
 '
 
