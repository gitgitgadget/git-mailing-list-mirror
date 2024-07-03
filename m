Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9F1EB27
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 14:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017707; cv=none; b=a6rWz4E3wqFzcYPDq4V2aDd+fNQyoh2Z51BaurJGHCcfTg06u1RqT8rxYidOcNKg6VjCadT4P+7dFhty4sSbsvOLe2rjcVim7juit7Ay6CaeNnzKfe/N8lV2eRK4VaRTyod0XzjrOZ1i9iR/w/TDyJmy+LppC2GJRFTpghM1CKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017707; c=relaxed/simple;
	bh=FLsk7YkBgZ+HRCOM0ckoH32gqsQLaxP99jQvrZIeqEI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=mgVIPi4mB5I9fC2c4m4Y1sJDPer03Wqr4ZwNYzRalTsANL8DNmRHQfYGpLz9K8vsdUZ6FWP70CfdSnZlFhvs7WaDLgBxc8ayq0wBfbojlo6eKAQBdGOSQAPRe/ncFLRkJUlybLXOgQthPoHPpZx5KpVKLJ/Dqi7T14Pjm0zRhsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQCVor5i; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQCVor5i"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58b447c5112so2612972a12.3
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720017704; x=1720622504; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/n+vxpOVc32taW2pZfVxWR70A4CFrCntdWO40K7YM0=;
        b=HQCVor5iYh9qSeZZpc6+iNUfZeqrk+fsGdT8ZDbTGfwHsHdiN+07+DScM1BnMIYkPx
         oM9NFyZUzRip6tNTWYdX7R0DQh66pKkxWiKw4iTS0cKo8rg2xelATkibckevIhC06L0H
         R5yZauBNdU2wv/NxsNLbZMfasAyQjRsJMElUT+D2l37qh94QD1QLlRbb5Dk/enU5jCL9
         5NzcwcR9yv8OFBDmwWrSem2lTXJSWglCK/ZENvJY8T6p74wP5dr3Bebw+5rOdKCrkzbU
         HyeYbf9eu5fVSYYMb0dRh+xBTjyS6+pQ1yrUqf7nt1gHkCV2g0jfSntkVZ8PC9I27Pmv
         HATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720017704; x=1720622504;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q/n+vxpOVc32taW2pZfVxWR70A4CFrCntdWO40K7YM0=;
        b=s/VPSnS0oaJZ+n8Llbj1IIHjLywxpR0lEMkJ2lJEJxfaMVv3UyaY6qfQ4hK9v4WM+M
         rWkMCZhn8fIyU2pSiv/dT0WqxK2URdMAu4wM6KO07lhlT9D5iVnL4aiqevGTydLwfOKP
         2B//TiDpNkRaVASby2u1/IabDq9Xa7QNMy1rpkIF+wBWmRbPGGnhjzCFLNd/Im1xFX3E
         T9FZbXhWQkIDcg5XiHRhbRAQviInMKgyC5RN1E2RJxIlhLKsUH1AP+xzyHoKvq+2D1Vz
         /cze7D56fZ9rbiK4ogyoTPQbHORGK/2bjSBk9U/feLCHW/aoKns/zay1a6EqNKflTFLs
         ayfg==
X-Gm-Message-State: AOJu0YxYO9Mvp2YxgUcTe1G4GuQ7G9h7k4Mns4NwlQcEN1jge0N8RH61
	WQguNQxOQJCgdkMJMG7y+tBsaNAHVkl1JopQ3w6CLGt3lQs31jaamlehEJk=
X-Google-Smtp-Source: AGHT+IEIJLu2gmjIVzn2qheDq0KQDr+toAdPx4bdToN5UF51ujSAZec6E6Ovq9ri78PllaI/0kEF5A==
X-Received: by 2002:a17:907:26c7:b0:a72:603f:1ea2 with SMTP id a640c23a62f3a-a75144baeb3mr915215566b.62.1720017703307;
        Wed, 03 Jul 2024 07:41:43 -0700 (PDT)
Received: from [10.13.100.2] ([77.238.255.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab06565csm513155166b.103.2024.07.03.07.41.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 07:41:42 -0700 (PDT)
Message-ID: <9b31e86f-c408-4625-8d13-f48a209b541b@gmail.com>
Date: Wed, 3 Jul 2024 17:41:40 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US, ru-RU
From: Ilya Tumaykin <itumaykin@gmail.com>
Subject: git crashes in `git commit --patch` with diff.suppressBlankEmpty =
 true
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

`git commit --patch` crashes with diff.suppressBlankEmpty option enabled 
under certain conditions.


Steps to reproduce:
1. Prepare .gitconfig:
[user]
	name = User
	email = user@example.com
[diff]
	suppressBlankEmpty = true

2. Initialize repo:
$ mkdir git_bug && cd git_bug
$ git init
$ echo -e 'test\n\n test \n\ntest' > test.txt
$ git add test.txt
$ git commit test.txt -m 'initial'

3. Make changes:
$ echo -e 'test\n\n test\ntest\n \n' > test.txt

4. Try to commit new changes
$ git commit --patch test.txt

5. Try to split the first hunk, press 's' in the git-commit interactive 
interface.


Actual results:
diff --git a/test.txt b/test.txt
index 366cd4b..611ca9d 100644
--- a/test.txt
+++ b/test.txt
@@ -1,5 +1,6 @@
  test

- test
-
+ test
  test
+
+
(1/1) Stage this hunk [y,n,q,a,d,s,e,p,?]? s
BUG: add-patch.c:994: unhandled diff marker: '
'
Aborted (core dumped)


Expected results:
git-commit splits the hunk and continues.


Comment:
If I set diff.suppressBlankEmpty = false, then I get the expected behavior.

git --version: 2.45.2
OS: up-to-date Fedora 40

-- 
Best regards.
Ilya Tumaykin.
