Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03944C76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 21:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbjDFVBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240336AbjDFVB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 17:01:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54A2B74C
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 14:01:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lj25so4356923ejb.11
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680814869; x=1683406869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ek91w4sPDEeNtNMjD5dLq1nded14X+LZHo+7VU/BVH0=;
        b=UI3xYPB2nJZCH4KGLzzOWaezOipg2/f03DXFLajrSUzRFEXqzoQ6MQ+V9GIZZ3pXpi
         4g2fBpepQ4lE3vYhUj/xtD9obEsLMbIwn37hxnVN/1CauUZ4N1zj+cehhxE6wGjl3pls
         Xixq2mxjP/AWlTfA88pRNdPSS6VlyNJM13uHkfGadiFRkkNWc8wgk5asjmH17rZOzLYD
         qY5XMCjhFOAJwRd5qTHozkJ/ZfspEtiAsUdHVjj8QhcDzYhUo/Wl9j2EmWaW23dVESsW
         eLpu+Z0sEE3eF+IXOLn/ya53hg4R92piBMzCRfaqMLy2x1mjNymhvKn+Ac5Ga3rnkWQj
         7ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680814869; x=1683406869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ek91w4sPDEeNtNMjD5dLq1nded14X+LZHo+7VU/BVH0=;
        b=EHiX/ZkiwJwPT+UMYMNSqHBcXvuQzYv6zxEvYJhVgXA8gHztcvcIHpjVOzsZkS6AM5
         LUkAT49o0A0INWcm1I83AQ40ytDjesLqa9ZlS79D06CEufDNPXo/zA4IwduVsTVWcTMT
         ZhmmFRsOuOp8qGSyr7sdk59yanJim+oYG8xhnVvH6uxsJ+c6j/vvYV3ZsbtQXWGlwi7F
         AdvQtwIJ+1qCPkiWajc2pep0rzJSnq722k1QLJgN5Wb8iIULUgiOoQuuOf1sVo0z03fI
         CKQ3y4+SCTmcR1c9K+p/ZSjvMB013kzf4VIPOtAeCYkPO2ssNu01FyLGgitH6iC1Xr5L
         NV+w==
X-Gm-Message-State: AAQBX9eLev2exGkjsRT8cG/EBz1PKmQK7OUAFJRM66UezBrCYnCstkp4
        MCbZLJU/OBg/KlwT4BOTX9Y=
X-Google-Smtp-Source: AKy350ZQns2N/STalLcQa9pZkp7ieq1yBoVGcXq2dYyJX7LESnUy8RblCFFSAKytLSBLSfn06hYj9w==
X-Received: by 2002:a17:906:585:b0:925:6bcb:4796 with SMTP id 5-20020a170906058500b009256bcb4796mr6526929ejn.38.1680814869137;
        Thu, 06 Apr 2023 14:01:09 -0700 (PDT)
Received: from [10.6.18.184] ([45.88.97.12])
        by smtp.gmail.com with ESMTPSA id f17-20020a170906561100b00927341bf69dsm1247168ejq.88.2023.04.06.14.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 14:01:08 -0700 (PDT)
Message-ID: <db2de983-9b1f-5efb-0fdc-cc704e6b875b@gmail.com>
Date:   Thu, 6 Apr 2023 23:01:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/6] t0300: don't create unused file
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?=c3=98ystein_Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230403223338.468025-2-rybak.a.v@gmail.com>
 <230406.86ttxttnir.gmgdl@evledraar.gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <230406.86ttxttnir.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/04/2023 10:34, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Apr 04 2023, Andrei Rybak wrote:
> 
>> Test 'credential config with partial URLs' in t0300-credentials.sh
>> contains three "git credential fill" invocations.  For two of the
>> invocations, the test asserts presence or absence of string "yep" in the
>> standard output.  For the third test it checks for an error message in
>> standard error.
>>
>> Don't redirect standard output of "git credential" to file "stdout" in
>> t0300-credentials.sh to avoid creating an unnecessary file when only
>> standard error is checked.
>>
>> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
>> ---
>>   t/t0300-credentials.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
>> index c66d91e82d..b8612ede95 100755
>> --- a/t/t0300-credentials.sh
>> +++ b/t/t0300-credentials.sh
>> @@ -808,7 +808,7 @@ test_expect_success 'credential config with partial URLs' '
>>   
>>   	git -c credential.$partial.helper=yep \
>>   		-c credential.with%0anewline.username=uh-oh \
>> -		credential fill <stdin >stdout 2>stderr &&
>> +		credential fill <stdin 2>stderr &&
>>   	test_i18ngrep "skipping credential lookup for key" stderr
>>   '
> 
> This goes for these changes in this series general: You're correct that
> this is useless now, but I don't think it follows that we should be
> removing the "redundant" code in all cases, rather than fixing the test
> to actually check these.

I'll reply to these on one-by-one.  See also this review of a patch in part 1
of this series from Junio C Hamano:

   https://lore.kernel.org/git/xmqqsfe8s56p.fsf@gitster.g/

> E.g. this will also make this test pass:
> 	
> 	diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> 	index c66d91e82d8..62c2a0fd50e 100755
> 	--- a/t/t0300-credentials.sh
> 	+++ b/t/t0300-credentials.sh
> 	@@ -806,9 +806,11 @@ test_expect_success 'credential config with partial URLs' '
> 	 		return 1
> 	 	done &&
> 	
> 	+	cp stdout stdout.last &&
> 	 	git -c credential.$partial.helper=yep \
> 	 		-c credential.with%0anewline.username=uh-oh \
> 	 		credential fill <stdin >stdout 2>stderr &&
> 	+	test_cmp stdout.last stdout &&
> 	 	test_i18ngrep "skipping credential lookup for key" stderr
> 	 '
> 	
> 
> Does that make sense? No idea, I don't know the credential system well.
> 
> But isn't it worth testing that when we ask for this that we're getting
> some known output along with the warning?

Current version from branch "master" with more context lines:

> test_expect_success 'credential config with partial URLs' '
> 	echo "echo password=yep" | write_script git-credential-yep &&
> 	test_write_lines url=https://user@example.com/repo.git >stdin &&

The test is checking that "url=https://user@example.com/repo.git" matches ...

> 	for partial in \
> 		example.com \
> 		user@example.com \
> 		https:// \
> 		https://example.com \
> 		https://example.com/ \
> 		https://user@example.com \
> 		https://user@example.com/ \
> 		https://example.com/repo.git \
> 		https://user@example.com/repo.git \
> 		/repo.git

... these partial URLs ...

> 	do
> 		git -c credential.$partial.helper=yep \
> 			credential fill <stdin >stdout &&
> 		grep yep stdout ||
> 		return 1
> 	done &&
> 
> 	for partial in \
> 		dont.use.this \
> 		http:// \
> 		/repo

... but doesn't match these.

> 	do
> 		git -c credential.$partial.helper=yep \
> 			credential fill <stdin >stdout &&
> 		! grep yep stdout ||

Here "! grep yep stdout" ensures that git-credential-yep isn't launched for the
three kinds of partial URLs.  Otherwise, the actual content of "stdout" is
ignored.  It comes from script "askpass" (see bottom of file "t/lib-credential.sh").

Absence or presence of "yep" is a proxy for whether or not partial URL got
matched or not, and that is what's important for this test.  Adding assertions
for output of "askpass" here would only obscure this fact, I think.

There are other tests in t030[0-3] that do check standard output for what
the helper script "askpass" prints out -- those tests validate that the
"git credentials" fallbacks to asking for credentials in the terminal in
various situations.  This is done via functions helper_test and
helper_test_timeout from "t/lib-credential.sh".

> 		return 1
> 	done &&
> 
> 	git -c credential.$partial.helper=yep \
> 		-c credential.with%0anewline.username=uh-oh \
> 		credential fill <stdin >stdout 2>stderr &&
> 	test_i18ngrep "skipping credential lookup for key" stderr

Here, the important part is that "git credential" reacts to invalid key being
used: "credential.with%0anewline.username=uh-oh", and similarly, I think that
adding assertions about "stdout" might not be a good idea.

>'

Perhaps Johannes Schindelin, author of commit 9a121b0d22 ("credential: handle
`credential.<partial-URL>.<key>` again", 2020-04-24), could chime in.
