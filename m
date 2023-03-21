Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D55C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 22:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCUWTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 18:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCUWTc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 18:19:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33201E5F7
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 15:19:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c18so17551474ple.11
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679437171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/102YtQveLI8Q+E1HidbIwc1Pt5Ms8uqBDLToLa6k8=;
        b=PmVfusLsA7rZUPSRz9yxVKtUSilTkNpJbbxN0Cuy5nfrpWM2gbw5U1tM5iaCHxZJpr
         FxJV2sEbJte6Vk7O5n0U07ZWgGYVOEEG9TQWV3RlszZHq+ruRz3MiTCTqsUe5Eygzuz6
         EJX4i/p6outaAladmluFOGD642H/lrH0p84CSrVp2tgSOwSRkPGEM2KQxHhCiyi2GkTP
         txnEHZSU9l+bKGaMQI9kvITSu9gGCoP8gW1Zy5P8ai5zwkrVAtUW9x2yJ3v8ICiz4+FZ
         0iYkNlojNcW7pKNBzb/MsG+bv4o+2vySsSPfIs2KDXtkYHHIV10VfmqDneWNBTX5w44n
         kyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679437171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/102YtQveLI8Q+E1HidbIwc1Pt5Ms8uqBDLToLa6k8=;
        b=UheLvfCVIpOdYE+ol6r8XXb+/7lgR25doktcPUJvjBhju61DfexAaqav2VcG1Scyi2
         hMa6MLooL9EwPZc+H5/1Ihv+x3JdPUsGpSUtqD8sQ2oIVPFO8Tu1LoD8yzBzIMP6zSOL
         yoOpTGyprMmwgyfUAgqsNHRPDGG+PqD5pG0E5CCBFcD68Pj/sJxDTuApgDL89eu4OFeb
         0kTlkUJfHIN9f8M/KaOXtfEp/Yic3iYdtqdqumCuZrnxf1UFJYjABmujPSUGILk7aVOo
         p5kemCjmJC7g1KAHaFs9h0AmIrRVO8dvWzCPCI+MI4FPx6Hg8BrkEKPLjw7yxNGONKUR
         /Vqw==
X-Gm-Message-State: AO0yUKWOV8u2uXCFBAfUrE01sKx4ji9YL1d1KZkUDON2r1lAeHORHrX2
        7NspLOVC7pyjhsHlzGMzs/ZGa+URGYKfFPw8KA==
X-Google-Smtp-Source: AK7set8iOEJQr/NsbQG3jTsGNRZxKNBaYbAWHeBQ2DD5Z7LWbBMzQEun77258dc0JLcXP4kyJZSmBQ==
X-Received: by 2002:a17:903:686:b0:19c:c87b:4740 with SMTP id ki6-20020a170903068600b0019cc87b4740mr511492plb.34.1679437171213;
        Tue, 21 Mar 2023 15:19:31 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id g11-20020a170902934b00b00199203a4fa3sm9168185plp.203.2023.03.21.15.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 15:19:30 -0700 (PDT)
Message-ID: <3e2371e9-2d7d-27c4-58dd-296fcee49e88@github.com>
Date:   Tue, 21 Mar 2023 15:19:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v6 1/2] t1092: add tests for `git diff-files`
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com
References: <20230310050021.123769-1-cheskaqiqi@gmail.com>
 <20230320205241.105476-1-cheskaqiqi@gmail.com>
 <20230320205241.105476-2-cheskaqiqi@gmail.com>
 <d940fe05-de86-5069-1d77-f4c7d0d368b6@github.com>
 <xmqq1qlhhk4s.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq1qlhhk4s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Victoria Dye <vdye@github.com> writes:
> 
>> The strange thing is, once I fixed the 'mkdir' issue in my local copy of
>> these patches, these 'test_all_match diff-files' calls succeeded. It turns
>> out that 'git diff-files' in the 'full-checkout', like in 'sparse-checkout',
>> reports a difference in 'folder1/a' that doesn't actually exist. So the bug
>> isn't in sparse-checkout as I initially assumed [1], but rather in
>> diff-files itself.
> 
> Is that a bug, or just a common "ah, you forgot to refresh the index"?

Ah, you're right - I completely forgot about 'diff-files' not refreshing the
index (since 'diff', by default, does). The ctime is (often, but not always)
different on the copied file than what's in the index, so 'diff-files' shows
the file as "modified" if the index isn't refreshed. 

Going back to these tests, the goal is to make sure that 'diff-files' finds
the correct index entry (possibly in a sparse directory) and compares that
correctly to what's on disk. But since we want to ignore ctime differences,
we could use '--stat' (or '-p', or '--num-stat':

	run_on_all mkdir -p folder1 &&
	run_on_all cp a folder1/a &&

	# file present on-disk without modifications
	# use `--stat` to ignore file creation time differences in
	# unrefreshed index
	test_all_match git diff-files --stat &&
	test_all_match git diff-files --stat folder1/a &&

I don't think that makes the test any less comprehensive (especially since
later on in the same test, we modify the contents of 'folder1/a' and get the
expected "modified" status in 'git diff-files' without '--stat'), but it
avoids potential breakages related to inconsistency in file creation time.

