Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D27E01FAE2
	for <e@80x24.org>; Fri, 23 Mar 2018 17:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeCWRfq (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:35:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46219 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbeCWRfp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:35:45 -0400
Received: by mail-wr0-f196.google.com with SMTP id d1so898612wrj.13
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PBeJQ+RyyiXR/UdYTS3YoL6tEpFYnHpHQp33t8lWM9I=;
        b=L9NBbgDC8oXEQe/r+iihdYLa7YoWBDJF0CDNxVtUno9DqXauQ/8rmgAKiHd+9bfeYC
         oh6egRFD4aWO3yy627XasjpDHpe/SjNeRfMecXan7DBwuEv2BaNwiXWKAF/B288mHbTQ
         HrSqXp1gwwT1WmtZb57pdN3zeHus+LFVVjx/MTBuBNU7irylnLZ7JGDg8vxDXPsGv1iS
         M2RLib9p70Av7RNCLHc/AuIct20E7ssr1IVoeh+7Yh3nJ/FKkj2YQEm9MbPaj9lD7L/7
         nx7JmwLECWXb7R4sNwfP4l58jC0mNMPDWR7FpU3Ca6xgZHHhCUwv0CYXhwcu9RhXyn6e
         W6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PBeJQ+RyyiXR/UdYTS3YoL6tEpFYnHpHQp33t8lWM9I=;
        b=JweIBA9W0crC/L6UBgVwUYptDR3hO16qJoFxEAyGM4HTOHfkNxK/T1yiTU5hl0RxsX
         w5rG4UiqCiqYOuGQvq7k+xWtOfLX/qw14bEq9GbLDLYsxNEKaGl+dwQQrBEv3TAUTXiy
         cMEG3fkxpxc5SMb4UUlg1U7uaRB7ZRrnVGTBtumB8ODBLcX39YpQCWPGVJGbSnpYBF3f
         CxG/tiLO+3P0usc6ucAAzE8gzSC0NlG4jN4MPl9NvXw7RNJekGhAJcdR33PVKnRkwuP1
         EPqEUJCcNdU9rGWPuW+VYRG5llWYaYgcNodtwD/7MiitYBGUxlC4fKBLuxNHsT/7G/Nb
         6YhQ==
X-Gm-Message-State: AElRT7FNL3eWgZsrepUPFtx73VqBJIDZaEBfNHRAzl9cqMpbOdlb0SB2
        xvLXcmx7g6UbiU3Uwu9Qwnh3h6hI
X-Google-Smtp-Source: AG47ELshd8UzPssrOM69hu9Cw6bW8aY8+ucwzChHWCcFe/8jWC6gqV98mhWjI9XONhcqsIusx6NxIw==
X-Received: by 10.223.209.72 with SMTP id b8mr23618835wri.122.1521826544071;
        Fri, 23 Mar 2018 10:35:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k130sm9763796wmg.9.2018.03.23.10.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 10:35:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] completion: clear cached --options when sourcing the completion script
References: <20180322141604.15957-1-szeder.dev@gmail.com>
        <CAM0VKjm3WKkxjEN09Dv1wUnuBf8CSsUvmLjmSVb1fbHTyAdXEQ@mail.gmail.com>
        <xmqqbmfek8ml.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 23 Mar 2018 10:35:43 -0700
In-Reply-To: <xmqqbmfek8ml.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 23 Mar 2018 10:24:34 -0700")
Message-ID: <xmqq7eq2k840.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>> Hang on, this test fails in the GETTEXT_POISON build.
>
> Thanks.
>
>> The thing is, we get the merge strategies with this piece of code in
>> __git_list_merge_strategies() in master:
>>
>>     LANG=C LC_ALL=C git merge -s help 2>&1 |
>>     sed -n -e '/[Aa]vailable strategies are: /,/^$/{
>>         # a couple of s/// commands
>>     }'
>>
>>
>> and that '/[Aa]vailable strategies are: /' won't match in a
>> GETTEXT_POISON-ed output, because that string is translated.
>>
>> I think for now (-rc phase) we should just drop this test, and in the
>> future we should consider adding a 'git merge --list-strategies' option.
>
> I'd say we should just add !GETTEXT_POISON prereq to the problematic
> tests.  
>
> "git merge -s help" output under forced C locale is dependable in
> the real world.  It is GETTEXT_POISON that does not get this fact
> right.  There is no need for '--list-strat' option to make this test
> pass.

IOW, this is the minumum required.

By the way, shouldn't we be running the body of these new tests
inside a subshell?  Otherwise a dot-sourcing by an earlier test of
these new ones _will_ affect all the subsequent tests.

 t/t9902-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 4c86adadf2..b7f5b1e632 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1511,7 +1511,7 @@ test_expect_success 'sourcing the completion script clears cached porcelain comm
 	verbose test -z "$__git_porcelain_commands"
 '
 
-test_expect_success 'sourcing the completion script clears cached merge strategies' '
+test_expect_success !GETTEXT_POISON 'sourcing the completion script clears cached merge strategies' '
 	__git_compute_merge_strategies &&
 	verbose test -n "$__git_merge_strategies" &&
 	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
