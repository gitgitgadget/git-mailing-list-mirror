Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7A02DF70F
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765618847; cv=none; b=BHEN+BeZ6O+noR5kUPQvetSl8f5dRXxDDbGNUie97aS6nimwRdTgADOnVCq3J4IZq+Sz5MZUB8MVx42LGhkRI6OIcQHH8oEZ5slEaGRbRjtOUqav0ND7iyQOtf32SA0EBcXeGB34UGzBhYr2xjoMWpZL6Brzmkin2oZP232aSkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765618847; c=relaxed/simple;
	bh=VO/Qd1hoA+COGtq75OLfJjjxd0djQq7VHsad//H/gh8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=eQEbQ/sSlPGFKWHFIYeYcAtPTrPlCndvKBP1Tz/m/i0KXYEElWLs4yXLuvi3uUvqjnHQ0Ll/JQV39r5S2U8S9mAXhMvUh/r2HjeriHyZ9U917IvRzD1tw9uprmkE3bPazt+7Tcj3YZ3Exv9bt9naQqtwNxkpeo+w2i2LFbX62y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=bsWJ4fKv; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="bsWJ4fKv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765618842; x=1766223642; i=l.s.r@web.de;
	bh=twIHWMrqqM8Wxv36Un+6bvn+T0mDpIN7OxpuFxrtrjY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bsWJ4fKvKIEQ69+B7ycMnrfjgoZjijf9AsQx/GlXPAMQyRu7wj9yVmFpDzaQpQK6
	 Yq7uTsdMrPKvNiOw0dFOJENcd421iZH0fn4PXsW3xw/Vn3LxpvumNOPjdBb1olpHr
	 ejdU0XOFv97yQ9K79gJf/V4EWKjoRGUv9XouZubFfYPb0m1fSigFV8wuQk3ZobkEy
	 NV1IgKZ3e0LCMeaLd7uE72dtPraJqkkUkNhBFscCxcwaZ4VKL5OW3NkeUDZTa+WwC
	 ExGrY0QKXjYy7oqqqHAdxnpB928jIMXTtqPOPb9RjQtwj4X3XJ5pAOiUZhf4QheBx
	 p3ZwiSLiepLFZJy7/Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrwrx-1vp3st3EdZ-00hjo3 for
 <git@vger.kernel.org>; Sat, 13 Dec 2025 10:40:42 +0100
Message-ID: <b79cba1d-f32b-4034-979e-fb9528d05f18@web.de>
Date: Sat, 13 Dec 2025 10:40:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] t4014: support Git version strings with spaces
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <eb0e6533-44ef-4b85-b1aa-f43f6d4174a4@web.de>
Content-Language: en-US
In-Reply-To: <eb0e6533-44ef-4b85-b1aa-f43f6d4174a4@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8bqL5xDeR4tHsfm/7MtOHf5guXAVuwMPe5cDSKb/6ZB6bw52jZK
 Uc1nYHBgZauY0Rm+YaUKTPBs7ngCmT3tJDjBOeejiLckTLEvCmJbqlynq17Tf/M7E2YjhBy
 Ov9bOGnWSTmrxjsp9gusq9KGarsZMckqtHE0yYAPdLdFGZqFOFDq8LNpMdq76dtmw7y3ytE
 e/XQBOde1saavFj1E3zhA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wvJvA93aDAo=;9Z6AlZbT/4tv3w5VgICcWJAjxlm
 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
 47+SAJUcMTrbzmohnYdzGyDaAWeq3mBJQo3Plv

git --version reports its version with the prefix "git version ".
Remove precisely this string instead of everything up to and including
the rightmost space to avoid butchering version strings that contain
spaces.  This helps Apple's release of Git, which reports its version
like this: "git version 2.50.1 (Apple Git-155)".

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1:
- fix description of current removal pattern in commit message

 t/t4014-format-patch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 2782b1fc18..21d6d0cd9e 100755
=2D-- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -980,7 +980,7 @@ test_expect_success 'format-patch --ignore-if-in-upstr=
eam HEAD' '
=20
 test_expect_success 'get git version' '
 	git_version=3D$(git --version) &&
-	git_version=3D${git_version##* }
+	git_version=3D${git_version#git version }
 '
=20
 signature() {
=2D-=20
2.52.0
