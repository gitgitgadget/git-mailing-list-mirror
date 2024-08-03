Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6FDD53B
	for <git@vger.kernel.org>; Sat,  3 Aug 2024 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722688415; cv=none; b=qIfPdtb60Giv9Ez+Z2DpeB/JicOAxQh1aZlRgQPK9Lnu9lO3ZMYPcqz2ZNemiCwEac0r1vB8wcL47tF6GPeZnwggwcQmceE3ls+Teso7xIDE/Bi0UT/gDnzJxybOCJ+BIYkPhuE05a6PGhk3xGJrGAMjMTbM4jQ1Ga41LT3KJZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722688415; c=relaxed/simple;
	bh=1qOTGRwJNKayIIW4JonPR1VPauVIM/y/UeZng9dl1YE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=VxJ8PRUJI3PcoJ3md20EFfHkuC1bqIpCoaHi0ugjfLxuQUVJR5+iy2hQplQTHdL7cOFM126d/n1/7l80QELd1iC1m94JXJDnpRwhPJ4t20zwuwGG8RbtLxeeonVar32F7eZXR7J2wH3NAQfsM6ZYUAumF6EJhYS9gkpaMKCXZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=nAG9GUM4; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="nAG9GUM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722688404; x=1723293204; i=l.s.r@web.de;
	bh=ly8sWEWhiUFVnTCSVSXDu7oTHpXd3yPHynOB9ZhodRk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nAG9GUM48PkvUgGC7n8uGPKNZA7mLNnMomw8H7GrPbvJbJqBBSHvw9MxG2ctM48X
	 KEgREBbUs291QioqDTIDluFlti+aQRCgSzwQL4OjeWlxcwi61h43SMJBe66M7BIRa
	 +i0WHBYpgsXmVDgNL2WDanH9Q8x5MdRLxZlqAuc5ml/TUkuY6/Rgm8iBZA/9jOl8u
	 jWToiChnMx03Kzt6zfptsA6YhTleY85KgRAWG4dbJozSOqcsNQoNvrGKaAmHi2CrY
	 zw5/e8ej3h9Kffa30f8rQqvOvmmZjv9VsdF23Gvy8TJcky5qZK/BciEXpVvktlxWY
	 TUiU+q8iCRoPVeW1FA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.157.226]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK574-1so3L833UM-00QAHI for
 <git@vger.kernel.org>; Sat, 03 Aug 2024 14:33:24 +0200
Message-ID: <06783722-5184-41d5-8edd-94f97b2f2794@web.de>
Date: Sat, 3 Aug 2024 14:33:24 +0200
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
Subject: [PATCH] log-tree: use decimal_width()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hk4yIQzhdAIbhvM8Fgj+looJNJcNgGUoNX+fksHFal7ho06k6S8
 5lbBLOXHbBcjxYW+Q7tB2smw36PHHlEb5gNTkVLG3n0ayK/J3eIx17mF9WBOXaC6IhIekIc
 wlEycnSKwNOrS2udoTlYfbSWhzVeRqSXs5SWceZCQfGmRAWlMiH8a6vlGe82izg0xWrgOIs
 QhLhclDo6MRSqqImX513g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FlcCowtXV3Q=;9tKujyMKElFg0x9rB/gjw5buLOP
 N7tKLw93TijHLx+DNQwsoxs4cEZh6TgJJz7yNmx3bSBib5Vr8VxYShIAZirGaIeSy+wV7f+p4
 dGVBHV171524A5Y2q4VJgMO67zG3640amLh3/7YlV2mIO3XgIh7lw3JKkbsUz7fz+qP3ZX4/k
 cmUq/1qlQ23sG5KiPjOStA3bu8VdhlPd6PeFn2NCATf78bTdgJAT0R59F5Q2iO6qIGuhzgkbA
 9dlzFDELgAxxSJ246iJNBm2Ucn8oNuymcVcI/P9cIiznJCC0LzLpHyziyGnCxwkuWTZahjN2t
 YTJCEDhLZuyCqEtk7R5/2xtxcTXazZ12zAH6SM+5Gj+E39Wxd4oP76JnwBIinIPjTg4zzG5tm
 cbGcQKs9n0I9bWpvB9EZVY2uY/SeaKawl1W1WatMgFBge4sMPxVf+UYiHwamK77K0puCPZTyT
 z6LKVj6NbE33kDwE5kE3r4Kb0SgRgVe7QCTv4/DqX5ZGp5r4JocJS9U0PTI3Kt+jKF+rdrlxu
 1dmVH6ZyRXpM3auJIUiH7Fecfkk2mrYAszRkKvNBHj3pVDkXwR7XW5QFTw8Zj6JqApXXSQHfw
 Gp++3WCDE7geKiNlAw9r2einridFmRL4GpytGzonh5mwOFfjsl+0PzivYxfIvObHIOaW/h3de
 jE0WvRgP9Td4y7nfAsFs+lnG40Lj8qKBoB8cgTv5racfb2mDBf4q+UgTI6pLmlt+UolRVPNrA
 PAilH+ktPLWyYFL2KcU8KRmOUwd29DnQCqniQyPhd2BsYplbdO+4alBjjbRYxBQaKYmGpZS4k
 8o6LDbh4v57LfbIJg8V2bY3g==

Reduce code duplication by calling decimal_width() to count the digits
in the number of commits instead of calculating it locally.

It also has the advantage of returning int, which is the exact type
expected by the printf()-like function strbuf_addf() for field width
arguments.

Additionally, decimal_width() supports numbers bigger than 1410065407,
which is (hopefully) just a theoretical advantage.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 log-tree.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 576ef30d90..fdb24cbef2 100644
=2D-- a/log-tree.c
+++ b/log-tree.c
@@ -31,6 +31,7 @@
 #include "tree.h"
 #include "wildmatch.h"
 #include "write-or-die.h"
+#include "pager.h"

 static struct decoration name_decoration =3D { "object names" };
 static int decoration_loaded;
@@ -411,16 +412,6 @@ void show_decorations(struct rev_info *opt, struct co=
mmit *commit)
 	strbuf_release(&sb);
 }

-static unsigned int digits_in_number(unsigned int number)
-{
-	unsigned int i =3D 10, result =3D 1;
-	while (i <=3D number) {
-		i *=3D 10;
-		result++;
-	}
-	return result;
-}
-
 void fmt_output_subject(struct strbuf *filename,
 			const char *subject,
 			struct rev_info *info)
@@ -464,7 +455,7 @@ void fmt_output_email_subject(struct strbuf *sb, struc=
t rev_info *opt)
 		strbuf_addf(sb, "Subject: [%s%s%0*d/%d] ",
 			    opt->subject_prefix,
 			    *opt->subject_prefix ? " " : "",
-			    digits_in_number(opt->total),
+			    decimal_width(opt->total),
 			    opt->nr, opt->total);
 	} else if (opt->total =3D=3D 0 && opt->subject_prefix && *opt->subject_p=
refix) {
 		strbuf_addf(sb, "Subject: [%s] ",
=2D-
2.46.0
