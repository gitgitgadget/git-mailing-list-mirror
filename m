Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0284F29429
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 02:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728442690; cv=none; b=V4j9EAkEUXo0iXhpFIGMAWduXKj9BK180+zLIKHThx8+kbWsNzfxkWmovNvuaVS/rrdpqvxjyK0PCYzAtAK+j0CHYAPatV+GTHrNBZ8TsXi/H1+CEnBTsaUpe5Mk5vrSYu/qUzqy4/1Xr3DJZV1dsRIHP+xyRUY7LefkdoAQ4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728442690; c=relaxed/simple;
	bh=tSP2R+ITrm8VBpdrJqfePyFmkRSi+P8+DgSbSXOuRC8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=chPcKjdrC1R7SqgJKnD369xs7StXfAUoNAu+KpctAnNeWHwC/fAATQx+YRkK79dHoGMHrBJ3g2GUyC0tHM3GHpJp0/yYXarBURxKu13DFLdpGsMeYt1yiGv8XdVABvgdtLqwaOIJfwXsOQmRhJ9uT0Qc7XgIiJySGGe/xhPG/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEsEJFmn; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEsEJFmn"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e31413a196so12090397b3.3
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 19:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728442688; x=1729047488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wbvgu9eS03hhlZbY0G5+mfQ7XUWGfeiy+WbcotHjuks=;
        b=hEsEJFmnqTc89kOuoHxUlTkPdlQ1nM6metdyYi3ut8Z60RpMgzngKL8LQGN/cClKY6
         qr7nYPavw1Z+hnbzBjsLD8qWjp2n/upJ0Cv8tgg9CnsQI2OZLM37o5Il8Yt1HGKmJOBe
         p3byWNqV5R4aYCujs23Gmx8QnXTgFpQJE3rETgEb47aJRMtICrKSe4lBwVGqra7P7gCX
         e6p80NsYGbp7WPZ0vJEKOlCxHnoDRAzIoo/F1V5Pt0yLYoWhYdoIRG9JfIaUUG2aSgmW
         OhkUPdCY/2LQfPja1QV1PGjhpL6qgql/x8WQvVv2Z9Ya5+Ubx4sS2gnnC3aJAxCGKFIv
         gmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728442688; x=1729047488;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wbvgu9eS03hhlZbY0G5+mfQ7XUWGfeiy+WbcotHjuks=;
        b=pHadd1rc8BvwV8Pze5kUvKI8XudkHQ0GjroUUuxQs9n10k+ge6w5LJboyuUw8YFoCn
         w4jd1p+mB1J0u45KpLTxxTCYyw3bDO+j6WJVSO0NG//i1Y28OsFjjUQwxNleCH8IpGga
         mip5rAirzlx4l4f0wjDRQBWOYdYeBBiR3d9Yw6ec5INBYRHLbajdlAs+7tesbtaQIRr0
         0V0wDzl8R8T7lFzlbBAoXXMbE+vuh7I9iFYMOtV5VLAUkt8ZUOmCldNP04Woasl5lSJZ
         ThBfS/gFZSqQPA9daKy8HwWj8bUFs3iJpl332TkvbIWqd7zsVSXITYVuwBrL0Ber4u9Y
         petg==
X-Forwarded-Encrypted: i=1; AJvYcCWNuCyKHSzg2qDymW2DlRw6zjVjiGXNiXIxb3aKqfe6Hsi2f2HA5g8bvAdxrnlwfHyr0Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGNvYxPK9gIzhs3tZsXyY9krpRrS+kdcJdg1GqUIX6NOHezP6g
	Lr65WQNDdTxntny0/K87Fev5Mz6NL4Dsr+y4d9Dl1vFxOnuwThow
X-Google-Smtp-Source: AGHT+IHytllcMqGxY3Vm7XTpqFtfAooU4etoBitywQTk6AXVpQrw2dXQOkkxVaWu+8hDyWdvmXdQiA==
X-Received: by 2002:a05:690c:f90:b0:6e2:ad08:4905 with SMTP id 00721157ae682-6e3221124bbmr11395987b3.1.1728442687958;
        Tue, 08 Oct 2024 19:58:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:799f:a786:d66d:649f? ([2600:1700:60ba:9810:799f:a786:d66d:649f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e30eaab581sm5739397b3.117.2024.10.08.19.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 19:58:07 -0700 (PDT)
Message-ID: <b4d75b35-bfe2-4950-b2de-b56d95918b3c@gmail.com>
Date: Tue, 8 Oct 2024 22:58:06 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/gc: fix crash when running `git maintenance
 start`
From: Derrick Stolee <stolee@gmail.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
 <976c97081af7c62960bd71d1b70039657e7cb711.1728389731.git.ps@pks.im>
 <c1271bf6-3648-4eca-916f-67a8518fe4e1@gmail.com>
Content-Language: en-US
In-Reply-To: <c1271bf6-3648-4eca-916f-67a8518fe4e1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/8/24 2:30 PM, Derrick Stolee wrote:
> On 10/8/24 8:15 AM, Patrick Steinhardt wrote:
>> It was reported on the mailing list that running `git maintenance start`
>> immediately segfaults starting with b6c3f8e12c (builtin/maintenance: fix
>> leak in `get_schedule_cmd()`, 2024-09-26). And indeed, this segfault is
>> trivial to reproduce up to a point where one is scratching their head
>> why we didn't catch this regression in our test suite.
> 
>> +test_expect_success 'start without GIT_TEST_MAINT_SCHEDULER' '
>> +    test_when_finished "rm -rf crontab.log script repo" &&
>> +    mkdir script &&
>> +    write_script script/crontab <<-EOF &&
>> +    echo "\$*" >>"$(pwd)"/crontab.log
>> +    EOF
>> +    git init repo &&
>> +    (
>> +        cd repo &&
>> +        sane_unset GIT_TEST_MAINT_SCHEDULER &&
>> +        PATH="$(pwd)/../script:$PATH" git maintenance start --scheduler=crontab
>> +    ) &&
>> +    test_grep -- -l crontab.log &&
>> +    test_grep -- git_cron_edit_tmp crontab.log
>> +'
>> +
> I see why we didn't catch this immediately. This is a good way to work
> around this issue of "mocking" the scheduler.

Unfortunately, this test is broken on macOS and Windows. Those platforms will
fail when asked for 'crontab' without the test variable.

Here is a potential fixup that will make your test succeed:

--- >8 ---

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4008e4e45e..86bc77e73f 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -646,7 +646,7 @@ test_expect_success !MINGW 'register and unregister with 
regex metacharacters' '
  		maintenance.repo "$(pwd)/$META"
  '

-test_expect_success 'start without GIT_TEST_MAINT_SCHEDULER' '
+test_expect_success !MINGW,!DARWIN 'start without GIT_TEST_MAINT_SCHEDULER' '
  	test_when_finished "rm -rf crontab.log script repo" &&
  	mkdir script &&
  	write_script script/crontab <<-EOF &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b1a8ee5c00..f12f3a7609 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1715,6 +1715,12 @@ case $uname_s in
  	test_set_prereq GREP_STRIPS_CR
  	test_set_prereq WINDOWS
  	;;
+*Darwin*)
+	test_set_prereq POSIXPERM
+	test_set_prereq BSLASHPSPEC
+	test_set_prereq EXECKEEPSPID
+	test_set_prereq DARWIN
+	;;
  *)
  	test_set_prereq POSIXPERM
  	test_set_prereq BSLASHPSPEC

