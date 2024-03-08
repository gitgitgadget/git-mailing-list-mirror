Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F513C32
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.34.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709926392; cv=none; b=DTa0UDaovl61KEP2Vtka56MJd85vOhi+z2M9R7jpwzVHs0g87YAVKAajbAJ54/ogkVFpWRrsG8RWwKwi70jrdVdycnIY7yeUVZsjlf6GNnDszRdfqwY2z7yCnFIUWHAf68mMpSPvB3j3N9DRu84s/WB14pRBc9GO+hUHS9XmONM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709926392; c=relaxed/simple;
	bh=bzlsFFGZQomgQIPoJwuuofLTd52XkAqMKpxg3BeILaM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=FLqaCm+Sz3M2+ktx8gkxWM6PESq58BH+aKoB0FYtZ6gCi73gZHCFbRtvxtjFTF1E2OB0zfSFdHNR9t91wzZwNHmV34hFaLKmeKcfXf2uvIxiOsJfAnO0q5PhEMhlw4rP841Fz/m6J6itOHeDGtDcF+ronmvc3oFuAFiEUcHtaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=1F+GBQBK; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=VNcyMbCG; arc=none smtp.client-ip=195.201.34.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="1F+GBQBK";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="VNcyMbCG"
Received: from kernel-space.org (localhost [127.0.0.1])
	by kernel-space.org (OpenSMTPD) with ESMTP id a3e88ebf
	for <git@vger.kernel.org>;
	Fri, 8 Mar 2024 19:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
	message-id:date:mime-version:from:subject:to:content-type
	:content-transfer-encoding; s=s1; bh=PxoYSfGixMA+uCt98qp1JNHJ9Qc
	=; b=1F+GBQBKyevD18YCmrzN1ksQPU3Z/O2UsUmZqXdtBm3NIOLLXB3YNwHcLQl
	8qSU7PAJATluJ4a0AcBGWsHqoxdlGbRyYRZUOKvUEvq5jR/HKEZr8YYmxgr/7BYX
	YMQAYSfFnhYIzGnARCA8pybG/OdU46RV78+S5E0V/LF0zb0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
	message-id:date:mime-version:from:subject:to:content-type
	:content-transfer-encoding; q=dns; s=s1; b=JxGQyykQWwcpoMjF2s5DI
	M23dgwggpxb/iy4s0SK4s9MoEG9n9+3J41fQIM/dgH2JtKzzuo9WzzbvR/OvasUT
	yA2cgKkWlwZz1XOht1dS8Bt+nq2ndKla0MjadA4AMYuQxuQ8I4sO3wS9X95M78tM
	R1XjsT99zfK/NpNtHGADAA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1709925836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4SKYGDlHnLdI/6iywg/kA/7+KdrqaPPYvVGkWASng8g=;
	b=VNcyMbCGbq00VWLqlN77BiYJj8xXBU5M+I6yEBYkx2tePKOL+vLQ5y5GOnnWe82CR84+Qm
	PplVXJHWuk2DqEo3FsZo7VrQ+RqaGUkF8n5nlTf0vCFKkblOXpzyfO32NknpcVsCG3dnfw
	mXagvceoeXXxx5dOLX8wid5zwBl0qa4=
Received: from [192.168.0.2] (host-79-51-238-97.retail.telecomitalia.it [79.51.238.97])
	by kernel-space.org (OpenSMTPD) with ESMTPSA id c731093c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 8 Mar 2024 19:23:56 +0000 (UTC)
Message-ID: <72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel-space.org>
Date: Fri, 8 Mar 2024 20:25:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
From: Angelo Dureghello <angelo@kernel-space.org>
Subject: [BUG] cannot git clone with includeif onbranch
To: git@vger.kernel.org
Content-Language: en-US, it
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

below the bug report, not totally sure this is a bug btw.

---

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Perform a git clone https with includeif onbranch in the .gitconfig

Create a .gitconfig
with
[includeIf "onbranch:wip/pippo/**"]
         path = ~/.gitconfig.pippo.inc

git clone https://github.com/analogdevicesinc/no-OS.git

Cloning into 'no-OS'...
BUG: refs.c:2083: reference backend is unknown
error: git-remote-https died of signal 6

What did you expect to happen? (Expected behavior)
Proper clone

What happened instead? (Actual behavior)
Error above

What's different between what you expected and what actually happened?
I cannot clone

Anything else you want to add:
I am assuming that cloning is outside from any gitdir so should ingnore
onbranch.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.44.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.0-rc2-devel-00345-gc2782531397f #2 SMP PREEMPT_DYNAMIC 
Sun Jul 23 12:25:41 CEST 2023 x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show
