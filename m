Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A314B18030
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722397298; cv=none; b=Xpq+enzEKtBVfVmK5A0EmxxnpwTQUTMawH/j9lw5gDgcj+4pATPHnQ6qoNtH0ebxONXS8PPl0L0a8j9Vk+AFI0PPCWx9uyGRyJ5jDLB76JOJJwvagziMd5+xk68n72rIrl44neldjvX3DgCrtT+eR1XhfQuQydI7cbSu2QzpZh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722397298; c=relaxed/simple;
	bh=NnJcXSJdL99fJ+lh3h3lUwNqML4RbgXsVJtL/5xtjEg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FMeP4js/DlLbt9psJBc6GzWaHKg+FMU66sILniByApwJoeq8UdNwE5Reqig0umBExApBqlJPvkvWVPeVdPs5XXPq6bXh9ydvvso71lrxO8iBrCpqKCUAj87qUCyE5BUpIf+Ax96xD1uUqZBDzE8I4aKg6nQCBQ7a8Rjasfxp0Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Or9aEvuk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Or9aEvuk"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428243f928cso11878885e9.3
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 20:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722397295; x=1723002095; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=diZ4Cw1OG1wSLvrRW/K90Wsd3DrK6WuvSyo8yMw1bfk=;
        b=Or9aEvukPYHSsMjT9nzbCkxaOwDoP4ak5lSSLMMqT5ZgB9DFmPMfMJbEfuNzcqfYXf
         6kEmC+LoM8h7KyPhG4zyAKqLkOTkWuVo7yoiVf5QDVdobP+jSOK0Ug5kRvbjipgkhYYA
         fD4cYDWHSwrcflFfoF6+pgoT8XzSvM77MMqtPWhKAzT3RyFhu5T8kd9YcPJ+73SXuW8h
         6IxcKjh2e8mX+o63/Kf8ezG5bqo/vg5av4DCYfRLVU5/tOrktGqayzUeA4m+/QT5vll0
         SawSQPoFIGARC8yL2cKvAR/YAjatLVgAa4h/531Hs9or5Fe7brPmye+yIA30ma0kyVUi
         bAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722397295; x=1723002095;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=diZ4Cw1OG1wSLvrRW/K90Wsd3DrK6WuvSyo8yMw1bfk=;
        b=XPuNa+QapOb1Z4EhRehAbar7zNdrMXFCQuXhcWdOILYdsH4WbimpOxw2MZLXybrCNo
         87d5X41dpYoe+BSs80UgCcGpkrU5ztok2sVOstzi1OYJ+YUkpGqja6cArVO7i2gJR/wQ
         BMptx3gdiW13tBq1MVuRg+UJj+4tFjXtV9SgDRC+2zxPgbWT8R6+tGUE/efme2kXK/FW
         VkoQyC+GrxrE+uTDcKsUxdxSlzRqazb9NaLGsQE68q7acQYXdh7olCxmfZnsNYOwxh9a
         Hbtd0e6olZWZtBZwlKg+3hn143q4XNVS9qlTYm39140MzlpKYYmescHWnM1pNldL6Vbu
         8RSw==
X-Gm-Message-State: AOJu0YwWmMIPk6OPBUiIGMfahIMrpNzKspSlAcYw2s7EiPfA+GPwa39w
	3K5fGs6k7Z/LCqBZqACBYhJg0SAFVshdiofjHpxZ1JwKJFPthqm33NCBHQee4YDeQlWfTvhG7XH
	WGouEB4f2yBusVHXC6GXO/fiFIoECOeGxYK4=
X-Google-Smtp-Source: AGHT+IHfaoKSUxMNSZoel826qbGUBL1giNutKp5/DKAWZz3HZjZHW2ZoqHI59lncuCgpje5GKB4FCdExxfqDBH9ReHM=
X-Received: by 2002:a05:600c:4847:b0:426:8ee5:5d24 with SMTP id
 5b1f17b1804b1-42811da0967mr91697715e9.20.1722397294571; Tue, 30 Jul 2024
 20:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hong Jiang <ilford@gmail.com>
Date: Wed, 31 Jul 2024 11:41:23 +0800
Message-ID: <CAEcKSiyo3dyNpGkE_FWE-Y710RV0H3EytM2psC=+by=4wP5qpg@mail.gmail.com>
Subject: [patch] credential-osxkeychain: Clear username_buffer before getting
 the converted C string.
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I encountered this problem with homebrew after I upgraded to macOS
12.7.5, but I am not sure the OS upgrade is the only reason.

After `brew upgrade`, I received the following message:

Error: invalid byte sequence in UTF-8
/usr/local/Homebrew/Library/Homebrew/utils/github/api.rb:182:in `[]'
/usr/local/Homebrew/Library/Homebrew/utils/github/api.rb:182:in `block
in keychain_username_password'

The related lines in api.rb are:

        git_credential_out, _, result =3D system_command "git",
                                                       args:
["credential-osxkeychain", "get"],
                                                       input:
["protocol=3Dhttps\n", "host=3Dgithub.com\n"],
                                                       env:          {
"HOME" =3D> uid_home }.compact,
                                                       print_stderr: false
        return unless result.success?

        github_username =3D git_credential_out[/username=3D(.+)/, 1]
        github_password =3D git_credential_out[/password=3D(.+)/, 1]
        return unless github_username

So it looks like that git_credential_out has invalid UTF-8 byte
sequence. I print it after the system_command "git":

password=3Dgho_SHADOWED
username=3Djdp1024=EF=BF=BD=EF=BF=BD`
F=EF=BF=BD
capability[]=3Dstate
state[]=3Dosxkeychain:seen=3D1

and

echo "protocol=3Dhttps\nhost=3Dgithub.com\n" | git credential-osxkeychain g=
et

reproduced the problem.

So I made the patch, which zeros the username_buf before retrieving
the converted C string.

From: Jiang Hong <ilford@gmail.com>
Date: Wed, 31 Jul 2024 11:05:44 +0800
Subject: [PATCH] Zeroing username_buffer before retrieving the
converted C string.

In macOS 12.7.5 and 12.7.6, the uninitialized username_buffer receives
a non-NULL-terminated C string.
---
 contrib/credential/osxkeychain/git-credential-osxkeychain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 6ce22a28ed..89cd575bd5 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -137,6 +137,7 @@ static void find_username_in_item(CFDictionaryRef item)
  buffer_len =3D CFStringGetMaximumSizeForEncoding(
  CFStringGetLength(account_ref), ENCODING) + 1;
  username_buf =3D xmalloc(buffer_len);
+ memset(username_buf, 0, buffer_len);
  if (CFStringGetCString(account_ref,
  username_buf,
  buffer_len,
--=20
2.37.1 (Apple Git-137.1)
