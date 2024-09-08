Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A291B85DC
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725779064; cv=none; b=Siet2o994dsbR+atmVNAg6Wr2hFCgEtXQn5Z9aY40/Sl2FOo9OET1DOhvqQh/CQnSl9e8bi2TKOVtJke0UqIBwp80vVtNTz64RIUgJnKeuQChkdejl6xymvk0jCC0pgS5C+3O5iBJy+Xxdcv/A5lKussxOpOPrLVblScuHY17fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725779064; c=relaxed/simple;
	bh=v9TW35FVdkjRny7OmKzSITaMrvylmpEOMx9iGAghXyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bY8W7dKFUSCRdyyaYRnbQCyxHKpYrUciwkhoXgv+DMhLSZ7gwmBR3+vmHWjBfEw8q02kAYFuYc01L4Bj1A1ox8iHOMfOtydwZ6IARZ+9kTM8mriCEgqEVou6DU32lLcjGeIrbF67mWsHZdXW3oyzA0qDWNlO3+kFvR3VQdqLvoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=DQbr4uJ2; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="DQbr4uJ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725779051; x=1726383851; i=l.s.r@web.de;
	bh=8voZgm94fNw13NL8VwNWDzg+EdbSJVR2rNz1aIAx9n8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DQbr4uJ2bnhcvrRUN7TTEss6E0JdbSfSADrWcLcGXsPyZ3SaBCFmRc9eFjKk22H6
	 EzSXZozcc7tyeTXelVvvPgOD1kutudbOVwlRMFs2zegjZljVHL6MciX0k8bR7KW+q
	 gELXwmbP7OGu3QV+ssC//cI0DDwcyS8Z5IEbdYNpdwzPzDvLfBRw68DxSi0TUmByQ
	 gjNrnmKPhU6CVCIbJ0YbC6J+YxuBpkhwpXB0CFa0k0pQVbX6+R0tT3zZLhWb/2qtj
	 ylvUP/SAfiAA7zsngviqJDjRndfLSG8Z4r5PBauq4/AlFQC83Q36WJ6upeLUtkINq
	 UMbi9a1E4szh3VWhQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.211]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3qY-1s85r71ZL0-00jF63; Sun, 08
 Sep 2024 09:04:11 +0200
Message-ID: <b21d74b6-aa51-474a-a8be-40dc1de94bc3@web.de>
Date: Sun, 8 Sep 2024 09:04:10 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug report - `git diff --quiet --cached` returns 0 when a rename
 is staged
To: Jorge Luis Martinez Gomez <jol@jol.dev>, git@vger.kernel.org
References: <0241cbcc-11b3-483a-8a63-d523291b92ff@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <0241cbcc-11b3-483a-8a63-d523291b92ff@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HB7AuyAGLdQU49U86WMNp/MCkJh1zUJQWHl7nj04Iz8rziY7Odp
 8iPvqmXuRpzWTKzjVo36VuciBLHWIutWrHmzx+QLNGbG7K/MsMgVJwiHeidpFDKES845cWs
 8wFiNOpQHyEDt4jG5CsjZtJqc6DSv7gQnl1DGdAWZp01UMktpm2saLDvguLxSEXC0nnKseh
 3K9F0IlLoHU5iLOdJ777w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XE23Ff6MotA=;LVCY9b5NIdeJwBQHo0haxSLwR/j
 y0R3JFlErlm3RT8Lhl26AfBP3Kq1dBIAzzzed2rcym/OKwwYzhyaLpu+G8Wepd3yy6iUPvFjZ
 /IoZXBXh5eyNwci9liALzdJIXLIDwvpvwWcNnY8CPlh2gVbwDcPgK7Nr0Ne0AuVjeIKwwq7ok
 9TiCUVEKJpR8df1V8BpbRhWFfQ5fK2xs+U6febdVHmRzba+tsyRP9H6vM+suARC216t0x9MlZ
 X6pZrUkgz8M1Z9SRTTrbDKoIvUOJa4KPPQFZjGyeLAD2y8JrTbflP97pmYeUWLl7i3xzU72o3
 mVS1hcIIf3v2a4S9icKX/ThW3igXWINtsa6EYFSomSuuSkp5WUU8j9SFB2zvAJV+xYSSCYiJK
 IG9B9xE+zr18SbzLBZK6fbIbtHM08+HKj8cs75n6AEAcg1KzzCVX7L5ajM8mfsYavknbPtvqf
 byzNRCuC36UyNkAVSGy+mCPq9qr5H//Aat3bJzO5ev2Y9vaV+NygOHPQxSZ4KNQ9dQRunOQmd
 2KtCXy0RgHT7PsO6DgnsJWALGfR9xzKTJenGZW8djtzmx5BcXM42wD18LlrlU3Fd0qowmiOBm
 286Gla8IwXCPIhbKi3zzRW9dD6RJT+f4uw7VXNNS17/h18wGm3jaCn8jPcL75CGzKJm5376gv
 TK9lcn++wi0l7iKdAo/kw2r3Q2FBwItFbzaJzh5qKDNUOfWQlg8dOemDEkh13NzOA0Ryzolpw
 PjaFVmkLsaHitfVj/eqYhrypnZHET/H6Qi09Q5mSyqkGAL0JXkEb5gk1m36lUkRHVCS+sPX/I
 Dmm6ZTY1RaorJUXPOHCUhexA==

Am 07.09.24 um 01:12 schrieb Jorge Luis Martinez Gomez:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
>
>   $ mkdir /tmp/git-diff-test; cd /tmp/git-diff-test
>   $ git init
>   Initialized empty Git repository in /tmp/git-diff-test/.git/
>   $ touch foo
>   $ git add foo
>   $ git commit -m "foo"
>   [main (root-commit) f60d7bc] foo
>    1 file changed, 0 insertions(+), 0 deletions(-)
>    create mode 100644 foo
>   $ mv foo bar
>   $ git status -s
>    D foo
>   ?? bar
>   $ git add foo bar
>   $ git status -s
>   R  foo -> bar
>   $ git diff --quiet --cached; echo $?
>   0
>   $ git diff --quiet --cached --no-renames; echo $?
>   1
>
> What did you expect to happen? (Expected behavior)
>
>   Versions prior to commit d7b97b7185521e3b9364b3abc6553df2480da173
>   returned 1 for `git diff --quiet --cached`.

Thanks a lot for the reproduction recipe and for bisecting it!

> What happened instead? (Actual behavior)
>
>   It returned 0.
>
> What's different between what you expected and what actually happened?
>
>   The status code.
>
> Anything else you want to add:
>
>   This bug report originates from a PR I filed with Magit here:
>
>   https://github.com/magit/magit/pull/5221
>
>   I thought this difference between using `--no-renames` and not made
>   sense, so I thought the problem lied with Magit. However, like tarsius=
 in
>   that thread points out, this is a change that happened recently with g=
it
>   and it's not in the release notes. After finding the commit that
>   introduces the change, I see the message mentions "The new options are
>   off by default, keeping the old behavior." It really doesn't seem
>   intentional, so here's a bug report.

Indeed, that's a bug.  Affects copies as well.  And could be triggered by
e.g. --ignore-space-change or --ignore-matching-lines before, like the
submodule diff regression reported earlier.

Ren=C3=A9

