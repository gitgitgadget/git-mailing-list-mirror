Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD331CEADB
	for <git@vger.kernel.org>; Sun, 13 Jul 2025 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752392652; cv=none; b=RJrX4qQ/iYnp4mG20DpWyUDp028ISFunf1dpUD/hkcCSwe0zWflfTXyvs7M4ifqSSNwGfJcG9NqFITYM8SK8bSST7OtnQ5u94cdgcDymEZ5yoHr7h67boxsHmD/OLsLeVx/fh4yvFCaZAy4gZ/1+pmmS4SN1ZipJnHn8PvXiRaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752392652; c=relaxed/simple;
	bh=jiE5NZkwjRmn8AWvQSqXeq3eHd0SjFCPyQOPgpCzTWE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VlMMaboN6W9oMh7rzQWgZeHvxTr6g/0aVjHfOe9hb8kuX+4M2Yr/7JsLD18SHbkF/F7Q8NNhX56elEbICO85tRAtrzrM41GdUWXbjV/1TKMfUzn6wHEd+8ZIDQLujisEq+44er636NEaTeblBgwbPGuLAUBXiiQ6jB8EbTG7elY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oe+sNanH; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe+sNanH"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-234bfe37cccso27971055ad.0
        for <git@vger.kernel.org>; Sun, 13 Jul 2025 00:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752392650; x=1752997450; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDlOfqjQnffwlQKtrcr1k1WULhy4vSVmFvblG3p09ao=;
        b=Oe+sNanHzRWB1F8qGmlU2XGtYRDpMbr5NODEyyTfSLmIbzT6IL9/td4kt4IwSQlrmz
         mOZ9JByLGxb/8HpfeF9Ri5abqb2iBW7ZL+Iet5Ct9/49ea6LdPI+J+wdWi67syL1hdH9
         O7LWoJ6wkLTlnRYQO76a9gwJsyl2tTOi7SkLHAjzvcIZRawi/4E1tAv0bFMXNLte7Cca
         geFm3mHpFm8y7XAni9FbmXoVDGRLc530nbjuRRw/gXID9N1szlJjqq122QRxuqBnBi5T
         j/7uK1VlE5AK3RPM9LCWNcavKRs7vQ+BhpxRyjl6HkJS5MiNPIVED7w91rHLoINIMJQX
         D03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752392650; x=1752997450;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDlOfqjQnffwlQKtrcr1k1WULhy4vSVmFvblG3p09ao=;
        b=gvZotZrDGRjVTiN01ANIuiDyjFCAH1lxUo6PYLaLlj8yDsOiyctwG9D1VRQq1aZG9I
         wVzoGrMFU6wsNBxnmz2PnoqEuF+DLdXdBu6XCWSlTcWVzKcO1iZjw6y6pVh346zWJz0z
         58Qr3UP7NaKtTgaLlpX7+kkGsEXW5YnFN+qkNBQ5c89tL8/10sycOkKUmJhgoowgsDEp
         EnZL/6QzRzZtuLME4lTph8V9ehmgdNnWHFUB6CeGbHxAs/74IUgPNmbY4xDoN7YW00O8
         qPwQeAm62nkuEXZ/52mI7OFkXk/4z0PfrQEPHepNKpG3u2wmc+rgNkz2zI0d0nwopaTB
         55oA==
X-Forwarded-Encrypted: i=1; AJvYcCW/J7yAR6cspw7OnXp+Mw/ElXftirCQFW0OxILUZi8f7fcUtk48mvAaVSPMQ607kX174cI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws2YhIHu4wOx9ccFL56ELSf+kwyyrpV0rkPX1AQfN911lyPJO4
	WPEE73o2O/bnAAg9LqFrpOoklvKkqET08hZs3PHYacXUfLC1hDq8ut989IoRs/lB
X-Gm-Gg: ASbGnct2rGl1tsrbfV0mGS/zacVGOssHnzGxBTLpvI3n3WhNpjivvflLzhEp7q4vkEW
	HzaYp8jSIAHhrHzgxTu7Xg7UgMxW7CIlm6DhTovRNp5NCY4gr/mPxAGC5gXEIIGxZL7n/PHh9RN
	Ho3m4FgUYkY+x6sjENDv0ZDTayGAmNC8858idL+pE7HFpdXIx/Bew7LIJ+epATr4MoMyzRTCpzC
	3IkymafgIv2x19YrFNI5q/1/P8hiRhBoNKigndOH3EDcZHd6+Jw9CUWZBJ1+GssX1yAtJrIWjk7
	8nUNfIg2voHafpYJykeG9gcYG2Odt6J1IiERTiUcrElr1qNJYypmBnIJoglHlwj0fMQqdsVl15d
	FZCkiT30vkPpurRYDC8cGdEPfEsNXSy/xFuGbelSaUph2IO+u819Da4ofJKn7+qRmbg2ypYECEI
	ocReuaqBa405MmtxMxpGjEzA==
X-Google-Smtp-Source: AGHT+IEBpOxrC8m+E35cmStHYSHgYCZdxgAmy7U5NCQl71z63/qb+zy8QPNcnAcx3daNBvo6VIuNUw==
X-Received: by 2002:a17:902:f70c:b0:234:8a4a:adb4 with SMTP id d9443c01a7336-23dede58612mr131233065ad.21.1752392650194;
        Sun, 13 Jul 2025 00:44:10 -0700 (PDT)
Received: from smtpclient.apple (awork062012.netvigator.com. [203.198.28.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42869aesm78142855ad.17.2025.07.13.00.44.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jul 2025 00:44:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: Why doesn't git core.eol=lf work?
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <sAxC2ASixUyCVtsk22zrxI2vAeM546T7O2tyWIS2vv_TGFo2OXWegg8J_r0zGzo5bZOA-BrwHa5yjAv2-Ewusjv9Fa9YYocrRkaIfpxhv_c=@proton.me>
Date: Sun, 13 Jul 2025 15:43:55 +0800
Cc: Johannes Sixt <j6t@kdbg.org>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C41F422E-8C9D-4BC7-BA0B-57B7D13D6557@gmail.com>
References: <8jPyf4EU-z7W6OHX4j_kba2G-1c2RIDtgBcSkFjWSNhMuE6pxOOyxSGBnguoZvuDQSaJPypH0u1vLJf6FBX_ahUn3bBO_1DVscfOQm4Jovw=@proton.me>
 <QcbAE4JJXpU-NcQ1loYdHthi-nYA2ZXcuuetCHE_0N0fRi0mdaf90VaLk0Y2ehrnVzoZraYO7jLhB7Pl68_k4l3HCqkFVGuMOzZ26cHYkfc=@proton.me>
 <23f2bbea-1294-4773-89d8-b270e2c3bb52@kdbg.org>
 <sAxC2ASixUyCVtsk22zrxI2vAeM546T7O2tyWIS2vv_TGFo2OXWegg8J_r0zGzo5bZOA-BrwHa5yjAv2-Ewusjv9Fa9YYocrRkaIfpxhv_c=@proton.me>
To: Jason Cho <jason11choca@proton.me>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Jason Cho <jason11choca@proton.me> write:
>=20
>>=20
>> Since you posted `git diff` output, may I ask if your concern is
>> actually the ^M in the diff output, which you intend to fix with
>> automatic CRLF-to-LF conversion?
>>=20
>=20
> No, my intent is to find moved or duplicated text among files.=20
>=20
> Let's say license_header.txt has=20
>=20
> DBeaver - Universal Database Manager^M
> Copyright (C) 2010-2018 Serge Rider (serge@jkiss.org)
>=20
> and another.txt has
>=20
> DBeaver - Universal Database Manager
> Copyright (C) 2010-2018 Serge Rider (serge@jkiss.org)
>=20
> My tool doesn't think the two pieces of txt the same because of ^M.
>=20
> Although my tool can do normalization internally, if git checks out =
files to CRLF due to core.autocrlf=3Dtrue, my tool is fighting against =
git. git shouldn't spend time converting to CRLF which is about to be =
converted back to LF by my tool.
>=20
> That's why I set core.autocrlf=3Dfalse, and ask git to normalize files =
to LF.
>=20
> So the problem is that, conversion to LF is not happening.

I believe that it's impossible to check out CRLF from the index as LF.
You have to use your tool to do that.

The definition of core.eol=3Dlf is here:
  =
https://git-scm.com/docs/gitattributes/2.9.5#:~:text=3DSet,-to%20string%20=
value%20%22lf

This means that when you use git add to stage files, Git will convert
CRLF line endings to LF. However, when you check out files, Git will
leave the line endings unchanged.

Thanks,
Lidong=
