Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13843C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 21:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDMV4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 17:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDMV4j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 17:56:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5978561B3
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 14:56:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so15650452pji.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681422998; x=1684014998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kr+/uywrzmJt7aGlmxL23Rfi8DQbsD9K/ca34OIrMkY=;
        b=OpM1j+a+ahuMTo2beCfABja5aAcnm3JAS+Jv5kXdUnXVeARqO8TROLxWDjAaNWtvtA
         jg+Bp5rRMBPIGdeyAVkm6VxGur1A2DD64yoDKRrxrS8cVZ4A639HUN+g+fRZ/uKBEa48
         udezKi9Uyp8r/1aqXGVd+PWkkB+aZbj/JvnaTKpOBuPZjumR8rPuWEJel+O7gs94hB7f
         qrY8rWZYe3YtZUDHGlvYn5wHPgdmJWiAnGjX8fTKdifLhTBLoqAjhEyIlab0aROPypTi
         TZlD8yxCgKoOOAK+bptY5Jm5tmsm7tXwBx4MwjADV8ampakXpipszcEBqfjsPtPcEXCW
         ar5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681422998; x=1684014998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kr+/uywrzmJt7aGlmxL23Rfi8DQbsD9K/ca34OIrMkY=;
        b=MtcCUN3xoPrMOCNkbILJIii/5dsty3k2Zqqo+1WCNzf7wHV8dzE81BKah7KBMMgiXR
         WzbjmtoPzaz2FdOKzzvDhnXdnetF6R7x6VKC5bFT37mjQn+8E53PMdShMu0H2ryHgGKq
         E15Z4FdiWftD0i+RsrAKqhWzvX/cg1tYYkfy8yfIDzua5ySVbmr3/PMiSanvtdO+q8TA
         +wGAbQVucUZDODRdaOqcg2CEfz1jGa5ZROTirf14y1tzPUbHu6Fr90Yc+fETZT/I03DT
         ZOzu4Tk1REpcPyHKzEADULl7AnpdxsQY5MdkICWNjZ5FOKV5Ik1nT68t7BL+5o9fnzmw
         gKUw==
X-Gm-Message-State: AAQBX9eEWWa5wRGXEf0q1vSq6HCrCzWbeA2CwDX5zELj+8PepXTZ9G4q
        J69AP5/zYZQc8ce0TkbIRrwv
X-Google-Smtp-Source: AKy350bT8goc4PRlRXeJc/+/HQUaAWSeBv6o9yZouyVkCsA6yfsMKJK8pYEX57utQPPQBVKzmTYytw==
X-Received: by 2002:a17:902:d482:b0:1a6:4532:1149 with SMTP id c2-20020a170902d48200b001a645321149mr517308plg.44.1681422997876;
        Thu, 13 Apr 2023 14:56:37 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id i12-20020a63cd0c000000b00517be28bcf9sm1822823pgg.86.2023.04.13.14.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 14:56:37 -0700 (PDT)
Message-ID: <4ffff8e9-3e03-9c5f-4a42-b9102ed24e66@github.com>
Date:   Thu, 13 Apr 2023 14:56:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v7 1/2] t1092: add tests for `git diff-files`
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230320205241.105476-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-1-cheskaqiqi@gmail.com>
 <20230322161820.3609-2-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230322161820.3609-2-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> +test_expect_success 'diff-files with pathspec inside sparse definition' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	run_on_all ../edit-contents deep/a &&
> +
> +	test_all_match git diff-files &&
> +
> +	test_all_match git diff-files deep/a && 
> +
> +	# test wildcard
> +	test_all_match git diff-files deep/*

Should this pathspec be quoted (like you do for "folder*/a" below)?

> +'
> +
> +test_expect_success 'diff-files with pathspec outside sparse definition' '
> +	init_repos &&
> +
> +	test_sparse_match test_must_fail git diff-files folder2/a &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	# Add file to the index but outside of cone for sparse-checkout cases.
> +	# Add file to the index without sparse-checkout cases to ensure all have 
> +	# same output.
> +	run_on_all mkdir -p folder1 &&
> +	run_on_all cp a folder1/a &&
> +
> +	# file present on-disk without modifications
> +	# use `--stat` to ignore file creation time differences in
> +	# unrefreshed index
> +	test_all_match git diff-files --stat &&
> +	test_all_match git diff-files --stat folder1/a &&
> +	test_all_match git diff-files --stat "folder*/a" &&
> +
> +	# file present on-disk with modifications
> +	run_on_all ../edit-contents folder1/a &&
> +	test_all_match git diff-files &&
> +	test_all_match git diff-files folder1/a &&
> +	test_all_match git diff-files "folder*/a" 
> +'
> +
>  test_done

