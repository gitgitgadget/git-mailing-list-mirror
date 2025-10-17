Received: from mail-107166.simplelogin.co (mail-107166.simplelogin.co [79.135.107.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05639405F7
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=79.135.107.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760668166; cv=pass; b=KHM6y/+aTOoEVO0w4IwIMcZgRgn6gE0YPaANmUnN/2xBZGivFcjEM9ncM6pnBCm64RzXw1GhpaHu6wiIgt1saL8H7oUiIl5WBIVO5KsrIGqmqTqVDAOvaOPUD99tP9S3brhe6i65yE/7cQ2RgbpfJd13RHgzXynwxAJqmf+ivj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760668166; c=relaxed/simple;
	bh=RKLg9oQYKYRA2tBiJ9QWFJ+S+FGmpqR4YomrWOG8SGM=;
	h=Date:Subject:MIME-Version:Content-Type:From:To:Message-ID; b=Ac3Rx2lifwVEyAqE8JZi0J+jzZ19+SGzjiQ8P4t+F9j2ZuF53oywp9PchrK1943YS/UfLyiYXYVMUO/ruIEKivEI1TLjQn1a2qPYXQYRwptKLjc8Il3eNi1Rn+CDP1gW1ZuhbZ0wrWtHkzCWcPCK14mv8bCp4V2eKy0ApmIpEXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=passmail.net; spf=pass smtp.mailfrom=passmail.net; dkim=pass (1024-bit key) header.d=passmail.net header.i=@passmail.net header.b=RDejdmC4; arc=pass smtp.client-ip=79.135.107.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=passmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=passmail.net header.i=@passmail.net header.b="RDejdmC4"
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1760667586;
	cv=none; b=EFK2I4lL8pk9yKJQR/3hgEcvu42WJwKMdD+2uItcQzmTzK/sDyxUwbxEKlMU19AuqYX0rN67HpJ91M6nixDh8aI2W+MMXcEdThP2NYr8ue9OiJ6uj1ermrEbr1e3y4RU0KPW7N4Ih2T6B06lOaNQ8PAGVGfuPEeiOngE7xysjdqPF2rkjAqdjnnnIRqSkaunnJY7zmI8fnRkH2EdC5gkrn+yd2VS072GaYCnT956aGW67qCX+2nN7MybnN+dbc1hzUxy86TIHzc/hJUr1WS/YQ4mrjf/+VaB6EWxlIAsZ/CJ57+OzKedrMYD0VXIa8gQfCeP376Z8xrpTw/iJ+MbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1760667586; c=relaxed/simple;
	bh=RKLg9oQYKYRA2tBiJ9QWFJ+S+FGmpqR4YomrWOG8SGM=;
	h=Date:Subject:From:To; b=kZGvAtAaK8CTX05TvNSvh5EqU8iI2GRUiFPPCklWSz2sYNH1Gyxl4k+MbES/vzGw2qbCJ6HroNGim9GaEt4f6ECf/yuDoqbDxiMprO3Ri2d3q44X1nw9YGc7KIspuNuAZn+adHIWu5X7FnNOoFzj4aj80VWHTebQ2F0wZhGajK9y7s2xxH9i+E1uHrB0IuX/ctqFCmz1BrfWpxwFjTrF6JCV80aDP49TiASzgeTcswH28ifWgTNMH6eCNlWwzG+JVF8ryZARxro0me6pTwF8lD/0we0lPWcnqh7ZtRIONkrIAEU0a3gjGQf2ZivTesERVhRdmvkM/IrDEPkbjOBriA==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=passmail.net;
	s=dkim; t=1760667586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RKLg9oQYKYRA2tBiJ9QWFJ+S+FGmpqR4YomrWOG8SGM=;
	b=RDejdmC4trtOgb1ryF5oeWIfj7KAJrHAO/SJSJKbEJIT1SO7YGS5t8qqlWQrrOk3zFWF82
	P5IAj2dU1HHeiQsQFJ0R+cmg15b4Ky3dzl2A14MaZ6nrKxy5U16fvYGSQLZ6kWF4dS/BAu
	CyoOw/kjCupPcOvrtMvWyYjLLWif9nk=
Date: Fri, 17 Oct 2025 02:19:38 +0000
Subject: [BUG] protocol.file.allow=always not honored when --local
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: fence.borrowing375@passmail.net
To: git@vger.kernel.org
Message-ID: <176066758616.6.12811000416591629223.957743298@passmail.net>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 957743298
X-SimpleLogin-Want-Signing: yes

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your
issue)

Created an empty directory, then initialized git:
`mkdir ~/test && cd ~/test && git init`

Ensured file:// transport protocol is default/unset value (file:// is
disabled by default):
`git config --list | grep protocol`
# no output

Enabled file:// transport for local repository:
`git config --local protocol.file.allow always`

Then, attempted to add a git submodule:
`git submodule add /path/to/module/.git`


What did you expect to happen? (Expected behavior)

Successful clone:
```
Cloning into '/home/username/test/module'...
done.
```


What happened instead? (Actual behavior)

Failed clone:
```
Cloning into '/home/username/test/module'...
fatal: transport 'file' not allowed
fatal: clone of '/path/to/module/.git' into submodule path
'/home/head/data/infra/src/test/git' failed
```


What's different between what you expected and what actually happened?

The default behavior of disabling the file:// protocol should have been
overridden by the config, but was not. In contrast, it gets enabled as
expected when setting the config user-wide:
`git config --global protocol.file.allow always`

I do not want to enable file:// by default due to security
implications. I only want to enable it for specific repositories but
cannot do so as this setting is not honored when --local.


Anything else you want to add:

A similar error message shows when attempting to update an existing
submodule with only the --local config set.

This bug is also present in git version 2.39.5.


[System Info]
git version:
git version 2.51.1.472.g4253630c6f
cpu: x86_64
built from commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
libcurl: 7.88.1
OpenSSL: OpenSSL 3.0.17 1 Jul 2025
zlib: 1.2.13
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/bash


