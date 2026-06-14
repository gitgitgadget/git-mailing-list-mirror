Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805422D63E5
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781454518; cv=none; b=i4pXunIJDlcLWjfg5CKdryfEdOZFQoX0yGCIDVTYv6bh3188XphTaxPhFCyikx22jHEgX9rABQolkG3EXo7E3K1jeuqhVATwgB2bz0cC9XgXSkmI5B6NS4P3RRpflTtwI35QDA4vP2pOuTFRP876rsRc7p1Q/4FWL8L/2VmIJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781454518; c=relaxed/simple;
	bh=vTb+zIGkgA0DWRC7deDe6Fu6hGp+VEug9yDSHeFjZ5E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=fESKo+rjCVRnUQkm0QJNYgqmmXJ87lrs6v/9HN697bGte7cCP2qOmpUwQ8CaVsfbMieCF1HgpNnQPtIDG/MWmL81gkyGzW+EnUGTEVTKvrW+2CZ73Sz2uZYX2UEy4jbWOiweDJY2O2nWPncDsWA30amRAdEE0K8283lBvfR2ajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=DiwIbUkQ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="DiwIbUkQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781454514; x=1782059314; i=l.s.r@web.de;
	bh=lLPI00WmPd8qKmpTAkv1mYVnPJJlCVzYHPL0Jg5zvkw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DiwIbUkQMr6Y7i+Z49gWIqWwvnVsPiJi0Rzf6Zr1lLiWTXoCM+YHBkY5/l4rj+La
	 nT6SkVTbhnUZGCRzxh7x8Dl8JYGYXcwJ70Yj30rpXWwPD4Ol92H7Y0W+YNfIZnzc9
	 mfHcwwS9l5Ik0DDkmryNG8xs4cpdXbNca3O3VRa3ciBtzK94R3uXtiE5UHVBSBiES
	 xGJVxyVPwqrp24AGz9axJBb6/XC0cYTrV/aJqFSCYISkvr45zRWFYCrN0yIlN5l0C
	 P7YdEyX/dXtoKp52dZv00DQ0KFNBeveJTwzFmEeYKyanLg6VMBI9U7aHAo8LczFDI
	 tiuf2jOen+1N51RcyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWsm-1wo8j41ldY-00MmVH for
 <git@vger.kernel.org>; Sun, 14 Jun 2026 18:28:34 +0200
Message-ID: <5a7ed929-6fe0-496c-83bd-65dee57c2241@web.de>
Date: Sun, 14 Jun 2026 18:28:34 +0200
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
Subject: [PATCH] cat-file: speed up default format
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S0voj87OnA/KMlLgRsJYjQ6eb4D2IWUG3u6fuBdlbqz0mRfi4RF
 OIjV/e7HviWl0UrUlTJOywuTKZ1Ng7AEK4z0WlmmXZx4G7vbXsBieD5BuUN1z2n2CZESnFF
 gCxdmOm1LscRDVQwiLR/ycIp6qjvZ1W73KQanqswOCaLhHXOpvuY9t2rn22MfuSL4GAclcs
 GPrEt+snq8AH6/+lDlBoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KJum6qaHuCY=;UM/TinpGtekf0u/zW4MZrQGWjB3
 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

eb54a3391b (cat-file: skip expanding default format, 2022-03-15) added
special handling for the default batch format.  In the meantime it has
fallen behind the code path for handling arbitrary formats.  Bring it up
to speed by using the new and more efficient strbuf_add_oid_hex() and
strbuf_add_uint() instead of strbuf_addf():

Benchmark 1: ./git_main cat-file --batch-all-objects --batch-check=3D'%(ob=
jectname) %(objecttype) %(objectsize)'
  Time (mean =C2=B1 =CF=83):      1.051 s =C2=B1  0.003 s    [User: 1.027 =
s, System: 0.023 s]
  Range (min =E2=80=A6 max):    1.049 s =E2=80=A6  1.058 s    10 runs

Benchmark 2: ./git_main cat-file --batch-all-objects --batch-check=3D'%(ob=
jectname)-%(objecttype)-%(objectsize)'
  Time (mean =C2=B1 =CF=83):      1.012 s =C2=B1  0.002 s    [User: 0.988 =
s, System: 0.023 s]
  Range (min =E2=80=A6 max):    1.010 s =E2=80=A6  1.018 s    10 runs

Benchmark 3: ./git cat-file --batch-all-objects --batch-check=3D'%(objectn=
ame) %(objecttype) %(objectsize)'
  Time (mean =C2=B1 =CF=83):     979.0 ms =C2=B1   1.1 ms    [User: 954.1 =
ms, System: 23.2 ms]
  Range (min =E2=80=A6 max):   977.7 ms =E2=80=A6 980.8 ms    10 runs

Summary
  ./git cat-file --batch-all-objects --batch-check=3D'%(objectname) %(obje=
cttype) %(objectsize)' ran
    1.03 =C2=B1 0.00 times faster than ./git_main cat-file --batch-all-obj=
ects --batch-check=3D'%(objectname)-%(objecttype)-%(objectsize)'
    1.07 =C2=B1 0.00 times faster than ./git_main cat-file --batch-all-obj=
ects --batch-check=3D'%(objectname) %(objecttype) %(objectsize)'

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/cat-file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2b64f8f733..d7f7895e30 100644
=2D-- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -461,9 +461,12 @@ static void print_object_or_die(struct batch_options =
*opt, struct expand_data *d
 static void print_default_format(struct strbuf *scratch, struct expand_da=
ta *data,
 				 struct batch_options *opt)
 {
-	strbuf_addf(scratch, "%s %s %"PRIuMAX"%c", oid_to_hex(&data->oid),
-		    type_name(data->type),
-		    (uintmax_t)data->size, opt->output_delim);
+	strbuf_add_oid_hex(scratch, &data->oid);
+	strbuf_addch(scratch, ' ');
+	strbuf_addstr(scratch, type_name(data->type));
+	strbuf_addch(scratch, ' ');
+	strbuf_add_uint(scratch, data->size);
+	strbuf_addch(scratch, opt->output_delim);
 }
=20
 static void report_object_status(struct batch_options *opt,
=2D-=20
2.54.0
