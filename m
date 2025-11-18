Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF483702FD
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505304; cv=none; b=Y0Fbnj/cjOYIYZe1mNl9uUu0D6TrDnXpYpWOX89pF4zj061pjWQG5p892edWuaACH5tQTZSNp+ElLaXoYGDlIP3Cpb7urrfVjZSJyOKhDo7zuqg3y87lJR7aP62EJwSqxiHYLYqreYQvPGIEsxrt+0sR57ETP4VI0MHH+MOKk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505304; c=relaxed/simple;
	bh=1kpjlBQNhp6/PkCBqc10WUbVkprn++cPMiI22ie/EYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjLWQx4Gd8PE/1y69JgIWts/3Gy8Xn8Oio9y//JI303zoHK6K97xwPDwt5TSC5FWxSziXR7nZi0zGvFngGl/v9cEUT/Qx4ZnADzeyrJug8yA7fm2gh53r89fzeRd8SBgvVTaYYO7OhGBLL/mpegE0IpvckPwcLE/TubusrW9Ibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=XXWffq3l; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="XXWffq3l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763505299; x=1764110099; i=l.s.r@web.de;
	bh=KAmI8aM2jkVvtP2oLjjl23aA0GAw6LlkynvZkKWKBx4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XXWffq3lRaWU8dfeRp0Ky/gEMl4ZoFIjFjyBS/XYZKAwrgxpLdoL1dwqQy/sYfpy
	 xVqWwOuaHkletWfwPaX7E0HT2YXLS5PnQPonj9fofT9jAz89icO+aiuarYobBTFKq
	 kl7ZyhC6NOfwpc06/WHs+q/gy8V8QJZKICLNADzTI6gQuHOBxw8l2pgK5s4NumybF
	 lsWLVf/4l6YYquYQwfQrR6r2npQ5ERofzv8806dJs+wngJteBCR3t8ThqxgU3cvwg
	 Pbj31lCF9ENFhGTjUJlscGbf+v5porC6eTyasELCZ7Izuz6dDb6lvRPPbP5eOPMKY
	 pbVd+7NgKg55aJqwxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([91.47.146.25]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mm9Zi-1w3JPm3Qki-00dAPY; Tue, 18
 Nov 2025 23:29:38 +0100
Message-ID: <3b1cb53a-6427-4626-a768-1961e25514f8@web.de>
Date: Tue, 18 Nov 2025 23:29:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wrapper: simplify xmkstemp()
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <058c5722-30f5-4bc5-90f5-24e4c6f3ff8f@web.de>
 <xmqqbjl0iax6.fsf@gitster.g>
 <20251118094621.GB530545@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20251118094621.GB530545@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IFy31CzBjd3Ch66K5xZn11Tbje5AzvkEthsEzgtSYOgLeXrmP8r
 sqYi7w+kWBxfziCPdwurg4uLCBoM799/zc9VSCYcZ7yrZxhmFvPx7hO+w8815boj7TNfEvb
 hBLqaeV50LHolph6oyLYR1T3ImQNyoSOkEvEGxWO1ZyqdnTY6ft8ABrSGktn6IXwKfVBfb1
 rBQP+9+1ik7lPlkGYnmBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1qxhXSqhSP4=;arXZNolhsv0yIPJcLbf1Mb2joOe
 rilNxYT+m2D87Fiu+YpoWzI5aorhEUaxYLpJgUUZZFijB7xBXkj1Hwu98TnQNnqtn3zff8pAN
 vBOBuRrXivseSaoPhNQclVJokRrvXm9BOtMxpf+10ShlY2tdGV17bTY6Z2OqQWgMz1O0Rg/I2
 tf++nmBRC3IZm/9s8D5BLFJNd+pOb9L5uziA/vJEPsKfGaqoC7DbupWtLrPX7IbfDN2L+zAZq
 2m1+N/bhYxlV7d47EjxP+6JzYqJK/b726lNacw+q0ut6JIa17By7CnkUYrsKRSSodo60yI1g2
 8AswxHEXQxNN/b7uIYE0/sazYPm3lxsc9PpbkyuaIPQgbxcDXoOvtlzVxY3m2NHKOQ3PIOxwa
 2XsO4jA13cQZzCHkKCi31QI1Iwk+O/nLBhoRmGLX+p+EBwPvTpLd2aEEQQbRGkgVaEvUxeSkC
 qiBOT7cIXRTX41gfHWvgBdFBMAVW/ejYu0/DxnUylCPEelP6Ql6Mny1PhGgq7jMAULNVkt82C
 E8CUbAJkcfFldQDj6I2lshAnom1keuFB0/aeNqDNM9tnc7oYTI5QQwbZ6vzfnayXjHUpQlVXC
 aoJfWHhFj2QE/1j22xcZ82+clhI5YI2TLPQ7P4jDc7qXyWtbI9uf2X7O7k/3YBNfoxw30ly2A
 Xr6psTTzh7QbYPpK2NpDQDaDQU+lt46e/3WpmZfuxwY4bfnCa7rf4euQ1lBMCOx22boLO87M0
 wj8h/hYzZ7yqnHQHdY84J1IS8Txw1XOM+9B/XsXiU0ZDqKEh14pB00ysT8r1f9nRfMcy5MznY
 edPruGcnPbDXiVdYFTZexmMv8z+e4s+kOqkmTiyVBi0oLSrY9dskMaBIRuRZcwX3b4Ykib9gl
 1SZIiQpvT4dj/TIaeiuVrcCFROBI7ZfF+YZn/BMKIYsMbYQb9nM2q1QsifsA8vig8mUtMebhc
 qwEwNf8MKOjYFEazYqCwnEkRJdHktknb2mrFyROEfYW80cq5t8IiPXIp/7Dzs6XSyuleTsimX
 WkGmZZE58Yt8fpapfIu8Lz6HG1KMJzwjX9Vzd5syKZ2n9OOJLpqovYaQW3DiLrCF+VL4potcI
 ojAuTkYjfW0OKOrD6YGHYj432m51dZSQCw5nBPuNb43BduAY0vLPBmLCd/Josi/k6Ff1jdbW1
 2xnRDoqKJyNQUSpIZ3ButLS3x+Ze0jL1vIChCaoOdaXF+y39gAbHumSIilnnT5LiUKgdbUr1I
 LZ2cxduesWRFQU8BH1pI28hEBSjXUwsMH+Kde2+Ul36Ly36VIRaNehYMWf/AvoULqDIG55lqn
 pwEQRn/tVYTy9ibTzo9Vaow0Xv+/gsklDiwmHwK1P8w7MZgrxWlAclIpoG4w3CMhpmazufjXR
 e0CZ5Y9eNgKGqEdWpfZRml+K8rMMYXi5cEXfMo9CUbI4AMomVit5gqTfuCuyF/AjGRl3ug1HQ
 kQqVig/M78uJBIRJBMBq2MDCTsmBpPQPSHFe211nOvnkni/D1Ni9rgSEJLr0vfpfRiItvLe5w
 8DFktv812dKOBkDFzAK+V5RMU4Xes09sRvacv3EDzKobwgzx4hukXQpmQ7/73aXeNmEVZlNfS
 w8GTPkBAAMAcJ8FlKDM+4M4eCoiAqqlUqMnYXsDBi2K/kNPeS4EcG77mAgr0mpU1N27pfRpeG
 pCBq3R27CrN4xBtk89ToqMcoNjNdNZxlRcBmOZjTfBS9fwMWyFELcu4ZkOW/DukKPRzwrh+RP
 cxG7fjedc0xMdrkSJT6a9PrFDUrNLLB4MlhCHwIqHEClCbGZcf8xzThyNv+3YY78L1WNeqkCL
 PRpr8awMr/GB7mojQriJ8zQLetMdbDKv79VI60LVDZOdj43c5bWlUDClSQGGjD5y1poCMlW8P
 ry2kEmrtEdPOigdo1jW9qX3v69IPdasCXoDQ4eK7JsaHY18juMtnagLzUGGUqv757d1Skv89G
 RHec8GBGS3BnkzmonsIQdGZwVKqzC/9EXLlr8j6pJVQUExtZe1t0s6xpg6+9CXM9xDe4SQt/L
 7OceAybxw7BCb9irGD+CJ6DiSEBlZzRIGsI8YQOpfpkTXVZ7+sA4d5M+BmnklzWngArjlPlAs
 MoxcFxcaFJf17pUGm06eAYaqKAedzeHKPdl3sRouozxkJreepqHKj8OKfVMDzhKg2LzuHv5Vs
 CQscfHS7radw+yFEiAKs1QO3bef5CShfHXcq7YVt3DE8dY9x94ZkMuY/7Z9Frgr4K/J5rTbCZ
 bGIuSNYr6JiTyjeESyEVH7IMA7Y6eh6zMqg82bangi0hsIPtBU2e5oMlzxkmFTPfm4/k3vLki
 fUNe29PC8TBnyIe81mdEvyQjjaDXf3zuScVllY/+oCqgdODKfW3cgydlfCOnLe4WA7eWNVotv
 VeSOSYwg7yw2G8VG9jmdt7ivgJxkLfogL5AncvkBPpr59X5FGfinfl4WVN9Ecd03NkMzqQ7wB
 EhRXIe5Atadffi1voQJjbTkYtk1m3QezlqJzLu4udgQsk7ghYbeklSz8M2PBnlvZlGG2iPMuO
 MKr16RVOSrnO0mJGJGf8XZhRaVDoeYt5TY0d2GlSb/CEwPiK7cg8C+o+Y3f/EL4euXoLIGH7P
 UOynYDiVdkh6CWZA17FO6mhWOpSuoqJGtPOEJTac9UmxT0RdavK2RxwsdaOevMLshG8GrW/Kl
 jrKLQPsfkJUwUhqsfTpocvRC2aAcQ1MoyYzgujcNb+6MR4vUJBLk3MtvPh0ucNjfsuSxedpph
 3yvCLQYuFrLaMtlcHowMVWa7OKqhhwUGhKhULdDRocto2qUoRU3jqkwQa34/BL6jaKObteTpN
 7rVHZivFmGMMjUTgyo5d1o7TmZ7DtWnXTA3XvLq4D+9ehvytw9zRJ+geCEQKxVi+MfuNDzh15
 +OZTKHK/JAdIz6jLq+b4vkK0CTB8XkkuQlVfs1pRN2jOq6wY8+3aWM2kbbR3WxSwz7EbyXnE3
 QpQ1CnU+PM+UzwMY2SzPCZAMpJ18LWo6aDF+/IWVKPQdkv5iOXh0MSWb8rZqP8yCk3njqIaWn
 ZdkG5tBMF2thopC4Uq91PBit0lUb8eXhbuRMCSgsRqFycKxsI3xx2Amidw1OHWHcYUvz9rF6t
 12o7mlQEKyXABKiJKX8Hh1nUXkrlP73vUhOHupLZLTNTAZ6JjdoGDpMGZFLB4mU+Lo2JWyLV8
 LV5tevKnP5rZ6DcQWAukWvY3r4so5wKzH23IgSaE8Mne1pkHrTgffteiuLc++763Jp2qqmCmX
 +sKLq3siZjkMAXdz6Nfe7cT8ckzvrfm3Ujljh0YxOoRtCFqtxOkXOIgu9CpPssL9fW7jJbdv4
 0rwwg+J7LPbCfZmz15KP51CGk3tywuD/xNs6jFKa/8lCpEHiZevzfmo6Ut+/YnSowu/x/nzlt
 iHcmEaUlYBgzJ4IG1AATGYGrudALaW6aaZ3oJVRv0CQ4tRH/sw/KspURFNdxDpILubGymXfGH
 qEWyBZD3cd23t/ssiHrNaf5Y0tFqcN8BGo72fnOBs7tkMw3wLlgBzraacQ5CqBkLhSY6PA76Y
 sL+0Q7lmbUjsd6AIfP11dw44VOExoGan7CX4RScu9ehodAltTsQlalsSGhZNjoMHniAC1n4Fr
 HkTX0ZdADwAm4867RDpNjyHeTZMmbIBl4CTKh1G0Mzkv2QV3XDrLGeEaYArNHu3VYCwtEtC8K
 2Ri9hjDwTJR7jCcjK0u2MM5EGgb1iaidIdqTG+hBJq8FMVo0tL8KtwEm93OjerQWqvzJ3AMJa
 WueoyWeBdigYVrxdN1dgYke6dFeyTR0CibHjJxr1pVO4jFVnXNRdMzJlu7/6BjxKEvebExoKP
 JovvYMZj0BrbPEOK/VZ3L+oC2UlIo8DTkH5sdJfOucVLSGGTVbS5n+rU2afj76i4eSZ53RE+j
 Om5VTxuSbqOYsjVCLWAlenbsmUS45Wg5eUZzbe6YphR5o4knFboQu+xVCScMVtZC6RrWN0h9K
 sqlbJAsJn0mDdnnidxWbsWPRi66F42NfQ+UXs0tXQi0bMzJgLP40yFvfNPFlXnwMnhc9xMD0/
 17Yl0Pq2rdcAGr+CvBqzZ3hc2Ak9hSiZdzPWJNTYQTI1QasSFsVugiFC93+NH+iHaOpvFxm1o
 +htjUV/e0BfyXj+lWxuCxVt7xzzFel6zBfqz5q23/hxvhpV44BqlIJPyv8M4zm+/6VrKoG+jJ
 E/hEEyMMP9GcFpwRDx7IJPXh2ZEnh2wnFqiWBQhWGe3+a0+8kDM7lbx+isdgx5536UocxjRez
 uieFbAs78DQ5Ol/a5i/kxup/uBAZigD4TuB6JokWhWXSxc95GW7NiNC3rv2EUxLlQJOJufP9b
 UU8ad0ByyOnkSUJfADal0O9tv5zzHT7TgUm6mNJMdJrf9KTjLkUug+QwiRI43sDe7kPymM0pc
 z5BEzkSgSmN+e92OfT0+sxZtCErB0YZcJqFBomSSSjfzhpw5lpo97tCyvE+jPjFPYmhP+Rmpg
 cFw6dF7Itg+TBZIc45Ndgez8VpghJ4yRAxm4IKzi1cb88fBL5iZ5n+M33vNQSLx6n4RahrgD4
 Ffy6rvV7UFdve1E1xY3QJVaglAyxwPCoGFJcbMvvHvgMT7eiN8QwHSGPRK9TcUcoGQjaCGVBt
 Q69FZEC8t5f+oRlf9izo4glKQHSTcnOU28dvKwpOoZmpjVTOX+C4UJ7IXgn4WUnNmcSz5W7iH
 x8eFfsuUxYMvj83Iz33Yz1oqNaPGZTXUhZhysRHw2LMyz9eGOwOzvC5vFeDkMKzECWHUB8/xd
 KYR+gcUMUAuh3Ru++bP3YcSpFjkT2HnmrYNAa5+OP4K961/J/xrO1X1t6vZVc1Wsi3zQFgq/7
 /EvjGSOiTO9SmfGzwA1saIqzT0CXV6xw2QrEKdLGK0VOejMwW9nI5c21ZguGfU76enYU+rJcL
 0DKE+1NIw8lyyvorYd14w32WDxuafY6TKF2SNOYTbECUHnx1LLHZtjpia1oNtTC9h70YuZ7rp
 KCV//2dD19mCJMzBptolrttvTJnwF5mHDqF6+oghIbXzFRdB1auxLSjCrR/QeWpNj9qH5bpvE
 s1cQw==

On 11/18/25 10:46 AM, Jeff King wrote:
>=20
> I also wondered if we ever use mkstemp() at all after this patch. If
> not, we might want to declare it off-limits. Not because it is evil, but
> because our own implementation is more predictable (and we can drop the
> compat wrappers for mingw). It looks like there is one more call in
> entry.c's open_output_fd(), but arguably that should be calling
> xmkstemp() or git_mkstemp_mode(). But that's out of scope for this patch
> (I just thought I might nerd-snipe Ren=C3=A9 into looking at it).
Thought about it before, but couldn't bring myself to ban mkstemp(3).
Its only faults are lack of features (mode setting and suffix support)
and not being available on Windows, but apart from that it does its
job as advertised.  Which means ... it doesn't cut it for us.  Hmm.

=2D-- >8 ---
Subject: [PATCH] stop using mkstemp(3)

mkstemp(3) works fine if you don't need custom permissions, a specific
filename suffix or to run it on Windows.  For those cases we have a
custom implementation around git_mkstemps_mode().  Use it for the base
case as well, for consistency across platforms.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 compat/mingw-posix.h | 1 -
 compat/mingw.c       | 5 -----
 git-compat-util.h    | 2 ++
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
index 631a208684..57915119c6 100644
=2D-- a/compat/mingw-posix.h
+++ b/compat/mingw-posix.h
@@ -185,7 +185,6 @@ char *mingw_locate_in_PATH(const char *cmd);
=20
 int pipe(int filedes[2]);
 unsigned int sleep (unsigned int seconds);
-int mkstemp(char *template);
 int gettimeofday(struct timeval *tv, void *tz);
 #ifndef __MINGW64_VERSION_MAJOR
 struct tm *gmtime_r(const time_t *timep, struct tm *result);
diff --git a/compat/mingw.c b/compat/mingw.c
index 736a07a028..dc3da7c6d5 100644
=2D-- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1174,11 +1174,6 @@ char *mingw_mktemp(char *template)
 	return template;
 }
=20
-int mkstemp(char *template)
-{
-	return git_mkstemp_mode(template, 0600);
-}
-
 int gettimeofday(struct timeval *tv, void *tz UNUSED)
 {
 	FILETIME ft;
diff --git a/git-compat-util.h b/git-compat-util.h
index 398e0fac4f..0e6bd266cc 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -446,6 +446,8 @@ static inline int git_has_dir_sep(const char *path)
=20
 #include "wrapper.h"
=20
+#define mkstemp(template) git_mkstemp_mode((template), 0600)
+
 /* General helper functions */
 NORETURN void usage(const char *err);
 NORETURN void usagef(const char *err, ...) __attribute__((format (printf,=
 1, 2)));
=2D-=20
2.52.0

