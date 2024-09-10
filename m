Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627C91A7AF1
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000636; cv=none; b=czQakQwHg96OuQjkiMbBGOUe92TkvW5XyVMwDM7GuEbydc7ERGmXeLaOdqHRlytAB1HK79KEj9Y8QxdgyuXOHnRmPGLK4Lq0RLLW4coJwKhAIzObdGQRB6fBe0ESNcG7DWrKwVJZN4w0PLdAfuPnMM4KJ6umJVBSxkOuZFqPi0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000636; c=relaxed/simple;
	bh=ZGaqvCLXyNI0beKjdZFgoJBhVZ/3MKQzvCuAetAdIvU=;
	h=From:To:Cc:Subject:Date:Message-id:MIME-version; b=oMcxq/mnMiSu82M6MyCGZnSfG6Nl1F6H34lT96nB/PgvbI06Kd543vk/v1ZZOSK2J3dF6lvEJtfnUU1bzRh/mxZIwCdfKLjnyFHz75z/IeXfFW8c+jDlGl+bPO0/FnkELRfeAYB6eNAJHF3XSVDzHDX5N8ZGFGor89y66cjN2JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=O9iOwfsd; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="O9iOwfsd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=cpI4P4GX5ZX4uwGXpcctSucimOEdaGQuEjDYHKqNAMA=;
 b=O9iOwfsdgK0crmvnKDZrvPnGeCzonRW6Vjrgq4MAIx7LP3iuWm77sFQ8iDO0J7feaMZ70I/h64iB
   O0AKCaundvTyGwW/GUHUbf43NxXklp7RlwYivXkv5fhhidktI1YftXWXHfJhtdLBI83hGn5F19zV
   0SxGVZVftz6aSs1dfERUa72OyAGULTfGCyvvx48DabbS7Y9JSg6JkSwiBG1MNhl8Qhyt06jxpezr
   Igu0T/UfMZDNJZjndbWSwt0xP65BJoPcWC4+6iGIsEXCf7EqniFNiuljBsknP5CV2CBRrXLe1bzE
   a7tg5Qc4iqQfdI3Loz8iYJsFgAYOJxyXXRSySw==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SJM002ZC6DFPM80@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 10 Sep 2024 20:32:03 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de,	Bence Ferdinandy <bence@ferdinandy.com>,
 cc@mail.ferdinandy.com,
	/tmp/FUboFpyPuH/0000-cover-letter.patch@mail.ferdinandy.com
Subject: [RFC PATCH 0/2] set remote/HEAD with fetch
Date: Tue, 10 Sep 2024 22:24:57 +0200
Message-id: <20240910203129.2251090-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHIA+iLW4+N8FNUHnoGYkiKLbs40IIVsmNPEs115GzgtOnvxOAVQo5dP7oU0E8L
 5HrmiweWSocxnOTcAeOe3pOUZCPureDjUHr6kCFMIqs4gVIaz/i80NNtfKlRZ8jz
 ocnIdGnGhEEHLXVFkX6GV2jqKgttQ/v37xrcOBBvKimfPRmBg4b08/fJTgmzpBPZ
 OzJ+e+j9myC+FHHdABg4teOMumBRXksr8fTWudk7bAUj+a8PB+P5KZGLJvn75mLf
 uB7iGOb2C3Rks96ItkrrmkGHvs2xBmEvLmAFvxrcWPOsWaFKk/SqOEF5KAUsCh0X
 ycLwlD4rO4jF0fAbRb7Oe3WNnEXSTLqAeKOgymTktm3BXbwW32p32Y/brG9T7Puk
 /43cMFj/+DGCMiixqv1/7hSKaXU47UqpjodNmvDQ6dZ7n5DSdfNlphtpQoAwI0Rp
 cy3ItwB9vj6Try6lLfyQgmtlRD6kKnDwruEpARBfb3+6CBvFCx1dXYVB

Hi,

these two patches attempt to solve the issue raised in
https://lore.kernel.org/git/D3HBD7C1FR14.74FL1Q1S9UCB@ferdinandy.com/

As a quick summary: `clone` sets `refs/remotes/[remote]/HEAD` while going init
-> remote add -> fetch does not, one has to manually run `remote set-head -a
[remote]`.

The first patch adds a `--set-head` flag to `fetch` and `remote update` which
runs `remote set-head -a` for us. Unfortunately, with the current behaviour of
set-head this will always print a message, even though a no-op fetch doesn't
print anything, and I think this is also confusing for people who do not care
about remote/HEAD, so the second patch removes the print if `set-head -a` is
a no-op (and actually makes it into a no-op, instead of just idempotent).

Another way could of course be duplicating some of the code from remote
set-head in fetch.c instead of calling directly, but it didn't look like an
anti-pattern in the code-base and it felt the best way to insure identical
behaviour between a `git fetch --all --set-head` and a 
`git fetch --all && git remote | xargs -i git remote set-head -a {}`.

What is missing for sure is:
- documentation
- tests (if needed)
- settings

For settings, my idea would be a fetch/remote.set_head that could take three values:
    * never
    * missing: run it only if the ref is missing, this setting would basically
      allow replicating the result of a clone
    * always (with the other patch, this would still be a no-op if it didn't change)

This would probably also require a --no-set-head flag, to disable an
always/missing setting. A --missing-set-head or something of the like also may
or may not make sense. Alternatively, only two behaviours might be enough
(missing and always) since clone already sort of does this.

I'm not sure if the general approach is fine or not, nor am I sure the code
itself is any good, but it "works on my computer" :) I'm also hoping that
I managed to read all the relevant parts for sending a patch.

Feedback would be highly appreciated!

Thanks,
Bence


Bence Ferdinandy (2):
  fetch: set-head with --set-head option
  set-head: do not update if there is no change

 builtin/fetch.c  | 29 ++++++++++++++++++++++++-----
 builtin/remote.c | 15 +++++++++++----
 2 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.46.0

