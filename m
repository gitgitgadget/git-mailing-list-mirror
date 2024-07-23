Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD913D628
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 06:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714577; cv=none; b=Ngn9dKWHLMUcnufLczQDhdbA1Po7wRGWbQIFdYfy0mBv2pVHTwZZGSlZdViPpwYSEgA4uMQFmJxjAXc1sDqj/B51e5SQRhxbdHqTLtWFgVVvRXPu1OV1eCA5UNA572UeGmbLk20gaEZ88g/2S0L+4kAFa+Qo6bxykhU8K8kWyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714577; c=relaxed/simple;
	bh=kl9uEYDAyVl+/jkxsoTnlNmS26WawF80ZKIgJ0cNms0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Bgc9slf3TkbZzxmFClexLokp2GVCgAXH/NueKMRLF6suZrOPM9UbO0Qnxlul3qFU2Sm1ylCQ/SDqS3IvugycJp3DTaGUAFyXogVsmirKD/O8qsBH+285SgI81+ksRoZvbPeEWOz/VWxYH2otJJSKoSYkvG8Zis9JLeul+tq1pkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=lJboQ/KO; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="lJboQ/KO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721714563; x=1722319363; i=l.s.r@web.de;
	bh=FNjgG6IhRnfTFLIfKCr4DCKjmLOrIwNbbYPTpSGD8pA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lJboQ/KON9oVAITn4ImMfohYQpwosRQQ9liDFUYiNVmWagybl5jS96+/2wUquFHB
	 6r1WwfSfFWEia46qZD84CupCKR+fDM20k+6uS5u23Kzfnra5D34NPGy4nyMgDZUIk
	 ffhyPcYzVwJJquJCNXsnxhihELf2zsGzZIy3VTAslSEyQMVGbSfwfVbOj5UMXe+Gl
	 uk+trtmfZ3MoAQiPpqhL5YlJTsAbQ6Me/+aN8K8ApcjWDK0m+6m6h1JhM7iyHjYBr
	 T1EAPFdOdDVa3cKzNyNmuKrkNrvJTG6r1cQzroEt9PmWYyosxktqh6oJG7PYucVrn
	 Zfo0EZxtAWPuW9PZPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXoYQ-1sopAN0FgK-00YU5q; Tue, 23
 Jul 2024 08:02:43 +0200
Message-ID: <d92e5854-e916-49eb-a79e-9dc43778a7ea@web.de>
Date: Tue, 23 Jul 2024 08:02:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] unit-tests: show location of checks outside of tests
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Josh Steadmon <steadmon@google.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <da7ed537-1c8e-42ec-aa91-49e1319e8c68@web.de>
 <2dff757d-3c5d-4923-97df-26bcb1c21230@web.de>
 <CAO_smVhoobWpsbYHnHJqTj7TJJ1udo_UaGdbOnUqe5jzL+tyaQ@mail.gmail.com>
 <xmqq1q3lb4me.fsf@gitster.g> <be282096-49af-4d83-b5f7-8b4f1b447edb@web.de>
Content-Language: en-US
In-Reply-To: <be282096-49af-4d83-b5f7-8b4f1b447edb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X4pdP/TIympIicQf5d5JRq6uTuooSMgMmD4Rl4PnuM3t6tklZvu
 UYZNZhzCOAod0p7xv9U63sbBz+LJbDcASriUAp19XETOuufw3F5yu4Kva3RHwnOeC3s+Imi
 pWpHYJHgEUFUkqGXednSdFufvzKOWPtbJDzENL/AkSM3+zdIek+nloVl/nt84H5nCaDhqug
 mo+1tV5aWcyg07xPiJYEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N7wtdwhbWIw=;7HL91P1ZtKcGLIl3fej/yzOcLLh
 ZmX/gkH/DaUAq13G5I8D01EereT6TLd402QGGoFh5nkW+ZAhhu/RpMjUHIz3B2rG6iJPGZLrU
 LMJRWcFNoYkp30h55oWtgsipL0rgArUG0/OPl63RAKILjPZSlmJ7gFyJ4xAEcj7AbzyTRGMQC
 Yx/nV6GW9MB7k7wgSLHl4BN8Nbe384DYzbiA8Ud3STqzoKte9h1zxA7fJo2s9qrxjELNcyk5j
 ll0Z/ZQRsqQ19LkOWK+SYTOQgwWwY0LjbJbBgNx6o8qFU1TM4DlZKUeDR6wJLsx+Hvx1dHYCd
 IqpCVpuicrissSRObaOO6Iq96sfg5RoMEDiv3PBrKoqC5T7/W2v1xW9rRx7CMimr8Z1J08wNT
 IQX7ltLlMQMoDzcgnr+6BrOdyTVxeIFDuASMfb+djqp1QIdpY/aue0Mtp+Jz/7kbg0BT0sgyp
 BTEbf2O6uIP/n5UpUmfwrQ/qdhVIpjzLb8Zd30d4fpvDB0E+N0H6wj2hebZEa9wgujVZK3wTp
 5emcD9/otlUKubMY6X/OLVTkxTSY5p8cLaWDNghMVDRcWZ78uSi0EkxeQhxhi48LFykQuIKi0
 GQyMGznxNwoUJgTXcsvGDY/kTeZZJkbeQXHicwhNLA4tEhzQh1row9Q2k0TKlgtYLYDdRTe+R
 p4scZg03MFEU8zNbZcnv/ytagoARb6ZKiB28HGM9V55sS5Nv2grnwQCYsKJy5yc3zm0WP07/6
 j1q+RQOngICbh2RGZd741PhqAcC1mv/4eWPPTyZ/GtlBYYo4QeHorM38iN1b2vd7nnYssaPve
 oz3HHLAynidD96VoXQLKvHlA==

Checks outside of tests are caught at runtime and reported like this:

 Assertion failed: (ctx.running), function test_assert, file test-lib.c, l=
ine 267.

The assert() call aborts the unit test and doesn't reveal the location
or even the type of the offending check, as test_assert() is called by
all of them.

Handle it like the opposite case, a test without any checks: Don't
abort, but report the location of the actual check, along with a message
explaining the situation.  The output for example above becomes:

 # BUG: check outside of test at t/helper/test-example-tap.c:75

... and the unit test program continues and indicates the error in its
exit code at the end.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v1:
- Set ctx.failed to report the mistake via exit code as well.

 t/unit-tests/test-lib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
index 3c513ce59a..989dc758e6 100644
=2D-- a/t/unit-tests/test-lib.c
+++ b/t/unit-tests/test-lib.c
@@ -264,7 +264,12 @@ static void test_todo(void)

 int test_assert(const char *location, const char *check, int ok)
 {
-	assert(ctx.running);
+	if (!ctx.running) {
+		test_msg("BUG: check outside of test at %s",
+			 make_relative(location));
+		ctx.failed =3D 1;
+		return 0;
+	}

 	if (ctx.result =3D=3D RESULT_SKIP) {
 		test_msg("skipping check '%s' at %s", check,
=2D-
2.45.2
