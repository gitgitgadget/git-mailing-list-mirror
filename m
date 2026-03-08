Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E254A3603F9
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772963833; cv=none; b=aOZ/bjcrN0OGrzkdYMxEZLKlT7riZ6b1s8DCA6Cmj7IWDenVvXgh95T79Yyvj+HYw84YLDAy1UTv8Im56dtif59e+eKbQt2RKee/u6+/bUR25gZKd7D+1uTzbeIlpNrCgJtO4dip+qBVd9DXswiaQ7tUa1USHZCLXknXq0E6EqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772963833; c=relaxed/simple;
	bh=kSLJpLACbGd/qEotb1KdJXz8R11Sia4xA1xBLMFvd58=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LbiSQn8uLlmn/hqq+Hb6AxPhUbhHScvvm1Y/9OWnRsdcAFIvqdACZ3B64LnoC2Ue/O97G6Rh/+6LOBIkotucmFb7ZWsV1NELwI/8WPC4XDJvwFj4K/qIG45adfuKTIsVjXg0+eCuRzjrtZCzhjYDAPFLwoo0P+rYQUEioTAe8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=EndDHxfp; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="EndDHxfp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1772963823; x=1773568623; i=l.s.r@web.de;
	bh=Oxny1Hz2Kqp1VvcP28mKLzXoFhTGNdBwMZhxlnjMc60=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EndDHxfpo61d7TbiTMk/4/fhWtW6R+d+oO7X/14AlPi+ijtSvl0IoyxVxNfN4h4S
	 zsOf1huLCIIAQy43Pss7+qYhbDS6nq7FCxtMnSd5xwBh7SviXrRkVA1tKsh31T06p
	 WdC3U78O1n57sQTlb+cdlK8NDdQLflLj76epcR4lbC2YmZ9od3YKabazHQhtd7rz6
	 DIzhIEITBdOJUs58Rerq2Q1UFZo0PrDPmc/2POTZeIBBjpTMtqAIzQ4Gfyi5mKY8J
	 MrAEaEfkCQ8EZ9CvoipFhoA9ficEx0C5NVUImfeLP2qQWlOTvI3qJ9U6+9VzlJKos
	 O9QvaKAFlE9+vZq/CA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mm9Zc-1vHLfa47NI-00amlP; Sun, 08
 Mar 2026 10:57:03 +0100
Message-ID: <b0b8633f-be95-48eb-8244-d0e3f1a7be72@web.de>
Date: Sun, 8 Mar 2026 10:57:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] history: initialize rev_info in cmd_history_reword()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/AMY2L273fyGbLV+0pX7fX8RLH+n7mLpqzmzVOXCduqgf6gOjiJ
 CrCOCswA1pC2xhGpHMGTf4zXnwy/x1R8XVqHb2DSOA35C3QlRPRudpXrgc32KH5Snudji2E
 0IcS2JGcb7e5INS2VCfXDAE4UtB6suVvBhx8PSI+KXsqUxi3vZxb3GoZ5n3O0hfetwByKWk
 vEAQRR9tBI7g6+HY9Muhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AE7ItLAD+Us=;dLojBanEnnjgW2roFA1b4VFbfdj
 /c/+lW8TCv8FXtHLYjCFKQz1rekFpntBOFYlaWPXTify3yuu/iEo267kgS9ERsW1X2Gse/tZp
 C56E1AEEdcPeALHB2DodldOHN7mXuW/r1mk0KjnrYgKzevmrACp2a6CV7JDVVeTUXLZqcyCSA
 ILlH1d/DV0Q2fooV7BavTgk7hcRYt+AMmcMFr85bFSOIfw7jgLCyjtxW145bPoxWtlr2WePe1
 mOBaRzx5mwlBMRFX7JzIqoGW0c6GYwloIJydl/7y1OfSl0/iNwVuD6Du46oZ6zWI/91iH7Xcm
 BiFgBNmqTwTd04SASg1C8RZe5uaZBKcBvG55JPx3MGHFpro5Hi0ffwZXeIfkDmLt7aZQ82NGv
 DmDawQOchFlemXzohE1v6i6Kc6ngOcAZ7cAgzzFD6EG0Ix1BsK4+bSHIs/rJWQsStKOaVrpVE
 dizPbA7aySpMaeiqfJuMTdbdbfjbx4uNQ4/vHRcKNdEDTK5AfdXr/lRdqBJz5YFBZzCoUjoNY
 gM2y7RF5PPInzzslf77kL7leY6IwFhAeBgGa8q2AZuxnjAeAdYtlLLXyvQEBozlTOaSY6Kqtg
 S5b2DdZ7uAoAc5/zFmAluLIaeVoQf2a+aQ76/vr7ij02qhrFfq249UC5Thp+2qHJfhAHtC8GD
 DlVZ5omt1K5kDtP72iRVEGt+a5cLt/f3PNGuwMDEpOlWTwraRsify7wOyZP0yWPArrshQ+pkE
 MqvsSB+2MbOkkzKZ5jXTqTPs9y835/S3t3LsyH4IYFvjY2FgYnOB558DX+knPkEG5xJgQ4emt
 N5xmXhUck69Uetr7dgtGz2ZEiOiuUBkDdPU5CyOVmLA9IwMZTT8gXAHuSI9J7bJbuI9qZnLnr
 4DOKLwTS8Z9gdqd47A+8Ox0iVcXKngAi9u4ZFe2NICeQdPEkofuvLx8UQey5wjQgotSe+sQ8L
 LhPTHz4WJ0R+xQ8FYUxe6CkRv8E5AwqiJ+8g2nl+W4IyPlWpNVFR4TfKwpL6ePnql9PTtP42o
 WuNhhP16FYuP6HYf3SDIfaVdnBJmyh0e+3cje87tohDCtt0rDPB8LVFKE9t2HIQweF5m51Fh1
 jydARARi/L3ZUaE4gzCElPWX1CB4wC/hIhHrzMSVek2lD1W32RFsSnhbLnyVKE8XrBtkHts0a
 o1eCjMlF1pihyl/pH50rSGLmlrGO0uzYjh9LogoZIvUepvQt572OiHLUhp7xJxnUfwyzzuUIn
 MC2yfo4UMX1VjX2efDYuZtFgyiMZKdK17+VjOgJpGiWNPVlGD4U5Lk9ppRa8c0K+X/mbhGD7Z
 EO63hWDV2WCLQLqXrbnc2+9Oc58weQJkaWgwImhpbBZLczAl/rztZUlYOQJ64Ngd+Xf7Rus3u
 z3qx8BL/f+6lRCdkKCIabAB8xDUD7gFNoSMPI1xZV5d45w8zaV1DK9Ea3rnl/NjCzljdgbChl
 W/C8ikICAiZ6kwhglg51xm3IqG/RBnpaR0LqBX9Tlx1IQ19yZ8aWpkrcQ6t4oy3In4PHX0Y/C
 BOe9BLUWkw/HSKN/uM4shRVgxYSZXOjgLzxkI8ehaPHjz+0+7athYR0qZOxfgabwcVutmPu3Q
 qLKBL7kHM7fGA5TqNdqQUV3GtG1+bxhmklBz427S1/nxuZ5QEHOT70UTuVay67YKoQVlqCRvv
 QTyb9NbAgO0azlQfYq0JL5DO7gBUsLVVH8NuEkcSx9R8l6SRoBDXHZM11nB7IUqP7WAac5dEx
 bvMbvc68WTQ77KrV7R7sA15KUw8V5Of/WjksbMXBrYTFa2vbP15zA8qS6g33qJxJgdT8WXlOt
 LtYbZZYY6aK+DuADIs97QwyGVdGvZ8ekoYrge1elIrWA1B0Re1pSADvI1axmZOJoHS7KNyxgn
 gEcivowQlhqtCev8sDErlKYQcNuaw6uzoZCj+S7xCWXJtgUC3bg5nbn5FsAlmH9Lfp1+d57WT
 WkZhPHuunCmlgFGG081N/TdYP2GpUz9hR5eNWMAgbZ9XMezuRSsWr7VaSugj0NZVheNbNvrZ6
 REsqGLOiBU+OAIoTSHHzmch++bM3cwoM+/llur/qTkqY3g2vHkTmMc0qCExOsEHonA/NIJ07F
 i61WjtuL+8/R9/3/vM7M5yGWyxSk6BwLPK324HCUknt6X2vbJGkvRn7sqtdE4HcixqkoX8iWD
 FSVRKgFiIZgiSHHF7U9KSsEaZFNg+Te9lt84yIPhULZKAMxO+UX87dIMoXlih0rYIg90M4FM5
 zBBI17uZlKwJ+aLtldgWHMlayqudqyzyAFOnRTa4seN8wpISECt08VtsMHo1XSLcQ/Kq5hTWD
 XGXrKPVmVG0/YzcUyCyqBLs3JTMfaxFmBj0kppKtvCtYkYQ7A9Pqt02QXC1AkzOQJGFIJhtTy
 nOex+LB/d+mDgjulMNwvRfpVwFe9tkxv3Wfy67j+7C7eTwKeVIX/bgimORBOQeARh1Zso3pv+
 nSccSGlL3GhOJjNNYVpXzgv1Y9n78GoQU56LNM/6oYzVI11wdWnKavodp1whr5/3Jnh+i63ig
 h1/ZyFRMEbAoKreXGSX1HZ1Drw8n+a32hGvAF+r6/MyA0JPi4SLXxq2/l3b1GbbhfcK3vy4SM
 +yHT67hcqKDejxmNX98hdObHA2uwQuvRugLY3udDiFgv3ix4/AkWP4pBRFqy2p+EWMxt0/NfB
 Z8etsFy0Nek7vHzpVq4uIBRfICR41Ca4lLfKMenp5tz6ygkduNsN/oNzrvx63UtE9OGoZkLjY
 Wnl68FIqfxYw3xoSBkPWrT1SrkcYihWwLGDOiRwm+HN8R9uk6c7WwgV9YRvgRuKvqVKn3KVWs
 N9VPU/DOCWPBuwSwWN12t1uQXygLuDxBTEx1IG1OB8Mka+uOa5uxmkWUhm6dJraUISS/xZWvL
 dqizNmHgdKej/ewGMcRMRuxu602cmdt4tdOPUDZVmZFwE5PxK3Kr2Od5xXMYxa8hibv83qHOe
 fOf0K4Eez8+3zLwDpuaC2M9jbLcLJ+DZYAblZRvf18rT6o0YfjKdWq5U1z9KC3toYawFn4su1
 ugETckI6Thky82s+ZRiq1/B+ExHynqAWqG56w2XhPZqw3MUPjSbTgoAP2K0aNCrbe4fmXO7Yx
 9r4+x/5C5nuqEAIGqm/UpKGC2DVaIqDHmw8hp1ELnBEd2Q+WNXBjjokL9MnsBG4yCSLJLQ/mP
 2reb6BaxjwA3c46mk8bQurQGifr6YMrBYyWXscuwZ/EH9qVfDT+gmyn0sll2KAD3I4jYYoji2
 2omYekRho3lmDrak1OdMOCn47haawiSM+untRKMWPKeR6m1WDx9HSySZIb/6c+qqT49NeFJ2e
 t5Elw1QcNOw0QTs606THOwPmQuPVB6/q8EzPfyfEeOII6mo+1BvDYJMgkAi8o6n0pvX90rLzt
 pV6OwmIoIFkX0ZRTFMN7ywXwgrUupQnH23E0sgvLXVDRpvoNU80Ks2szQ1r45oxNWwbGi6A76
 zZIRZF7LJdcg4kOI5N/xc8mqZ6ApW3/9h1jFPlFwlGQCoUWFjoVe5rkFFL0IoosuLK8KPmSyA
 KlM8rtbzrYb0wAk45B+1pLMuYMS3Ry2tZfUW+WSxcelu9y8vH9feu6XgGRGT3jUNqS3BRMIw/
 AE/63pFvAmNRZORb0jp/xfpQyTigbA3qGE0fUeTL22X46TaLROFIZTfiCcPC+y4pmLP+hX3Ph
 88+snMIIIKWVZjYKTha6GeBFjT/FFczMPRcdtWlARgWfmh8LjiSxAs6sbStYamWWMyfE9GbL4
 fcfRGsDiWEfRqY7qwfxisUmP584eAFbIDl6BmAzrtryJ9lwX4nSkidhmy8u3DEWmWTu7jOTEA
 /9zlpGEJmSmXL7TZVMnGKnp1YN/drgu9m3CgWz4/JsNiFAPnjx+tFshEsqelOXkzGbd+pYw9s
 5xzitjMMiFsU2IN6gHHNRYHrhtwwOnjodhK4m2zxprAZt4O2RAXD6GsnfiR5wICaCgWCh8Kmj
 BmKAiOwlMPAvWWZid6qe0p6tZwwaOH26HK3H+DIkaoNEH4InGDGej42qIF+UQzZ43mtPBZH7o
 tNaeh25Z+OyIrJJHUTe9s7mp4X3L0lkwph54ZHdw6rbP9gKMiOci7kYWq2LTH+pFrhzf6jEKU
 lv0jzFKz/e9+Th1GDlAsAT2/RlpWGDtWJdhndnopOCtm5Gx8ggvF0yS1enO3STFSW3fUwHTrs
 IRU7XCp2x56nUmjeN7GzKu2a+4WQFPqy9DCxZzGEK5xJvNHym2kYQiwKuLpsSalgK4YZPtEcU
 ykhfTYsxGD2diUNLSgjc4dxFx0+Fwas/7qDrX0qWV/M129w/8rZ1ncdumeYhScHp3m5ezb+5Z
 IJM7poYW0o6+sECayIlHhoQLadOttd2A6wC11syYL8268r0cRYa421aypOlmadpALE6hrqURa
 4DqN5ShYF/3nfMXg36fnO+tqu+FTsetdYViEURZaQFzz3pGUBYQBmVwQQaIbZD1NrqQ8IWm5H
 hRtUCAPp3mXtN7HsbShH4g23XXKMPe3ZoQXPf6Oajk6/ITm8XryN1DYc2AALNSjEdBVhO3loB
 K1KYcYz1J9Z5waA3wAeo/sx0dQIZNNuERyOvcn/ib4A7olnpK0HIPTdmrvOrWnJA5manCgNJ3
 /EuxIAZBcSeXteP25UaL2GajElyERUI2zYjscNsRce2kSzyZfU7ZKXZ7mUgvNu/qb4iqefZWg
 IxlPdjJwNz2aS9h1nf+Qw2PBVyfKWKqoPGOw5Ng6m5TH+cI0D5A9fb0SuD/SJRU4zIH1z9QFz
 uFjn7PqIcLzwXVldjiOApNdWcDYLHwLhiMzGEsK4egFsFHUOrPikZrIxwslg5hTmFnYQ0dpWU
 Sa+xcYbk+vatPIsdPH3RxxvHU16oHhLR8yVP3zLoToRrGz38ZeKuxLIdlXn/15dyu1K6nmDHe
 fic2zhijpAVTN950bub8Md4655q136PMqgWiTVxPMBpHfu2JPxsq5SQyCrC2meI6I3C8SLXnO
 0nCZzcnRvspTdEoO7HYBywgojDbT61l8SWI0DzS7xOWKlzBnM2N6RaH1geEKFNc5PZhT82LXV
 Mrc8QGfmjOj1TS4YOM5m+BTAhhXKHvauFhQFYNgLlf/FR88GIMlb4qSzUk/QmmNqzKcO59k0n
 ONIdGI6MdMU6E/TiNQ5oFoX53PMIUV7NtjSK+g

git history reword expects a single valid revision argument and errors
out if it doesn't get it.  In that case the struct rev_info passed to
release_revisions() for cleanup is still uninitialized, which can result
in attempts to free(3) random pointers.  Avoid that by initializing the
structure.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/history.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/history.c b/builtin/history.c
index 1cf6c668cf..88822a184f 100644
=2D-- a/builtin/history.c
+++ b/builtin/history.c
@@ -425,7 +425,7 @@ static int cmd_history_reword(int argc,
 	};
 	struct strbuf reflog_msg =3D STRBUF_INIT;
 	struct commit *original, *rewritten;
-	struct rev_info revs;
+	struct rev_info revs =3D { 0 };
 	int ret;
=20
 	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
=2D-=20
2.53.0
