Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B54273D6D
	for <git@vger.kernel.org>; Sat,  2 May 2026 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777753608; cv=none; b=B6Q3jrL2NZAQEbDESAJblZ8PN6NEnZJjD0zpuPoaXFU3AIdhQGcNYxNSa5nOh2gTsGuY0iJBuZSKG59JE9Sv589g/YCaOG82R25IaZ3x2Pk3CSXcFd0kcDmLtmXNgBULZBfd56tqnw0mTLaKkFrsbC+18E8Gp8818WB1csJKDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777753608; c=relaxed/simple;
	bh=W+Vn2MNi72g/VAXaLaCJ2OpO+Ojp7xZs0DIUBPznYJ8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hP25xDWAU3mNz8hOv3gvR5u23JTqazuPg/juUDZ2WkyIbnW21AlXhzzijKuY392KkcOJW0waag9Qs1upDutOkH2JIMK7RNzDLrOmEWCaW/8kWOO/e5aPRLlFfonT7F0S6L96nKyBqOyiKyQQKybpvzogfC1llkuff5j+TFXj0HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=aJTrG9u4; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="aJTrG9u4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1777753595; x=1778358395; i=l.s.r@web.de;
	bh=BvJll7dm2lBTDn6pnKNpoNuvum/Z9fuZM2ZQK7Z2ODw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aJTrG9u4oXgEinR1QjrRd1HH7i3HX1BuB9LV6gfGb/BCwqKykTWHN+9drz2gVC2I
	 iy4MO4II5u+3OE40KwPnnswcnDeTs33KNDAgNiYN10s0s8eYtMKJhdoqixS4+F2N2
	 w8qN0mWjjaqJXx6R+PsyMjvn86ik00ToaSQIdRbVsovXfryAuMUFUYELo/tqIf4/G
	 7zpVt3s2YJ4dE5Cwxfl3ml8hOp6N3EJeij8Sjz3rQP/2svSvt6PcJ0rUkL+29ki4x
	 iVy1kOIe9b1VODkheIg7IRQSBZRa549BmAJJT6PrUTC5dk3RtGZQHTLWzs9IdgciL
	 pIK3xvp9lS7sVr6dyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MF2gW-1w8HTv0vQ8-00AEPT; Sat, 02
 May 2026 22:26:35 +0200
Message-ID: <e39f6770-fcc4-49a2-b3ba-5ac2ec9e047b@web.de>
Date: Sat, 2 May 2026 22:26:34 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] fetch --deepen truncates history in v2.54.0
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Owen Stephens <owen@owenstephens.co.uk>, git@vger.kernel.org
Cc: =?UTF-8?Q?Samo_Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
References: <CANOh7gEEw+6146NN3JV8EYxQarj0KkyA7r3RZ6v-DxeqQZLrCA@mail.gmail.com>
 <a5fd970d-fd78-41bc-98f8-a6a87a7f39cc@web.de>
Content-Language: en-US
In-Reply-To: <a5fd970d-fd78-41bc-98f8-a6a87a7f39cc@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DVqnVAb+gHHEqsP+9lHyVFSaUCkTBStdlLhprreP6g0uyfp1XL9
 5e9UyVoZFhG4HwaOfhfMsDL7WV5KUcurFEqHMr5ktl8jDVSkvmIkGU3eJWcIkv7n5uoH52z
 tp5B6FTIEBFQunxtk9uSCuIB9NpLZ1C6VlZPIbKzFhmHDqFiLCJcqGHesjea1kdcHJF/Wnl
 iJWwORdVQgfCvASE3xmuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IAeDWCu54b0=;PV2QOuYasDJZvb32LQfDzefkA4O
 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

On 5/2/26 11:22 AM, Ren=C3=83=C2=A9 Scharfe wrote:
> On 4/29/26 1:27 PM, Owen Stephens wrote:
>>> What did you do before the bug happened? (Steps to reproduce your issu=
e)
>>
>> Repeatedy called `git fetch --deepen 2` inside a shallow repo that was =
a
>> file:// clone of another repo. Once all commits had been fetched, a sub=
sequent
>> `fetch --deepen` appears to "reset" the repo back to being shallow with=
 a depth
>> of 2. A reproduction script is included below. This issue appears to ha=
ve been
>> introduced in v2.54.0.
>>
>>> What did you expect to happen? (Expected behavior)
>>
>> I expected `git fetch --deepen` in a non-shallow repo with no upstream =
commits
>> to be a no-op.
>>
>>> What happened instead? (Actual behavior)
>>
>> `git log` history is truncated to two commits, and repo is considered s=
hallow
>> by `git rev-parse --is-shallow-repository`.
>>
>>> What's different between what you expected and what actually happened?
>>
>> The previously-present commits in `git log` are missing, and the repo i=
s again
>> considered shallow.
>>
>>> Anything else you want to add:
>>
>> Commit 3ef68ff seems relevant.
>=20
> Indeed, bisect identifies 3ef68ff40e (shallow: handling fetch relative-d=
eepen,
> 2026-02-15) and reverting it fixes the issue.  Copying its author.

Here's a simple fix, but it feels like cheating.  A proper one should
live in shallow.c, no?


diff --git a/builtin/fetch.c b/builtin/fetch.c
index a22c319467..310099b96d 100644
=2D-- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2664,7 +2664,8 @@ int cmd_fetch(int argc,
 			die(_("negative depth in --deepen is not supported"));
 		if (depth)
 			die(_("options '%s' and '%s' cannot be used together"), "--deepen", "-=
-depth");
-		depth =3D xstrfmt("%d", deepen_relative);
+		if (is_repository_shallow(the_repository))
+			depth =3D xstrfmt("%d", deepen_relative);
 	}
 	if (unshallow) {
 		if (depth)

