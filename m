Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528EB665
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 23:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752276281; cv=none; b=darCIg9hMGrt4s6aQc5Q7155BIxnonOI3cesHC600NcgfjaBxKUzvBo1+lqwfmoMOMpMI2XAy449z1Rpp6xzVsWxOyzJBeoKF934YR8WZEBu4A9tHOC/cC0+IkRShdPjeyxsvp4T+yJHK3UM4wvhHvGa3f7YB310Ftcrxnmcv8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752276281; c=relaxed/simple;
	bh=sNVEaHcQ8Ylt04KLtC8s1rI+mo4H+XvvNUfeg2fXNNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omYJqN0wncRQwMzQQStJkblPgOb/q1VkiH7difgQvCqD1BtrP30cet6ueqEey30Axh3k3IH48mlnuHKqr1sRQ5eW/mtJNzPCzrbewlud9ARgw0ZIb5llvGIlcus2DV0AFyNI+gQs9t0JcThAYZ3VD3A6il3xyX9DBLbfA13p6Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at; spf=pass smtp.mailfrom=gmx.at; dkim=pass (2048-bit key) header.d=gmx.at header.i=jonas.brandstoetter@gmx.at header.b=ugRxXn6D; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.at header.i=jonas.brandstoetter@gmx.at header.b="ugRxXn6D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.at;
	s=s31663417; t=1752276271; x=1752881071;
	i=jonas.brandstoetter@gmx.at;
	bh=SXxaG9CtORERsmttXkagwPfuiZ8/TFae742+qfLTpKs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ugRxXn6D8iw5+H9nZbyXl/zLLSTfPkmjJ9ZYSLqEASJ8VQR93NAEyro8Gmtr55lg
	 HB8vU5D/002ZaLStLr0Jupce8MRwGvMQwr1i3dbwJ6HKKNyi4RDF1snIS0IqRXOXH
	 tq6trNTqgnCJdOeOM9GoT7s3Y6iWsMJ3lNiEiQYrbhxw6ZS2vOLi109QY/mZP+j53
	 jsAc5UerBpwObnLzA44vYj2fNSL14juDx/LCtuwcK0Lt3gs4AjBjMk8g+ntLSGBT2
	 sdYSjuIIjB/ejxHv4xZtcY7MAq4IZGz+ModoEkXbBTGXwVQ/PxIkiQ46inqqeEJ6O
	 Ox9gZP4SNDi5smi9qw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from fedora.fritz.box ([185.89.163.201]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QwW-1ukmjp1AJi-0133ko; Sat, 12
 Jul 2025 01:24:31 +0200
From: =?UTF-8?q?Jonas=20Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Brandst=C3=B6tter?= <jonas.brandstoetter@gmx.at>,
	Fabian Stelzer <fs@gigacodes.de>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gpg-interface: expand gpg.program as a path
Date: Sat, 12 Jul 2025 01:23:47 +0200
Message-ID: <20250711232348.460804-1-jonas.brandstoetter@gmx.at>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAF1X4d7N1xdZt9JkVZytbEU1=7q3X_F_nqm4EG82B8-cVa7g8Q@mail.gmail.com>
References: <CAF1X4d7N1xdZt9JkVZytbEU1=7q3X_F_nqm4EG82B8-cVa7g8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wDe6lm5h5U/8qojBDaJY3CxeU8n2LeW87ImqS+KSnASlmzc2w1Z
 iOmdh3/3+oQz2i1l2t2n4ue1UbWppLZLK/Am4/HRjqDYzJOGDMcN5YtFzBY+cO0dB9PXnfU
 5TUEG6xWa+FMonjd84njOoCMOdittluBF+V0RI2gFJpQvyP265B1OJASRyeVVmph6uLKEWh
 m9LggBW1echJvTyaCMBYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wTgWks/X7Ak=;FuebNLS9BrH4YcF5QOXdyt3REli
 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
 Ul9qNUcfZc6kNasUsEy7W644GpkhQg3gYHP

This allows using a custom gpg program under the user's home directory
by specifying a path starting with '~'

[gpg]
        program =3D "~/.local/bin/mygpg"

Signed-off-by: Jonas Brandst=C3=B6tter <jonas.brandstoetter@gmx.at>
=2D--
First time interacting with a project via a mailing list. Do let me know i=
f
I did something very dumb.

  Jonas
 Documentation/config/gpg.adoc | 2 +-
 gpg-interface.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/gpg.adoc b/Documentation/config/gpg.adoc
index 5cf32b179d..240e46c050 100644
=2D-- a/Documentation/config/gpg.adoc
+++ b/Documentation/config/gpg.adoc
@@ -1,5 +1,5 @@
 gpg.program::
-	Use this custom program instead of "`gpg`" found on `$PATH` when
+	Pathname of the program to use instead of "`gpg`" when
 	making or verifying a PGP signature. The program must support the
 	same command-line interface as GPG, namely, to verify a detached
 	signature, "`gpg --verify $signature - <$file`" is run, and the
diff --git a/gpg-interface.c b/gpg-interface.c
index 0896458de5..3dfbc45385 100644
=2D-- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -783,7 +783,7 @@ static int git_gpg_config(const char *var, const char =
*value,

 	if (fmtname) {
 		fmt =3D get_format_by_name(fmtname);
-		return git_config_string((char **) &fmt->program, var, value);
+		return git_config_pathname((char **) &fmt->program, var, value);
 	}

 	return 0;

base-commit: a30f80fde927d70950b3b4d1820813480968fb0d
=2D-
2.50.1
