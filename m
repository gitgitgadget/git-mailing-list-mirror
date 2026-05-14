Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619C9396B73
	for <git@vger.kernel.org>; Thu, 14 May 2026 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784069; cv=none; b=ldlhTnsNr/FN+0q8fMy4nuK2wwVEofjBmrM4oRjfzxrPB4Ew6nihPxOl9twf83/iDOBXZqNyuwcZYS9GTd/QN45jYE3J4mpq116sGmpjGVcJWsQJIi8lOx3HkWyiGZx+fp/5VL43TNnX1ExNeXWhb9FG9nQphPOMCdGfQ6rLrHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784069; c=relaxed/simple;
	bh=Y5+B6TphPYGbIFaDaIrGs9wn5IHLKB1wZ9oMYTjiets=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=E+4bTvH0onozsEN6WHG00SRl7hzv+7B+8WDgt7fFX0+fyUN5KTAjHmw+IKsr3m17a9JlMlalrkGxrNH3+JOFwrx5rHBJUE0gz2IlyL5yzZl4YJOX2ske/Q+gvoNQvRR3bAJ+q46c659caONGcRMkNCtr4BsPdqB7e8DqLdr968o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=S+tNErLz; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="S+tNErLz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778784057; x=1779388857; i=l.s.r@web.de;
	bh=hkDzNAR7xShoT6m7ZkAmgGutRz/JdwZtWz9Z/jW0inM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S+tNErLztt30KGyZYAPxeBmXGODiAI05hel0DEJ8nZH7aEGaWDUWKvi7iQuGjKk9
	 V6+SUQC+u1IC5uQ0gXChw3WfFoT2F0fONFZ1dOy90c29PqMvucBaiB3jC6awd7+9v
	 BfzPR8NPFyJDjxvVgkOZYaBl0cZ45Yy/kNqHBx3ST/mkpMkQLuAFeTQtiCznpRFAV
	 Th/OBPnlxb+FAU2j9BRiN1KB5Y2eeoWPWzVRWmGBatKQKIpMsew1C6kUSawWWpbVa
	 QkCmi7t8GJLxfbxmZxfLv4G63CmrrH+Sb6IAQ4jMO64kXWWG1c19+uFGjFD/7VBZF
	 aRUkKEHTg9U4hYlfAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6b8s-1xSMqc3rsk-00yu2v; Thu, 14
 May 2026 20:40:56 +0200
Message-ID: <9629b0c1-b28f-4cd2-8d59-67d909ca9052@web.de>
Date: Thu, 14 May 2026 20:40:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] trailer: change strbuf in-place in unfold_value()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cO0Dk3h8W/0XqtOlBwS3Dk7AUO2eV8ONBrEruBPD9BWCi5PbZYx
 QcaYdgu8U/yUTEo4BT67LxS9gblBhLmNnAM35GPpjL/WQRuWXlZMkOXNsNuet6ZtYJgjbEU
 N2EMmjjw4BIeULI38IKMdN54cHhMuX3KljNTlZ58rF/2yt/FUkMWu8vj2Y+RekKWKoh3BYL
 zK4IN3G/B86aJ/nmpxu0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SYPhbwyVjS8=;QBQsHDmlacml2qee7/CRqac4xtv
 ux/ydmztrKYVFCXtsfBU7MtGxOesqcPUzlWwAOiKefdVr2Xyp3sH4jhxdyA43PTLhm/fN4Rg8
 CGys0JCiU1FsEWENMPzk64Q/61kLOoQ44zrdoj3k2EDZRt+uKphTPBhrr8oJ4bJ7FyGVGEyxr
 Fzv55wBYT0fcXjhnk4XhhHNeBslahjXzCapAS80om/JQ0svTfmAeECgU6gqkKzVhRq2HtnC9D
 5xZR0x4LIy4K5Y7P5gsl2hFHZNBYz3AcJvjTMguba/GhlO16GgV39kUnQ0cRhsUA8g8dsGGfc
 GbMaPykR7iApR2NSQXd9MmYpsNZ0hDSqbyedbjYvwsE99e8YJdvIZbye8SY2NLWNRsvFmu3SK
 pe7UAp28UyMeqQD3BaPwAM3fvITfrnPGCUYTXaqFpqmAtpsDVFk971wUS/mhbaUXkqCRlAwqU
 lzXFiHCt9p2QWUMShl/0gSKg7n//ewVuomGrN+hgaXOVllDwzBiShe9DISHL9XqxwRDXv7MiD
 25B8tG2OWj7mCUi8g/moRnF9ASXHDsizICIyLDeTp2/IcpwR7LqLoOCC0hizPZxtvS3+kSQzD
 EKNn2hLll0CEKGv1KI47/GtEL5IWeqHofS31sWEAL1SelOIGtMnmDdRC4fvxZSOOkr3/Tedfd
 E3FmKrq/oPMWmaUOeVQrFLJWFfBCBNH5iq4dlF+Gu0Gou9Uqst0gOELhXxxkXaBuk3z7ljuqr
 Lu7vHVgH21WbXDlvQFuz7Xq6IVlf9gvLgICrXppwT4zMMsUCTFHLXbPHffm2tjCUutzEjHIhN
 xXOYsMkfeytfkqFeFXgT4hwlfR9NygLOJniDm/r6F/S9fqYgpH7WnxzJQM2Qwiu1GTkFF+XC+
 UJtmqLtiaRsxvqhA5+/ombekakd5XnbN4AmgOYqNtssHZ65c7QH0EI8uPGda6ViDGugHqrC8K
 H2u4BEo0uoH4/nkyTbxQKjn0uposCKBPx4wJkI07Gpa6f5gNFV+ALRVYIqd422I8WFiw2w0Bb
 yolDfIo7srjdGC1zhEfozoapNHr4hCiZsSnhhF6IzmUveV08XckubiYdgTM0DkaKrbvRNnJ5b
 Hp/kcmwyjhVZ+QyJkrcZMgMPou/6ZGCS0rtsFNlUCRnUBJajLFZU1XMeXsKipeRJ+pX1IE3E4
 1wr1FvKTCAsenoLXvXlHHRKjSllfwpmUReCHnwziHPe1t9dB6NYhA6Hrrsqu30SNjDIUvwuJr
 vCisMjMD+33jRCpv5JDrJqQD8f67hIGCW3uVZm9Jf/+keXBLFe7/N/3nuAXRaVa54gakampir
 JxG5BTNKSnhrvZmh1JrQRNPZg08neOyJFXuuqirhgo9HmZ+nymMLUR8nMjJxbObfO2pkce8Tb
 D1L8ci9xmzIPDlEE71d+p5n1WareMFzWGDFSllK3mYMwRwWw5+ykFeJa98q4fEeKQkyJWmUFe
 waKZEncK/pmAQAkYJGFJM6jFB/sCYEmPvg/vLd1yDHlA5KHx+mzP+4lZ72V+5rK8XnAAQ65m9
 l7dKklu+wD/yIWo7h9wCYrhdcX6ZcolnD62Od+rWYyps0Er4o2BlsWYsNMHiXWLr+7DVfTm1l
 mIbC56Us6Lzjtpf2J0yJHTfNYIs8IHCqsraq+7MLIQKG9uNTH63HJx8FYoaUnwqan0UiV3rOY
 Z7s8adUxPP58kKI1BCE0/mGiGsRHGWhPif1RMYq+JDsRgyhpHkFwl80MHucApyMTxYMAuVBCt
 4K0/55E9ULrrA5dSVvHmXlxoi4LKbwxmVNj9I3O4d8P/k35HLgdhbRIzP14ZwWUkAvbXfi0+Z
 9MBqWytVBUhW16X3MxWGO/4w3yvRyo8b6OEV1YinEwr8ZhOlpHyN7nJLlhZzRsxx3/V6ZHBsT
 hjEy3E8k1JKCHWzV9rjwQahJ+FoNHEuBzct5ajMVciD2SG9Qi43N+gTnnlNTfAPciCU9iF9Bs
 l8+q8KJe8lHAAXoC0cQPQ9/RUACKC0or0MnDcullKYKQ2j4yBU7qIwVe3JwwCmcrXTBWZQjcu
 +r9QiNlm/vrO2lVPNvvD0gphl/LaJbjjgN7MFk+u4FIhSlb7QUeVpCx5dsVRIXybLeSxJk0rK
 Cob4I+xr7JFvyCwqHImpax++ZVEp7gAgMro+pFHLPX2R5li4QKRkFza1iRWzzjLAGKwauAZL9
 oMo4cu1yBYVQIrxLpvtQjMkPxn9Fzy4qmzX4O/IEqjgiDh/jQJbndh1I/rWtc32+m0R4VjAm6
 6lkUpQcp7vCWjSL1hkarOsvb8hKcp6RXOPUfUaY0FQeJI4oEG61pxCOmOEJfSTK5TXN+OxugV
 6T0uv666FZcHkCBoAlnnSmDBLfWR5iKpaCTMyuTV9dHMJLOr49F4b7gsC90rq4OaxaelAe972
 dfWsNI0h+m3wU9sz4DFd24HaXAm69+luEGv2VRikInRRUY2YZcrg4MHIsWZ0UNKdtFr9dCAma
 +lBS/vF0MOQe4wofy7L6Ta7tLhRA5ZWY/6Qs5YZnxOgawIS5G4sPlDRr65jT9JfOixPDi1QbS
 BDWK67TKoZkKuuTOU7VGkVgG056Otwrd8pLC44a36b5kPfU5GrkwEm7MDyXJ1fZyiArVpjoon
 HUghuw8unBrN85TCUUl2VrOn/uqRE0JES/F7QwvCNwzXAyA6Up30Vac8jE6BKirC4jxjVRrok
 ps0FSaCE69A3+2eSJmuTCU9xv43BglmqpmQTzEjrnaZML9bAUjcB5C2MWLREPj6xl47bjQEFZ
 NBXgqax+vhSLltkhIGI5kDpyvCP42Wc0fXDy4p8Zf+WlxTe4hKAsRjX44er69PLVGO/y9+4BK
 /p1F5zxU+7Ar3oZ3YyHLn0GOxzDi3bOTQVfQ+wWwgt81yc2e6aEWHLYnqFHa5FG5YklvpPoui
 gJkWnn5jy3L8FyHpEGUDc7Yp0XEmmqh2NV5VmVAm/vaHmOejHqb9ytR8j9Zao2UATFsGN8HFd
 RuPPepRXJvh/6PFr+k9dRRxx9cgXevdM6DcVncqTmhpekwwtM84ys9EcDFSuDFxOMdYeqL1L0
 85YHmTp42ijSANo4mOoT9fMl8G8FOQZ8OlmTSZFBU3eqJqDgl44guwtbDUdDeRsd7UsaMhTiE
 1mLy3QOJxvWtesZEJjHJ5j15a+7e4UM9rL4tV9rFSs9vLoNRkoMLaY5IhNhmiKCMfws3wriKq
 jZWW+xB2gDIO0KDpDcIwEBCXxfbFIF8+S1Wo7/PSNDR5rv1XHpTTTTJFLwvhHWDaIjYlZU1to
 FG/doBo4TZ8jvyVOgSBv0x1iwdukFsBIdf2AA6f489spBeWgiaCn+5llT/WTOwT+ThCNggESg
 eh2W/Wv5aAI3meh7bhyWI/Sp5b0s+SOQBAU99I2C+tRSJMQeodlHrkfoYdRIkBsJruk/T1wDW
 WJxjsg13qOyVfR46Rso6WTyHDA/NmjJIVnO7LhdMKdb6QNPTWfMfQPtj8A6cQ1zt8KiG86aee
 KJFN4BkCu0mK0PwmgGXhkLjK9jRZ6O4PriFpG5TIxZ4Dww4GTsSrncGvhNKSzaXvSuZ4Q4VpL
 X9zSb07HW4pn7KM4qJsMlQR8S86GLb3fAFtLvDiHlLdgBirsMLt+JbFprhGjLjqouBCQnBu8S
 rsyp54gqqJMcYwnVIjBmcdMUFbTanL+tJ3OGU00FCHTHNWycr+kaDfDByJL7giM7eYnNBdcI4
 3d6WnwVO1UcQjzHCYmmZu4aiiyhi1JLVpR/w4JIRg2nvQrI83v0Uu/a68tS9ttQWlYVCY1o8s
 9pN8aEpsLQmDLya1l79GZv4uZvfxvDi1EOy08PP+Rqeve9AxPudbO5D8ik82bT5HRnKXJGaxn
 ApUsQukRwqEpGMVVshSK/UEBSk3j0kHtmMKr1lnXEfeFkw9Mrl/Evxd7nKq5+TXuh1MABEKZ+
 YiMEdWu37A07LBMWoyvVZtsOKiHneX+eKsEgfivgX20O8MLCnOWXkgZE5ths89Dwd174hjbfh
 eLBmDK9X7hO2oLshVadFBi4/q+40xJASDUwh6oyTWkRId8rxUZdIqOEsCVv0+thOWf3U+8M6U
 Z5v/nCu5H+sbjad85y4FjNM6LV2tKKS6hQznsHoxkMv92QOLdwlSOtZLjZe23sTz6QabEHlz1
 s7G3WP+3BlG4g9VMFDwA08TTw8qF36vtEPITQ9gY/+mJs4xkTC8CGkwT1kV/nb+BuToFTQwfN
 44t2l6mXms5+8He4Rnjl09aixsZSSIGos4JEK5JZwd5wZKFa7Sunyl4NA870ztHENX/MXhI0S
 3YfcPqgwutblseeDOp9DDdKbnpR75/94yXuap1vAdGDvbUAk1wP+LWngP1fyznLUpYkbtdn0n
 vh4+keqW+sECKdpQjhZjrYD0TkfRQEumncM50U2MjomdpOSdMWUgjiiFSM0nmr4fvi9jcuR3l
 SM9ApbKJm1LxX91LRuo2Sv6sCTj7dmhc01QF4GJ4e0HeyRKU5YXvYOmTX7xSuvbw2JYJLURT4
 85S1a98ZfQ/RYD2wRfdtIIiAoFZmzBlnQrQ42j3aD4xFD0YA+b7uziWtAoi/x/b335iY0F+8x
 csJkfqPIDZ0H8/LCIS0mgepahhKc/Ed4wU/dJKg2cn80HKnoeITgJonTO22iTtSpbqu9DSnBI
 aeA+IxkkELSfxbFXr9Q1Zrl1VsLIqJ8liRajueXcfvMBi+m0r/pkVGPen7NkLtjXMNlUMastR
 hTkCgG5C3IeCfaxozV++Q/B9Z1n5J4kpjv8YcYR/VvORAdzzm/Q2Plq/j8nCZVnrZnlVl33zA
 j0IxbBzYrOqLz6ca6yMUEDJxLCIRZPHN7kWk41yx+R5LBgSNqKeCrLmBO2iGOJ8McPmFkl0AN
 PXASX9q2OyBEr6exzvJooVldUjUU3zCxGj4SO4GyTW/Y8ogsfTUQZNqOzPHbA5gYTqgivtJoK
 IsQEBkgZdA6zTEYTb8RPPST2OFDF2ILfGg67OtpxGiu3s2SK2r/0cwLZMnMen5RWWWsuOsvvL
 ngmuwXR86Q4tVagYilJfdSyp9lw10qcPUi+TbWV95hQ5bnx0LJWssNSFJ6k6Hygsn/rBO/Hjw
 tlmDv1nfe5/8uE9jBpjiI5mWf/GPHaI2ZLJwo0O+ETI7qFVR6eRpqPHpVKFVC/4zw9DWXwuyk
 Num6MWmlZIzaDGLLTfXMLIP02OotXA9POsgVcTMUTr2RN1bYHsR5jjZ+nkpNmqB8Nwc7Vydtj
 Ry9k/1PozwTvucoAfzL1+4BT30TcLu+vjZLjEwSSzIY8yACgSUI0JbdMud+pUO7OfrwmRmtti
 EA8x1asms9QMveyR9Zq5+vNT7iUb3SdPPmzARyP5836kl4LpCA4EAAzOKLOiqJG0u+88a34lv
 JeHm4sEOgVLno6/nxV5wsFvJw0C2gamFuwVKmcsXgG7xDhz5iks8wgRJ4gQlvTu1QADjsaq1O
 Os4emnudKTHryPbnlus0HinswVAM5NwHSX3/SrKcwPDZpwZEXkEZxmNOF45P85oOPC0pIEFX0
 qp8n64JaoSpi4eQ==

Avoid an allocation by doing s/\n\s*/ /g (replacing NL and any following
whitespace with a SP) right in the strbuf instead of copying the result
to a temporary one and swapping them in the end.  We can safely do that
because the replacement is never longer than the original string.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Formatted with --function-context for easier review.
Inspired by https://lore.kernel.org/git/20260513185408.GA147423@coredump.i=
ntra.peff.net/

 trailer.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/trailer.c b/trailer.c
index 470f86a4a2..b89fa12fe7 100644
=2D-- a/trailer.c
+++ b/trailer.c
@@ -988,29 +988,25 @@ static int ends_with_blank_line(const char *buf, siz=
e_t len)
=20
 static void unfold_value(struct strbuf *val)
 {
-	struct strbuf out =3D STRBUF_INIT;
 	size_t i;
+	size_t pos =3D 0;
=20
-	strbuf_grow(&out, val->len);
 	i =3D 0;
 	while (i < val->len) {
 		char c =3D val->buf[i++];
 		if (c =3D=3D '\n') {
 			/* Collapse continuation down to a single space. */
 			while (i < val->len && isspace(val->buf[i]))
 				i++;
-			strbuf_addch(&out, ' ');
-		} else {
-			strbuf_addch(&out, c);
+			val->buf[pos++] =3D ' ';
+		} else if (pos !=3D i) {
+			val->buf[pos++] =3D c;
 		}
 	}
+	strbuf_setlen(val, pos);
=20
 	/* Empty lines may have left us with whitespace cruft at the edges */
-	strbuf_trim(&out);
-
-	/* output goes back to val as if we modified it in-place */
-	strbuf_swap(&out, val);
-	strbuf_release(&out);
+	strbuf_trim(val);
 }
=20
 static struct trailer_block *trailer_block_new(void)
=2D-=20
2.54.0

