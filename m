Received: from outbound.st.icloud.com (p-east2-cluster3-host7-snip4-5.eps.apple.com [57.103.77.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7B43FBEB3
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089283; cv=none; b=mOk03MXUaxtfYo2l6/h/8ldiD4/qClPqaZOi1JfPnl54+PDnig9Lhd0Irp4/tFweK5J0JEs4XOXYUvF6wpaa8X5r1kAC7RbFFOaQTVNltBpXxyXkTPO2bAybRoy98ofz0re5q1cH0cUV1bwNXFcP/cOp1jRNYNh68AU+jMVp6XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089283; c=relaxed/simple;
	bh=lj9RLFYyjsLXugSkZza3TXmlhY246Q8m5NPknkxOtsQ=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:To:Date; b=e2wgb1H933z9O9B/BCFC4s9WOjryZQlx5PsECtYWE2236XK2tvmo933Mtmg8TXzAViNdwY8XVfeo7B3L2RC8XKKxDDOF6A1whrBLW0mNhPygTVOMDHr98BctZbfEsvLUkxE0RU+Z8PAPD1O4mI6l903u9wBQEzOj8VaGU5Lrj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=sWqM7D+e; arc=none smtp.client-ip=57.103.77.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="sWqM7D+e"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id BF61D1800A19
	for <git_at_vger_kernel_org_zrn2851626f813_a09p4603@icloud.com>; Wed, 10 Jun 2026 11:01:12 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACksBTUQeDx5WFlZNRAJCTQtWC18ZWgRBF0oDVRcOVk1YHlwDRAQcF0sZUAx3BldeWhdeTVEPDxlaFFwYU0VRH1RYQQ4KWhIYXBRcUFgeRhJWDV0JGRhGXlAbXwJCDxwTVhUTHUMZDysISgRDB0UCXgslEwlTVlsTVRdGCRkIXR0ZFVoJClcBRXhLBVV1Ux9Je0ByQANfc0kUQQUpdkYERXw8AltzXHZFD0xzBFQHXQVdVlACWlUSBEAIVlBeCF4fTBw=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1781089275; x=1783681275; bh=QqQiRwSHIOYjpS6pTf0TxJvsgyAqy99egqyMooGJkUw=; h=From:Content-Type:Mime-Version:Subject:Message-Id:To:Date:x-icloud-hme; b=sWqM7D+ey2xQo62ANIfR6UNaThNQPvv6lPut3zIFUDU1JcuI99A3VJq9/4ISS3xmYwVpsrTAYs8Gp3NEseCZFW86LKdCUKwhQlF6PnoW26QtshhUAiT4PR9+V4c188sYhW9eBiO/5JvCVwZLm5zv/LGtrdaOc3CP7Otm4wy5Wh58/DLm5CDQz0R8M+KmWS6cPn3QkB6gLIW4DvZWcsC/XVA1qjhZ/+SINnyxF5SzvD1R9iWe+rONueG/WCEImNEjOBDVG+7cuZxjqZxKvwsL0LUyCNyMv27qMqxc0HqVjGP+w0DCu3hXwVOB2VKlB1cKliPTtFTpMkDmPgiLWWNgGQ==
Received: from smtpclient.apple (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id 963C018005F6
	for <git_at_vger_kernel_org_zrn2851626f813_a09p4603@icloud.com>; Wed, 10 Jun 2026 11:01:07 +0000 (UTC)
From: betel_taxis4h@icloud.com
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [BUG] rebase --update-refs emits unqualified "update-ref HEAD" into
 the todo
Message-Id: <35A368B8-9B8A-44A9-96DA-65ED16D7D564@icloud.com>
To: git@vger.kernel.org
Date: Wed, 10 Jun 2026 12:00:54 +0100
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-CLX-UShades: None
X-CLX-UnSpecialScore: None
X-CLX-Spam: false
X-MANTSH: 1TFkXHxoRCllEF2wBa2cfRVh4HwFNEQpZTRdkRURPEQpZSRcacRoQGncGGRpxGRA
 bdwYYGgYaEQpZXhdobnkRCkNOF1JyRmtgbGV1T3odYU96RklCSH0TTGYeQxoYQHhjE0xYEQpYX
 BcZBBoEHxIFGxoaBB0aBBsTEgQbGRAbHhofGhEKXlkXQnJfQ38RCkxaF2hDa2trEQpFWRdva2s
 RCkNaFxsdBB4YBBgfGwQcHREKQl4XGxEKRF4XGBEKXk4XGxEKQkUXYBpsZRh4GmttRHkRCkJOF
 2xwYHlAHWJSaRpiEQpCTBdgGmxlGHgaa21EeREKQm4Xb1xiG2NnTH5IHhsRCkJsF2AabGUYeBp
 rbUR5EQpCQBdoem1lZkBCGhJPbxEKQlgXYVpwGW0Tem1+ThwRCk1eFxsRCkVDFxsRCnBnF2x4X
 UZPHmx9YwV7EBkaEQpwaBdpT0hMfmxzWF9GTRAZGhEKcGgXa2hrU0McZBJCGm0QGRoRCnBoF2J
 yXE5NRQVjU1ppEBkaEQpwaBdlEht+SWFBZ1lSbxAZGhEKcGgXZFJrHF4STF9BQ3IQGRoRCnBoF
 29nXW5AUF4TS1ITEBkaEQpwaBdgZG15QH5/aWZ8HxAZGhEKcGgXYmhDAV5MXn5weEQQGRoRCnB
 MF2x8X2YZbFtBUENBEBkaEQptfhcbEQpYTRdLEQ==
X-Authority-Info-Out: v=2.4 cv=W9k1lBWk c=1 sm=1 tr=0 ts=6a2943f9
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=x7bEGLp0ZPQA:10 a=07kmp8Wwd-MA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=sgalKznxOHDm0tBmlUsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xXlAJFO_eP7KePlchbW9fL4i02jRI9fr
X-Proofpoint-GUID: xXlAJFO_eP7KePlchbW9fL4i02jRI9fr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEwNSBTYWx0ZWRfX8ukVEA6B8sE5
 flsX7a7uRqdoLlAzpeBs9P0STgbBdkDsVZMFxv5mt+GdD4r3SYG6c2pkorLWgaTnUQXwqm1hfKy
 JwI6mqj5e2Bx2kpX2ohcUEdArkjCU647M6j0t8YpJmH3XQltvkHyFoSkyeiLbfnRHZJQBYrfG0M
 rCx2vhSByuKjBM1NH2s9DFzfgMYsvVq1PMq8LzqWmTGpB+0p5wy7SUPv9BeKcWDS8/13bXAKdEd
 W4do0Dc3S1b4rycjB+Fl7NiBsiYqUgB3i0Um9jhwWgpqAtE6MdjgSLEVaOH+7JmbJJ5aqIqhTbt
 SGLEQA0uGQQlc2FVxSWRUjR53ILbv8wz2ERiOHpjohG3UhcuQcWjqm1RJMsCeg=

What did you do before the bug happened? (Steps to reproduce your issue)

With rebase.updateRefs=3Dtrue, an interactive rebase of the checked-out =
branch generates a todo containing the literal line "update-ref HEAD=E2=80=
=9D, which git's own todo parser then rejects.

Minimal reproduction (plain repo, no worktrees, no remotes required):

  git init -b main repro && cd repro
  git -c user.email=3Dt@t.t -c user.name=3Dt commit --allow-empty -m =
base
  git checkout -b feat
  git -c user.email=3Dt@t.t -c user.name=3Dt commit --allow-empty -m c1
  git -c user.email=3Dt@t.t -c user.name=3Dt commit --allow-empty -m c2
  git -c rebase.updateRefs=3Dtrue rebase -i feat~2

The generated todo contains:

  pick <c1> c1
  pick <c2> c2
  update-ref HEAD                <-- emitted for HEAD, a symref to the =
branch being rebased
  update-ref refs/heads/feat     (correctly placed; this one is fine)

Letting the editor save the auto-generated todo verbatim (or running =
`git rebase --continue`) fails immediately with:

  error: update-ref requires a fully qualified refname e.g. =
refs/heads/HEAD
  error: invalid line 3: update-ref HEAD
  You can fix this with 'git rebase --edit-todo' and then run 'git =
rebase --continue'.

What did you expect to happen? (Expected behavior)

--update-refs should not emit an "update-ref HEAD" line. HEAD is a =
symbolic alias of the branch being rebased; the branch ref itself is =
(correctly) excluded from the update-ref set, so its HEAD alias should =
be excluded too. The todo should contain only fully-qualified =
refs/heads/... lines.

What happened instead? (Actual behavior)

git emits a todo line ("update-ref HEAD") that its own sequencer parser =
rejects as not fully qualified, breaking the rebase. The only recovery =
is `git rebase --edit-todo` to manually delete the line.

What's different between what you expected and what actually happened?

git generated a todo command it refuses to execute. The unqualified =
"HEAD" should either be expanded to its target ref or omitted entirely.

Anything else you want to add:

- Reproduces identically in a plain single-worktree repo and in a =
bare-repo + linked-worktree layout, so it is not worktree-specific.
- An in-sync remote-tracking ref (origin/feat) on the tip adds a second, =
valid "update-ref refs/remotes/origin/feat" line but is not required to =
trigger the fatal "update-ref HEAD".
- Workaround: unset rebase.updateRefs (or pass -c =
rebase.updateRefs=3Dfalse), or delete the "update-ref HEAD" line via =
`git rebase --edit-todo`.


[System Info]
git version:
git version 2.54.0
cpu: aarch64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
gettext: enabled
libcurl: 8.14.1
OpenSSL: OpenSSL 3.5.6 7 Apr 2026
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 7.0.11-orbstack-00360-gc9bc4d96ac70 #1 SMP PREEMPT Thu Jun  =
4 16:40:25 UTC 2026 aarch64
compiler info: gnuc: 14.2
libc info: glibc: 2.41
$SHELL (typically, interactive shell): /usr/bin/zsh

