Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A922F156F45
	for <git@vger.kernel.org>; Sat,  2 May 2026 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777713781; cv=none; b=tS7L6VeDfj+9rVZ0vnqeA9ICYXJ3GTVik6bnXTd4MrqA9ceR8OkbJ0T/NC8rRZLsChRaK61vIrVF+OM1mEaTHHuaMQfa0qkIZMSTV+n/rY1e0QdSIyZxCv4NAC9Zab1x1nqCD+jG+6enLfHRbQVFtWt0Y2Rym8lf2bFCA0ZiqYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777713781; c=relaxed/simple;
	bh=S4RL+Pf4hZn+HR+KkeVwZ3b9OTwgP3+XCEwkadNsZYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ktDxo44yLNAn7dM8S46bGRZUCo0GJPYG0/zR4d337QgrRDT1J6xDFdHhi/sJJghrHqgfk+i3SRQiUyOk1nxWoqCWlc3p1IkPvZcFDwvXyoB90/jroJ54hC62bF6XjgKqsqUyVXnfZgkZV/vFtk90dkO+YsWulYppu8YeEUYih24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=JndwqJje; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="JndwqJje"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1777713769; x=1778318569; i=l.s.r@web.de;
	bh=SjpiA6rrk5sPnzew9WEiQLVSJxiXaMwHavQewTs2v6Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JndwqJjeDqIvm7Tz0ckkPKpvbQyOCB8jp+X+2opeCW8FhU23k7d20kJp2r+hlmHV
	 ubfBuAxQ5y8YBmAwc+kx95FxP1iQwHVS0R8z0Qweex1pzOgS4pWEeCviAlrbCX+XT
	 CW0LXL7TELaKGvCKSAN0hpkNivoT+1oXAWs0NejMEB4/+DWIoQRtwskRmL5cIxPVU
	 2VAmW2/csYZlZKSf3du3T1WnJKyws5QM3zHXitsCxGMcLETl7Sm4xZzfnEke9f8aF
	 cFFAevww0U0yx7dMHuzFGPN8D9lD7lv9Kgtmg6SkXGjFpiTKcyiQca59B97bZET1k
	 Z9AUCxng7//rMUDBMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N62ua-1vHAAL3CBs-011Eb6; Sat, 02
 May 2026 11:22:49 +0200
Message-ID: <a5fd970d-fd78-41bc-98f8-a6a87a7f39cc@web.de>
Date: Sat, 2 May 2026 11:22:49 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] fetch --deepen truncates history in v2.54.0
To: Owen Stephens <owen@owenstephens.co.uk>, git@vger.kernel.org
References: <CANOh7gEEw+6146NN3JV8EYxQarj0KkyA7r3RZ6v-DxeqQZLrCA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: =?UTF-8?Q?Samo_Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
In-Reply-To: <CANOh7gEEw+6146NN3JV8EYxQarj0KkyA7r3RZ6v-DxeqQZLrCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hQavugdsT43GdS5H+xOgO8je2TX+uSgjZ3EQFu+PJABnBUXnfZc
 cjaaYBrc/Ke8c8k+Qx5truVxceBg1kodJaIX8+qVCOp0ngzu4BNamUTcO3EYkx1wBdjrG44
 0oxC4iTYKqgNUfWItvGchVTVfRpPdv5L/BBtIAsT2Yxz99yNgsFzwVvDD+v+gqXkEMMBXo9
 LILQs8/53wB6XBQussPwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cS7BNC6yW/E=;eMAJ29UV2TWJpOMF0ypr07In4o8
 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
 lr1ASPTh87FvJuQfxvouQ3qE65qYLhzPhyGA=

On 4/29/26 1:27 PM, Owen Stephens wrote:
>> What did you do before the bug happened? (Steps to reproduce your issue=
)
>=20
> Repeatedy called `git fetch --deepen 2` inside a shallow repo that was a
> file:// clone of another repo. Once all commits had been fetched, a subs=
equent
> `fetch --deepen` appears to "reset" the repo back to being shallow with =
a depth
> of 2. A reproduction script is included below. This issue appears to hav=
e been
> introduced in v2.54.0.
>=20
>> What did you expect to happen? (Expected behavior)
>=20
> I expected `git fetch --deepen` in a non-shallow repo with no upstream c=
ommits
> to be a no-op.
>=20
>> What happened instead? (Actual behavior)
>=20
> `git log` history is truncated to two commits, and repo is considered sh=
allow
> by `git rev-parse --is-shallow-repository`.
>=20
>> What's different between what you expected and what actually happened?
>=20
> The previously-present commits in `git log` are missing, and the repo is=
 again
> considered shallow.
>=20
>> Anything else you want to add:
>=20
> Commit 3ef68ff seems relevant.

Indeed, bisect identifies 3ef68ff40e (shallow: handling fetch relative-dee=
pen,
2026-02-15) and reverting it fixes the issue.  Copying its author.
> The following script reproduces the issue in 2.54.0, and does not reprod=
uce the
> issue in 2.53.0:
>=20
> ```
> mkdir repro.git
> cd repro.git
>=20
> git init
>=20
> for i in $(seq 1 4); do
>   echo "$i" >> file.txt
>   git add file.txt
>   git commit -m "Change $i"
> done
>=20
> cd ..
>=20
> git clone --depth 2 "file://$PWD/repro.git" repro_clone.git
> cd repro_clone.git
>=20
> echo "Shallow repo? $(git rev-parse --is-shallow-repository)"
> git log --oneline
>=20
> for i in $(seq 1 3); do
>   git fetch --deepen 2
>   echo "Shallow repo? $(git rev-parse --is-shallow-repository)"
>   git log --oneline
> done
> ```

Nice!  Here's a test for that:


diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 6588ce6226..fdb1dd9823 100755
=2D-- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -251,6 +251,16 @@ test_expect_success '.git/shallow is edited by repack=
' '
 		origin "+refs/heads/*:refs/remotes/origin/*"
 '
=20
+test_expect_success 'fetch --deepen does not truncate' '
+	git clone --no-local .git full-clone &&
+	git rev-parse --is-shallow-repository >expect &&
+	git log --oneline >>expect &&
+	git -C full-clone fetch --deepen=3D1 &&
+	git -C full-clone rev-parse --is-shallow-repository >actual &&
+	git -C full-clone log --oneline >>actual &&
+	test_cmp expect actual
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
=20

=20

