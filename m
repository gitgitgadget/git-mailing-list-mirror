Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64247C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4A4610EA
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhKBOw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhKBOwz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 10:52:55 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44750C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 07:50:19 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id o4so30289175oia.10
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 07:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=CYp3o/YTdJiu+EkQujYSYglh2l7b776e4adXyvrpQD8=;
        b=WIVUa8WWUgiTSgPPBJviJGBGcXlIk0W5Gva+eEzUmGnBlWVOvA216mlqYuF6P24vHD
         u8foJjjbYjLoWhpuRYDIVrQgbfo5GJ3/BlvTtOv4UBOKsJJAb+TMuih7/RjH5h7rfUPv
         2slmNUKSHiCQw1REpZun4v+mGwuIsquWTlPQYObBDHAXgNmlC0mgWcKgUYDErhMyJawB
         AFLUq1ti5mx9GU9UKqkIDk5rsoU2HqOUn0ewMJv9PtRQG5ag2y/UUS+flFCL+J/5d5c3
         Lm0rRaWFy6aU89Gdig/TAZ000j6TzspC0Mo+WcqNpzv/TcbrjNmPYZQV58Wtj7vqxGsv
         +TBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=CYp3o/YTdJiu+EkQujYSYglh2l7b776e4adXyvrpQD8=;
        b=FQib0NwwvnccK03vs3sjehm1ImMfX8xcUouG/ks/3Ly2mHep2PG9NLN3vWpYS8fTdq
         t344pBoHRcmjUswaX3JQIpEfJJAq9X/5ayC38EE1WjfxOj7pG60hyfTgcfaSqO1MPY5F
         pj8/dco7EdbDNk8l6R+Kya7eEhWC+Gd6x70izhUkmBZctfFdqXbCUt8/CdByiHcgU1+E
         /jOnMi7g2kDbpmwqjjQ2wMmITTRnsWXaVAqEf69ZgMAR8daSSPRPL+bsWB1RLHdRodjD
         BwHlVcQeg/1Q4iREhMyzC5v+/lPiRyED6CqcVGUl5Ru6NwuCAIiVQDpG8b9ifBK5NOvX
         ObpA==
X-Gm-Message-State: AOAM533rAsMs/WeoTj7r1IABiuFl1tWIT84BFyG9S8AtExYXB2q9f+4Y
        rnRPwdCfbxptZxKoffrw68g=
X-Google-Smtp-Source: ABdhPJwqjOQIqggxCLeESt1rXJyPkF+YqgTSPAHkftUEe4MPCTW++aNONDjvhaQhQHKitWUbXeJbag==
X-Received: by 2002:a54:4f8f:: with SMTP id g15mr5331232oiy.169.1635864618436;
        Tue, 02 Nov 2021 07:50:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d138:db8d:4df:dd6f? ([2600:1700:e72:80a0:d138:db8d:4df:dd6f])
        by smtp.gmail.com with ESMTPSA id r5sm4821912oov.48.2021.11.02.07.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 07:50:18 -0700 (PDT)
Message-ID: <7a62be4e-aa69-8a79-4608-971b96ee4d7c@gmail.com>
Date:   Tue, 2 Nov 2021 10:50:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v4 04/13] dir: fix pattern matching on dirs
Content-Language: en-US
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        vdye@github.com, jrnieder@gmail.com
References: <kl6lzgqnv2dn.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq7ddr9z0i.fsf@gitster.g> <2f1d2e09-faf5-0caf-6be8-7bcede9fe8d1@gmail.com>
In-Reply-To: <2f1d2e09-faf5-0caf-6be8-7bcede9fe8d1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2021 9:42 AM, Derrick Stolee wrote:
> On 11/1/2021 8:34 PM, Junio C Hamano wrote:
>> Glen Choo <chooglen@google.com> writes:
>>
>>> This patch changes the behavior of .gitignore such that directories are
>>> now matched by prefix instead of matching exactly.
> 
> Thank you for pointing out an unintended consequence.
> 
>>> The failure that we observed is something like the following:
>>>
>>> In "a/.gitignore", we have the pattern "git/". We should expect that
>>> "a/git/foo" to be ignored because "git/" should be matched exactly.
>>> However, "a/git-foo/bar" is also ignored because "git-foo" matches the
>>> prefix.
>>>
>>> I'll prepare a test case for this as soon as I figure out how to write
>>> it..
...
> In the meantime, I'll try to create a Git test that demonstrates a
> problem one way or another.

I created a test, but had some trouble reproducing it due to some
subtleties higher in the call stack. Here is a patch that reverts
the change and adds some tests.

The Scalar functional tests passed with the revert, so the original
patch was worthless to begin with. I don't recall what motivated the
change, but clearly it was a mistake. Sorry.

---- >8 ----

From d1cfc8efeab015273bfebd6cd93465e6f38dc40f Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Tue, 2 Nov 2021 10:40:06 -0400
Subject: [PATCH] dir: fix directory-matching bug

This reverts the change from ed49584 (dir: fix pattern matching on dirs,
2021-09-24), which claimed to fix a directory-matching problem without a
test case. It turns out to _create_ a bug, but it is a bit subtle.

The bug would have been revealed by the first of two tests being added to
t0008-ignores.sh. The first uses a pattern "/git/" inside the a/.gitignores
file, which matches against 'a/git/foo' but not 'a/git-foo/bar'. This test
would fail before the revert.

The second test shows what happens if the test instead uses a pattern "git/"
and this test passes both before and after the revert.

The difference in these two cases are due to how
last_matching_pattern_from_list() checks patterns both if they have the
PATTERN_FLAG_MUSTBEDIR and PATTERN_FLAG_NODIR flags. In the case of "git/",
the PATTERN_FLAG_NODIR is also provided, making the change in behavior in
match_pathname() not affect the end result of
last_matching_pattern_from_list().

Reported-by: Glen Choo <chooglen@google.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c              |  2 +-
 t/t0008-ignores.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index c6d7a8647b9..94489298f4c 100644
--- a/dir.c
+++ b/dir.c
@@ -1294,7 +1294,7 @@ int match_pathname(const char *pathname, int pathlen,
 		 * then our prefix match is all we need; we
 		 * do not need to call fnmatch at all.
 		 */
-		if (!patternlen && (!namelen || (flags & PATTERN_FLAG_MUSTBEDIR)))
+		if (!patternlen && !namelen)
 			return 1;
 	}
 
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 532637de882..1889cfc60e0 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -803,6 +803,32 @@ test_expect_success 'existing directory and file' '
 	grep top-level-dir actual
 '
 
+test_expect_success 'exact prefix matching (with root)' '
+	test_when_finished rm -r a &&
+	mkdir -p a/git a/git-foo &&
+	touch a/git/foo a/git-foo/bar &&
+	echo /git/ >a/.gitignore &&
+	git check-ignore a/git a/git/foo a/git-foo a/git-foo/bar >actual &&
+	cat >expect <<-\EOF &&
+	a/git
+	a/git/foo
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'exact prefix matching (without root)' '
+	test_when_finished rm -r a &&
+	mkdir -p a/git a/git-foo &&
+	touch a/git/foo a/git-foo/bar &&
+	echo git/ >a/.gitignore &&
+	git check-ignore a/git a/git/foo a/git-foo a/git-foo/bar >actual &&
+	cat >expect <<-\EOF &&
+	a/git
+	a/git/foo
+	EOF
+	test_cmp expect actual
+'
+
 ############################################################################
 #
 # test whitespace handling
-- 
2.34.0.vfs.0.0.rc0.dirty

