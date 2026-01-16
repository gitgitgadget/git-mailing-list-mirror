Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F892EFD8C
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768596169; cv=none; b=iKP6zz+KQbwLAEuKjlYS+2zqZSey6/aOQk8kTBGLa1n9KYhh+th2Cl384OWfeM1rrFHiWtJkmxGfQpmJnhGwtHYxzkDew/Hluax5WyCISotYEm6IzfAEeFi3sXvsuI7dZ4/qNUt5LWLu1WvQAF0QBW6obqpLXSlMB/4uEc9RcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768596169; c=relaxed/simple;
	bh=MQOWGslgtMSTM+BriGZnDcUsJFp8Lm/+hCYEHlqAVkQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=oMp/i8Z3E5oMSosBoDl9cOgPUavB3WlRHl71HrUP1ZNpl68Ri9kYzJ0/TNxegFfUBxxaTKVP+9ZLm3Y3cG2ScT052COqyfF7bDdS5cAdfmd+OmsHh+USt8khHLn0yX08Hr/Wa4XI7chV9KUN5fY+Z0o3SuR71+c1fxWJ51RyUCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=PHDzBwGy; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="PHDzBwGy"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id gqbhvtpffkJhVgqbivUOEM; Fri, 16 Jan 2026 20:39:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1768595986; bh=1DojMO4t6RGhpCbvLgszXnvD/4pxfOZb773DKhLTw00=;
	h=Date:To:Cc:From:Subject;
	b=PHDzBwGysoXgEGm1RCQm7vVyGNF9ZHkEG8R6aCQ1jDoX15cBeD3oh4UBISQ6NLgfZ
	 Hd6/xtUKPGdKDpKWUWme6SzBVvhCtCjmtdAywobjIkqKXsfVRzBbbWRz5cnj49DKLp
	 ZQHBpgJRqupKDdyGQJvg/EwDcocH0+pPsZISNLQuTqpDViN6xP69nHXeVbPiAbZbbE
	 KC3bspmbqJgmE//60FkSburNvFqcKElHEq984ZSQ/viugHbE3NmpeiDA3oVS3uy/tc
	 ILzMw9ab5epZ081XditUoCOL2lSY3xtyHY1rZvcioepl3dnCjR0KsIQJEZRbtjGk8U
	 Gfr6TOI0qUitg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=C+5KyhP+ c=1 sm=1 tr=0 ts=696aa212
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=RMdYD1IlY8hFOmm90WcA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <79d1fba5-8cd1-4fa5-9424-7ab77da0f5e0@ramsayjones.plus.com>
Date: Fri, 16 Jan 2026 20:39:44 +0000
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
Subject: [PATCH 1/2] t9700/test.pl: fix path type expectation on cygwin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIxDkUixQtfZ8pWVDB1+DWIvDKRZo704u9OOQ+LyUliQMlzq4gyunMg2h3/5o1cjdHp8HqVqIJ2lratzximCObzq41UNpH0tIB3OdCjJ3wvbg/CiUo0v
 9PmNMv8+vkqSVmV4qV3yaE37Ny5XTtQytu9ROEhiOCz6N52W0F6Z3VPgjC1GEbWJ1oeYpUbguonBU54/QfAdikTkiDErLhRvByM=


Commit 4ec7ac101b ("t9700: accommodate for Windows paths", 2025-12-17)
changed the type of the absolute path to the git directory from unix to
win32 for both GfW and cygwin. This fixed the test for GfW but causes
new failures on cygwin, since the test expectation is that it uses unix
paths on cygwin. In order to not break cygwin, disable the new code by
removing the "or $^O eq 'cygwin'" sub-expression from the conditional
part of the fix.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 t/t9700/test.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 570b0c5680..f83e6169e2 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -118,7 +118,7 @@ sub adjust_dirsep {
 
 # paths
 my $abs_git_dir = $abs_repo_dir . "/.git";
-if ($^O eq 'msys' or $^O eq 'cygwin') {
+if ($^O eq 'msys') {
   $abs_git_dir = `cygpath -am "$abs_repo_dir/.git"`;
   $abs_git_dir =~ s/\r?\n?$//;
 }
-- 
2.52.0
