Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933E01F404
	for <e@80x24.org>; Tue, 20 Feb 2018 17:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeBTRTN (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 12:19:13 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:40026 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753323AbeBTRTM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 12:19:12 -0500
Received: by mail-wr0-f176.google.com with SMTP id o76so16542430wrb.7
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 09:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=p05pOhDIlRhAC55uQoebSY36LxjBQusFokcemMsvkJA=;
        b=hoMEKbKGqNKypB5JrQMGuSGEoaxHhrE6Jg4Lj1O+l8BUOjM5dsDzut0zVqiwfBi/Pb
         Zt5enWq4qLd07EUzvUs9HCtxo24ciJE7BrWWByJBJwudTzvmyN2bYXtiiKXr2ellYeKT
         LCKMOtXrZUOtaTraF9aj1AyEicKGOJvIxfN/3qdQLIFc8wg9L0CO6lnCboRWguLW0v8c
         qw+tNhGS6lZIWO4tedRWh+JWi5OZTt0Dl8C4qdIaVeGmmH4ABClPygibHNV3P9FuZmDG
         IQum7+7CRkOiXUMS2T+GcErMs2Y54FSXZrD8cDUYJiZOQzvMbnk9IQjWvQanr7K03RRx
         Iq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=p05pOhDIlRhAC55uQoebSY36LxjBQusFokcemMsvkJA=;
        b=fh+dv10/9AKolNshrfNmSBCQpg2+qsJhu04W5XP80XMu8IlUsNeyh0NGkAgymxWyYb
         /RoXo3Rq8HdUZdwtllOOblSQdPv3KThdV3IXPsBgo+ce5qiUMf2GVYfYm+oEMo9xaWNz
         Cks0b13MN6iU9R7lkVg1hMEhGy+SjWo+JVVRCUuERp/2mE7FlDJ5nCnuEFuO/QxVFyWz
         QEd9+6lEssRlC3EoeNXVBloHQHl6haH70myfoa2uA/k4CsdMKsWO/6QO5/teXRMXwBOm
         CZkynctztDMyiD2kT2J5CAhWTKCKdgBKZGH1VMguWGBLT1EVSDgUIvOPO9bI9uOA6Q/e
         C/Rg==
X-Gm-Message-State: APf1xPD1PGq8sVYQFXL7ZKw/BC+wSvvx3QrUuDQkb7juwkv6BBtVpLMO
        aAwv+N3qKqX+GSzqC1uzCPX9Y3Ko
X-Google-Smtp-Source: AH8x226WyjWyLlxdbvBIv57bUq4hdmTq6hbMkK5YHhaLuQMY0ABQVwLzbvmLBiuIZWojDaMsWIwa7w==
X-Received: by 10.28.210.212 with SMTP id j203mr822492wmg.53.1519147150395;
        Tue, 20 Feb 2018 09:19:10 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 27sm26652932wry.5.2018.02.20.09.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 09:19:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/9] t3701: use test_write_lines and write_script
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180219112910.24471-1-phillip.wood@talktalk.net>
        <20180219112910.24471-4-phillip.wood@talktalk.net>
        <CAPig+cRWCd6pYxc8NrOM_ntodgkwwfMpD_tWQXYXOukVWgQfCw@mail.gmail.com>
Date:   Tue, 20 Feb 2018 09:19:06 -0800
In-Reply-To: <CAPig+cRWCd6pYxc8NrOM_ntodgkwwfMpD_tWQXYXOukVWgQfCw@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 19 Feb 2018 13:47:16 -0500")
Message-ID: <xmqqr2pf4m0l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>>  test_expect_success 'setup fake editor' '
>> -       echo "#!$SHELL_PATH" >fake_editor.sh &&
>> -       cat >>fake_editor.sh <<-\EOF &&
>> +       FAKE_EDITOR="$(pwd)/fake-editor.sh" &&
>> +       write_script "$FAKE_EDITOR" <<-\EOF &&
>>         mv -f "$1" oldpatch &&
>>         mv -f patch "$1"
>>         EOF
>> -       chmod a+x fake_editor.sh &&
>> -       test_set_editor "$(pwd)/fake_editor.sh"
>> +       test_set_editor "$FAKE_EDITOR"
>>  '
>
> The very first thing that test_set_editor() does is set FAKE_EDITOR to
> the value of $1, so it is confusing to see it getting setting it here
> first; the reader has to spend extra brain cycles wondering if
> something non-obvious is going on that requires this manual
> assignment. Perhaps drop the assignment altogether and just write
> literal "fake_editor.sh" in the couple places it's needed (as was done
> in the original code)?

Yeah, I think $(pwd)/ prefix is needed at the final step (i.e. as
the first argument to test_set_editor) for this to be a faithful
rewrite but it is distracting having to write it anywhere else.

Other than that, this looks like a quite straight-forward cleanup.

Thanks, both.  Here is what I'd be queuing tentatively.

 t/t3701-add-interactive.sh | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 39c7423069..4a369fcb51 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -87,13 +87,8 @@ test_expect_success 'setup expected' '
 	EOF
 '
 
-test_expect_success 'setup fake editor' '
-	>fake_editor.sh &&
-	chmod a+x fake_editor.sh &&
-	test_set_editor "$(pwd)/fake_editor.sh"
-'
-
 test_expect_success 'dummy edit works' '
+	test_set_editor : &&
 	(echo e; echo a) | git add -p &&
 	git diff > diff &&
 	test_cmp expected diff
@@ -110,12 +105,10 @@ test_expect_success 'setup patch' '
 '
 
 test_expect_success 'setup fake editor' '
-	echo "#!$SHELL_PATH" >fake_editor.sh &&
-	cat >>fake_editor.sh <<-\EOF &&
+	write_script "fake_editor.sh" <<-\EOF &&
 	mv -f "$1" oldpatch &&
 	mv -f patch "$1"
 	EOF
-	chmod a+x fake_editor.sh &&
 	test_set_editor "$(pwd)/fake_editor.sh"
 '
 
@@ -302,18 +295,12 @@ test_expect_success 'deleting an empty file' '
 
 test_expect_success 'split hunk setup' '
 	git reset --hard &&
-	for i in 10 20 30 40 50 60
-	do
-		echo $i
-	done >test &&
+	test_write_lines 10 20 30 40 50 60 >test &&
 	git add test &&
 	test_tick &&
 	git commit -m test &&
 
-	for i in 10 15 20 21 22 23 24 30 40 50 60
-	do
-		echo $i
-	done >test
+	test_write_lines 10 15 20 21 22 23 24 30 40 50 60 >test
 '
 
 test_expect_success 'split hunk "add -p (edit)"' '
@@ -334,17 +321,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
 '
 
 test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
-	cat >test <<-\EOF &&
-	5
-	10
-	20
-	21
-	30
-	31
-	40
-	50
-	60
-	EOF
+	test_write_lines 5 10 20 21 30 31 40 50 60 >test &&
 	git reset &&
 	# test sequence is s(plit), n(o), y(es), e(dit)
 	# q n q q is there to make sure we exit at the end.
