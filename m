Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA443FBEA4
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773953351; cv=none; b=dDDOx6PzgR2fty80YzlVDAkkIiY7rIpHq1MD+jenM3F/kLrKEG49ufn/88tA3cIVW2LT/Z6XH63HbAOiBsAZVhg2yY9aRBXYyw63fH39cKFgB4hPcYSQ0r9d8rFgB9bzkA25KpiFqtpCNgngNEsBAJ4Si40Vpje+hTPaFFejntE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773953351; c=relaxed/simple;
	bh=se0e6QJwOrGr8nQc8F06xnqC8uYnlXnqQGkF+PnZFhY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=D7JHZ88fQ79v9SB8rYJvC4jcJK7bZ6FjhXHsaIMy6QDu++PmKsvDzlWUWzvIi1g3fEqujsPfeaiSDfoss5aP1I8nJYYnxcFb5DG0xxfpGbZrkmec7NZ2WU4I8O1wCqI+WOxRMUIR3pGE8WET5amzAZZ42UMuHRyJsNP6W3gWkhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=JJb7GT7b; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="JJb7GT7b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1773953346; x=1774558146; i=l.s.r@web.de;
	bh=X4ry+yaFkEAitgB13VDCT44RXyhGxUBNEAUiCLdKzBM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JJb7GT7bfb6Kb1tpCoT1RAFdbazq0lThEM8HaI8FxN4nsrnLCBiPmfrqM3wtfX13
	 rgzvTU/ASKfeKvO/B1RzhT1YbycV8rbrswSgAZJwCMI4dgWO5zRu63LiwosVvw5n1
	 hHEHT/UZ29S99OUfNUVt8XtdL7iDRd0HKOKYNoFO6996Yzq4vM3Gj6wFhsLrLpkda
	 +fuLMuR4ZpD4FRP0xrqDOTxqChOc9UbRrrM4+N2XR32X+wRGZ68QbCHEfyOmSYAF8
	 53o5aHjEwaaStXW7BBPDacPrx++IahZwx21C0T0hSKnsHES5caREc/c3+ovVodi3E
	 gbdmF26R55CAnz35RA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MREzO-1wFNVl3tAa-00Ji6R for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 21:49:05 +0100
Message-ID: <ad46f86f-2ac0-4802-8e63-d854d594932d@web.de>
Date: Thu, 19 Mar 2026 21:49:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use strvec_pushv() to add another strvec
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+zl9OpE7qUCFHzb/I60X/cyFNI+iqbnp5wkQkoQKB1FmQ/kuPUX
 nNSaUABqhhywBv33Q8PbLLAZPMdL9jhMrlG7GiD02XR0ZyMJGJHoWMUmJAsA8ixiEU6BXA+
 ZprCVXbNC31un4fMJ/iFBa1X9mW6ZyRL8krGAXJ16Kd3GBOMvDPsBaT9/3icwgou+l2y4vV
 RrevHjQGQCkrqIH7cGVGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kwRSe/T0/BU=;4jTVHdBfyEJtJ1TJmktqYzv4yLS
 f9Efy3UHHHeILMkgsrqLR74aK8V7PuQUr5b1S84TJmLT0eLJRKiirlQ880LPr6D08fZffhlf0
 u0XWX3pN1Lj/QaTOmgDoghi6G4jCWRcDGeaiDueSgdCv7Izua9byENNmUf/ZAc0Dz97gW2Hkg
 UrSR6SlrjC3UsTmZUciXOnq34uPfNe3NgtP3jRvnlRxzQT2Wu/TZUfbr8V1DDly9+fbgEXyAL
 K+bfgO+eqbOw1V5ZgSl24Hf40glmrelLPANqk5SRdXmWYUKLcpJI6a+Uxozgok0SCzOnXh7BB
 BPXEiTGUqjbEx1h4Z/Ei2DBeigF/wyi8+418U77t//kDsjDI4sJkTf0ePvp7RLVTVm1p9sHar
 7QFBcFM7F8gJTepajIcR5EfKTxpEGt8bSOf75kFr8Fd4MN3ANY5En/eKwB/LRvnbz+xub0KbE
 V4Tlo0TOO02fZ4U1hMIOKcViNRBg3sllLnF3HURAEDa5NOiENzIVVjxzEVpzVZh5s5FVhgWUx
 /6pdDNXqM3HSMse4+SoNogu0+bsMx/e8cJN7gUTyydxIsg47PMwiJVqfgnzx8y9gm5aNhq+lL
 Tsv90IT8c8xTDAqPSWSEZs5XkMYSk4XOaWHaakUOYeWaX4u+hNG5UJZ3j0rG6/WanxYd0XWXb
 wfITEG0PzmHsKxmEFl3Hky5qUNev77MaOaJbny7w8n2dlgM+rByCfTMiI0ziS0y0krFXByzvz
 chuw1uib/tR4nOxgfkvG+YQZOdHNra4bclWMYlOC/wSS4p0XhqVb9wsxdjVO1t1eNXsmdNO7V
 xGNCisSTzDmzAz9suOE5z3I3W6tecefbAro5YzI5+Ll7uofTLAdePY1cUu2c+3FwOnJNC0B0U
 +TI+X6IHk4HGjR+XuFlUHOlv3pO3aBXI6GKdPAu6rx/kjmdbKnRySyqQ7Ob1HBsaWkv1ThpUt
 s9d2hX89V7ChApSI1RkesJEVO4LX1IJfAQmpZ2pD95RvI41kUneCH36TVXv09fcjbXjgwT5bz
 U6juK7CPdRQ7XdxgCpHYf1XscOKTa+7ZvcM3nWt8LfAQJ5YNaGGh0Ul7ZgAWQ+Jtxnjkm4qPL
 sIaJeU5pBnf3HFwrxzdhq5TKFQz7JAUx3X6CDjMfbFQABjSVAWAvqiSeDOLMAV8CgQajPb252
 NtwNSc3vURP6MR00Bt0g/keH1eJ7Yu+jzX2yCLmlAy3Qf2wtDfwwlT8zT8k14VhumMFiwOtHV
 SnQ3HQTlfjfvsCI6GZWf0kld3DLQmOo2NmiMq6h7jXFiX6PTIFIL6vz+/HF4u2EtAzX+nCQh1
 mpNiNzFYtO1srrKHHQTyZDV3DdiKI3SGNCUyHWNN8bRg97JlsRl6ng5SskPnDjxU2gt96ZK3N
 7QQxIoUUjKvfjRGveSCAPPO6UFI1u4Lk0RJ9Wn000MjlUMFiwcybYX2P7vS8dW/E2aToO7Phg
 4MKHUr21ndDam+QmdYoch3ejV8uvxZJDgJjSV1GCAywPzpf6u7uASORDQkoENm6NZ3xVGlOwt
 8KutoMnVa7mFYVhv7+xMDBmtjJCzQ0oMxPm/iIYDDy91fmcDTWPq4HSISm+uj9OPkldqiC+9g
 33AIWWMBDyH48vKkbY8+GhzGacwni41qMspl8555OsNNHJz/ztJvD9MaHLYVVVROQo18FXQh3
 95vXuQd0J8rU3jsLgTrhSl5lc6pyIgpDt00VpQRWFXzh+u+Kqhw5vFfR4oVovo/jpNStjzs1P
 cUwEr0WOhg1D4N05lHov/jJ1NOVDlADxnkoRL0grTjtz7iPqY+Cnn78az0cfhFZrSrncuCtOK
 0p3R3ltYxEZnQmyfRzCxZCTwlaAOCuA0vVNiRxS3AY+nejfMAHptGpe3jwATkgxDUvibf79tl
 3+eEHRcmkS0YO1KHXTOI50opWkZzK+w7qmyH8AQyTYos7m0oXPZbvpW8f7i2fxPUNWt+lsUAE
 aDto9YxP/QdJ/oP51gD6D9vg3ajdQjjr07ayzXNt7G+AaEoZNR1xt7BrWNR08vi3tDCIe013s
 lgtNOt1WY6AANtytinVLPt+zvcTKy/HZcx/RtcPvWm0GH7uTz+x2kYcAG9OPWJ7NzfDJsa/qN
 rLy1w5+mbHYWpyWErOygjnvOC/ZizX2g7gfQUlmw9Oh/pTQiwbdB0530axTyASS8OAypcD3s/
 lZEGH7yy4VE3fi3ur4wmbNQUjgK8l/j4myD08vHkLh/RCQhqWbIx9Wn1aK7u2/Sl98vIjhvVt
 u1UxiLTuTSXoB+SAuR6jAuXhTz7xBOYKY97xE3BeQ1G7ClDja9NeO78Oj4n/Y4TWiBSQ2d5IZ
 ohThecH6db5WzttXLabmo3HkznxCUIMHjSyc53Tiqf2cKDzQNLd/9HFWWrVwpXaGtSJLUfmf6
 SMRVXwEYb7eIIfw7CiZ4N860SZy2Q3/tVMKX80wdd69MoNWg8hgj6S2QjPRkxh4tkGNpW0Bxo
 bTGDjN6mu8UO7Fi3Ie92hZTSuivou6IyLFV7SJNS2gimreQxAGFN4WKl7DDjmx/uxPN2KzezU
 eeRIWh54UWwhtnDlRiQqJpEo0mlpTDlK2UY9wuFbiBxbh8j1hfp+iN35zb8Z4GF322fqXS5Ek
 TUjyNt5M1kKSDEsA3onRFo/FbLk6Yp89+jOCp3Rxnj71YNlzbwheJtKcJIbXcum8iZIV1lo3l
 VNp0jSpf7rIRbPsSKjWqjiF6pn/ZxUxfVs6CDVGhj/rUyHrCFn1nH4NF6cah41vsrNXLZFsyI
 AkwvlfGKxyWZ2nuQbrGi8zareIjmcdZWMTXyosbBLesTkxwW9rpRDMkgUJBjGXfx/C0GhAjEC
 4wzgzR2ZchhfrIWoR9qcWmK0VFtMiVtcGX+1PpL1KebEqM+FjdNV1a9+lSxztlGM1Olo9ylBT
 6WtdQ2VSSUOC2jw32+7GqpIz8x6wY+zk+TuYzGqhq6Wlx65YB2rd7hH3a3aK+duzd91U/OTzL
 j0m/OWEF356Y/I/zRD8d46PC3CEnYC8oVXAXdaNy5oGUSg2qthGGRxbwt1TpWC7W8bbXauhYf
 yhJ/SG827X8CS6p4w/1xDhZDYHy/OTRPSxptiGxv7Px4YjzCd9mH8sSrW/hY3BoEffyjRh8a+
 qdxTejwFOd1l7kbScNogxtbs7SMEAoOAMzfhWEd3Qug46fWnihSmPQErLpBKqV4nJrTZqDaJ3
 Gnj1Way0IMkQws+Q0wzyOZ4ZA4G+crdZPHm7NViI8PKe8Kex1Isf5DwaqCeJYCg30guiV1YiZ
 IL+P+1qYzNNrWX4nUoCLs9FBF3Ma+OmxQWIzn07sYE21hVtbiM8DurMhLkh6ZIrGmoYZ1kMTQ
 jQ3IA34sJ2zo0TSmD8MrpGhaC6X7VITwYnUBc6imWfx2P0cm8OmLFlKYfSzaC3JdASo6tN9fP
 8c66KzFXj/Jvu63UO2CGMhNsUllc7o7+fAhVyluVd/ykXimTy9hihSfIQoFljLYk+tWiftC/n
 ++gJ7VgRvu21+3lGWFFx2GqTKDPQmqQQwh32wefQx66coLOb52nToNKiG+DewKJvfkPA3VLwn
 aJfJDZObzJdf2DuJz4KLPsghkgSLjjCa2gd1Ssy/oTCmMd0UTWd2/pceENCJ4TrmlmpLV8mp5
 aP2gCdT3SY7MnMX9ho+W8JaZDhfco8aP0p2k1IYJgS2kKsQt0bcYGpEIqcwYWeJ8pCY9jWlAB
 KRuyGOuihBOz3px9yul2MIdlsJUltCsSIHTp6+6apXhFRZM6k08RXMOPpSF3L+NoSyDyhM3W1
 B4zsCerfde8hzWkAp7U2BD3MJbH4ecjdy61hJ3RES5fSRfZWl1CZVxyuNipGy8mCw4QUsPDzQ
 y27emrIxPF1uZgOHpVYCxmpk0vpH9GvswF42bK/Chf0RwFTx9/3UmVbykDsedjMyW1NkRB0Ma
 kvRZJ9r3OdWPqJolng4V/wAoxI5iRKNR4I7aEZgkF+3yfVdKlOV2mq5vqPEOCKjpGQGMt22mk
 7wwR6GwT+8y/cIaQiOUZLbzIIUxporFnLvID0OUWdCNOz3bprwxyYGis9eOt2sYqaVqEiD+w4
 9vGSUXbpe2LXnlBUa3wC+b1y9WXecuvWPwKPCH/mbzVzpjbCLQBnDHyEJl1nxyz5FERtvep55
 7eC11EWWVY9//RBOYmkhS119kW8FVdTMkLuhuDmXHMIrr2Z9x+zKq/LRxp1ZktJsB4wZxZNW7
 8rXXa4DfLrhoKEtpiIXH1St24QV5v1xQGEeaAOtmlv+GisI7Gri1NV/aKTl6PH4x6ci92k4gG
 lfEEHNzHCUgrf8kPG95Kz9atxiRHi6m9OgVnN1RX9cUR/ZZLGlas+d5iASCGrVKv5tFVxbTVV
 ZH1TA+CmM/rvCUtnJcyYVCU3TLBKKXajGpGIgf1AbycJP4VZAUhp75qN+ez61IGmpPd+PfGyx
 KbXlzw2XYJg6JJlA2/nCuCGI42AaRPrYOaZjLvp68BTrD8XNA9PJCUJaTuPwgVh7lohXwjjmh
 kIhPbFUmO+eaUzsl3l8EGsane3kJB5P54WzES61yXWjvUmwWiuDhch2KZGtAMiNCs/zLmoO+L
 iouvXsYeFPgSwUK2dkyCTaAU3UiHk3dOHyqIrQOuMf+BkXfdg+0UHeIBDTw+JDD831qZ32MrP
 N7jvUZ57soLkNWuldNxgeF8m8ZniiDnuIm8zvK+SBSkGWGZ7wr/MgtrxMXN0e63IPWsCArdul
 9N6LtOCVcMWDEw2oDTP1IHpCTTin36apZzhT+GwmUl9ZeFGAiN7f6PDtEx4Btu/P9deg2G9Uz
 KKoO5hFP0fyRq3g+RexOXx4zskodHDG0vswI7Fp92Y0R6aK3LTdZ0hkc0ZAfcnaQcoMH/T6qi
 zrsmWgAN3XGuTEr5uSLpdwRif8BlDlDUlWJ/fx6fCG+1vMImZHRmNJPw7iZe+dCbHXTUC/0jI
 gfe1wMeVRIlBkvg7dyrwtOdmCtw3ndQN3t++y7Fca6NxVdT4MyfDEscE3eCt9R6tEfXTBz5S1
 X8+WFNaUJlQU/ntgeaVxCQYz0LgF00d8SoeAoiksuBn3lPsra6He+Axqx1BVZh28zlBJjk9OQ
 XlEyKvenKej2osCrVtCBAlika3GT/g4KOX/CdvJ2yQibxq40S1YUmQQeAt+4LbqRe+M4ZEaCK
 Kwdj+j19v64D69WMyZ3tPTo2Kn6/8+AZdmMUF5O+nEuhAhaMOcrkUh8PldRg==

Simplify the code by letting strvec_pushv() add the items of a second
strvec instead of pushing them one by one.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 fetch-pack.c | 8 ++------
 git.c        | 3 +--
 submodule.c  | 4 +---
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 6ecd468ef7..a32224ed02 100644
=2D-- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1024,12 +1024,8 @@ static int get_pack(struct fetch_pack_args *args,
 				     fsck_msg_types.buf);
 	}
=20
-	if (index_pack_args) {
-		int i;
-
-		for (i =3D 0; i < cmd.args.nr; i++)
-			strvec_push(index_pack_args, cmd.args.v[i]);
-	}
+	if (index_pack_args)
+		strvec_pushv(index_pack_args, cmd.args.v);
=20
 	sigchain_push(SIGPIPE, SIG_IGN);
=20
diff --git a/git.c b/git.c
index 2b212e6675..5a40eab8a2 100644
=2D-- a/git.c
+++ b/git.c
@@ -877,8 +877,7 @@ static int run_argv(struct strvec *args)
 			commit_pager_choice();
=20
 			strvec_push(&cmd.args, "git");
-			for (size_t i =3D 0; i < args->nr; i++)
-				strvec_push(&cmd.args, args->v[i]);
+			strvec_pushv(&cmd.args, args->v);
=20
 			trace_argv_printf(cmd.args.v, "trace: exec:");
=20
diff --git a/submodule.c b/submodule.c
index cd879a5cfe..4c8c674aa4 100644
=2D-- a/submodule.c
+++ b/submodule.c
@@ -1815,7 +1815,6 @@ int fetch_submodules(struct repository *r,
 		     int default_option,
 		     int quiet, int max_parallel_jobs)
 {
-	int i;
 	struct submodule_parallel_fetch spf =3D SPF_INIT;
 	const struct run_process_parallel_opts opts =3D {
 		.tr2_category =3D "submodule",
@@ -1842,8 +1841,7 @@ int fetch_submodules(struct repository *r,
 		die(_("index file corrupt"));
=20
 	strvec_push(&spf.args, "fetch");
-	for (i =3D 0; i < options->nr; i++)
-		strvec_push(&spf.args, options->v[i]);
+	strvec_pushv(&spf.args, options->v);
 	strvec_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
=20
=2D-=20
2.53.0
