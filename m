Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4998C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 16:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJFQKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 12:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJFQKK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 12:10:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1722205E7
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 09:10:08 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w18so3438039wro.7
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ltVYeFv2E0JQHrqashkmibYEQNYzx4hGr8JBivPCX9U=;
        b=GPIZY4VHGIHsoEMbSIBPjoo+rcLrRKEWGNyd25JYf2kPyMEFsRCg2T7wjwy7kgrEQW
         TZ/zhVG4pr1b9vWZ8Qhh5p8N6jN/UxY9tY3kqgD9eN7SrFrEtVw5qEaB5drUoReJSSLj
         piFuVejv/e3h3+oOWOat5EpPDzvLGsqIQgH++q5AMlfdfnEEGl03zsD45tEY2SNSWkCA
         iuCGlqTiMirWIvuYnrVj1u2g6GY7nqD45FE9ggsFEy6vchQk6Hc7zsoQvc6hSVHCQ+VG
         UNcRPFRxZZjhdkiONC3ZBCUrszRxLFl8A8FdQyxj3pC1GLg12s7ToG5VSb1KimxQKJFu
         SErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltVYeFv2E0JQHrqashkmibYEQNYzx4hGr8JBivPCX9U=;
        b=jUCsGRKqigyvZEtX19wp7D6dLfS7ln1oox1iN1rpcqWp0ArXCVdeHJ6+EGkGwnV6bB
         L1Zqdt7Q0bhAESRCTJoEUnst+aNPxtS8H/CKI4lG3akF5jjyu2ErRXzrUVr7IIBN5W2F
         VhhH79El9OyrhwFIyruyocgRX1eef89EHgQB/fUXtYUpcAs3tUWmlD8H8MTs6R5uzgSY
         rS7aJH/U/bcbfmKJX5veKyAMwkeCdUufBZXU8V0LR5FoeR3UhaHgmviG9KMiawszrCeX
         R4uBWEbk7rzsl3l9Dg8EviWRFTzrz9ToaaEdEtpYyIPcajC356dYOxCGZcdR0f8qsB5O
         AZvQ==
X-Gm-Message-State: ACrzQf0/bB5h5trg0eO6oo+zcICGsM1cxGdbhXPMCko6qZz+lv4yLDHJ
        ZOXJWxBMOBd7jT4Ru/+QdsLA15HLCPY=
X-Google-Smtp-Source: AMsMyM4gL5pE2zm3ztUH2JGkP6YRp0gCETNmaPiJob83rvEiUoYiG+rVpT4dsjqY16x2AYH0ZLVhXQ==
X-Received: by 2002:adf:f90e:0:b0:22e:3dd5:f724 with SMTP id b14-20020adff90e000000b0022e3dd5f724mr459383wrr.83.1665072606890;
        Thu, 06 Oct 2022 09:10:06 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b003b4c40378casm6023102wmb.39.2022.10.06.09.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 09:10:06 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <7306b890-641f-2c45-f610-2aa0361d6066@dunelm.org.uk>
Date:   Thu, 6 Oct 2022 17:10:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/3] [RFC] tests: add test_todo() to mark known breakages
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <pull.1374.git.1665068476.gitgitgadget@gmail.com>
 <472d05111a38276192e30f454f42aa39df51d604.1665068476.git.gitgitgadget@gmail.com>
 <221006.868rltrltu.gmgdl@evledraar.gmail.com>
In-Reply-To: <221006.868rltrltu.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 06/10/2022 16:36, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Oct 06 2022, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
 >>
>> test_todo() is built upon test_expect_failure() but accepts commands
>> starting with test_* in addition to git. As our test_* assertions use
>> BUG() to signal usage errors any such error will not be hidden by
>> test_todo().
> 
> I think they will, unless I'm missing something. E.g. try out:

It's talking about BUG() in test-lib.sh, not the C function. For example

test_path_is_file () {
	test "$#" -ne 1 && BUG "1 param"
	if ! test -f "$1"
	then
		echo "File $1 doesn't exist"
		false
	fi
}

So a test containing "test_todo test_path_is_file a b" should fail as 
BUG calls exit rather than returning non-zero (I should probably test 
that in 0000-basic.sh)

> 	diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
> 	index 80e76a4695e..1be895abba6 100755
> 	--- a/t/t0210-trace2-normal.sh
> 	+++ b/t/t0210-trace2-normal.sh
> 	@@ -170,7 +170,7 @@ test_expect_success 'BUG messages are written to trace2' '
> 	
> 	 test_expect_success 'bug messages with BUG_if_bug() are written to trace2' '
> 	 	test_when_finished "rm trace.normal actual expect" &&
> 	-	test_expect_code 99 env GIT_TRACE2="$(pwd)/trace.normal" \
> 	+	test_todo env GIT_TRACE2="$(pwd)/trace.normal" \
> 	 		test-tool trace2 008bug 2>err &&
> 	 	cat >expect <<-\EOF &&
> 	 	a bug message
> 
> I.e. in our tests you need to look out for exit code 99, not the usual
> abort().
> 
> I have local patches to fix this, previously submitted as an RFC here:
> https://lore.kernel.org/git/RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com/
> 
> I just rebased that & CI is currently running, I'll see how it does:
> https://github.com/avar/git/tree/avar/usage-do-not-abort-on-BUG-to-get-trace2-event-2
> 
> When I merged your patches here with that topic yours started doing the
> right thing in this case, i.e. a "test_todo" that would get a BUG()"
> would be reported as a failure.
> 
>> +	test_true () {
>> +		true
>> +	}
>> +	test_expect_success "pretend we have fixed a test_todo breakage" \
>> +		"test_todo test_true"
> 
> "Why the indirection", until I realized that it's because you're working
> around the whitelist of commands that we have, i.e. we allow 'git' and
> 'test-tool', but not 'grep' or whatever.
> 
> I'm of the opinion that we should just drop that limitation altogether,
> which is shown to be pretty silly in this case. I.e. at some point we
> listed "test_*" as "this invokes a git binary", but a lot of our test_*
> commands don't, including this one.

test_expect_failure does not allow test_* are you thinking of test-tool?

> So in general I think we should just allow any command in
> "test_must_fail" et al, and just catch in code review if someone uses
> "test_must_fail grep" as opposed to "! grep".

That is not going to scale well

> But for the particular case of "test_todo" doing so seems like pointless
> work, if we think we're going to miss this sort of thing in review in
> general, then surely that's not a concern if we're going to very
> prominently mark tests as TODO tests, given how the test of the output
> shows them?

 >[...]
>>   test_might_fail () {
>> -	test_must_fail ok=success "$@" 2>&7
>> +	test_must_fail_helper might_fail ok=success "$@" 2>&7
>>   } 7>&2 2>&4
>>   
>>   # Similar to test_must_fail and test_might_fail, but check that a
> 
> I remember finding it annoying that "test_might_fail" is misreported
> from test_must_fail_acceptable as being called "test_must_fail", so this
> refactoring is very welcome.
> 
> But can you please split this into its own commit? I.e. that improvement
> can stand on its own, i.e. just a change that has "test_must_fail" and
> "test_might_fail" reporting their correct name.
 >
> Then this commit can follow, and then you'll just need to add (for this part) >
> 	test_must_fail_helper todo "$@" 2>&7
> 
> And it'll make the resulting diff much smaller & easier to follow.

Sure, I should also improve the error message in

 >> +		echo >&7 "test_$test_must_fail_name_: only 'git' is allowed: $*"

for test_todo.

Best Wishes

Phillip
