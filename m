Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD20EC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 03:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbiANDOz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 22:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiANDOy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 22:14:54 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC53C061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 19:14:54 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id m2so9661208qkd.8
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 19:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1BymXwOmyBwBbJ/ns9AaKHWq7umlU+Xd53xeQSrCZdg=;
        b=JpwlfBfxL5fu3+AB40S2j54/BPyUveCFYHWdEX8hrvdKnXAkzc4ps3Av6dezC5dgV6
         sI/XLwooc1E9V2+XApLL7cZDCiBub6sLvgefGwpwOmeuKXWKsR7JS85nwIMQ1XOooZ64
         KfepluD65cR0TECJ7mOYJN7R1RwX4WLXtQElBIVOfjY5djrQ2j06VejhNomiDKBwMStW
         tcnx8WebRMGnWNd0KGWiztdmtkK1h8PnFK9aA4wXfhqm0fg4yMXAuWeCtQimVi0ipext
         uWqW6YoavjKuutCe9OShoEXAZlwF/8v5K8rJ5uBgS5WlcnBy9gcrdrsS7WGVZCGPQBEu
         toMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1BymXwOmyBwBbJ/ns9AaKHWq7umlU+Xd53xeQSrCZdg=;
        b=sTswwj3AqPDDXvQdT4RhkEq+Hx/H8yOTW/tQNl+u8khtKFPH0eu1aXn41e4+d5dIsE
         S3CzZCL4H3PbihDOgDFQT4GMbunU2I0vJ5MuVOUIUbaG2xWhnjHfkGR5Rfs1qH5X9ikS
         9zmxZM+UngKw6PLMI8C9iGEs35RfBTInrZszOwyyzvKPfbjutal1hCz3hmSa5ew4WADq
         2eh/mpIDI1wEIjl92QtosnxCADS8uS0XOoRbL5JnxUl64SZfwhExYoV4gkWN7Jt3HW4L
         fjm/Uf4dCjdysOAUh6dhJz6v43JQBJiVuMTTHd36w0O6Ha3Cal5nscPx7aEH0378qbrv
         ja0A==
X-Gm-Message-State: AOAM5318Xt8rHrWJKdVcIVmKs34tnlQIe4oDb1IZrTawLtgPUdE8gptM
        4QSHiMGimngoB754P7aifc0=
X-Google-Smtp-Source: ABdhPJz04OKslWsswXsINN9PXZPYkIyH9OXvYdki/rDLx9Q68Z/LXWQZADxSFDAbhYNNs98RVMSUeQ==
X-Received: by 2002:a05:620a:29c8:: with SMTP id s8mr5174464qkp.169.1642130093491;
        Thu, 13 Jan 2022 19:14:53 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id bq15sm1271759qtb.54.2022.01.13.19.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 19:14:52 -0800 (PST)
Subject: Re: [PATCH 1/1] builtin/pull.c: use config value of autostash
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai <johncai86@gmail.com>, git@vger.kernel.org,
        Tilman Vogel <tilman.vogel@web.de>
References: <20220104214522.10692-1-johncai86@gmail.com>
 <20220104214522.10692-2-johncai86@gmail.com> <xmqqbl0r9l0l.fsf@gitster.g>
 <4fe0e850-1c30-da70-5535-e2a4105ba734@gmail.com> <xmqq35m0el28.fsf@gitster.g>
 <xmqqee5bfaof.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <8d19623b-4b11-8ecc-8f27-17ad4ba4167a@gmail.com>
Date:   Thu, 13 Jan 2022 22:14:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqee5bfaof.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-01-13 à 19:00, Junio C Hamano a écrit :
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Here is how I would explain your change.
> 
> This topic is in "Expecting an ack or two" state for some time.
> 
>   - Philippe, are you OK with the attached patch?  If so throw your
>     Signed-off-by to this thread.

I'm not 100% OK since as I remarked to John in [1], I don't think all 4
tests are necessary, 3 out of 4 are duplicates of existing tests, and I
would have put the new test in t5520 with 'git pull's other "autostash"
tests. I hoped that John would incorporate my suggestions in a v2, but he
seems to be busy, so I'm including an updated patch at the end of this email.
I only slightly edited the commit message you wrote, so thanks for that.
'pb/pull-rebase-autostash-fix' could be replaced by the patch below,
I would think.

>   - John, if you find Philippe's implementation a good idea (I think
>     it is, as it is simpler and cleaner) after reading and
>     understanding it, please throw an Acked-by or Reviewed-by to this
>     thread.
> 


Thanks,

Philippe.

[1] https://lore.kernel.org/git/fe0b7337-3005-d09c-a3b6-65a100799676@gmail.com/

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
 From 28edde4e302e14c900e314268e4eeaeadc240bcb Mon Sep 17 00:00:00 2001
From: Philippe Blain <levraiphilippeblain@gmail.com>
Date: Thu, 13 Jan 2022 21:58:05 -0500
Subject: [PATCH] pull --rebase: honor rebase.autostash when fast-forwarding

"pull --rebase" internally uses the merge machinery when the other
history is a descendant of ours (i.e. perform fast-forward).  This
came from [1], where the discussion was started from a feature
request to do so.  It is a bit hard to read the rationale behind it
in the discussion, but it seems that it was an established fact for
everybody involved that does not even need to be mentioned that
fast-forwarding done with "rebase" was much undesirable than done
with "merge", and more importantly, the result left by "merge" is as
good as (or better than) that by "rebase".

Except for one thing.  Because "git merge" does not (and should not)
honor rebase.autostash, "git pull" needs to read it and forward it
when we use "git merge" as a (hopefully better) substitute for "git
rebase" during the fast-forwarding.  But we forgot to do so (we only
add "--[no-]autostash" to the "git merge" command when "git pull" itself
was invoked with "--[no-]autostash" command line option.

Make sure "git merge" is run with "--autostash" when
rebase.autostash is set and used to fast-forward the history on
behalf of "git rebase".  Incidentally this change also takes care of
the case where

  - "git pull --rebase" (without other command line options) is run
  - "rebase.autostash" is not set
  - The history fast-forwards

In such a case, "git merge" is run with an explicit "--no-autostash"
to prevent it from honoring merge.autostash configuration, which is
what we want.  After all, we want the "git merge" to pretend as if
it is "git rebase" while being used for this purpose.

[1] https://lore.kernel.org/git/xmqqa8cfbkeq.fsf_-_@gitster.mtv.corp.google.com/

Reported-by: Tilman Vogel <tilman.vogel@web.de>
Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
  builtin/pull.c  |  7 +++----
  t/t5520-pull.sh | 13 +++++++++++++
  2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 1cfaf9f343..9f8a8dd716 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1036,14 +1036,13 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
  		oidclr(&orig_head);
  
  	if (opt_rebase) {
-		int autostash = config_autostash;
-		if (opt_autostash != -1)
-			autostash = opt_autostash;
+		if (opt_autostash == -1)
+			opt_autostash = config_autostash;
  
  		if (is_null_oid(&orig_head) && !is_cache_unborn())
  			die(_("Updating an unborn branch with changes added to the index."));
  
-		if (!autostash)
+		if (!opt_autostash)
  			require_clean_work_tree(the_repository,
  				N_("pull with rebase"),
  				_("please commit or stash them."), 1, 0);
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 93ecfcdd24..3e784f18a6 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -330,6 +330,19 @@ test_expect_success '--rebase --autostash fast forward' '
  	test_cmp_rev HEAD to-rebase-ff
  '
  
+test_expect_success '--rebase with rebase.autostash succeeds on ff' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src "initial" file "content" &&
+	git clone src dst &&
+	test_commit -C src --printf "more_content" file "more content\ncontent\n" &&
+	echo "dirty" >>dst/file &&
+	test_config -C dst rebase.autostash true &&
+	git -C dst pull --rebase  >actual 2>&1 &&
+	grep -q "Fast-forward" actual &&
+	grep -q "Applied autostash." actual
+'
+
  test_expect_success '--rebase with conflicts shows advice' '
  	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
  	git checkout -b seq &&

base-commit: e9d7761bb94f20acc98824275e317fa82436c25d
prerequisite-patch-id: 3c6b4be75d7a634bf45f0264b3f04216818a0816
-- 
2.29.2
