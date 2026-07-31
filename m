Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B3E1F3B85
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.144.192.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485970; cv=none; b=VKzp4UT3Et+wdIqOt1UMFDo0cpatZ88UWJyqqaejWLZWJj9XOWgXpkJfAV94jVR/olbRAw52PK1LKSfz+ueQLwtQbxspmCXidAPdu+6gTNcySzJuB/C2d2lIxS8umk9khRuT22mrul8VzpE2srCh5YvtsqET2SlmMs3ErjByT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485970; c=relaxed/simple;
	bh=js0fJXRdvY0kQ7N0wnpy3RqFyCxaCKiV7cgZPYJs9Ts=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=kEwN3qBjv2c3MSHDabdb+UwHhCDza4NyoMSXklX8vQdjNf0vXlwceBGQkxqStI1oZeb5TdpgDHGCHvqFu//l14uM3TVsbjTiH5cxO/JcttSq15FC/LDXbW0WO70OeN0F4FeXo9ypntdR3PHAP2HbSzByhI2Bf9GFOKzLwKq0KlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com; spf=pass smtp.mailfrom=rawbw.com; dkim=pass (1024-bit key) header.d=rawbw.com header.i=@rawbw.com header.b=OGl+7Qb6; arc=none smtp.client-ip=198.144.192.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rawbw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rawbw.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rawbw.com header.i=@rawbw.com header.b="OGl+7Qb6"
Received: from [192.168.5.3] ([24.6.215.85])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 66V7o0P0010826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 00:50:00 -0700 (PDT)
	(envelope-from yuri@rawbw.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rawbw.com; s=apr2026;
	t=1785484201; bh=js0fJXRdvY0kQ7N0wnpy3RqFyCxaCKiV7cgZPYJs9Ts=;
	h=Date:To:From:Subject;
	b=OGl+7Qb6D25KId0+j3svFUeQc2cGMrE4USl5Pzi29gNFKkVXL84ZOBEIedKNhYB2Y
	 0bt9IqFLWpA9jwaF8xYFm4kxnfncR2vrZd0E6vWBedLMfVNTGdfvMBG5YD9rLVfMvQ
	 /+QFrceYAuMnlD4bamYAo9kABYZjFXMPwqfh/jSo=
X-Authentication-Warning: shell1.rawbw.com: Host [24.6.215.85] claimed to be [192.168.5.3]
Message-ID: <334fa4a8-1a84-4528-8f8f-9b1e9607bb75@rawbw.com>
Date: Fri, 31 Jul 2026 00:49:58 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git Mailing List <git@vger.kernel.org>
From: Yuri <yuri@rawbw.com>
Subject: 'git stash' pushes files that are not listed in the command line
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I work in the FreeBSD ports tree.
There are multiple ports (subdirectories) that have changes.


I intend to stash only 3 ports:
$ git stash push -m "docling: some updates" textproc/py-docling 
textproc/py-docling-mcp textproc/py-docling-slim


However, other files also get into stash:
$ git stash show -p
diff --git a/misc/github-copilot-language-server/distinfo-node22 
b/misc/github-copilot-language-server/distinfo-node22
new file mode 100644
index 000000000000..cc34bd17864f
--- /dev/null
+++ b/misc/github-copilot-language-server/distinfo-node22
@@ -0,0 +1,11 @@
+TIMESTAMP = 1777521723



misc/github-copilot-language-server also has some changes but it was not 
requested to be stashed.


How can I understand why does this happen?


I believe that I've seen a similar situation before with different ports.




Thanks,
Yuri
