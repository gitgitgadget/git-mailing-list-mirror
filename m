Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375DAC433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 22:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiFTWUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 18:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiFTWUL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 18:20:11 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABE6192A3
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 15:20:09 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id c1so17501190qvi.11
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=VbT9+iQvZ2R2/qPquP5PQ+P9ayKMQoRNHRWBgCIR8Kg=;
        b=CxFdTAm2mdsTSZIitJubq7XlAwFgDILhL1f37ahyAh2wVT/JqzU1/tQxHF2jhPimDg
         gBtG5p2l911OREWVifv1EsZ4aUilPE6Cpk6LYEL6ch78Qh29NzUxFOgMz3vCV0PtpNPD
         9Yufy+HafOkqNrzInuA79VIq3BRmpND1fRwtXVX6s7qvQYF4Y9tqVfk1pqU/qe6Myctl
         MEK7HXOQ5FD8zCsZY/wX5cbi3OqFRy4vOjXxVqbQNSQ9rkhF2LWXUOKQR4gTiPx0uES+
         jb60t94CV0FxpGnjjxl8Ce/+IT8lwzVJhLYG0ADVwoJF6k8GH3hgE2htGlvRxt3/BS8m
         zjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=VbT9+iQvZ2R2/qPquP5PQ+P9ayKMQoRNHRWBgCIR8Kg=;
        b=3JwCxHS7ywWBRyzmG5Av411zt1gzRydKcGFckCKl75dCcJHNt36u+0NI47aZjvqOjs
         c0uWSmRjAM1nSuXGAw99V5RHUF99dra9TDK0UrH+5z4WJIBT9+wv7ovCsFyT+XjlOcNa
         ZIUltNQeKvEOOLw6PkILynR/ykQzfGlIl6JuYyTN0zAkYrXi2Nm8uTfOaerBehOAszOY
         Rl2nkmoKh31/+iSlefNYQF7oA4G3d8b0y2UUHhkxHHUme8pMR8gYFmFUanJk+In4wR33
         1+7yBaQhjla2kheD6yRgaNWUrz5N2LoWFlAG1ZovhagmLyeClBif94UoyGq8DdUmBfNC
         P8bA==
X-Gm-Message-State: AJIora9v68zHgtrp7GPZ4zBfz3UpSDsxkGNVo/kLzezwyzFlqyAtyeJS
        VrjMiBSRQLrpGMghKof4oDZwu1F/hLHY
X-Google-Smtp-Source: AGRyM1svQmQWc9mWhNaQoIyCo0+TzqkDE7NpwEm8v+Wl5k2jjkJkz0zmV29Mb3og9xhO2jFXdgqlog==
X-Received: by 2002:a05:622a:1749:b0:304:f43c:d7c with SMTP id l9-20020a05622a174900b00304f43c0d7cmr21228735qtk.91.1655763608493;
        Mon, 20 Jun 2022 15:20:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:ed9a:c6cc:7079:2a02? ([2600:1700:e72:80a0:ed9a:c6cc:7079:2a02])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a76a939dbasm13684294qko.112.2022.06.20.15.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 15:20:08 -0700 (PDT)
Message-ID: <484a330e-0902-6e1b-8189-63c72dcea494@github.com>
Date:   Mon, 20 Jun 2022 18:20:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: [PATCH v2] t5510: replace 'origin' with URL more carefully (was Re:
 Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1)
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
 <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
 <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
 <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
In-Reply-To: <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/20/2022 4:00 PM, Derrick Stolee wrote:
> On 6/20/22 2:59 PM, rsbecker@nexbridge.com wrote:
>> On June 20, 2022 2:46 PM, Derrick Stolee wrote:
> 
>>> The issue is this line (some tabs removed):
>>>
>>>  new_cmdline=$(printf "%s" "$cmdline" | perl -pe
>>> 's[origin(?!/)]["'"$remote_url"'"]g')
>>>
>>> At this point, $remote_url contains the file path including the @ symbol. However,
>>> this perl invocation is dropping everything starting at the @ to the next slash.
>>>
>>> I'm not sure of a better way to accomplish what is trying to be done here (replace
>>> 'origin' with that specific url) without maybe causing other issues.
>>>
>>> This line was introduced by e1790f9245f (fetch tests: fetch <url> <spec> as well as
>>> fetch [<remote>], 2018-02-09).
>>
>> How about using sed instead of perl for this?
> 
> I wasn't sure if using sed would create a different kind of replacement
> problem, but using single-quotes seems to get around that kind of issue.
> 
> Please see the patch below. I'm currently running CI in a GGG PR [1]

Here is a v2 that updates the sed call based on the feedback so far.

I'm basically switching to sed because I don't know perl and the
discussion about how to fix this replacement command is completely over
my head. That makes me think that using a simpler find-and-replace tool
like sed would be good here.

Thanks,
-Stolee

--- >8 ---

From 7fae22e0ad09af00de5a294f61dfd29cb349feeb Mon Sep 17 00:00:00 2001
From: Derrick Stolee <derrickstolee@github.com>
Date: Mon, 20 Jun 2022 15:52:09 -0400
Subject: [PATCH v2] t5510: replace 'origin' with URL more carefully

The many test_configured_prune tests in t5510-fetch.sh test many
combinations of --prune, --prune-tags, and using 'origin' or an explicit
URL. Some machinery was introduced in e1790f9245f (fetch tests: fetch
<url> <spec> as well as fetch [<remote>], 2018-02-09) to replace
'origin' with this explicit URL. This URL is a "file:///" URL for the
root of the $TRASH_DIRECTORY.

However, if the current build tree has an '@' symbol, the replacement
using perl fails. It drops the '@' as well as anything else in that
directory name.

You can verify this locally by cloning git.git into a "victim@03"
directory and running the test script.

To resolve this issue, replace the perl invocation with two sed
commands. These two are used to ensure that we match exactly on the
whole word 'origin'. We can guarantee that the word boundaries are
spaces in our tests. The reason to use exact words is that sometimes a
refspec is supplied, such as "+refs/heads/*:refs/remotes/origin/*" which
would cause an incorrect replacement. The two commands are used because
there is not a clear POSIX way to match on word boundaries without
getting extremely pedantic about what possible characters we could have
at the boundaries.

Reported-by: Randall Becker <rsbecker@nexbridge.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t5510-fetch.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 4620f0ca7fa..c255a77e18a 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -853,7 +853,9 @@ test_configured_prune_type () {
 		then
 			new_cmdline=$cmdline_setup
 		else
-			new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
+			new_cmdline=$(printf "%s" "$cmdline" |
+					sed -e "s~origin ~'$remote_url' ~g" \
+					    -e "s~ origin~ '$remote_url'~g")
 		fi
 
 		if test "$fetch_prune_tags" = 'true' ||
-- 
2.36.1.220.g1fae7daf425


