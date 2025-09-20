Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45842158874
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758328602; cv=none; b=Y6FureIbXm7fa+bmWvh6M0mkhJZf2zmyCa0tnGdB+jc3beeTIv1oS0pfzkOY9V1ubQe8nyO0KbPrV1C8x8nC464zDJIH9apbjlJvnRRTKfxT8a0NSyKsfDWtVD2S6L3RxTe9FDG8Bb+QNBCx4pC4aV9/m1/tSdkKfmlE6Zvbgao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758328602; c=relaxed/simple;
	bh=uxExNDfKtqf1f3bBw5f7daIn/Q3SiGBPFgZ3XM0eskI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=CZ/kyW/XSXe9PbmxHvbFcJerF1cL1l8K9FISctVQtUqhbmUKYn1NakPlh9fn+Ky7/Dzgwh0MY5hz1HTfeL9+QgMoph9egOK7X/CbCo33t+TpC9l7iUuQYKBo6kG5CrO75NjVX87FFhLdH8kvcaKvN/e+3+1KL6Sz9VS7arKhWQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/DIfHAl; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/DIfHAl"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ea5c612297bso2031679276.3
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 17:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758328600; x=1758933400; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YoaTZ86/pW3qUk0hN/62jWgLZ2+JANRiwFIFSPZuRRA=;
        b=N/DIfHAl4wVUyyuzOtC206mQYdw55YSSw/yi/NqauoUiDWsKyK2V+wjxaNymsFiO2X
         Qt1diR4tyeMFdQYDHKrnw8wYRnKvO1vZ1/ypvFoiVlsxjSizVN8AvzoRNJwJBSg0WnTK
         bSeQjqNtyTOsVzLmreyZFmkVyuksruVHbQwkJAoAZeY7vgXLz9vuNkQxZpqK8SMY3z9+
         nYJo9mp8fg4RU0vw0mdjHdeklobsdvZlyQr2DofQcDXx4pUtnJTZtmn6aBhvZH2G1hIW
         wOLBeGcc8UeW+zpy2+R5EhHuRirKamDvRG20erWXjx/GctrMZdnWJECYkIu3ss/TAtcO
         L4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758328600; x=1758933400;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoaTZ86/pW3qUk0hN/62jWgLZ2+JANRiwFIFSPZuRRA=;
        b=Vbm7sjG1TPupvOx6+DusZZNAY0fCiYhwDGyiZhgOxrEh02o8QRCJH0s+GiBMeXMzK8
         t5UU5ytivBbtj/bKVNPbJakJS7SwU9tYxcnk6JxVkf0amevQCqxEMGODART8vLgEEmQ0
         J2M6h/onlQaGGWls0WhFvI/7SomGpA82cehn9B03kvHCKGRfgsNdVYjFtvuw+lGw+PbY
         9zy36vEV4yYSNNpTMOpsfsSTxMTmJhLkO/0QrjCsxIoFgrPLgCe0CtNB+K2Kcwhq0Aso
         OntTQjEvKzZQjWJKe5pD1AzUdfNSsUttusA9zbfaKvW+m74aDqDzG/j6iY++9rlv8Oxj
         246g==
X-Gm-Message-State: AOJu0YyvC00PgetGujGRY0d1Xvj353RnQBdLOIFolm/rXmGCSLZYxlvp
	AB6fW352ENJgyMeHbNlrjXxpxTsQ6tpdS85ucD1yal7gqM6vpudVi79ZUYTL6g==
X-Gm-Gg: ASbGncv7Lyv9GWWDjhZlidUGrWVhsDPBIPysKnVGWhksJU9lZwdjM233PIZdmvZLQn1
	K3qAcvdfbZHYZYYrMWFLkBLfmQY/VmxQSv89SEASVhkTV/JYDiFECxDrJJUoMZjpSYO0ZEi3AEN
	xnVBX71M+quMuVFunJruQybPa/oxDPWjynkvoaCH/GCvcYEge1o74yqNps0iSGk+VfdKT4Jjc7X
	qvJvoUiTd8iCD/7clhZ02Yl5LbxxtMEhHUSlXC3yKErHQOrVy3vwN3LKezXxKKGN8G9DgpiljjJ
	q46C0cPkRelxb0hufNzpZW32j3V8xFIP6yVGpjKZ56rNMGca/PwnTU7bJY0AU3+aXN1zSPPQP38
	3g8GX+gy6zXlME9ixOQD3N9SL+Iit0jLCOxY5YDDu+v5m7BXnUgywqgUpaTaW+M2NIHzI38Uh
X-Google-Smtp-Source: AGHT+IHDQt6BtnVJrkzodH6ZQvyTAXcevKSBaM/svzx2vfMi7BG7/1qYuHpt8MK+sDVJRSF1TnPbvw==
X-Received: by 2002:a05:6902:6207:b0:ea4:14d3:6ce9 with SMTP id 3f1490d57ef6-ea8aac284c8mr4400068276.46.1758328599896;
        Fri, 19 Sep 2025 17:36:39 -0700 (PDT)
Received: from smtpclient.apple (69-77-149-20.skybest.com. [69.77.149.20])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce70a02esm2160115276.7.2025.09.19.17.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 17:36:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: git whatchanged: fatal: refusing to run without --i-still-use-this
Date: Fri, 19 Sep 2025 20:36:28 -0400
Message-Id: <81760BFC-9F41-4BEC-BC32-7D0C2180AD0D@gmail.com>
References: <d94afaec66f8ab8058764cee08e9dd56435dd667.camel@jame.xyz>
Cc: git@vger.kernel.org
In-Reply-To: <d94afaec66f8ab8058764cee08e9dd56435dd667.camel@jame.xyz>
To: James Puleo <james@jame.xyz>
X-Mailer: iPhone Mail (21F90)

> Le 19 sept. 2025 =C3=A0 16:00, James Puleo <james@jame.xyz> a =C3=A9crit :=

>=20
> =EF=BB=BFHello World,
>=20
> I have git version 2.51.0. I encountered today entirely on my own this
> fatal: refusing to run without --i-still-use-this
>=20
> Why I was using this command: There is a bit of code I wrote in a file
> since deleted (from the tree). I knew the path but not whichever ref
> last had the file I was looking for.

In that case:

   git log -- path/to/deleted/file

(or rev-list?) would get you there quickly.=
