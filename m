Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF165134C4
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343600; cv=none; b=ccQp4S6E3XHsXv8fPSaTlafxh6EtrODsU5JTCEwW+Y06XiOYSNcGpMTzIBbvPw+09fby6/xWpVwHQwbEaTGm6Idm68IkDXtpNDxivgtRKZQ3g9514Y4ZvacpRHBiBZ6V9qk3TT9HjpL7yGltFuxKFZSCa+GO7kGHAPx8/8Cffd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343600; c=relaxed/simple;
	bh=hDXCpaatAtQw4mtyLCMcNN5Dhmprz1G/DB+CXkZ6zLM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mvHO1LLo4AP3dOVjK6bjc1qArRut+Tp36OVB5ESV2vxA5LmQ34GQVVCaaQ7dEcRsg5L09zuFHowLrVrmyKJfFXbVQ5045ZjflzLF1KWrEej6lKDCs1jXhczAVvGCxj1zNZQT4fxDymMyOrAcOS/x2xw033JS87kuG6RFUQp9j6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=gy8bXGd7; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="gy8bXGd7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712343593; x=1712948393; i=l.s.r@web.de;
	bh=IOCbWJZCzUGl88gjLziaoAl+w3tC6ajoXkEfA3tQXQU=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=gy8bXGd7eeCAzcYQKVE1f9hpBv0glIgez7eGcbpBOlenpD5rSGe2WCV++2BTWXYo
	 LT8yGSSkGJ8DpO6jyC7fLJnXg73M9H7qN2MR55msQRadF807Qo/F0q6ApdpgrUNkF
	 oQNd8IpZl/Xfr98PylH11T9ZYcoRhuvSk+wBGHOCnGCjaHsnnpjIc2W2ZSdMIwmNv
	 FsRlXOBw3xtaIe3XpAfzNUCh9mNAkmYE7gYcefg4mh9EJeKfwNxlxy+XdPJyfvKGk
	 SYSaew794CKbPUiS8qxy8ux5wjIHZv9aawLaml2SL0JrgHXvG142pNmJqamayIYqo
	 2gfq7fja2vLIs2GdmA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.225]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQgpA-1s7cOF0DPK-00O2Ad; Fri, 05
 Apr 2024 20:59:53 +0200
Message-ID: <3da13298-b6a6-4391-b8e8-5dae9a28b860@web.de>
Date: Fri, 5 Apr 2024 20:59:52 +0200
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
Subject: [PATCH] usage: report vsnprintf(3) failure
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:STRnDC9IcicMbl2ubgGEW9q3sC5SeJ8EK2GK0ScKaWvhtRK5kAT
 jy3r/uHXdAp+UmfhNhuvYGDlFd4rBdyw3wRc9g0ssFX8loB9DhwZ83z1Tqbq3KEHyTupwOP
 GrkL5FZoZzLmDeBaaxOvmjkl+q6oKkYyfBOl4z4FRqol5tFVfzfwIh4WG1FnGBQGI3/SGcB
 L2Crp1ukQu45cOW2gau0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FpXBJxuPlww=;7aJ+VOFPAYtaXBw1vtilV37W6zj
 YFhSrA1u3QUI++YELYzoCyl9Vx9czVwYfbkS3jdJczwxTGIkWwi70ZETiT9Cfpse31vJgOR3P
 wlS4K9zsaC2j4TKOOEPII04qr2YdSSeuLF4NksDgwBsTj6G2OTjYCJJ/0UuB4Dd4VGCDSL4kq
 kJ5z9PdMKI3wrC6WO6VaDekhFMuGHpk1047mHI5fx/sORIw8jNBiRABkhz1QGcqK/09YArnyC
 nDYyn52XM0i46PGs19Q0+Y3p83iB8p2LvyAhuGk+afzHk37d8GeqKYLPjm+geyYwKICUP8o3j
 v4vzwqnCCZW1s4mUwJqH2lesvQCxGcK8LkI9r9/ibdMMP+EbKeOKiTzB90BG8q3KQfaKVjXP6
 qo565Nz5EYAJN8OqvBG5kOgFIR3/FiJA8RNqbMlfynA7pbaCzV/uY1DZSxAN2irev2sTcr2w6
 wQW5lVup62FyO4uZMfKSSiooPuAmuffE1HtLuSaV+Anw+OIT4qKol6tTMgz1XdTvZZ9R8Wu3i
 aHL3T9jV4ARab4i5vUaYMFTrIylRZz+eRhG/Ww3we7y6D+OBA6/TAaMWhRPWEWntO+wvcUzVD
 qzOMCc5/sVBux41/txorFth3M4oy5xdeHTZcbJljRH+0ZD2XZKH/nzg3Pr3mAj65t+3EBTIxT
 m5CddL1wXTD+f/xxGVFmScUgClv9mm0YR7yIvPI+KrmP6G2ySnR1FXBSeSNFTFY20pkPsI3OU
 uvXgqpUQX7ctw221D+dcF8cd+UB/rjfVHNK06tI+U9PfnfX04B26Gjiw6l7RwqAzXE3YG5RcJ
 Ro9tLL+8qPsjGezVXcTQcswv928ifxjwRoQxWkqon8C7Q=

vreportf(), which is used e.g. by die() and warning() by default, calls
vsnprintf(3) to format the message to report.  If that call fails, it
only prints the prefix, e.g. "fatal: " or "warning: ".  This at least
informs users that they were supposed to get a message and reveals its
severity, but leaves them wondering what it may have been about.

Here's an example where vreportf() tries to print a message with a 2GB
string, which is too much for vsnprintf(3):

  $ perl -le 'print "create refs/heads/", "a"x2**31' | git update-ref --st=
din
  fatal:

At least report the formatting error along with the offending message
(unformatted) to indicate why that message is empty.  Use fprintf(3)
instead of error() to get the message out directly and avoid recursing
back into vreportf().

With this patch we get:

  $ perl -le 'print "create refs/heads/", "a"x2**31' | git update-ref --st=
din
  error: unable to format message: invalid ref format: %s
  fatal:

... which allows users to at least get an idea of what went wrong.

Suggested-by: Jeff King <peff@peff.net>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 usage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/usage.c b/usage.c
index 09f0ed509b..7a2f7805f5 100644
=2D-- a/usage.c
+++ b/usage.c
@@ -19,8 +19,11 @@ static void vreportf(const char *prefix, const char *er=
r, va_list params)
 	}
 	memcpy(msg, prefix, prefix_len);
 	p =3D msg + prefix_len;
-	if (vsnprintf(p, pend - p, err, params) < 0)
+	if (vsnprintf(p, pend - p, err, params) < 0) {
+		fprintf(stderr, _("error: unable to format message: %s\n"),
+			err);
 		*p =3D '\0'; /* vsnprintf() failed, clip at prefix */
+	}

 	for (; p !=3D pend - 1 && *p; p++) {
 		if (iscntrl(*p) && *p !=3D '\t' && *p !=3D '\n')
=2D-
2.44.0
