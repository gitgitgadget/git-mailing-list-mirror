Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CFC1A9F91
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450356; cv=none; b=cQQsQH+nmGWyJgh1W8ff2+dEVcxrCQW99z0tg54MLBSmPL0DbmCRleUSiWAmFDeL6nI3SG6/2kyBZpQegoUcSwVyQykcRG2ddusu0HzdaeQ+mJLlnnvOC47nb0M9mVRXIkjdJmpojOXoX5XfcxsKy6FCL52mn0J7WfahtkAICjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450356; c=relaxed/simple;
	bh=KWshOpd9PMJDTacNYXPU6oIt+cNDsbCk6FkuzuiG+EU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PiIcxpkFA/7wwaj2VC9Iftsk6xMylTD+I7w2ajW4oPfrJvFIEVGDwlfkyVQCwBKdeg8bpsB2Xfmp8DEXid2yUpvdFIMblvnyML6j+r3H3gDCRPehsgQt+0de5TRPYjUIlTALrAFqBIVL8y5Rx9Nz+AdKeHhBEorMGRI7vsr6eV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ft6vPB2/; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ft6vPB2/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1771450343; x=1772055143;
	i=johannes.schindelin@gmx.de;
	bh=XKRiEmpZMEWaPI8NrB7ivuxfmdRQqmR4u0BmfaLjqOY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ft6vPB2/vPQzZDYiJwaf/+QlBeHjjw4I7RNetVB/XVF8RtVYFlJV6ms/+1ckOCTU
	 ipJSqIuern3PCCUQmMK1oA4iKTqjYGTa4TQ42n2R9OIAO1xGwVAjwvdHKl1Tq8MQz
	 PCHrO1GF2fMEBvJ6NKp7X0Bl70VpTexudYgXNBg6HxCczEtGGpgH3YciMlW8EyQMv
	 afl5Gui57Bm/qy+VfukRfe3C23I8En17tQ7NidBCraY22filaS36nIuk3WQgiNXI9
	 V6ItyA6ZiTNBv0CcoqtPAUwTs9VJd8clX9Emzzov5rGKZ1QZZKR5XyNbFYjw+EucG
	 6oCqhvN1vG0CgQznNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.214]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9yS-1w9wIe3zl4-00Yf3A; Wed, 18
 Feb 2026 22:32:23 +0100
Date: Wed, 18 Feb 2026 22:32:20 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>, 
    Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/7] ci: make test slicing consistent across Meson/Make
In-Reply-To: <20260211-b4-pks-ci-meson-improvements-v1-5-cb167cc80b86@pks.im>
Message-ID: <83168201-9c26-4ece-51e1-1931d4b38443@gmx.de>
References: <20260211-b4-pks-ci-meson-improvements-v1-0-cb167cc80b86@pks.im> <20260211-b4-pks-ci-meson-improvements-v1-5-cb167cc80b86@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4uFGd6XvrAnegDZWTDxQlJlLJuTAmAU3nPNKFq0evyz/pJiz2hk
 GRBbq2yPBvq3/CM75SkwC/FVDGUSQhNkXOHDYow07zZNLPjkWytY9D9l08Iza+08F4K+G7o
 Ec3twxpSYhCYKPsmKn51qZJkOBzhNhXrp5UauM8xdNMTNuKguVV/T5tgOgPnDjzdfPgPKuw
 WXoELsB+OoiOQN9BkQiUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CqhidBO8Zas=;LPUSzvZmnKSHuL2d39j7du8fzOx
 zImjegPBF8XWikJgZ3UOM9b+ldlRx3Nk1SL05V+6f76Im0/GbJyjM+cRZuV1hrGxT1eZmaGho
 Q3YMOul5OS11dS7VoJ3pik7tL/Y/Na3r2IX0eC7pmdZcRhnm1TJzRC51nQBKOl3Tn8uEIcaOQ
 g81LeqfHO7C7HBPtSEhRY27K3dv3YBOOGorph8a+ajRX7RMJzRfG2DImQtYwRmZld1Bu+PXwg
 6nSUuUyuA0681c0J37/FjhlrU6LdehMBJAPuFp+52opZo7dZLEvoniXm1nNsJOehVsVw414Zf
 vYlwn2AjBQk3ser9j9fFO9V5pfew4+l0hZE12VoSwCbPLWpiH9L2hvdg7XjFNzTM+/L/Eq21A
 LY1ctppRdxIlkFv5aQQ4CwmcXVWt9HOnQsgq1AZr0E7RvZKYr1Oc3jb9MvH2UF1JYWoYuMqbm
 AMwpNt1x2CcjD8LQIl0VujdYQrvJ1E6Yh+EgqRV4HxZZGG+27w8OwPmgHc+OQzpIvQnD6fAaw
 e31JUM7g/IfdA/Fr//YqgKxocN6fiVsZ2UOd1V/FsE9uXGk3Rn1ycbEtjD+WxKiEtiRhrv88N
 se6NmCFdU2Ycj+5GnwubpMcXUigoSSCTMvka3WNajRtEsiYnxPQya7O6QUjKW0GCbmVrOXj0K
 tW/Y9PX8YPYLR7xCO1qyUl6MyGE3jh5Wv4HyFx+Mqndn9UJqHO+bsULhVZg0Z1enHEF+W7FAt
 A5DbMi6kB35o8RLlV4srWUBYsCCgBrOeEjjNHElezm0hVNNpaboBQadDdGLp5BJYJBehvhTbu
 ykNc9iolnDEeqp1EUwl9mv/ZTCkN8CdtBaJXAFPpNlDDA2xbnOZ/6qFMZpNKBM9K40U6mE16r
 9rU+jA2USgkW1nXzsTcRCMljhM3+PJy0s1uy68L79/vH/5b3AU2+yi+3PWt0NsFTbllKWI8DV
 78RkgIc8poCxzmxT4vsyDstLlTu+jpF0kZhX3bwKZRbrzwT3WuT40QtfQez7sW9F2mhMl+TGU
 1iJUdi/7lMMyHuvxO7Rsd3At7A0jFj0cthgrCC/fOmoVi+ZF728lM3ogeJR1XlNsfT8AYD5nz
 t+4i5EpfTM8NddlMDoU0gX1x2yki07NpVnRg6prfC38Zj14Npuuzsorf/Vk+n55MBG2L8fUG5
 /VlBbsEZXQkAyQbu5ij9zAB4fyW3Kt6UpK7l5s3tVmnlRkMQtJ5bMd/TANwnDJGOqsVlu33ow
 JnGvwuzU+a0jyjFlnOcF0TqgOyWWHMuHKuCD6k7yS0Dr3eX5QhSX3Eu+80CFPlt9XtFrip3Kv
 GmbkAAhdPBoG+G9tSSfbKcAbsimc0sso1Msf8nBUmH4eq8gKAuys9/F94dmi/QBOSNLNV7Bep
 CPt/CYuw0ctu7TSImiahhmGvHnZ3WAM3YCTy2OX3gdNN3UlMRnGu7vMcbYsI9DiwB3xIvFeXR
 aib/LYkRUEm5hTpo7nLxr/H+kZThUfUsdc8cRVWCaE6b4JzL8qoMGYgMtxktMiWyWt5O4+8vp
 Nsdged2Js3wFlYYhgmVYhBy/KUDkIER0IKlGtFw9cUigAqpyT2Bqsl5I724NZfW+xa4mhyCQa
 H6bFjcIkZfxvDNiEAYsR26Fj+vjJ1UTMS7BEfYeOgpRqbEctEIwdPsWIJKbzHZSVFu4uDztEm
 67yX1I1Jf+rQEEtMa8nV+HhrSKDmhOEsFdERyLd3Ca7dceU4CymV/db0nEyyWhpW92pwbGrWG
 nZMXRfGvK/SiYgIbemLrlr1xL3SvLPqZiMcoolUxSo0YQ+3kSDBhghJhYSTVNWYRbHglxRE0y
 zspmJgavP49Gd6Uuw790tq6uTQIbJe/S9P7G88/2YNBk6caazzYEL7u9PfS0Ie/oBuWfBCEpN
 R72y6bYBpaIPJY48hgkOBH11SUVKPwX2ZvYkdX2y7HyTh/0/yaYh9ZndKB05Ax41cKgOoMgTe
 pEWsYVOXFKNDciTw4a3h9Y6Xr3iNqaHUjsQSPPv6dNyijdjqEbNjnsrKh1T2U24yXaRycnjX8
 zsqud3oTOWpmoB2SiA1xvh6V/YrhuY5p3UB1WxSusq3JZTlMKKej8zvFKghkvnUhSmJ+m1poU
 1TTSbtEG7rNyFT1l4SbtCtGHmfp/mKav/YDbUMap3hlBpWCcKf9ZQV18h01bDoCZshj3AsuON
 JZFIp5OpHEna3ojh4s4JNl7ElBpFjcUTpla40qdqCCIGfwh3EeGVKniIxrVcuuuy78DSdVltA
 dzPOnOdchkSsCdjjrX+JWWAlSPtxT++6rw/popAcN317HJah5Rc8rxC9GKIUYV45/5AkEpRQ0
 cycBgWJihciVqEOiiT2CUM5gcwfreXHgwMPA87A+bXDEDLg7RCVAEWabY07CsXgg34v1dvJHj
 LoQN0YqZZzQO7wS4uZi8eICf/pLTo1/RLcpE5hw0TG/5paIk1J1nPw1ZTCvspt8ZD0M+rSSGg
 3G4ASeq53QDuwP23u5jRByVkMghumiRaooqdHjGka3gP6JgsjgAjmIea/k2iqytDEry+Acmha
 r6G94o/CaVPoCg5moxyYaKiAoGIO2Y+vYaOipb5EHYko1Wvhwz1LZK+15RsSz3Fn7qW/Ccwyq
 RqSBHxn4Cc5LULz/V6hoVUdztfkhiz3lvxF2LNZEYgZ6MLa/Ei0HcNh56Pa5pcej3MgDyJO77
 vGAZOXA1Y5zlm5XjhJ8xreYynsTHrJMDQHkKd5aR7lzXfo7+M06iRu5jPD3xnImLdP08aiIpM
 eDPcxKCn+5S5D52msIUb+JQcRxNbQrgGnVLMatbza2m7FIC/jHycfQOZVzCF7FQwklRlPh9qC
 sRSQAGPyHHElCPSaLLXWn+2koaMLQEN9IftM7XQbsqIdumIBObkFInEiuQkmPXmlvCgKDM565
 Ok4ce15trTSdIvSCsqf2KfU++Iiuudi6tTQeQEhAWYEzfe14flxOvoxuB5JawpbsmgGoDtyvW
 xKIlcvDZ+qzHm+ewPvVvBUtgf9eu8HvOLMIrKmjih5WTQuLXBN/w0ZMuFIuRL5BHpe0d5bZRD
 w2n5XvCez4RFwHgvgIQTaj6Bk+1n0WwRo854MPqczzFBXkcHV5ek0SFFfqT19B2EO0f6wAneS
 Il9bs5EBpoJOut8H1KLiKrAPBVVhz1Ro/1kjH7fdLmqrMFeDYJi1yw/poxthjHmPS+vO2J/ac
 WAeMoXOGtEaOtaZm655FmpFVfTJiZVG5u1gl743H38Az648QtH9T29N8OpUmZSEKs4Y4f6zTY
 ZlnneLjeZ4VBo75N+UN6CQRvbX4dIDvGG0b7UqdH5yh/yOcYqX1HyiqR4CB7U17Lz0UkvIolF
 bV8IxXPxqYLO/whgwcXKhelEQEVngF096wsh8KE6dlkkQUrUkvkULov/FjPEZg2NRF7YS2JNl
 YB8KLVJmKvtZmqc1/kU+CHehw6xCYUIdNujuFmldVk7tkJ6gzBJ/bI/8MERT0qiW74NlSmX5k
 BNHl3Q4ij24onzp8CnOPbI6kEXChADb6DkQwMicLZcPIgmGOPkGGcFu+FzDMjY5Z5H8M0VP5n
 NpJ+MlBCLJXkw7zHNrUHoEGNJGEzy3o8tDOi6SAS63q09b/7bj5Kyr7Yfgcr0hnNV7zM9b490
 IJpkXEu9YIhcs18wI+yTaCDeFmTdSWtXqpNSBrlahCL4UxdUU3Lmns5EMmRZ+YipUHVApP3vc
 VHw5szHacINOs8wFe11C6l2lhYQdqjAaHbk/BWR3iYzf/3YwWsbTKnjmXwFpK4RGUau4uYBpt
 /0cxaTscVkahRuaDER8RBc9wBW8taMgr6ihMTh3dsqP4lUMKzFG32BpEjd3Bqzgy2phl3QNoK
 lQjvYaqbgjChbOznt6X5ND4In1stjHQsGLTYWRxOWj+yKNR0dyWllAPGp+M1ysi8dVWxnhfie
 Sh6pBLBAOpVn3eG+KEaWkoKKKZiDajEIeNl2+9CURYHv/zyDRxA2I2gbttEnB37dfxK6POAea
 fZGwqe9SCMHtTH3sXlZc9L7qlciqYRQhoj/ks+QyPw4XH6MyLuuPzVpL0K6V0C74ojejS6fEK
 FjBMvGqo78T/vhebSsRgmyQYu1nqk6D6pQqVha0dgJzcZ6HCfUZzvvIwobMgN4Nq0DVuVJBeY
 SQ4q5iEMZ5xZEfeQxdI8Nkz6PjLS00Jloj0kXGj1MMOHgxk05mxXCc073YUMU4iPYO6MqYBNS
 +bufGn8R62lvFi7ABCRc4RCPQpCWLUH/zMj2GEgCjwHs0vo2vPEJPLV+AlMr1dci3bFE6sNBD
 gTDPGtR4BI/lzbaDqQnP8HYNW7tz/0mu8IcVbTnwAUBi/azWaaUwfq+rA257/ISfj8rWceJdl
 tUIa7R+AhzZps/Ib2faRiuWKW0YNKPZ9ZmAhm2JVseWDKt+YDQwPFiAYucRoKPa2KAxTWIFBl
 CKvGOUQCZ7lAqj/ZNMPAvc74CnTmH3SFembOm/2GpNzz/XmEF6Ca11ZLzuaJ4ysFNqobbLI/+
 n6fXUO/f799KSRaFOoTs2CFyG/dLJE1BKY08uri9HxmMXMsm2h+y75mfwsirp3D4Wk+zkL62k
 fQBgOvsOWE1OLnOzg2nihF8p/NZ+ZwxSWEABJwr88SK6WLf8lvEu4fmTFPZ5kf5wovjfEJvQs
 k9og1Rvr3URLH3HO/6I80vbfUuFCVsSYw3BzMjsAsdJlEZoRxo3n35AWc8TgLL3+75kkit1Dj
 KMHYRTsz2ELoL8CaBja+uxl6/dPro9tQS8V+SMlqFNd5UxY612VT+uOdELZlPa0dSyn1JqWkj
 Zj242i0JzUyzt1PBoKfz6hij1x8EEtziXAFfwAL+Fgu6WZ554oW9Cgoi2AMI2mX9KZD2mTsNT
 GG6ojjtGpK6HjDw9dUBEk1jj3CVL4fh5oMwd7uVmZVQP2J4PSN8ixPK/dRYKTrUCXTJA1qm4s
 lCeafvQmPZFsg8cjFQQbHNLnSUJmZ9OE5ZF39iDEdKgwGG4xrhHnhqIQu4Pq0jEk7Z4OBlEJ4
 dT7FTDoTfkh80pSeyIppXSNDlqzrfZlTT4xtkpGrIwDRVyhRkN5ExXHY2f47x8pZ1/p+M8Y+o
 dJR8gqCoSCT87io+aE8CTf0JKa9nasvGujUbDQkIesivrChFdUr3+TRUpj480OEPckHC0AN1c
 TploFXWGURD+aWWPkWTonvE5o8p5R81g0Sc/uT84hQ49InZsJRjM47hmWp4FpzFKflDe2CT4d
 JWVYQ/1aFzS6pqo0jgjwicXse6vuofNKR1u5sWWpg+hE3uXSS3yRmZ7Fc9L9MIbkPalWOeT4=
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, 11 Feb 2026, Patrick Steinhardt wrote:

> In the preceding commit we have adjusted test slicing to be one-based
> when using the "ci/run-test-slice.sh" script. But we also have an
> equivalent script for Meson that is still zero-based, which is of course
> inconsistent.
>=20
> Adapt the script to be one-based, as well, and adapt the GitHub workflow
> accordingly. Note that GitLab doesn't yet use the script, so it does not
> need to be adapted. This will change in the next commit though.

This seems to require the following to be squashed in:

=2D- snip --
=46rom 677370c8cd3b73358713a0efac6bb573b347d53f Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 18 Feb 2026 22:12:27 +0100
Subject: [PATCH] fixup??? ci: make test slicing consistent across Meson/Ma=
ke

This seems to be needed to let the first "win+VS test" job pass. See
https://github.com/git-for-windows/git/actions/runs/22153194896/job/640539=
53314#step:5:70
("fatal: slice must be in the range 1 <=3D slice <=3D 10, got '0'").

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 412842eb3e2..42585fff779 100644
=2D-- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -240,7 +240,7 @@ jobs:
       shell: bash
       env:
         NO_SVN_TESTS: 1
-      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
+      run: . /etc/profile && ci/run-test-slice.sh $((${{matrix.nr}}+1)) 1=
0
     - name: print test failures
       if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
       shell: bash
=2D- snap --

This here run proves that this change fixes the CI failure:
https://github.com/git-for-windows/git/actions/runs/22157880378/job/640672=
14717#step:5:70

Patrick, would you mind adopting this amendment into your patch?

Thank you,
Johannes

>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .github/workflows/main.yml | 2 +-
>  ci/run-test-slice-meson.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 76ef513e72..352357965b 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -298,7 +298,7 @@ jobs:
>          path: build
>      - name: Test
>        shell: bash
> -      run: ci/run-test-slice-meson.sh build ${{matrix.nr}} 10
> +      run: ci/run-test-slice-meson.sh build $((${{matrix.nr}} + 1)) 10
>      - name: print test failures
>        if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
>        shell: bash
> diff --git a/ci/run-test-slice-meson.sh b/ci/run-test-slice-meson.sh
> index 961c94fba0..a6df927ba5 100755
> --- a/ci/run-test-slice-meson.sh
> +++ b/ci/run-test-slice-meson.sh
> @@ -9,5 +9,5 @@
> =20
>  group "Run tests" \
>  	meson test -C "$1" --no-rebuild --print-errorlogs \
> -		--test-args=3D"$GIT_TEST_OPTS" --slice "$((1+$2))/$3" ||
> +		--test-args=3D"$GIT_TEST_OPTS" --slice "$(($2))/$3" ||
>  handle_failed_tests
>=20
> --=20
> 2.53.0.295.g64333814d3.dirty
>=20
>=20
>=20
