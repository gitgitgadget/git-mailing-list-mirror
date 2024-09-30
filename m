Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD41170A22
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733843; cv=none; b=K4+sfBg8CHwTwxydVU1bqb2/8+ohq6R1leIFOne0LzABpaoUq8fsCkcxfOjDFbsWpvmF703fMJ7cD9644olkSqMRWKUGjoz62EJWQ9gy1X8cxI4elkgrWRPO9x1FxtCXxqGXfTOG4tWZMeRqu+YWop5EJqtGK4YvSh5NYbrr7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733843; c=relaxed/simple;
	bh=04w+uS7hplBu0fkUChowTAdoZMn9BPmjmn2Fw2+S00E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xlj+4Nzco25v/gIcfGWPlg44wMdIeqLC3OKaUvQh2bHDD5lmzjrlq0r3ojB8SxKdQwrz/piKwqPvV+ysXDNiXls1n/319LxJMjxroNSX6rHRm5ZC9piELyEkyNQT9hoUPjBxtCYQX0Kh9/rPeqx23PA84SRtBC9iTro1LWtRn0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=b9Z5b6XH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="b9Z5b6XH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1727733840;
	bh=04w+uS7hplBu0fkUChowTAdoZMn9BPmjmn2Fw2+S00E=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=b9Z5b6XHKFF56qUsEd4RXJd/TdQ3tJQMuMMUKTnxrCvuHAIuS4mTsJ1LbMPKJHHfW
	 c4M5RXwsNtFLkXi2BlfPrlPpb8eeUy3XPHjtkIedzS9W4ECGCNpfuZ+z/28Nw76nzl
	 1mVPUIoiiEBSeGrVZrHG31qjNUQeCUzWUHAz65wgH+edi75zDZk0VFrsstd2XtcCPU
	 dJWmyIhZAgl3v/aYyBxRe3DPv9UXon46BFUrftwLF7EpQrO8s9jXZBnwdwPxegGv+m
	 g2Pe0+4Ux34p1W4omfUqHJt5LYjn4IrwvnZbZHUSezy1XXaYHpnqNxKse0Ff4qNedN
	 s3Raf77ci9xatN8RZOyqWlHE41cICKm5a3Rs91Apuo9vWTgQMW7FsIU94Z4Y8uuZs2
	 GUmu4Mwh0EDqSzUuNRskKGTlbuK1+WSJeXVsrANrjjhLgjIiZDbpGbEo9NpDaaMp+h
	 l/ig9jJKwD+TaPrtC4hMv6LYhT8Ezp3ZKaMCBnbzejNlRZK1Sbt
Received: from tapette.. (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5EFD32007E;
	Mon, 30 Sep 2024 22:04:00 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Emily Shaffer <nasamuffin@google.com>
Subject: [RFC PATCH 0/1] Typed errors
Date: Mon, 30 Sep 2024 22:03:51 +0000
Message-ID: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've discussed, as part of the libification effors and at the most
recent Git Merge conference, the possibility of typed errors in Git.
This would be useful because it allows users of our library to
understand why an error occurred and what to do about it in addition to
knowing just that one occurred.

In addition, as someone who has done a lot of scripting of Git in my
professional life, I've noticed we have a plethora of different messages
for the same problem.  As a consequence, it's very difficult to
automatically map all errors where an object is absent into a distinct
error type, which makes automation hard.  It would be easier to work
with Git as a scripting aid if all error of the same type produced a
uniform message that could be easily parsed.

I had indicated that I have a design for this, which I've improved with
feedback from the contributor summit.  This is, therefore, an RFC that
doesn't wire things up in any way, but is suitable for discussion about
the approach and design. It may be that we eventually adopt this
approach, or we may discard it in favour of another, and either way,
that's fine.

I will say that the fact that we have a pointer here is useful, but it
means that freeing memory is necessary.  That's inconvenient, but if we
choose to adopt Rust on a larger scale, it should be much easier to
handle by simply using a `Drop` implementation to free the memory.

brian m. carlson (1):
  Add a type for errors

 Makefile |   1 +
 error.c  |  43 ++++++++++++++
 error.h  | 168 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 error.c
 create mode 100644 error.h

