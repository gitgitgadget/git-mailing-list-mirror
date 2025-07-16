Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEA12F49E5
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687527; cv=none; b=X7dVbstq/CvLqfS537h//MPcZd6Prbur0FlYE4KMyWm8tMN8Wh2YrFb0I92wdUpYB0R3G2AvRH3FN5II03IsU4uUZPJFstifDCGrRqI2uhgGX4E4olWZAfOWpcqA+X6tf8+BXhC6nSEkYpeQK/7UFmCVc8JKvX1v24Vbds0VjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687527; c=relaxed/simple;
	bh=BukURH9R0CDokwTIHyiunPfewSoR8J2J4MvEf+A+qKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=fgJ+Cbc4wC5ZOWpB7Vi/8CGt3XR4NTIfYRrxfb/ANadm5jaKVTXxsJ5a08O3KU2JInlHapaNcU0BIEde3OwT9elzbnaan11eQj7W1PPblAU/YwFaSD1pgo6ZuiGozbQM+JbBAY/mmR2/YnnE77I3+yy1xpQTY1MMVYwuOD/FGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (089144220187.atnat0029.highway.webapn.at [89.144.220.187])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4bj3F71ykxzRnPn;
	Wed, 16 Jul 2025 19:38:35 +0200 (CEST)
Message-ID: <2a7f20ef-ad7b-47b5-9c3a-71fbdd11e756@kdbg.org>
Date: Wed, 16 Jul 2025 19:38:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] git-gui: Add support of SHA256 repo
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
References: <20250716073227.11486-1-tiwai@suse.de>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20250716073227.11486-1-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 16.07.25 um 09:32 schrieb Takashi Iwai:
> Here is the v3 patch for git-gui to support SHA256 repos.
> I put a preliminary patch to clean up $null_sha1 in addition to the
> correction / update of v2 patch.

Thanks, queued.

I applied the following fixups: an obvious typo-fix in a comment and use
of our wrapper function `git` instead of plain Tcl `exec git`.

diff --git a/git-gui.sh b/git-gui.sh
index c437980927fd..523e4df8069a 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1298,8 +1298,8 @@ if {[catch {
 	set picked 1
 }
 
-# Use object format as hash algorightm (either "sha1" or "sha256")
-set hashalgorithm [exec git rev-parse --show-object-format]
+# Use object format as hash algorithm (either "sha1" or "sha256")
+set hashalgorithm [git rev-parse --show-object-format]
 if {$hashalgorithm eq "sha1"} {
 	set hashlength 40
 } elseif {$hashalgorithm eq "sha256"} {

