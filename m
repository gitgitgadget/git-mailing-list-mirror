Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36B635
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757784401; cv=none; b=kjBYmA58a8O95Dn7bn+Eb9Nhk65cbVYT/4VSpKEK/4nR3vHXmtGi/i8p5Cp9/IVVFxClMZS4lMaEdJTZjL3DUhuGPOI7jC4TbMlL/+xoLc0l04Nmf2Ao7IJ5YU1iLTalTFbK6dw5HDelrDQgCHRsNM3N3J3omRkQjS2Bs9poK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757784401; c=relaxed/simple;
	bh=e1LSfg7ZuGSJTxFp9gtiqZXI6hRzPlO+ofenrN/qTRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aUYQz2EmqIB5KAigPBx4Dp5cDvJs60NRK5iHBJSm7aZBoLfUPfr05b0VXw8XYdYVasQNNKhQCBpAJnxGQ1uQ84VmGH7tWpPIJwLsX/PSZxCaKuXAAQXb1frsQjnjHkG2xXOQJXhnxYF7qj9W2GFRbL3bAG60xXQCFHhjo86kAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anl3j/kW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anl3j/kW"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2445824dc27so25398845ad.3
        for <git@vger.kernel.org>; Sat, 13 Sep 2025 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757784399; x=1758389199; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzC+ppmXaAKBx09Wasa/oSV+jD3F24HaJ2Nn7y2Q880=;
        b=anl3j/kWmnsp0oCkfxrIW4W5a8R4h4oWidONFAr7spWJ6CKlXFnFK7BHrpOlJPxj9m
         vZVAfqTK77Sy8Zl6EKiEAexrGzlpMn0Ws8jIM8XyGfseX1zyCFYuHlGfOR+wWybMt5VC
         J7UoVdM5693VAx9BkMS8G+xjhSkoRJlHKAjmQyL+hN8PVI9x1t1LL6lJ431KAAH4zcbK
         zG1sRPO4vsu+l+DNVZvQefSOPMRslZqnJXOHK6TJ/W5BcnHCTMTw/YX1/4EngwE+krHH
         JvBXjsENR3IQeEkgYEXNHuCNoMRRT4o/B8ATKnlE+EeYR96yk5KFbAXwzQcOUiubxMmS
         /pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757784399; x=1758389199;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzC+ppmXaAKBx09Wasa/oSV+jD3F24HaJ2Nn7y2Q880=;
        b=HtkO+79GEFcXh0Nbw0n174ErRM0E8h7i1dVoZYiSMF04RiXExjQ8M1VNwUor7Ji3jy
         2DkInnlw3W2VHlyF+soGVoJZH5gLtgO3vbZFRjs4XSg22SF9uQ+payjlyGLz8elZFLcb
         IwKfsYDWJihIzxj1jyNVEDr9o/hnk5qkP6O9fqdibYC8wgbIn+jDJyfxw/bNIq55ym87
         yeDwKQ0QPK28//kTfB0qPpuJr7Clw/KmzQHugftM056zj+Yko+1qMvgZ4wEwONSU8cWA
         yJRxrzoeLWwUtgSEBTJCfV8oM3scs0WoNWZoIMGKRUKc9LmbypRi/nqjzACxgjiSMVHW
         72lw==
X-Forwarded-Encrypted: i=1; AJvYcCXNL15aum0MDthNoxNnGnOejpP6JCK/fZwc2pHNgZSNGHrAwuFyrwNF4Sl2KbFL8XNxSu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/Y1jJ8Hciq7ls1UFArLl2QeebjuHs0gSuDXP36aN3vPfJyl9
	TjvufVtiGWLPanrsmanLHcgP5IfsfqbPbdt0CVjQmHOnjDBpU90we2Qdo8TaOPWiq/o+nKncDZA
	xuvbFHk1mZDiecJ4So/hJr3PLTU/Ex4I=
X-Gm-Gg: ASbGncuk8p7bWlZkS2AoDp0ymqhJRgbLLM4KAL1DKAvj/gKV1ynd1y2Nan0I/1RWQLI
	qhjabGjOPN2+Assgy6jn8DBgXE9KVo6VufOIwA/dY8UneMor5gGs2jy+nHaqUK6mogAAYGGjc0S
	We6HzKNxLzGL7n0A3SjqAQq7JBGn4DVWx28diskxh7gelJQgQgbtr38BrZvoQawB84hVoOmh6oJ
	modC9M/3Oa4EVfi2tmnRgU6PVV+0gq6aA74u5b/MDRIFJml1BMOdjL/7i9zPB48kfUPOYIKzKJE
	DnRB
X-Google-Smtp-Source: AGHT+IG76PinyQ1o2C292ocp+uc9ECaL2X2LzqLugWn3xQqHhq1d7/LWAaECjOzGfKn0+b94zmh3buhSoErPMMbd7Lc=
X-Received: by 2002:a17:903:1590:b0:24e:af92:70c2 with SMTP id
 d9443c01a7336-25d24ea0302mr87432655ad.24.1757784398582; Sat, 13 Sep 2025
 10:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFBn-2MdP=jw3mmF9G3t4hC9PnK=DxBiBzPV1smVmaFLU6FjDA@mail.gmail.com>
 <aMWXnTWzVimEjUp8@fruit.crustytoothpaste.net>
In-Reply-To: <aMWXnTWzVimEjUp8@fruit.crustytoothpaste.net>
From: Sandra Malla <sandrammalla@gmail.com>
Date: Sat, 13 Sep 2025 14:26:27 -0300
X-Gm-Features: Ac12FXy9wnMhau1FvQiLAh50diGkAsv5WoMKh3HPtJ6--nH9TiJ9fyqIrFGB5_c
Message-ID: <CAFBn-2PMK4OQ-9YhMHxwQo8BgC=m3f3cROZKpkDwoJuV_Q_+aw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Error_en_instalaci=C3=B3n?=
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Sandra Malla <sandrammalla@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Estimado Brian: Much=C3=ADsimas gracias! Ya funciona.

Saludos cordiales
Sandra

El s=C3=A1b, 13 sept 2025 a las 13:11, brian m. carlson
(<sandals@crustytoothpaste.net>) escribi=C3=B3:
>
> On 2025-09-13 at 15:47:20, Sandra Malla wrote:
> > Estimados: Segu=C3=AD los pasos de instalaci=C3=B3n de la p=C3=A1gina o=
ficial pero
> > cuando quiero verificar la instalaci=C3=B3n de git me responde lo que c=
opi=C3=A9
> > y pegu=C3=A9 abajo (aunque antes hab=C3=ADa dicho que la instalaci=C3=
=B3n hab=C3=ADa sido
> > exitosa). Abajo est=C3=A1 todo lo realizado. =C2=BFPor qu=C3=A9 no reco=
noce la
> > instalaci=C3=B3n? =C2=BFC=C3=B3mo lo soluciono?
>
> [en:]
>
> For the rest of the list, I'll translate this into English, which is the
> usual language of the list:
>
> I followed the installation steps of the official page but when I wanted
> to verify the installation of Git it responded to me what I copied and
> pasted below (although previously it had said that the installation was
> successful).  Below is everything done.  Why was the installation not
> recognized?  How do I solve this?
>
> > C:\Users\Sandra>winget install --id Git.Git -e --source winget
> > Encontrado Git [Git.Git] Versi=C3=B3n 2.51.0
> > El propietario de esta aplicaci=C3=B3n le concede una licencia.
> > Microsoft no es responsable, ni tampoco concede ninguna licencia de
> > paquetes de terceros.
> > Descargando https://github.com/git-for-windows/git/releases/download/v2=
.51.0.windows.1/Git-2.51.0-64-bit.exe
> >   =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=
=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=
=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88  61.7 MB / 61.7 MB
> > El hash del instalador se verific=C3=B3 correctamente
> > Iniciando instalaci=C3=B3n de paquete...
> > El instalador solicitar=C3=A1 que se ejecute como administrador. Espere=
 una
> > indicaci=C3=B3n.
> > Instalado correctamente
> >
> > C:\Users\Sandra>git --version
> > "git" no se reconoce como un comando interno o externo,
> > programa o archivo por lotes ejecutable.
>
> Sometimes it's necessary to restart your terminal because the
> installation has changed the PATH environment variable which is used to
> find programs.  When you restart the terminal, it will read the
> environment variables again and Git will be able to be found in PATH.
>
> I don't use Windows, but hopefully this works for you.
>
> [es:]
>
> De vez en cuando es necesario reiniciar su terminal porque la
> instalaci=C3=B3n ha cambiado la variable ambiental PATH que se usa para
> hallar programas.  Cuando reinicie la terminal, leer=C3=A1 las variables
> ambientales de nuevo y Git se podr=C3=A1 encontrar en PATH.
>
> No uso Windows pero espero que eso funcione para usted.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
