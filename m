Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A06C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 14:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E83BA6117A
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 14:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhKKObh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 09:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbhKKObg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 09:31:36 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AA7C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 06:28:47 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id p19so5384556qtw.12
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 06:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7rPjQSru2egYvhBa/g/eBNTWtDUOTXrR3rFI4hPEXaE=;
        b=QKO2XCNidV5M3UDX5r8sopNmlECO8sOCJZtP0153ZbY289+4vSQrGspBxvtATlJCyF
         7FlevYUvQWuYAMmC3FuwsigLwXQLCEvjARvVC/BnJZN2TMW3boJHZW+1jI5b9s7hU+Pl
         Y6k2+RO9m9PCwV7xwnvUhTxONF8o/H1Z9xqivK8EJDQ4Y4L1NxU+AWOKR5M/a9bGEzvO
         u96P+adPmSnWrM02MOLbBiCwo3BSPbhscc4qyDUGxgYMQo84MxkrHlUr2l/PJC3sldtZ
         DFTi5B6QAqKE9keRx365VKm3ymiDQzhTmmND4XukBBej3ZHPPSvswVU4vHwg7cRJ9MXL
         1eWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7rPjQSru2egYvhBa/g/eBNTWtDUOTXrR3rFI4hPEXaE=;
        b=YITq9QCBSeCE0UJR+z7c2lubai7mls3vlxiB2OJj7Meb4O5AyrntVuI1x3A6Vgmn33
         ctulXNxkhNz841/fv5U5DqrmnVU6xrGPqRsKUFnOpYl6H8co8SQ/JR4N6HsN/Hq45JDc
         9AVqhJ1R0yL8aNYzQyiyoc7uVGpxvnfF2GqviDQ+vQpW8OXHZ/zrG49qjBK1ApBMJ60T
         PHSpYiMMROtpwmb9DbYQCUzgxY4XEsxpTx9fJ2Iixlhh63ItYqZdcC2u6ZLonoupz6We
         +ClcK/MxRU2OoSfmcHCx4VJFX3MJkdZpH4obLmaA9nQ83QLKPhqf5TVOTHP2vTaF/myQ
         nc7Q==
X-Gm-Message-State: AOAM533klVjnU2cc1WClr/xIqR5+BQd3sVzrhpqrQaf/XC+mZH1mPZCI
        M72dMaGkG0DtQIghTIaFkpqNCKByAHQ=
X-Google-Smtp-Source: ABdhPJxP8P4CtDfSubsit6sc4BGnnW9zhUygGXuV95haqXXdgAdbFb6WZlgOSIF2B1lHsZ69oBuS/Q==
X-Received: by 2002:ac8:5cc5:: with SMTP id s5mr7991554qta.256.1636640925970;
        Thu, 11 Nov 2021 06:28:45 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id e15sm1529710qtp.94.2021.11.11.06.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 06:28:45 -0800 (PST)
Subject: Re: Possible merge bug
To:     Saksham Mittal <saksham.mittal000@gmail.com>,
        schiff.michael@gmail.com
Cc:     git@vger.kernel.org
References: <CAJcz5TVsv20+FmHR67_UhL_7rhEGvfPHeP3RMiRtnSGAEKiwBg@mail.gmail.com>
 <5aa1fb67-6bd8-6de3-8271-369722b6ebef@gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <da873a08-c73a-cc30-6b7d-dd5cd3bacb22@gmail.com>
Date:   Thu, 11 Nov 2021 09:28:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5aa1fb67-6bd8-6de3-8271-369722b6ebef@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

Le 2021-11-11 à 06:20, Saksham Mittal a écrit :
> Hello there,
> 
> I wrote a small script as well that automates testing this use case as well, but I don't really know what the policy is on attachments in git, seeing as how it's my first time contributing to git.

I used the script from Saksham (slightly modified to not depend on any Git configuration)
and could not reproduce either with Git built from the same commit as you.
Maybe some setting in your ~/.gitconfig is at play ?

For the record, my edited version of the reproducer:

--- 8< ---
#!/bin/sh

export PATH="/path/to/built/git/bin-wrappers:$PATH"
export GIT_AUTHOR_NAME=J
export GIT_AUTHOR_EMAIL=j@l.com
export GIT_COMMITTER_NAME=J
export GIT_COMMITTER_EMAIL=j@l.com
export HOME=

git --version --build-options

rm -rf sample
mkdir sample
cd sample
git init
echo -e "a\nb\nc\n" > test
git add .
git commit -m "abc"

git branch b1
git switch b1

echo -e "b\na\nc" > test
git add .
git commit -m "bac"

git switch master
git branch b2
git switch b2

echo -e "b\nc\na" > test
git add .
git commit -m "bca"

git switch master
echo "----- Merging b1 -----"
git merge b1
cat test
echo "----- Merging b2 -----"
git merge b2
echo "----- Content of test -----"
cat test
--- 8< ---


Running it ends with this output:


----- Merging b1 -----
Updating 5e00de3..02910cf
Fast-forward
  test | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)
b
a
c
----- Merging b2 -----
Auto-merging test
CONFLICT (content): Merge conflict in test
Automatic merge failed; fix conflicts and then commit the result.
----- Content of test -----
b
a
c
<<<<<<< HEAD
=======
a
>>>>>>> b2


Cheers,
Philippe.

