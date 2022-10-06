Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9057C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 16:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiJFQmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 12:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiJFQmy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 12:42:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0242A5980
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 09:42:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bk15so3535850wrb.13
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/s+AF/WEraZaezoclwWq0sIFO3kp8QctUEqcS+uQCQM=;
        b=hyPFWAKlohtTGAJXENcWC9/C3836We0eKuxQjoQZjmLzDQfdmd2Af/v4IAMpNEkrsS
         UuP9Pb56C8vUuVsc8qE0QCtxR64iyiGpkV2FZ8ILPKDF4KN+Ub5y3fS/csDh0de23fQW
         FkZw6Qaoz6xTUEowMq0KyL0lxt4a3I0NJIfeWCxIhGhLEAqp0pq3ZhxZkmSLA9l0Yfyl
         /OZyxUPVPOtelu9ZfAy0WYkeUsFoacRr8ZgtASWk+3iJwF3fpVpw9EZ/gnneHJSKTLLK
         QMFfN3bP1zqp7UA7EmEppyZDZkGngX112ytcluQVQtVq/tWFdsMG5vYh1ZdxEL1cFEvz
         HtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/s+AF/WEraZaezoclwWq0sIFO3kp8QctUEqcS+uQCQM=;
        b=gH2gOl9GsUb09QhdvmiMxTpZJ9aXxmt4dcvDIXMlftGLzAuf5vFsc7mN/v0MDMs5CH
         t21c9hi/T3tl4xMO3OZMX/FEswXzFZIjm/NIlgq86Xf/JoRoaqxpZJLyqrNjgc/xKd1i
         FOx6ynMu9+VCouaX4B4f2G3XzOsgU5GGNXjhPiKCDInL882lWuFo0LPCGTmlzRc1ZNEu
         MibItU/jbbYeIPW77rsJk3GUYD/EmQRw82OFQjQjwDMcoXgQ1+j92YFD08zu1MfDBmAG
         WxBaeGd2Q0PudOsIEBVG2spCQzuOtdflY9+sRL28AoeROd6g+jpW+XM6bV/4tHM7YJ8V
         mwag==
X-Gm-Message-State: ACrzQf2+Og0AtZzoGn9X1M1vT9qN2jxbZiZZmm4oOny0+Y9u9/3ruqPo
        YEB0x/90c5/QM4AGMpTc0Ms=
X-Google-Smtp-Source: AMsMyM7MkVD5EJNQ7uEbn2fX1HjIQYDL9THAngkW8pF2fXFeGFXJzK3FOXGCxoyuv0mdlWUOTLJ3/Q==
X-Received: by 2002:adf:d214:0:b0:22e:6c5d:d468 with SMTP id j20-20020adfd214000000b0022e6c5dd468mr583883wrh.75.1665074572224;
        Thu, 06 Oct 2022 09:42:52 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id g23-20020a05600c4c9700b003b4fac020c8sm5083530wmp.16.2022.10.06.09.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 09:42:51 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <c3f4a79c-2dc6-fbf4-fc61-591ebf417682@dunelm.org.uk>
Date:   Thu, 6 Oct 2022 17:42:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] [RFC] test_todo: allow [!] grep as the command
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
 <645fa2990f79bdb7ee00ff3fd34122676469a783.1665068476.git.gitgitgadget@gmail.com>
 <221006.864jwhrldr.gmgdl@evledraar.gmail.com>
In-Reply-To: <221006.864jwhrldr.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/10/2022 16:56, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Oct 06 2022, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Many failing tests use grep, this commit converts a sample to use
>> test_todo(). As POSIX specifies that a return code greater than one
>> indicates an error rather than a failing match we take care not the
>> hide that.
> 
> Ah, so on the one hand this gives me second thoughts about my stance
> in[1], i.e. if we just allowed any command we wouldn't be forced to add
> these sorts of special-cases.
> 
> Although, we could also allow any command, and just add smartness for
> ones we know about, e.g. "grep".
> 
> But I do find doing this to be weirdly inconsistent, i.e. caring about
> the difference between these two:
> 
> 	$ grep blah README.md; echo $?
> 	1
> 	$ grep blah README.mdx; echo $?
> 	grep: README.mdx: No such file or directory
> 	2

The intent was to catch bad options, not missing files (i.e. we don't 
want test_todo to hide a failure from "grep --invalid-option"). We could 
check the file exists and skip running grep if it does not (hopefully 
the test wont be grepping multiple files in a single command)

> Is basically why I took the approach I did in my [2], i.e. to force us
> to positively assert *what* the bad behavior should be.

That is what made the end result so hard to use though

	test_todo \
		--want "test_must_fail git" \
		--reset "git reset --hard" \
		--expect git \
		-- \
		rm d/f &&

is not exactly readable.

Best Wishes

Phillip

> Which is why I ended up doing my verison of this sort of thing as [3],
> i.e. you'd need to assert what specific exit code you expected, or
> equivalent.
> 
> But at this point in the series:
> 	
> 	diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
> 	index fa7831c0674..086eaf91351 100755
> 	--- a/t/t3600-rm.sh
> 	+++ b/t/t3600-rm.sh
> 	@@ -801,7 +801,7 @@ test_expect_success SYMLINKS 'rm across a symlinked leading path (w/ index)' '
> 	 	test_todo test_must_fail git rm d/f &&
> 	 	test_todo git rev-parse --verify :d/f &&
> 	 	test -h d &&
> 	-	test_todo test_path_is_file e/f
> 	+	test_todo test_path_is_file blah
> 	 '
> 	
> 	 test_expect_success 'setup for testing rm messages' '
> 
> So, for our own test_path_* helpers we're not going to care at all, and
> any failure will do (including a missing file), but we will care for
> grep?
> 
> I'm obviously more on the "let's care" side, I just find it odd that
> you've picked this halfway point here, but not for other things you're
> wrapping.
> 
> 1. https://lore.kernel.org/git/221006.868rltrltu.gmgdl@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com/
> 3. https://lore.kernel.org/git/patch-5.7-553670da8a9-20220318T002951Z-avarab@gmail.com/
