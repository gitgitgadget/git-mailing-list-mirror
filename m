Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6738D1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 12:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfBMMAE (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 07:00:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42526 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfBMMAD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 07:00:03 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so2155830wrx.9
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 04:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ks1yEnT5q4m28xBarGMz562nQjJCtSXncvbGzg0p9Cc=;
        b=byF4qarl0v8l/n9O3mlBOhZXt4CnMkQoMX4yft/cXkk7RCv1E4P6RiOAwhRSoqLqCw
         O75SufxBrpkPdg3tz3L3PTBniN2cftgdQr9fLUqiGeQxLkTuKdzY660o0fSFyZU4o2dJ
         xnf06xlY7UcvrbWzsZETaMmfSwgezkA/wTYFtVga48pswW+6KKqa9mM9lbYCG8fqYpdy
         iGMsu4Ab6rHXs2RZtXnei0TAtr69Pu8mfljByqChlnwqzmipNedLIVIxcO1BsWlYeOPc
         Hbxci89fWk99aZEsWcnUUjPACdhOgDKO0NFxS6lJ2dt+HjvxmoMkHbtocv5Ft8sHPjae
         sp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ks1yEnT5q4m28xBarGMz562nQjJCtSXncvbGzg0p9Cc=;
        b=XeOjexdSywHHlnm8IcDZI7xobiI4Nlzh/YUGpeyQBK7nW6gJ/TC+DBEy1smJZdehHF
         wdOSNcdG1jCh4HO8IH2WSaua62PruA1SMquuw1elAqRcMJur4vpW/chh8kQJzkYRl5JV
         922zUhPJ4Bgc7szfJgtFX9tkuXXBVi5Kmor6yls87283ZzHTrKDWwmD/uO/pvbkeZDNv
         1yxsRndtdp7KPe+0y3WnO3DJxkd63IauErXkr9OO1R/vlBF8NptDKPHI6RdTs9Q9OZMc
         oWcyiL/EUsaYNjmQ/BfKpZDteDiUKccWAjJct//d1go9rnJwGle4SgsQU4Uuf819ArwJ
         j7qg==
X-Gm-Message-State: AHQUAuamYSTB8I5sfQ1qde0GBdsLfbDm6V3xGHkqjMM2uYjo5m0R2o9m
        Ofbqn/p1plQyih/3O50JnwacuDXG
X-Google-Smtp-Source: AHgI3IbSTuiQ2LPBikEXb2NfWCeZQqOPwnlWLm5xJunrB//pz7Fr+s7FZG9MexKEb7QJlgbEp1+CIA==
X-Received: by 2002:adf:f80e:: with SMTP id s14mr76310wrp.327.1550059201474;
        Wed, 13 Feb 2019 04:00:01 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c65sm9147847wma.24.2019.02.13.04.00.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Feb 2019 04:00:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>, hsed@unimetic.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] tests: avoid syntax triggering old dash bug
Date:   Wed, 13 Feb 2019 12:59:51 +0100
Message-Id: <20190213115951.12096-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1
In-Reply-To: <xmqqo9a9stbs.fsf@gitster-ct.c.googlers.com>
References: <xmqqo9a9stbs.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid a bug in dash that's been fixed ever since its
ec2c84d ("[PARSER] Fix clobbering of checkkwd", 2011-03-15)[1] first
released with dash v0.5.7 in July 2011. This failing test was
introduced in 5f9674243d ("config: add --expiry-date", 2017-11-18).

This fixes 1/2 tests failing on Debian Lenny & Squeeze. The other
failure is due to 1b42f45255 ("git-svn: apply "svn.pathnameencoding"
before URL encoding", 2016-02-09).

The dash bug is triggered by this test because the heredoc contains a
command embedded in "$()" with a "{}" block coming right after
it. Refactoring the "$()" to e.g. be a variable that was set earlier
will also work around it, but let's instead break up the "EOF" and the
"{}".

An earlier version of this patch[2] mitigated the issue by breaking
the "$()" out of the "{}" block, that worked, but just because it
broke up the "EOF" and "{}" block. Putting e.g. "echo &&" between the
two would also work.

1. https://git.kernel.org/pub/scm/utils/dash/dash.git/
2. https://public-inbox.org/git/20181127164253.9832-1-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Wed, Nov 28 2018, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Tue, Nov 27, 2018 at 11:43 AM Ævar Arnfjörð Bjarmason
>> <avarab@gmail.com> wrote:
>>> Avoid a bug in dash that's been fixed ever since its
>>> ec2c84d ("[PARSER] Fix clobbering of checkkwd", 2011-03-15)[1] first
>>> released with dash v0.5.7 in July 2011.
>>
>> Perhaps enhance the commit message to explain the nature of the bug
>> itself. It is not at all obvious from reading the above or from
>> looking at the diff itself what the actual problem is that the patch
>> is fixing. (And it wasn't even immediately obvious by looking at the
>> commit message of ec2c84d in the dash repository.) To help readers of
>> this patch avoid re-introducing this problem or diagnose such a
>> failure, it might be a good idea to give an example of the syntax
>> which trips up old dash (i.e. a here-doc followed immediately by a
>> {...} expression) and the actual error message 'Syntax error: "}"
>> unexpected'.
>
> Indeed.  From the patch text, I would not have even guessed.  I was
> wondering if there were interactions with "" and $() inside it.
>
> If having {...} immediately after a here-doc is a problem, then the
> patch should not touch existing code at all, but instead insert a
> new line, perhaps like
>
> 	: avoid open brace immediately after here-doc for old dash

Late re-roll. Now using a variant of that suggestion, and with an
updated commit message explaining what the issue in dash is exactly
and why it was triggered.

This isn't a 2.21 regression, but sending it in the rc window anyway
in case you'd like to queue an obviously working minor portability
fix.

 t/t1300-config.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9652b241c7..428177c390 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -892,6 +892,7 @@ test_expect_success 'get --expiry-date' '
 	1510348087
 	0
 	EOF
+	: "work around heredoc parsing bug fixed in dash 0.5.7 (in ec2c84d)" &&
 	{
 		echo "$rel_out $(git config --expiry-date date.valid1)"
 		git config --expiry-date date.valid2 &&
-- 
2.20.1.611.gfbb209baf1

