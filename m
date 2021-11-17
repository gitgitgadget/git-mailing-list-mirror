Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF8AC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 15:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F99D6187F
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 15:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbhKQPVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbhKQPUz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 10:20:55 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60275C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 07:17:56 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id p4so2864204qkm.7
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:from
         :subject:to:content-transfer-encoding;
        bh=xR9/JVI7b0SSrqePrV6g3ymGRdohKFlLl46hM4uDEK4=;
        b=ArBtr97jAaCihC5f4+1ACx6R4eV+laUJmPcggcOafrMp1lf2Qoa4XOwbXkaboaSBer
         B22Kd0JvbCs2sgAgjQ88a7iUc0Feyx+7QWOBIL/OnYoChv8gSD4RAsu88rc8Pbr7DxQK
         csCO10zjOtuFfHeC9xrfHSri3BsHv8H0f+n+FIruf5BH79ScYb9/czMdZLugofLh+19d
         PKBSWCFEJdtVK3+bt8gdeiMy0G8sCkIK8+MwLTsZ8yPmL+OP5r3f60ZvsnHXYXaX1iLD
         klTj0yNxcOBpfFY/hFSw8bFYc2I96m2NS8tLoSz8EVKTaiZ6FO5NFUjV+5pM5YyRuNMo
         o9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:subject:to:content-transfer-encoding;
        bh=xR9/JVI7b0SSrqePrV6g3ymGRdohKFlLl46hM4uDEK4=;
        b=lz+K7KVKX9zPOve7ikqN1x/LDewu1RwlTza3ntLTzQj7Qwug8/PhFKwBu2xiD9KoiW
         syqYkQoPUYZrju+NGmMSRUvYXKcteKbLfAZQSZy6hfh+VejUiVjLxgsPV5qIYTMHd2Uv
         mwS/f6qChCdv9fixtA+O2vfO0ri5W9cLEwir3Ec4OB0axURRGJLNg4b0BIK9yZKVaASu
         cpMjMAq053LsMNuNZY9KU+rzD+HrCXmo+aheFpHIQ5tTv5qqoKOLTafxZRfEnixH8oM2
         fZOldH8mgUsu2CPYxbIJWyXaQuWR4LSB44bi/9sScwI4cpB/0RipgSY8A3WTYAEVJIyk
         gvag==
X-Gm-Message-State: AOAM533d5RSt4Tu1LF7cjaOsg8XSDQ+2pXxOm3WHVwbTueca4SuHyF3/
        HojA8YA6BEBnVwH5KNrw8SMyjjvfaug=
X-Google-Smtp-Source: ABdhPJyDi1nHu2rGbU1d+Uc/Jc38kJNaRbwQsZWcWUB8K4vaf7KV8mXB64ZMnBl7NlkT6/At7aPJIA==
X-Received: by 2002:a37:ae83:: with SMTP id x125mr13738911qke.37.1637162275037;
        Wed, 17 Nov 2021 07:17:55 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d1ee:6c8f:319:f5? ([2600:1700:e72:80a0:d1ee:6c8f:319:f5])
        by smtp.gmail.com with ESMTPSA id t35sm89759qtc.83.2021.11.17.07.17.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 07:17:54 -0800 (PST)
Message-ID: <9393e572-0666-6485-df29-abad5e0d32a1@gmail.com>
Date:   Wed, 17 Nov 2021 10:17:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
From:   Derrick Stolee <stolee@gmail.com>
Subject: [Question] Unicode weirdness breaking tests on ZFS?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently had to pave my Linux machine, so I updated it to Ubuntu
21.10 and had the choice to start using the ZFS filesystem. I thought,
"Why not?" but now I maybe see why.

Running the Git test suite at the v2.34.0 tag on my machine results in
these failures:

t0050-filesystem.sh                   (Wstat: 0 Tests: 11 Failed: 0)
  TODO passed:   9-10
t0021-conversion.sh                   (Wstat: 256 Tests: 41 Failed: 1)
  Failed test:  31
  Non-zero exit status: 1
t3910-mac-os-precompose.sh            (Wstat: 256 Tests: 25 Failed: 10)
  Failed tests:  1, 4, 6, 8, 11-16
  TODO passed:   23
  Non-zero exit status: 1

These are all related to the UTF8_NFD_TO_NFC prereq.

Zooming in on t0050, these tests are marked as "test_expect_failure" due
to an assignment of $test_unicode using the UTF8_NFD_TO_NFC prereq:


$test_unicode 'rename (silent unicode normalization)' '
	git mv "$aumlcdiar" "$auml" &&
	git commit -m rename
'

$test_unicode 'merge (silent unicode normalization)' '
	git reset --hard initial &&
	git merge topic
'


The prereq creates two files using unicode characters that could
collapse to equivalent meanings:


test_lazy_prereq UTF8_NFD_TO_NFC '
	# check whether FS converts nfd unicode to nfc
	auml=$(printf "\303\244")
	aumlcdiar=$(printf "\141\314\210")
	>"$auml" &&
	test -f "$aumlcdiar"
'


What I see in that first test, the 'git mv' does change the
index, but the filesystem thinks the files are the same. This
may mean that our 'git add "$aumlcdiar"' from an earlier test
is providing a non-equivalence in the index, and the 'git mv'
changes the index without causing any issues in the filesystem.

It reminds me as if we used 'git mv README readme' on a case-
insensitive filesystem. Is this not a similar situation?

What I'm trying to gather is that maybe this test is flawed?
Or maybe something broke (or never worked?) in how we use
'git add' to not get the canonical unicode from the filesystem?

The other tests all have similar interactions with 'git add'.
I'm hoping that these are just test bugs, and not actually a
functionality issue in Git. Yes, it is confusing that we can
change the unicode of a file in the index without the filesystem
understanding the difference, but that is very similar to how
case-insensitive filesystems work and I don't know what else we
would do here.

These filesystem/unicode things are out of my expertise, so
hopefully someone else has a clearer idea of what is going on.
I'm happy to be a test bed, or even attempt producing patches
to fix the issue once we have that clarity.

Thanks,
-Stolee
