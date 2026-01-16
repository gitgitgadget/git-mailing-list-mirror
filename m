Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390632ED84A
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768596180; cv=none; b=kJ1/GPk3L/WDT7xwKhk+gGqMCc6Fiv12II9kH1SDhJrQmZlvOMYNf6NkV29xa/wk6TNOknsuM3wDFEB0QQc18TPZ3Z6gAwMlE31lreU1+SdimzTTbIgF6A/6I1oNuMYXpO8cWQ3Bd2VawjMxLkpBzu2bHGdc1OMV5aihzGHyRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768596180; c=relaxed/simple;
	bh=l7SoYMU5XofmYqBNOwt8bK5uoDfYuBat9IjpI7gA1MU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QWLcB4fEr1YdpzD/t4xyL2EiURRHRBej9Hj21U7fXF26SdPw/w/Kx8nFCUo7mAfFqmCZsbdqC95H9KtOiZ9gYxxbqIz63WRHrnY/B1Fkjvr7Uu+y3aof8KJcTEK11QJsUFdS4LxuEUTYcZVoOvvukmy+WaSly62+OEViGzZ7FnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=UfirhZ2q; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="UfirhZ2q"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id gqbsvtpidkJhVgqbuvUOES; Fri, 16 Jan 2026 20:39:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1768595998; bh=3Ez5xCr4j6qmZjwx/NZ0PcmuIxGMkX4Mx+DMxuLo7uE=;
	h=Date:To:Cc:From:Subject;
	b=UfirhZ2q7hAUcAN/v93oQdqQLoel0COwHFVsu8Ogy9GaJ66vhJXfSFIIq/voK7C1O
	 ApT15KLyrH8+QVY2kuyzsdoaaUIKbldvDrw3XZUxqeVKWuRjldKC2sGhHoIwcHPcBJ
	 bF/g6+/zPgrJA6B9ma5dDYZmoZfoE/HZBb5vN3MzBJ1GNTgkKT+2QeJuKZsYqYkApO
	 j3XmGMy6cK5iB/eEfvZo4Tf+jo2Pp50XEk152LlFQ0PcSAQ+Ix5HNDU40j/oreiIJX
	 0Kf3deTwncJuXrsot+agrVlL/MQe7GmbtxbSC49FGsRio3DXIopQqearll4wrXJ2CQ
	 hbSVbPK2VbnNQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=C+5KyhP+ c=1 sm=1 tr=0 ts=696aa21e
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=fUSZDwcxntXz5Iget8wA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <f46e023b-1925-41b2-9842-42e7cb727056@ramsayjones.plus.com>
Date: Fri, 16 Jan 2026 20:39:56 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/2] t0610-reftable-basics: mitigate a flaky test on cygwin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGkB+jYD9LEu7qh20IirN1rU/tz59eibS8NYgopDIH9tr4d5GVjF7lnb+fSeMhQOy343Yg3h6m8Q5k12WnuMC1a8PHiFnSh8KGtYqBJFnYKb0BYPLnIX
 0XDtwSfzZ/V137XpQK+mzve2pTjs5X2yroDi5eUPzgeUFdQ/TY/vaCh+wjdlFD0GVUqxMLmXmkClxGPN7klxk8zQU+OlK/ThIIE=


Test #29 ('ref transaction: corrupted tables cause failure') started to
fail intermittently for me (from v2.52.0-rc0) when running the testsuite
with '-j8'. (Also, having moved to a new laptop and windows 11, rather
than windows 10). If the test is run by hand, or without any parallelism,
then it passes without issue.

When the test fails (e.g. 1 out of 32 parallel runs) the cause is due to
a permission error while corrupting a table file:

  ./test-lib.sh: line 1010: .git/reftable/0x000000000001-0x000000000002-d89bb8ee.ref: Permission denied

This corruption is done in a shell loop, directly after a 'test_commit',
which uses an ': >"$f"' expression to truncate the file. Adding a sleep
of one second after the 'test_commit' and before the shell loop fixes
the test (it is not clear why). Replacing the redirection shell expression
with a 'test-tool truncate "$f" 0' invocation also provides a fix, which
could simply be another way to change the timing sufficiently to win the
race.

During a debug session, I tried looking at the strace output for the
shell redirection:

  $ rm /tmp/hello; echo hello >/tmp/hello; ls -l /tmp/hello
  -rw-r--r-- 1 ramsay None 6 Nov 10 17:25 /tmp/hello
  $

  $ strace -o zzz bash -c ': >/tmp/hello'
  $

Similarly, for the test-tool solution:

  $ strace -o xxx ./t/helper/test-tool truncate /tmp/hello 0
  $

When comparing the output, the differences seemed to be what you would
expect and, if anything, the shell redirect probably would have taken
longer than the test-tool solution (many fcntl() calls to dup the stdout
to the <fd>).  The call to the win32 api NtCreateFile() was identical,
apart from the first (FileHandle) parameter, of course.

In order to fix this flaky test on cygwin, despite not knowing why it
works, replace the shell redirection with the above 'test-tool truncate'
invocation.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 t/t0610-reftable-basics.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 6575528f21..e19e036898 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -207,7 +207,7 @@ test_expect_success 'ref transaction: corrupted tables cause failure' '
 		test_commit file1 &&
 		for f in .git/reftable/*.ref
 		do
-			: >"$f" || return 1
+			test-tool truncate "$f" 0 || return 1
 		done &&
 		test_must_fail git update-ref refs/heads/main HEAD
 	)
-- 
2.52.0
