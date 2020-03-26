Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65BDC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929F420714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 15:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e86zePJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgCZPfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:35:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35083 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgCZPfc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 11:35:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id a20so7356240edj.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W04oTd51q6MJkeHeQFvCsMYz8qVC8QbnTGr2YUSTVvo=;
        b=e86zePJyVHZq1f92xirgSInk9+rc0OxIWbg9eQgoejzPNVos4GmRLyfduuYcuDU6ps
         dcCYaS4Wb5jDA/TmYCZAlGIvNlBj2s0ynmSAGVS54F4Zucg8fSv7Jr49LFdu/9tR1q19
         gcYyg3hN0okcQMK4+THwJtPvy2xBc5LHLkVhkomdm7gWnNI2EjZF5hNFD/pZhEEsLPcT
         g1CFbDQe/6szdVT31AraKgePE8nEtuYqKnyHRx9gnGEJz0m8Xk/8UPFgmjIfZBTmXsyA
         rr7lYkb2CCqqY5MxtVuXco2HMMj7GQ47F/Qx7fhvLt9pkaNIPpIWDT4q2e+hWQ1AS8zq
         qY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W04oTd51q6MJkeHeQFvCsMYz8qVC8QbnTGr2YUSTVvo=;
        b=f4a5MobJ6R0+z5l5ZbN/ruGj0sfpzvB9YtCrueS9mCOm3P+1LBYkvqxChhN3MdPCgw
         XTYQygtYiNECgCs4klX2ne1SSAxCLfCu3LydzUum9nPJFKvmSORwczTc06PsP0uPo6qr
         PYbTMmdnUSZNiTk9DA10um8uB1oX4M2tO/hBetkvSSiPBbf+kCB/KCf0kJExn9Nmvlr0
         GPEK/5SaK2p96IsUOTKEdMkG+hQaBOBVH7sxgpd7KX5vQbSOeUQ4AcMy2KRImut9edg8
         kmt42nflQa57LhXD0VItZt+k082s2fO9/vvtmQHktROzmRR3NGiHBTesscECfY2OUZHT
         Yg3A==
X-Gm-Message-State: ANhLgQ1QEiBNC9JQtViiuqtfq8yh/36mP/e0iqQEymyEMTP7JyKrJkSg
        IKJOmKnNz4Li7puX+0/3GpGHz7Xl
X-Google-Smtp-Source: ADFU+vusUpRTaxQNvnWuXp4ClONcrgs+eGGP3SGu8b84+Ou0B6NdYTxQBW6sc80wMTkfgM/AX3HcIg==
X-Received: by 2002:a50:8b41:: with SMTP id l59mr8573339edl.44.1585236930086;
        Thu, 26 Mar 2020 08:35:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13sm377947edj.8.2020.03.26.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 08:35:29 -0700 (PDT)
Message-Id: <pull.728.v3.git.git.1585236929.gitgitgadget@gmail.com>
In-Reply-To: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
References: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Mar 2020 15:35:23 +0000
Subject: [PATCH v3 0/5] Enable GPG in the Windows part of the CI/PR builds
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While debugging the breakages introduced by hi/gpg-prefer-check-signature, I
noticed that the GPG prereq was not available on Windows, even if Git for
Windows' SDK comes with a fully functional GPG2.

The fix was easy, but finding out what was going on was not, so for good
measure, the fix is accompanied by a patch that will hopefully make future
investigations into GPG-related problems much, much easier.

Changes since v2:

 * Reordered 4/5 before 3/5, as I had intended originally.
   
   
 * Renamed _trace_level to have a trailing underscore, in line with the
   surrounding code.
   
   
 * Added a note to the commit message why only lib-gpg.sh loses its
   hash-bang line, and no other files in t/.
   
   

Changes since v1:

 * The prereqs are now lazy ones.
   
   
 * A new patch was introduced to make tracing via -x work even with those
   inter-dependent prereqs.
   
   
 * The test-signing's stdout is redirected to /dev/null because it is
   unreadable and unhelpful binary gibberish, anyway. (This imitates Peff's
   patch.)

Johannes Schindelin (5):
  tests(gpg): allow the gpg-agent to start on Windows
  t/lib-gpg.sh: stop pretending to be a stand-alone script
  tests: do not let lazy prereqs inside `test_expect_*` turn off tracing
  tests: turn GPG, GPGSM and RFC1991 into lazy prereqs
  tests: increase the verbosity of the GPG-related prereqs

 t/lib-gpg.sh     | 110 ++++++++++++++++++++++++++---------------------
 t/t0000-basic.sh |  13 ++++++
 t/test-lib.sh    |   6 ++-
 3 files changed, 77 insertions(+), 52 deletions(-)


base-commit: 30e9940356dc67959877f4b2417da33ebdefbb79
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-728%2Fdscho%2Fci-windows-gpg-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-728/dscho/ci-windows-gpg-v3
Pull-Request: https://github.com/git/git/pull/728

Range-diff vs v2:

 1:  287a21f1033 = 1:  287a21f1033 tests(gpg): allow the gpg-agent to start on Windows
 2:  c1811d54190 ! 2:  b4217c36070 t/lib-gpg.sh: stop pretending to be a stand-alone script
     @@ -5,6 +5,10 @@
          It makes no sense to call `./lib-gpg.sh`. Therefore the hash-bang line
          is unnecessary.
      
     +    There are other similar instances in `t/`, but they are too far from the
     +    context of the enclosing patch series, so they will be addressed
     +    separately.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
 4:  0767c8b77c8 ! 3:  f35830c0eba tests: do not let lazy prereqs inside `test_expect_*` turn off tracing
     @@ -60,7 +60,7 @@
       	fi
       }
       
     -+_trace_level=0
     ++trace_level_=0
       want_trace () {
       	test "$trace" = t && {
       		test "$verbose" = t || test "$verbose_log" = t
     @@ -69,7 +69,7 @@
       	# Do not add anything extra (including LF) after '$*'
       	eval "
      -		want_trace && set -x
     -+		want_trace && _trace_level=$(($_trace_level+1)) && set -x
     ++		want_trace && trace_level_=$(($trace_level_+1)) && set -x
       		$*"
       }
       
     @@ -78,8 +78,8 @@
       		if want_trace
       		then
      -			set +x
     -+			test 1 = $_trace_level && set +x
     -+			_trace_level=$(($_trace_level-1))
     ++			test 1 = $trace_level_ && set +x
     ++			trace_level_=$(($trace_level_-1))
       		fi
       	} 2>/dev/null 4>&2
       
 3:  85457a7b618 = 4:  f69f97e24ba tests: turn GPG, GPGSM and RFC1991 into lazy prereqs
 5:  5e89b512513 = 5:  064f4e541b8 tests: increase the verbosity of the GPG-related prereqs

-- 
gitgitgadget
