Received: from smtp7.goneo.de (smtp7.goneo.de [85.220.189.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9632EF67D
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075555; cv=none; b=Tr1V85sv4VZgML0LYjsHuPDzct5LkU9/RZB08SqCK7QpeHlGfQHOxPyqAVJGwi/8gjW0+sD5NhL3qaVkNVtu52bd82HserSoXKr0VxgwXpzqeYXA30cm4dQ8ZZnfCWpBdsQOAcz576LvP+Y/wQCnraKUNKolDfra0SKqFrQHBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075555; c=relaxed/simple;
	bh=5ohOZ9zG+3IBmsvz5ZrN+CdtdAdY28WxaPfZIT4WzVA=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=VPSvwtKuLMq3OFqys/D+LzYpo53jgtJJC2CRF40UEd1xdY/Wu14+Yjg09MJJcW/buJGAGR0CdVCma4PU/XeNOXNAmR9jNxJQgFVO8DQh5/y6XSx7b5QewALLQqFLXktYn0dGFAneCRH3MnPxaNFKCFRlgknC1j6sznEatZguo+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dettweb.de; spf=pass smtp.mailfrom=dettweb.de; dkim=pass (2048-bit key) header.d=dettweb.de header.i=@dettweb.de header.b=h8AorpeP; arc=none smtp.client-ip=85.220.189.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dettweb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dettweb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dettweb.de header.i=@dettweb.de header.b="h8AorpeP"
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp7.goneo.de (Postfix) with ESMTPS id A3986241039
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 10:51:52 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 12D9E240116
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 10:51:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dettweb.de; s=DKIM001;
	t=1755075111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2f7qlpakxa08G10IiutN6bJdSmFXXUGwpUhXP4L237Y=;
	b=h8AorpePWmI0xQ8ATeJdgUUysy6iXn276g0ty4ysZ4kSzHYhmUxOKL5BvRWndWGWf5Dgkf
	1OKOrpq4lpcAdTvONouS/uncZH2eY8G12tSkeiynZI/saS7hwI/2gLmndcxyKwpZIVUtKS
	Ebszr9af2e3c0QmsFGrf7HjdTvUXAtAwcGNxddtSNVkTPuHwKFQrZ/yTw51HCAO2NW/iwk
	/N1p5sHvAJrSM2r0qSeKG9vehCaSUwyFmSOgBqBjWLUItfApWKbQY6lyrIgcg8wELWjcs7
	mOYnEEC6RlI2wBG12nnHvfXP+KSBN5Em9xzyxVYP2Ce6xuC6xhjtHBKDQ9GZ2Q==
Received: from webmail.goneo.de (webmail.goneo.de [IPv6:2001:1640:5::2:12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id E0E2424002B
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 10:51:50 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 Aug 2025 10:51:50 +0200
From: "J. Dettweiler" <git.vger.kernel.org@dettweb.de>
To: git@vger.kernel.org
Subject: [FEATURE] Proposal: git stash --only-unstaged
User-Agent: goneo Webmail
Message-ID: <12fe17735317215aa0de58a20055193a@dettweb.de>
X-Sender: git.vger.kernel.org@dettweb.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 7dcd9b
X-Rspamd-UID: 62ddc1

Hi all,

I’ve run into a recurring workflow problem when splitting commits during 
an interactive rebase, and I think Git could benefit from an option to 
stash *only* the working tree (unstaged) changes, without saving or 
restoring the index (staged changes) at all.

---

**Scenario:**
- I have a commit that needs to be split.
- I stage the part of the changes that will remain in the earlier commit 
(this becomes the new, fixed commit).
- The rest of the changes (which belong in a later commit) remain 
unstaged in the working tree.
- I want to test the staged commit in isolation before actually 
committing it, without losing or committing the later changes.
- After testing, I want to bring back the unstaged changes exactly as 
they were.

---

**Current limitations:**
- `git stash --keep-index` still saves the index in the stash object.
- When I later `git stash pop`, Git tries to restore those staged 
changes, often causing merge conflicts if I’ve modified them during the 
test.
- `git stash -p` and `git diff`+`git apply` can work as workarounds, but 
they are clunky and error-prone in longer rebases.
- The goal is essentially:
   > “stash the working tree only, leave the index untouched and 
unrecorded in the stash.”

---

**Proposed feature:**
A new option, for example: git stash push --only-unstaged

---

This would:
- Save only the unstaged working tree changes to the stash.
- Leave the index both in the working directory and completely absent 
from the stash object.
- Make `stash pop` safe even if the index has changed in the meantime.

---

**Benefits:**
- Cleaner workflows for splitting commits during interactive rebases.
- Safer testing of staged changes in isolation.
- Avoids unnecessary conflicts on stash pop.

---

I have not found an existing Git command that provides this exact 
behavior, nor an option to `git stash` that prevents the index from 
being stored in the stash object.

Has this been considered before? Would there be interest in adding such 
an option?

Thanks for your time and for Git!

J. Dettweiler

