Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3E1C6B4
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743165306; cv=none; b=PtELecwHqdBGvmkB5XKQAGt0rbmx7iKxOV233BM13ts8AZ3tCbkzFvSZYbM+tHRIOeDzqEtZfVnfNGeR7DutHNIeJZaNZ2LdaUkHtT7ZGE171eEfJwCYqvkecntz5u7Td9I6KI211OapaKwJIokifgvwVCkqaHdsqJzfBj6dBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743165306; c=relaxed/simple;
	bh=nWGvhq53oWLfmMHoNrClyhzThDzG+ow5diJRHMOhOug=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SjlP5vZnt+pdkZ5IUWOTVyZsrr/bH0J0kOpSpDRzosAxopPpuDMJxNpCNvG3fdryTgds1GK7o+2pCrf9N8xCJRzZYn3Uz28n/g6KRUCr4T+7+w/5o0JmgZZgEQ8yEh74FYhj6DNRGKEvHYw3+kXEwoHEZzB1ZJHQq80kL1sWXQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URjGebfR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URjGebfR"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c56a3def84so222602285a.0
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 05:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743165303; x=1743770103; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4SbGQMIgPqqs6QxHKAEPG0zE8dO7O7zkcIRPfwsoUE=;
        b=URjGebfRb+aMVbjorsmt8w2XpmBFtgYnCiWPGO0RiG4EnF5Yue7Q+1e9hzjEocr0vL
         67enMbwgIp45fz9DtlqnHwKU1+ApDodCLwUnBHm/C48l1SUkI57SeI5+KnASIpFkcMBj
         NU7ULW3hr4Z/8rsFCNqw0l1RM62iffC63lyRtml4lt3Xw98/WSBipSBDzFIhttbPeS6y
         If4PDZ3U1vs7FjsyDLr6JlFL4t+6t5XmcporsDp1mXJe6n1OPSCOGMasSZgzJyQ+1Pjk
         nQvQxE1WGs7DhFyW0DIA8zzAXscDAvrlyXZv+GI6rSlNUF4aIFCRE4jTuoLD54rJ4zGN
         Bv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743165303; x=1743770103;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y4SbGQMIgPqqs6QxHKAEPG0zE8dO7O7zkcIRPfwsoUE=;
        b=KSX/GMQSGJYky92J9am7Jggy3rtQYbY2W3l5uRoUpeDAkOj7wO8aJZieG1REjNN9rm
         TTqH+uR4zzVzSbHSQ/Or9kTAx5iz6BD5gqiE593SByrunq2xKOBFsxi3OPQtqyq700as
         KuJCIpgOpmxoiA4ifNWqMkTC1oZ9yrwLvaoGV6efDd1hypbtvDzNPAXVOjbxH6NVR1Ef
         8giR6iUIYwHIqs90SYt+IEqrBypJ/gWqF3u2s4u4cpAeFKAy1tnBX7M9jWNFMiuoNece
         TawdI38+fGVMTgx2J5ztA3MyJr362nXb3Rm4u/U+dU91+bCcgZ9IPT4l3FqVB3W9YE43
         Io1w==
X-Gm-Message-State: AOJu0YydSxTz/AgzFKWD/IogwgxbuPe6knzseSHUxBXnQ8E/rRfSQpWf
	dsDwb4o40jjgZmc1wraj87AVbU+zwuUDHQfSzJk0tW/86vk6IVFmO+yXXA==
X-Gm-Gg: ASbGncvzvKcR2qu3ErEFj0/71mvdCMN3LTNGc20W1CLFFDcfTOq9WVj4g2q12QvEmjD
	deOANQ19QNL9ZbLAkMbuqB7043KfCuBnC6Lk1DrIKX7pKl9TvNL9to96+2VD+yuoX4X6toM9V4X
	9FFMOlcgArWMy3GgnChGiJl97BWmi+ScExbuP1TYKSKWgoZsw1CFmox6Ar+8ahJ1ujlbBAZgIeU
	0AFY0TZNzDMche48tP5LG+xC4f2iz9sAkQzDWZ3mdPaXoNpceS7niuX/s0Ioo5KjMUEjsNFD/y/
	zv2a0XFqUz7RkUZSABsW1B3vjecu/qvjm0M9/mauIrKPu+Nj84Vwsgz6atrrQJGb9Q==
X-Google-Smtp-Source: AGHT+IH54swaj/V1a3/KcmbtBST88uo1ikhW9rqK5NPcvcM8MQk+YnQGGxvD0gw/539+YxJTlCuw/Q==
X-Received: by 2002:a05:620a:1aa1:b0:7c5:6cf5:9439 with SMTP id af79cd13be357-7c5eda6507emr1040334685a.37.1743165302553;
        Fri, 28 Mar 2025 05:35:02 -0700 (PDT)
Received: from ?IPV6:2600:4040:2644:5100::387? ([2600:4040:2644:5100::387])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f76ac39esm112483385a.61.2025.03.28.05.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 05:35:02 -0700 (PDT)
Message-ID: <23088b7d-ed98-4b78-bb9a-c3674da1117d@gmail.com>
Date: Fri, 28 Mar 2025 08:34:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "git@vger.kernel.org" <git@vger.kernel.org>
Cc: j6t@kdbg.org, johannes.schindelin@gmx.de
From: Mark Levedahl <mlevedahl@gmail.com>
Subject: git v2.49.0 - gitk regression on Cygwin
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

referencing the upstream gitk repo at published at 
https://github.com/j6t/gitk.git:

Since commit 4cbe9e0e2 - "gitk(Windows): avoid inadvertently calling 
executables in the worktree,"

gitk no longer works on Cygwin. This commit is in Junio's tree as part 
of release v2.49.0, but I didn't trace to the specific merge commit.

The proximal issue is an endless loop caused by routine _which invoking 
exec, which is now a wrapper that invokes _which, while the builtin exec 
is renamed to real_exec.  This results in stack exhaustion.  There are 
other problems due to munging Cygwin's $PATH into Windows rather than 
Unix format, so changing _which to invoke real_exec just changes the 
failure mode on Cygwin.

Removing the Cygwin specific code so that gitk treats Cygwin as a Linux 
variant does work: e.g.,

diff --git a/gitk b/gitk
index bc9efa1..2c29118 100755
--- a/gitk
+++ b/gitk
@@ -49,14 +49,7 @@ proc _which {what args} {
     global env _search_exe _search_path

     if {$_search_path eq {}} {
-       if {[is_Cygwin] && [regexp {^(/|\.:)} $env(PATH)]} {
-           set _search_path [split [exec cygpath \
-               --windows \
-               --path \
-               --absolute \
-               $env(PATH)] {;}]
-           set _search_exe .exe
-       } elseif {[is_Windows]} {
+       if {[is_Windows]} {
             set gitguidir [file dirname [info script]]
             regsub -all ";" $gitguidir "\\;" gitguidir
             set env(PATH) "$gitguidir;$env(PATH)"

However, the above leaves code in place affecting path search on all 
platforms without justification. The commit message references the TCL 
man page for "exec", listing a number of directories (including the 
current working directory) and file suffixes searched on the Windows 
platform that could be problematic. However, that man page does not list 
any such issues for other platforms. So, it appears the patch does not 
address a known issue on Unix platforms, which includes Cygwin.

I believe the correct fix to 4cbe9e0e2 is limiting the override of exec 
and open to Windows, and I also have a patch to do that rather than what 
I show above. Let me know.

Mark

