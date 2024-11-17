Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4407A1803A
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731847221; cv=none; b=ghVROri4rHZWp4RaV4vmMastksF1+1yOIAtG7YVZRZslCkCJ179dw/B8pzmlhcpKWkgb+BQe+RXsz4HKUB48wBjrsW4IrOt+e/BhEpApRLTo2qOeobM5iIQ0/Q3XaXXES87fookAKT8VFEtnQpQRvqlhBL0GV38ZNfFArwa3bfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731847221; c=relaxed/simple;
	bh=t/O2wNJiZeIAHEaV+HBymIMe5/f+puvqUs5t+0f+uBQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WJPHDKyxBk0+ZSAjgGEj0AValrwUwMEjnbRabSV0L4jXaP/0wIZvh0f5SUC2ZccvwLwq61zVql/mGfxXMv2447SGULA78WDEJbOapeaLx8dRct7vSbTRp8cdk8cfzqUZyq3zcBnwdEEjOzCjhW+91zpwB4IOI9r7zcZVcw5dvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO30EBet; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO30EBet"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3823eb7ba72so452956f8f.0
        for <git@vger.kernel.org>; Sun, 17 Nov 2024 04:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731847218; x=1732452018; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t/O2wNJiZeIAHEaV+HBymIMe5/f+puvqUs5t+0f+uBQ=;
        b=BO30EBetl1xfq2IL/pAZiWhorrq2V2WYnhr7qGfPCF65l/oQfj87kHWxMfDrz8VeG1
         W1WGK2Gk6zMRVAqtt8+ck7RBdeGZ5KqnVHB/EIpEJjdRcSM4qouaRpghzecBbP/nuvHA
         08+pX2rDeOzff36mHpD3YKj3t7eXKZzd/50mQnDZoUrigIyFyhyy4pfqnw1NGVhoOwkz
         caV4TuXwHSKEkfnIPiAlJ8gmXLw5XXFGO64PTH0nbJn+YQxwenQrccmIeu02kmNXrFY0
         StFg26XNRfFNBEo4q7gBGsM89wp0xQ4wrSP6BZ/196URy0hQi8Q7KWzaq68BC7d4cSII
         2Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731847218; x=1732452018;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/O2wNJiZeIAHEaV+HBymIMe5/f+puvqUs5t+0f+uBQ=;
        b=tmIbpdjVSZXnvIz6V2ibND6omcqofwvTfiFlGXWO2RFmlZ5DtXIEge5Nh1eX9+4BcF
         e1PfDfuKjuU1cSf23aRB4xrLfn1dUY8Z0y4qfBfa7HDkV7mNZd4nHG1jFIsJQatLbT7+
         TnjoqXGCHFlyIHpFoLSdenr08eFY184S4Y9Mg+a1GDLeGO+Qm48F9mLiGt6TKpTfm5u5
         sG57xBZVq4CkSv+3Da4wODbpG1sd7LTFyZIhVTHGP2irqIqHjD7bFqYYTQI9eHo2qX0+
         79JZzflZaDwvhN1r0/Np1y3grbnLcIkLiiPrsdxTal1xG/Ga7LrcA3uZWAIfzl7zH6jm
         Sdcw==
X-Gm-Message-State: AOJu0YxT5DR2WByL7dohp96XZ2kpc39PSESCpUNEdpObO3h49cf6O9We
	Oef/Ul1MfTG46MMqQ1cmDbzbS9P2SjR9X/3PHt/xA8b2Fvntz2H2+9thKisJBlovQ8sAS3KDQO2
	cBJKIMPpLtbMsjJgVseCrlqYu8x+yILcUTWY=
X-Google-Smtp-Source: AGHT+IHwM5Ka0iBKm2wiYhn+6I7ws0VUsPXyPGEeHsW6kvknSqDWLpblgLC5NqObgf2OX6bi7V83DM2WUkmdJ39SRA8=
X-Received: by 2002:a5d:59a8:0:b0:37d:4d3f:51e6 with SMTP id
 ffacd0b85a97d-38225a07151mr8413544f8f.14.1731847217407; Sun, 17 Nov 2024
 04:40:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ylarod <ylarod9@gmail.com>
Date: Sun, 17 Nov 2024 20:40:06 +0800
Message-ID: <CAGtHOOFutv6wHgoFnkZoETJwq6FDkbbBgGqzSXT9V7ESXQswCg@mail.gmail.com>
Subject: [BUG] Apply patches failed without any changes
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1. Clone the repo

```bash
git clone https://github.com/Ylarod/frida-core
```

2. Generate patches from 36a8ffbb to ed039c9f

ed039c9f Florida: memfd-name-jit-cache
f5f61669 Florida: pool-frida
7d4ada2d Florida: update python script
bbe4ebb1 Florida: protocol_unexpected_command
bedd2337 Florida: thread_gmain
e251174c Florida: thread_gum_js_loop
357374cf Florida: symbol_frida_agent_main
da9110f5 Florida: frida_agent_so
351d9c1e Florida: string_frida_rpc
36a8ffbb subprojects: Prepare for release

```bash
git format-patch -N 36a8ffbb
```

There will be 9 patches:

0001-Florida-string_frida_rpc.patch
0002-Florida-frida_agent_so.patch
0003-Florida-symbol_frida_agent_main.patch
0004-Florida-thread_gum_js_loop.patch
0005-Florida-thread_gmain.patch
0006-Florida-protocol_unexpected_command.patch
0007-Florida-update-python-script.patch
0008-Florida-pool-frida.patch
0009-Florida-memfd-name-jit-cache.patch

3. Apply these patches to 36a8ffbb

```bash
git reset --hard 36a8ffbb

git am 000*
```

The bug happens:

```
Applying: Florida: string_frida_rpc
Applying: Florida: frida_agent_so
Applying: Florida: symbol_frida_agent_main
.git/rebase-apply/patch:126: trailing whitespace.

error: patch failed: lib/agent/frida-agent.def:1
error: lib/agent/frida-agent.def: patch does not apply
error: patch failed: tests/labrats/agent.def:1
error: tests/labrats/agent.def: patch does not apply
Patch failed at 0003 Florida: symbol_frida_agent_main
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"
```

What did you expect to happen? (Expected behavior)

Apply these patches correctly

What happened instead? (Actual behavior)

Apply patch failed

What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.47.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.10.1
OpenSSL: OpenSSL 3.3.2 3 Sep 2024
zlib: 1.3.1
uname: Linux 6.11.6-arch1-1 #1 SMP PREEMPT_DYNAMIC Fri, 01 Nov 2024
03:30:41 +0000 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]
