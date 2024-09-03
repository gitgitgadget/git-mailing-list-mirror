Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187A433BC
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401655; cv=none; b=itpZmvl46OaEfHHuo8CeVnmcq8W7VrHIGcpmsArCo3M3dghecsjPPnfCGmFltNhu4jYllTWlKTtg+/Pt3zCVMJwAYo7EI49isctZHA3CxlaG25ci6FjpeJ4duMIktEi8AmwFxGS/t3G59m8yb+0AFhP6hb8VO7OmR2c6j6WD8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401655; c=relaxed/simple;
	bh=xBM5GZRVJkVz+5PfYMM/N2xEgCGmtc+g6dFzOVQGIXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eM4CjIKEhrwFvapSbGLVPjWarMmKt1F6prVfRGlPfYd54qwqzWQmkb2UJkzs+hybkyUXJ16ga34+jjzW1NCssikcdJaLVGTMhxuZpuWvxZtv1Sv9THdMlFrz+dpk3cs+eN7+elwwz8YoFwxdjx6UAud5/whd58814kwJalV21MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=luRg2fDv; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="luRg2fDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725401649; x=1726006449; i=l.s.r@web.de;
	bh=zKhjfTKZgUfjP/MYOMEyDD9f9oSCjkuXrE9ILDj/Cno=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=luRg2fDvHsD2RJAPX02uevBR28q56Teo8K+pnIqA/2YoO79inWGw7fo5+ulWNMFn
	 j6gR3Ht5AJrRdIbh86Xx/ZbWaRlK+QrmZwOneLI09ycHPN9wqyzdMiliXEViUzyIg
	 PPMXNldADMWY3KPlXjUUoCB5BUgoGsdJZFL3cFOHjIt3QM2R//vKb+E74DGvOfHi/
	 bRfbxNzpm1ysI8QKz4v2U/zXb0l7ng/9ZeLAMamp6p5Gogj97pHMgWDgxcFUoIxHI
	 dXq6wkFFEZkFgkyJXkC7ETrzU1pIBgHsxyCaRErLALCEJSjxDFPKGguYhnXed9ySe
	 qZGNIsFNAOFjOG3rQw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.92]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MA4bO-1sw56Z2LvO-005Z7F; Wed, 04
 Sep 2024 00:14:09 +0200
Message-ID: <73fc18f3-9d2f-43fe-b0a1-2f3680f09ce6@web.de>
Date: Wed, 4 Sep 2024 00:14:09 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug in "git diff" exit code with submodule and `--submodule=log`
To: David Hull <david.hull@friendbuy.com>, git@vger.kernel.org
References: <CALpyDwE12kHV--NkbcSgxLacsYw_w1wdBhzM21-JO1yYKW2PwA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CALpyDwE12kHV--NkbcSgxLacsYw_w1wdBhzM21-JO1yYKW2PwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kGKGMizxG9rVe2+33k2XHfMXxCPeImOZPXEIoV+ximqpusdxu0J
 kpWRZ57HDT0+XVhSQ8L6Ln5qtnvJumhUYPmm7YMT4yeEwGknW/bjyZsNNvcKYTLi626TFzS
 Umy3wIx2jArFDj/TU/HWIEqxh+KVTNZflaj4xfFIfBcAOQjDUmiPobu1UZoLWtYlGB5EdmN
 JvnNQxZuu9uk6RG/z+9DA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:n4inzECt9SY=;genkiyp6ZRCNHSoAPQLreJOaR4k
 MJHu64HVBHO38kH+gFKlpt57uqNDwXFk8bHM/2dHtFCIv2rn9RwdePOAJFF4lgLp0KcjQ3xlH
 cvUbXd2vKUtWLCEO3JMmfNchvn2ElT1xNvr20RVhLuIJgRiIVPnnyg4leO09OLl4muhF0qOXf
 WmtpSCKPO6OrRd69Rhca6M93k3trEmIdTqzp3OE1A8OaBgbmIE//cvX2iQ5r8ho711NgwRVRk
 Yin7ZSBzKc37fczkBfDSv6uY4wRWuFergmRuLwaozoqfWC6qYLof72Yl69KhSrdQLoHUfl/2v
 lhcPvoHNwLCRHsBTx+tjIR22i+qwVqDIyPZ8rEKUJLwz4x4cJQVfpNSlmHbEUh5+7gMEQnRDM
 vsrd4qiu3Lv7SicQLka0G01QbfO/XGF6gZXL9IbyLx5XHW9k3R45L9Utcckzzo3ysijvHRci5
 4HVXOxr6+T3C6+EdJfbwGVFzlO+FJJfg0Em0khuIJUYd5Ju9aVQ5WHb+PRpEqBTXRcgnk7ZZk
 bz0jim9qdrbJX1dBqxHhyJ5cwN0ryb/ORyQG8ECIGjodeTYrDa0aSFpI4Oll3FMhunU4Eh8V5
 MYoKpEuToaNFzlhI1PIMiLEM9q5MZ1EfbVuvlBKg8+5cbTiihvvGTLE16WvhxwMsi7W1y6tbQ
 S6nS7UJS9F1eQ4vg48N7+6fSRIALcZ/z1KkB3H1u92AcKYFD6gQ6kPMToHAZ1KtY6pDnKSsWq
 nkJESyIZr3mxqeWkWbSZsUE9Z7CKTsE0OnMD8pfnRpqyVobnOPgIhjBJx0vYdD/42wI82idlf
 VSP/AvQxzvOCYPwrKJHxj3Hg==

Am 03.09.24 um 16:38 schrieb David Hull:
> What did you do before the bug happened? (Steps to reproduce your issue)
>
> Create a git repository that has a submodule.  The git repository
> itself should be clean but the submodule should have changes that have
> been staged in the main repository.  Then run:
> `git diff --exit-code --cached --submodule=3Dlog --; echo $?`
>
> This shell script will reproduce the bug:
>
> ```shell
> #! /bin/sh
>
> set -x
>
> (mkdir sm; cd sm; git init .; git commit --allow-empty -m 'initial')
> mkdir test
> cd test
> git init .
> git commit --allow-empty -m 'initial'
> git submodule init
> git -c protocol.file.allow=3Dalways submodule add ../sm
> git add .gitmodules sm
> git commit -m 'add submodule sm'
> (cd sm; echo "hello" >greeting; git add greeting; git commit -m 'add gre=
eting')
> git add sm
> # This exit code is correct:
> git diff --quiet --cached --submodule=3Dshort --; echo $?
> # This exit code is wrong:
> git diff --quiet --cached --submodule=3Dlog --; echo $?
> ```

Very helpful, thank you!

The misbehavior occurs with --exit-code instead of --quiet.  And with
=2D-submodule=3Ddiff.

> What did you expect to happen? (Expected behavior)
>
> The output of this "git diff" command should be `1`:
> ```
> git diff --quiet --cached --submodule=3Dlog --; echo $?
> ```
>
> What happened instead? (Actual behavior)
>
> The output is `0`.  The output is correct if the `--submodule=3Dlog`
> option is omitted.
>
> ```
> % git diff --quiet --cached --submodule=3Dlog --; echo $?
> 0
> % git diff --quiet --cached --submodule=3Dshort --; echo $?
> 1
> ```
>
> Anything else you want to add:
>
> I believe this bug was introduced in git 2.46.0 or shortly before.

Bisects to d7b97b7185 (diff: let external diffs report that changes are
uninteresting, 2024-06-09).

So enabling diff_from_contents breaks the exit code of submodule diffs?
Then the options -b/-w/... and --ignore-matching-lines breaks it as
well, as they set this option, too.

I guess we have to do something like this, plus add a ton of tests to
cover the option combinations:

=2D--
 diff.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/diff.c b/diff.c
index 4035a9374d..bc2e559ce9 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -3565,6 +3565,7 @@ static void builtin_diff(const char *name_a,
 		show_submodule_diff_summary(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
 				two->dirty_submodule);
+		o->found_changes =3D 1;
 		return;
 	} else if (o->submodule_format =3D=3D DIFF_SUBMODULE_INLINE_DIFF &&
 		   (!one->mode || S_ISGITLINK(one->mode)) &&
@@ -3573,6 +3574,7 @@ static void builtin_diff(const char *name_a,
 		show_submodule_inline_diff(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
 				two->dirty_submodule);
+		o->found_changes =3D 1;
 		return;
 	}

=2D-
2.46.0

