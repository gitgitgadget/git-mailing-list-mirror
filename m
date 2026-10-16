Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F31763CB
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148231; cv=pass; b=NP/JUchjjDq9fzMjbCsfM22bw1z+QjioGqNmQ7ix/NuSDphnICxChjVYT5EvOR+3X11PIt4CA51JhAKxB4Tw19WoPnBI05Kpa4dPxkUORQbdk0KY/3l4bHge8ffmEKVTJ74neiJVAn2UwP4JyB0r3AmDrFXW+ZaOQsnFHXaNmh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148231; c=relaxed/simple;
	bh=Ks5WCUW99ejKZVNmTULoAZ4CpcQspI5fTENCdL3pNrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImjuNCMebDc4sL2RS9ip+dg0NqihkDlmwgBndmBIoYk3WZmISgTIGz91SXCgTbVC85q7qZp2Q/TqgfTKJSJzOBA+s+6YUgvEXodEMQHmpkcA47CifKYFBFDB07himP7AHfr/7P8nNR9QiVWZGkkjXh7ib17RXwtjld/q6P9KTao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kf84Ox2c; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kf84Ox2c"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5337c7b9937so256191cf.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 03:57:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792148228; cv=none;
        d=google.com; s=arc-20260327;
        b=dGnvQQ9JGbHevlFIiWraoadpNI3Bcnsp5y4kiOFq7nREzPa8iEEEhSJBTCJBRqYcEH
         J2Ia3Iq9jy7/07Oeyaze9mh6udwcWDhRr4h+WXKJh0ud6BtBGu2oB13Im+6s7fNGHOWL
         EyZnrHgNiZzMKOujyZtjdANnFQpYSodebtkN0ca67fy0zSETEZMsjOeaOvCnPogdReWO
         JM/r+bi+zIFTBQTLBodv1PktHAU+lQLSdoIfVSMLMXFpsWepuzNsCI8G7BqDMjj0NoUu
         8iVEEl6j9kOAuzQIqo1DgjsqDqcc12EgeSdJhlOWAo/TyRQUPHSuMG9PNXkc+WkBBopx
         qWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z0CdK1ofU19h+w9ts593YEQJyntKe/pvp3rQ8FgMp6Q=;
        fh=YTAsl9q/AZvGwmvbogGJar0R00s8Rvbukv/zonZx6qQ=;
        b=UQq/wupDUfLdROxo3MWv3Sqxwa0c5zCPma1j3heAc38msqNUjcjeXvY+7kr5uTOK9+
         nKo7KYO6cATWH4NcYx4LpMsJlF0hOR7WmuIPwfw78SYTutyewYR7uu7PdkCF+no3/2Z9
         4SVDsYKPTWTj1+55NK8OsRf03FRKLoy4+xCSoZR80JPamLDnW0Fpx+wgBAV+ocOd8Vgk
         gRmeQ1wPVO2nnAPXvynqAjqsAcN8KLpnS8ypf+Wr+mQ2OS2HZy8eZxf+xIXTTOtZciSJ
         /pfD5KR+NqNcDpyK+mFboMwryRx+jlwxadEVr+ArvJ0M19hkemRj3e+zSZWlCQ3NNQ5s
         T/GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792148228; x=1792753028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z0CdK1ofU19h+w9ts593YEQJyntKe/pvp3rQ8FgMp6Q=;
        b=kf84Ox2cBcMFJb2yeUzjGbDC3p/Vj2K2eKRSJQD+Gf9FeEPrm7OB/FPCHmNR8vaCeG
         a8HJWFcDY1RHKzbhrrFDBysImsIsCLRgjpdoevxyLhJh2099P8dR6e6pQkqliCqXugif
         TjnR89oN2TJiYKMgyyv036xdw91L98JCN/rM5RbwzrojeTBecckUYxRAB5WRgODnIm1g
         UhMH2sNfmo8wKAHpJHJRZ1xZ2/ER2zfCXzOOXN+FMsHYz3Mn5v8USR9vQ47G67ugAcvJ
         MwNwcqM6qDafCzIVwSA+l5U3Lp58aKQLypXEeUNrN1wgxoC+51nOhZLK5B3L0yA90Mce
         ot/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792148228; x=1792753028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0CdK1ofU19h+w9ts593YEQJyntKe/pvp3rQ8FgMp6Q=;
        b=adq4qvL9f4ZcdHdd0nIzaSg4MUFM4wy4Yp7ijEiekaPoZNEcnDYcVQbuxcOLdq/484
         K3+sSi0NgPTruUCaIsoQmJyN8Z7qKUIuQGUqVrh3R4ACu6upC97/tmEGTRkdPGtazYJi
         rwbXFlhaOeSCFKcC2v25vwxzvOIQvzd+9gJdEYG8gJDoxNp0uv0hghtIRmtMvDbv3x1R
         i/u5c5KMVY1zNti80uZLNvK0nuIO2cd6JbSzaDKrPnUHoNiKBjdKFNHnzViuIHuDSPzu
         zaFQtfqjy/B2XNfsBObnEJIwkOj9i/dix8OXwwR1z2R9qlHuH6GkgyyVoEGnL8IsIXjV
         AIOw==
X-Forwarded-Encrypted: i=1; AKwUvBx/cnfSb5VRWJG8gdT12xYcK5/YmlJOCG+4Px+FQv27dx7U7YRSygf7gSKp9/8IyYPHA8A=@vger.kernel.org
X-Gm-Message-State: AFq9FYL45Hu3i21I0MOJC0nYK3L2JW8oVxysZ3MMIuZN4vxWL86iyC5U
	icz/ztt/LoflRKH37twYh0eZxc/7nfMYyBpUpLor/pldFwovpvHvNdr4cMPEO53VPE1KvyiOkGD
	CWmAY0ItkNZM2XZvdcHoBlPcQ2iCLf64fNuj/+pslTacceR71z7j82ajUq/I=
X-Gm-Gg: AYBFou2ZFfS010eM4/lyuu64aqrm1Vqcv/wDhG+p74Mox7Iviq/FmkBgo0/Systfxzk
	Q7utgj4BNGWH+RCEIk+ZAm2L7JzUhcseIvMA+5eNWJPAWCmXJpz+FeW6Q0X823RAS0MQUJWxxiD
	jXD5nBQf0RGm8nhrwKXMtgoKuq0NhnZz+FO0q7/DThzEot4+nxppD3Hu0cfTlrVA+WKnQiZaY2M
	Rga8u0A9wIOXC0I55XIXiPpMR7w8P+jB0RjMmWmvq1ljvEU8Z6L8yFfJsIQhps6N4q710Gh3D3Y
	xqoMWc2attlnD8ncRtGKNvqbr5qcJYnzF48yPLgugiW4zx3xMFO6xAqsv0zqEJmon6WX51g4mDT
	Vzvlrei168Q==
X-Received: by 2002:ac8:5fc3:0:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-536293e8196mr15123001cf.0.1792148227525; Fri, 16 Oct 2026
 03:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012203057.969878-2-dev+git@drbeat.li> <20261012220039.136932-1-aniketgupta3001@gmail.com>
In-Reply-To: <20261012220039.136932-1-aniketgupta3001@gmail.com>
From: Xiangfei Ding <xfding@google.com>
Date: Fri, 16 Oct 2026 12:56:54 +0200
X-Gm-Features: AclHuK-ejXBrp5pAJ7GpuMAmAfzfeGVUaXv7csehkzY2e3d9ZpKdtjn6YlUrFcU
Message-ID: <CABtdbskPaYgVnV+5P7-0G8KVYK1FBekwe2ygoYkZcvCR3RXj8Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] imap-send: let OpenSSL do the hostname verification
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Beat and Aniket,

> I don't think this can be reached. With SSL_VERIFY_PEER, SSL_connect()
> already fails, so a hostname mismatch would only print "certificate
> verify failed". It does not name the host like the old code did. Could
> we print the verify result when SSL_connect() fails?

I suppose that we will have to install a callback at SSL_set_verify,
from which we could leave the bad hostname in a "mailbox" so that
in case SSL_connect() fails we could pick it up and print it out.

Would you mind me posting a patch on top of yours?

Best,
Xiang

On Tue, Oct 13, 2026 at 12:00=E2=80=AFAM Aniket Gupta <aniketgupta3001@gmai=
l.com> wrote:
>
> Hello Beat,
>
> > +             long res =3D SSL_get_verify_result(sock->ssl);
> > +             if (res !=3D X509_V_OK)
> > +                     return error("unable to verify peer certificate: =
%s",
>
> I don't think this can be reached. With SSL_VERIFY_PEER, SSL_connect()
> already fails, so a hostname mismatch would only print "certificate
> verify failed". It does not name the host like the old code did. Could
> we print the verify result when SSL_connect() fails?
>
> Thanks,
> Aniket
