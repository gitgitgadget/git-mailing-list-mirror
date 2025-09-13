Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440302C21F0
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778452; cv=none; b=djppjxQGwj/LOXe7gInvvUTmhhk2Lspip7YxQtEY6DpWq3R0bSuoVGCFSBh3OJpIUlexY45LsaweGZK2b9MokJNND7E48RzMuzVpLx3uTrcO9EHSs5YF4BQti6LC85ACwNUKWX7NrqcwDd/w7AzLc7L1qEKh7aY7j0sKTUPeQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778452; c=relaxed/simple;
	bh=XhytID6wQuicXf+XzEKj4O5do8r6JrQS3NjLJwgQ2Xs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WDAORpjazttBuSBWwmFaAbw0yb493iXoKWqjTy8G1gJhg55wjR32hUlqT/des9rYUr2ax8wiy4Gxf1uBEsrTwvyTrkfyBVzqp8unhKsenJF7ZGeX3DuXL2zjLUr0jIk+oa0MA6r3Fp84FWYdAXlDw0tDp79UkfC4S/wszU7jj+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7Ee+Fq6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7Ee+Fq6"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7761bca481dso930874b3a.1
        for <git@vger.kernel.org>; Sat, 13 Sep 2025 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757778450; x=1758383250; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uvq5q7/O7TaxLnqDY3TX4gCgF/v08IVBeImna9vUoHE=;
        b=Y7Ee+Fq63pLxfH3tpBdEqDXuJoV7Qm+99NsD/qLTh71YaLM0Ye68FAFU8S+x7+IRrW
         yFTKODkX/Xdk1TWOuXjUUx+AwzPrmGXO/xrBjd/SUgCVdKQpb8aIRYnw9Z9pF9kRlJQ/
         bgDUMYNdvHbZVbT/Uz+qt0uTR8lGQjYhy7GthniDEdGiNIE6XRL1HPm/MrJdVYveT3sd
         /X4CmpJNCjbBkJ6ZNNeIlvyklT8mIoPq09QyDxiMSkP3aXF0IrE38kVy5h3ChMeciuCK
         WlHm1uoZlROhKuiBBWC8szvrYQH8tnSriX3GsiASU9ncWxWt99/QkzZeFt2DSe3bS+Rx
         QfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757778450; x=1758383250;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvq5q7/O7TaxLnqDY3TX4gCgF/v08IVBeImna9vUoHE=;
        b=I3cHPBdg/993roIpX/Lfnel8V1M+DSyJbPqV9fBi59c9QYLBpIWDGUF4ySsZftwEhL
         Rngp/hcL2Wb0GBXAiMbFjWNkOb8dxhTFdjUCk6JylelqfMmf8J7K8Xrv20AnT5wQJZEn
         GS5tn8Pwgv+tB/jlH7uL2gmLH7pW77jOHwDOzKXU0zvE16JKL0vtFXFx7cFiINpsyYjq
         o33jdGimadRYtKG66sYUU8UUqY6BzOwp/QptqTvyRP7cXEygTMioBlSr9Sh9Q8GdpXa7
         sIaSwPZ37UMIqktP/hCbS0EfQihk1z8Q6jdblZdHIDAM/UfQSSH+IbI9VGUOp9LKpN5s
         LXBw==
X-Gm-Message-State: AOJu0Yzg2p0+rR3l+E1Qcnw9LOFzfYq/ImxrHfLi4vDAuidHbkluTh6J
	C1Qe5SCtp+Rs7N2NhzKvZagMINdztwVz34gplw3CgN/Pz9Og2lBey6f8GeRD9a/B73bbePPiO/d
	O6igJTOd/GKiaH+m8hRJyg75KsJGSynmdelBj
X-Gm-Gg: ASbGncsTbl4HTAcsjNep051W5x179hqTIoUWTM2gN+k1o1GZ8zUR1iptW1HXKTls3Wa
	wyQJ9u1kekTwoQvQ16uaRAkGDfDHzkvkqerR6JttMZ2y0ese1aa55tPjO6G+yUTBDiT/2SkUCok
	6TdM3sf5VhdGieuGc6hSdQqeEO2XM5nASt/lhIw/V4EZSxz7/KV3b8EMeFuF4KudqLMPDceX7kd
	C7HKN87Tge11Qtq1DgaiRVrSI9ggtd23G6JBaWH78KovSaf1OdSpErWiFW48ju907npiZt7MPHQ
	M4QT
X-Google-Smtp-Source: AGHT+IH8Af1vzEjjPHbaHQNukS7jDZQrlVP6c1s5E+EZUkHOmA8gnIV8IyAVpBCNwe0hIe/4vJNjEeIZ9pGa6DIAKW0=
X-Received: by 2002:a05:6a20:a11b:b0:243:c6d1:776c with SMTP id
 adf61e73a8af0-2602aa80246mr8277807637.21.1757778450284; Sat, 13 Sep 2025
 08:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sandra Malla <sandrammalla@gmail.com>
Date: Sat, 13 Sep 2025 12:47:20 -0300
X-Gm-Features: Ac12FXyWuCusioxJeuLgN3ttUJnZkTGBRyFMFzp-C86JdaMszHmd_K6EVG2t06Y
Message-ID: <CAFBn-2MdP=jw3mmF9G3t4hC9PnK=DxBiBzPV1smVmaFLU6FjDA@mail.gmail.com>
Subject: =?UTF-8?Q?Error_en_instalaci=C3=B3n?=
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Estimados: Segu=C3=AD los pasos de instalaci=C3=B3n de la p=C3=A1gina ofici=
al pero
cuando quiero verificar la instalaci=C3=B3n de git me responde lo que copi=
=C3=A9
y pegu=C3=A9 abajo (aunque antes hab=C3=ADa dicho que la instalaci=C3=B3n h=
ab=C3=ADa sido
exitosa). Abajo est=C3=A1 todo lo realizado. =C2=BFPor qu=C3=A9 no reconoce=
 la
instalaci=C3=B3n? =C2=BFC=C3=B3mo lo soluciono?

C:\Users\Sandra>winget install --id Git.Git -e --source winget
Encontrado Git [Git.Git] Versi=C3=B3n 2.51.0
El propietario de esta aplicaci=C3=B3n le concede una licencia.
Microsoft no es responsable, ni tampoco concede ninguna licencia de
paquetes de terceros.
Descargando https://github.com/git-for-windows/git/releases/download/v2.51.=
0.windows.1/Git-2.51.0-64-bit.exe
  =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=
=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=
=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88  61.7 MB / 61.7 MB
El hash del instalador se verific=C3=B3 correctamente
Iniciando instalaci=C3=B3n de paquete...
El instalador solicitar=C3=A1 que se ejecute como administrador. Espere una
indicaci=C3=B3n.
Instalado correctamente

C:\Users\Sandra>git --version
"git" no se reconoce como un comando interno o externo,
programa o archivo por lotes ejecutable.
