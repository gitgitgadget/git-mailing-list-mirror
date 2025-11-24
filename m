Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703DF8634F
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764016731; cv=none; b=KJDYlKt7sVtDd94j0ACepZt4Mx+QjpzJgElN5iolRFIlQdZNUna23f+0o82njmUCbh8U700QOhiuJhIscxNh2SdEiEAOb++yH/2+paYngOcTRAXn65oY4nijZz6WbrRzUsIjoABNanHSFX77Qj2bKu4ik+yoFo6yefZb0gsFD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764016731; c=relaxed/simple;
	bh=do452ta8iGAlTGsetpldvouxuGArrtpeTvzZpdDjTyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ikAViA5bTZpAUUPuIJmd/vbnBw8UoTned7eay5mZsh0uLNIV3R0ycR648P82Aajhbk2AXa/fdsXqlq/6EYMMqvlV2PIVuZLakw/zP2jQvEaqz8zWBDzZnNOg7s39EruAXF3qTp1EVXHPRi278U7Xk5J9zm3JngAiX1+KbD482S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=E5ZbjCf3; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="E5ZbjCf3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764016726; x=1764621526; i=l.s.r@web.de;
	bh=58hWEJCjw7BYR8EMw2aMrKB0O14XscQSYy/DbKvJy/E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=E5ZbjCf3GNO5V/JHNMmcmOLk21IJ8O1PWbhIsxHUMQSJ9vj1hkq+Ox4b40xI4ZUw
	 3VIbBIkDr6tGRYsRvwuERmc36IPWcA/iH22OIpYusM2+m68py/iJe9pYzEkQReYsD
	 qlRFk2EiUvbSoKj0J5/0xULl33iWPVSXG1TN3bYLBoLwgHGKNuoUc2g1CEZDz3dGl
	 /sVj+70p9hi0vTYlS6vU71RblqEYaOCe9Mq6Ux690CO3gHgImnkGJZl3A0r3NEohm
	 lEYKg9n7gmoex5ahXPi1soys0h+8jtph4PeFwtO5kxioG/OoAql8V9IOR6OgMY7TY
	 wgMY67eOneImgtohag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.16.127]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgX3-1vqxjS1b8l-00jP9O; Mon, 24
 Nov 2025 21:33:25 +0100
Message-ID: <c09945fe-fee2-47f6-8193-ac60d7245209@web.de>
Date: Mon, 24 Nov 2025 21:33:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] config: fix suggestion for failed set of multi-valued option
To: Paul Wintz <pwintz@ucsc.edu>, git@vger.kernel.org
References: <CADBJ995pDG9R8EJnK5nwWKPWAf-XF5P5KTY+bAx71EhdMvvO6A@mail.gmail.com>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CADBJ995pDG9R8EJnK5nwWKPWAf-XF5P5KTY+bAx71EhdMvvO6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DeGJlm6mkVtncLgKBZ3gJGqcbzCgPfhsh3pAPZhcXBdO+qwx0HR
 3iSlKdsmVOCrgypDFFKcFMBQFkupPdqk+qy1n0p9H5zeyJnqlINEnIxorfZKfkQ+P+naVsG
 ldL+vcPhYdWm1znBgRf+lR7JXpj6wLiwejWakfz9mJUtnD8bCjy2xpTQQsFaiGTc2dzcOyV
 c14OxgxGdqhULUYhla09g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IooeUt8QvHU=;1czXA8y4jn5MdeuvXLh8YpBkzY3
 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
 yjlZx7lStu1rTG8HU=

The command "git config set <name> <value>" fails for an option that has
multiple values.  List the "git config set" flags that can be used,
instead of old-style "git config" actions.

Reported-by: Paul Wintz <pwintz@ucsc.edu>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Resent as a pure patch because I messed up the scissors line.

 builtin/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 75852bd79d..86e0cd77f3 100644
=2D-- a/builtin/config.c
+++ b/builtin/config.c
@@ -985,7 +985,7 @@ static int cmd_config_set(int argc, const char **argv,=
 const char *prefix,
 						     argv[0], comment, value);
 		if (ret =3D=3D CONFIG_NOTHING_SET)
 			error(_("cannot overwrite multiple values with a single value\n"
-			"       Use a regexp, --add or --replace-all to change %s."), argv[0])=
;
+			"       Use --value=3D<pattern>, --append or --all to change %s."), ar=
gv[0]);
 	}
=20
 	location_options_release(&location_opts);
=2D-=20
2.52.0
