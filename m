Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A048299AB4
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750770015; cv=none; b=Y8cgT7L+ysFTCXGbS+IwzMk1l4iPneGAdH8jDta/7CS3oKpcbNE3w+CpADUW+NLq2wrTuOtsW5Wl5dCd5akFtDglk3hd8/J73pwAx55nmmqnMdXH1s3ma5cJnWxed/zY+vO2eb5ClNjls09T46nkDQyqwsu/fsQCEDTpg6W2qPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750770015; c=relaxed/simple;
	bh=OZuSol3TZsA7sjaXA4l469FN6Lorq7yQW60gDOqjmhA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aPpKo+qN07hUsEbUXdXfHfCrMzZMNNsRamZTSKlX1q6aQxYAhrnniYcA9ojCQ2vgBzuIWco5Ll0NwO+kozhoyutVjgXFLdz+TbGZ8FYAdKFgIvz9/EbnOlZyIM/5aC9WQZlAcDi6TCGk+bl23WdrdeqKDhzw/xYBAuBp7VIZhZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EWORJEw8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWORJEw8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750770013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o7gFjeTLYSD68xnO9ojGiTrINp5tMybXxigddDvyePo=;
	b=EWORJEw89NDlOuZzqI/vY2pdVea9IrVIcNrWGK6BNjpTHIrmuqgk6tylFYanVg7isgNLeA
	nQ5h8xVyBRKKQKa/5CZCwFsAOpcBrAcesNf/bzneAt5xw2HRKVTkHDm8ek2qeYwsMtu77B
	INIG0WrbJcseetrYLO/F1qH65otEZIE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-CE1mxiFvPLKPYATXXkCRDA-1; Tue, 24 Jun 2025 09:00:11 -0400
X-MC-Unique: CE1mxiFvPLKPYATXXkCRDA-1
X-Mimecast-MFC-AGG-ID: CE1mxiFvPLKPYATXXkCRDA_1750770010
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-acb66d17be4so36105666b.2
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 06:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750770010; x=1751374810;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7gFjeTLYSD68xnO9ojGiTrINp5tMybXxigddDvyePo=;
        b=p7KzcUDxRa8BaXCiH/DaXqMdfUwNAW9TdVEw2rFGQSUylNVerm7nBUwGE0Km6/hYWT
         DnvkQB/GPPoremKnadB7mEWIE0gn6ubORj8hKqGJo2BOHD9XrLFoxoOPEqpRd2ybO/nr
         JdBD7UycXiHAXqqtTcllMArC32tyh37hYFKRyjDDaV9k1WsrjBcWbG7kbf2D3R9ZxTur
         ScRAZvJKd3EhQLPQXhcwexBpw7dW/5HS++aKLE3xDRklD2vFV9ShhsqV/oooN3i5PTuY
         sK8ZOpkuBBm2D/ZRH3cCBE6FET3T/BPEf1KaZsvYZMTZvhHA8eU1JJ4QrFwDDVrQO0yT
         8MgA==
X-Gm-Message-State: AOJu0Ywj+0EJtMyznItpkTTvNeytkZD6g0tOGr3rOfkUt/3t4XryGqp8
	ysiJWZqaaVgyaFYG3d4b+GdWbO//sqPB3Fq+42wp/XtFbXHuCsp0lkTHfKn5ZipLErySxDCIJzC
	iBWUFtD6y60MGNkY2SMt3Gz69OjTKDslHPEVGC1sjYNQIkoAlIiBlKbJm5dqSBj+XSKSzuPYOb+
	tI9g9g7xmMfZe7FkNndGBB1MA815rtfDhryqU0EZ5YpQ==
X-Gm-Gg: ASbGnct3mTpdPlOyKqjacgfDZXXq9Abhmc6IWS1vsH7QheZY9q63a2XqeNtYhufQfvz
	DW/aL3H7Kif3fld7OG4J4x65UTlhIXqsTy+t4KEmKlKFfbxqPJpFd4dFv4ERZbcUMlkrs93amJi
	3+Ikc=
X-Received: by 2002:a17:907:86a2:b0:ad8:9a3b:b26e with SMTP id a640c23a62f3a-ae057c8d395mr1578790166b.56.1750770009647;
        Tue, 24 Jun 2025 06:00:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeOR1PnQ6HhTxq5OeCKZXB00yyJBnSqUJ6YGJEH6e5f065jLRh8IAAWSoeQeAzOgZbMbegFtJEZlAv6/dD6Kg=
X-Received: by 2002:a17:907:86a2:b0:ad8:9a3b:b26e with SMTP id
 a640c23a62f3a-ae057c8d395mr1578786866b.56.1750770009113; Tue, 24 Jun 2025
 06:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Pohorelsky <opohorel@redhat.com>
Date: Tue, 24 Jun 2025 14:59:58 +0200
X-Gm-Features: AX0GCFu-uqc45x8Cd689Uhm4SMZ7i6WWhhzRckhdBcTPDIbe6oETeswwhZ04Les
Message-ID: <CA+B51BHEB24JNzOroTxFodxiuPJ1=Vj7KRFevrm2YatnTVuoYA@mail.gmail.com>
Subject: bash: unescaped `>` character when switching branches
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Our customer has found a possible issue when switching branches.
Output redirection character `>` is not escaped properly when
switching/checking out to different branch.

Steps to reproduce:
1. Create a new branch and switch back to master
```
$ git switch -C 'issue#1234>/tmp/dangerfile'
Switched to a new branch 'issue#1234>/tmp/dangerfile'
$ git switch master
```

2. Try to switch to the created branch with using auto-completion
```
git switch i<TAB>
$ git switch issue#1234>/tmp/dangerfile
fatal: invalid reference: issue#1234
```
3. Verify that the /tmp/dangerfile has been created
```
$ ls /tmp/dangerfile
/tmp/dangerfile
```

Internal interpretation of the created branch:
=E2=94=94=E2=94=80=E2=94=80 refs
    =E2=94=9C=E2=94=80=E2=94=80 heads
    =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 issue#1234>
    =E2=94=82   =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 tmp
    =E2=94=82   =E2=94=82       =E2=94=94=E2=94=80=E2=94=80 dangerfile

Tested on Fedora 42 with git-2.49.


I've found out that this behavior happens only when using Bash. Zsh
properly escapes the characters when creating and switching to the
branch. Git shouldn't be tricked into creating a file when the user is
switching branches. I'm not entirely sure where the issue lies in the
code, so I'm not attaching any patch fixing this.


--=20
Ond=C5=99ej Poho=C5=99elsk=C3=BD

Software Engineer

Red Hat

opohorel@redhat.com

