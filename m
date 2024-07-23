Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C25D25760
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721776051; cv=none; b=aUZUtM314pcGN4uaX3UKzKjMm2g6dK/t2Bo77w69OZHbtsjw2aRYqUHod8jTHJCN27Ej+PSNZ78Ud+KLiU8LG2p7P8C14JjIzSJJQ+4Bvu2gxLv8ry0O/20lSOzmKjyqDjrj7QOYBxf9L0z0/7YMnq6EnguRCGl9ga/knv8ykjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721776051; c=relaxed/simple;
	bh=uEBzWkHfcO6/vVsD3ojNHEqEbE74m+KC5Ebuv3gIvzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlImRIfnLC36w+lBtnE1t2LrxGKP0MMYUv8EdbHYQhwaCkMXDAJyJFlwZFv0cir3PQb2DfVo/3KEQlCfHamFyuolxuOkjG3uXKPn/gE7N+pTVxaB3dYdF7i8vA5qw619vSYKCQGbbczeLTJhhMNl5bQSRnA9uXb5sqacq6NiJKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvegt3rT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvegt3rT"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-427b1d4da32so1726435e9.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 16:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721776045; x=1722380845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8nD+IMbkJXrIrpx+uwP1Utp9oDmdhiPKtJ21zqzOARc=;
        b=kvegt3rTgAJPRQz11YSVaztQKKxSdFwmVv+TWf3YLSLyQ60VNCrDmT1d15oYdxKvxO
         pdaTxS52ubqf9C/5b3yWV6mMulWI8MaDi2ThCxeWFKksqZys7gqpdd8dsb1a/UIaXtH3
         dwSVgqQmWBkf0ldZHKH5G6GmtBlTT+Og4r0SSYaTssblwepnToS9wl2oCOJMrmNtBpgQ
         risZr0En631cj/xQGnmxM1o6ZLyNRG3aYunrjHme+iVTElr1OMoj1AA5+xqDco6hSFPG
         D8vAQp/9cPRAS0Z01rKdwuWqX5+teoSawCnk74oacLSOFYHqN/9oq+HyJTxegtHj6Tw5
         pFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721776045; x=1722380845;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nD+IMbkJXrIrpx+uwP1Utp9oDmdhiPKtJ21zqzOARc=;
        b=MZDLUgfzg5E2QHoBNiapNNStrExq++PhYWANjS8hLmer2qe1IBW4aZDSzAp0TONzKC
         qfPm+VaMrI2tqSAdJOYVktKg6KDxGSGGjY2XxEK0e2fS+pMeEbqg6fXoiFOXOq5e2rRE
         msiyE4CQYCxtirIwsVNxcZbhuXzlbSot1VFaOsxVLZjkSyQsh4Mj4jns6Cy8d5hOJm4Y
         fPs0AVav+aBvkrhYrTmVwid4dVKUxdsvNi8HMdiLwVLFQ4+onoVpOASjVELSHF4S2kiw
         nSsX1YRBSlaFc9b7jr3mjCcoVRnAgndO+6cGM0o8s43OahP9pORCPLD0bAMGGTxJQg3O
         i4rA==
X-Gm-Message-State: AOJu0YwW/L1DU0/P2u9tA0nULY8iktD9xMQnbE0MXNAZQRbRagv2Udkq
	9l/4vHz65zv7fXo+BPcILXHufWj1kOPW7zN5KK6Yi/sYP02g8OT+
X-Google-Smtp-Source: AGHT+IHF1jfgaIE7Hv+cJMusFOiRMozfxmBvBz5QJxMhiDL58TQiMsB/B4T/QIV16uqb9XadsP+yFQ==
X-Received: by 2002:adf:fd10:0:b0:367:8e63:4da4 with SMTP id ffacd0b85a97d-369f66bb346mr78759f8f.14.1721776044329;
        Tue, 23 Jul 2024 16:07:24 -0700 (PDT)
Received: from gmail.com (155.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ebab0sm12755460f8f.92.2024.07.23.16.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 16:07:23 -0700 (PDT)
Message-ID: <4b1391d5-89c2-41b1-b1de-e1bd26b9f10e@gmail.com>
Date: Wed, 24 Jul 2024 01:07:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re* [PATCH] t0613: mark as leak-free
To: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <23d41343-54fd-46c6-9d78-369e8009fa0b@gmail.com>
 <20240701035759.GF610406@coredump.intra.peff.net> <Zp4gILfskdpc6RUk@tanuki>
 <20240723210339.GD6779@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <20240723210339.GD6779@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 23, 2024 at 05:03:39PM -0400, Jeff King wrote:
> On Mon, Jul 22, 2024 at 11:02:24AM +0200, Patrick Steinhardt wrote:
> 
> > > I'd noticed it, too, while doing recent leak fixes. But since Patrick
> > > has been working on leaks and is the go-to person for reftables, I
> > > assumed he had already seen it and there was something clever going on. ;)
> > 
> > Nah, you assumed too much :) I just forgot to mark this as leak-free and
> > the topic crossed with my memory-leak-fix topics, so I didn't yet find
> > the time to fix it.
> 
> Ah, OK. :) Then I think we did the right thing in your absence.

:)

> 
> > It does highlight an issue though: I think memory leak checks should be
> > opt-out rather than opt-in by now. Most of our tests run just fine with
> > the memory leak checker enabled, and that's also where we want to be
> > headed. So making tests opt-out would likely raise more eyebrows when
> > new tests are being added that explicitly opt out.
> > 
> > The only reason I didn't send a patch like this yet is that it would of
> > course create quite a bit of churn in our tests. I'm not sure whether
> > that churn is really worth it, or whether we should instead just
> > continue fixing tests until we can get rid of this marking altogether
> > because all of our tests pass.
> 
> I could see arguments in both directions. I'd worry that by switching
> the default to "assume leak free", it may end up with misalignment
> between who introduces the bug and who deals with the fallout.
> 
> Right now, if I introduce a test that is leak free but don't mark it,
> somebody working on leaks later runs in check mode and says "yay, it
> passes. Let's mark it". It becomes their task to do, but it's an
> easy-ish task.
> 
> If we go the other way, then a new test that _does_ leak means that
> either:
> 
>   1. The original author notices the CI leaks job failing.
> 
>      a. They introduced the leak, and it was caught early. Yay!
> 
>      b. The leak is in some random part of Git that their test happened
> 	to trigger. Now they spend effort proving it was not their fault
> 	before they annotate the test with "does not pass leak".
> 
>   2. The original author does not notice. Somebody notices later when
>      doing leak-checking (or I guess just running their own CI, if we
>      are hitting these by default). Now they are stuck with doing (1a)
>      or (1b) themselves, even though they do not care about the original
>      topic.
> 
> So I dunno. If we think people are paying attention to CI on their
> topics, and we think that we are close enough to leak-free that (1b)
> won't come up a lot, it might make sense. I'm not quite sure we're there
> yet on the latter, but it's mostly gut feeling (and I know things have
> gotten a bit better recently, too).

I don't know either.  Maybe it seems a bit early still considering the
numbers we have: 

   $ git grep -l PASSES_SANITIZE_LEAK=true t/t[0-9][0-9][0-9][0-9]-*.sh | wc -l
   678
   $ git grep -L PASSES_SANITIZE_LEAK=true t/t[0-9][0-9][0-9][0-9]-*.sh | wc -l
   329

BTW, perhaps we want to do this:

----- >8 --------- >8 --------- >8 --------- >8 ----
Subject: [PATCH] t: do not mark tests as no-leak-free

The mark TEST_PASSES_SANITIZE_LEAK=false and the absence of it mean the
same thing: the test triggers leaks.  However, explicitly declaring that
the test leak, with TEST_PASSES_SANITIZE_LEAK=false, can suggest there
is some special consideration for it, which is not the case.

Looking back at the history of the tests we're modifying in this patch,
we see that both were marked as "leak-free", but later started
triggering leaks and had to be re-marked accordingly as "no-leak-free".
Instead of removing the mark entirely, it was changed to "false".

It doesn't seem to have much historical value to keep the mark for this
reason, and removing it reduces the confusion that it has some special
meaning.

Do it so.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/t0210-trace2-normal.sh | 1 -
 t/t0211-trace2-perf.sh   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index c312657a12..eff9a59dbd 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -2,7 +2,6 @@
 
 test_description='test trace2 facility (normal target)'
 
-TEST_PASSES_SANITIZE_LEAK=false
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index 070fe7a5da..b9421a64a7 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -2,7 +2,6 @@
 
 test_description='test trace2 facility (perf target)'
 
-TEST_PASSES_SANITIZE_LEAK=false
 . ./test-lib.sh
 
 # Turn off any inherited trace2 settings for this test.

