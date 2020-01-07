Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FD0C282DD
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 20:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0F22080A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 20:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="SPQHjkxn";
	dkim=pass (2048-bit key) header.d=nyu-edu.20150623.gappssmtp.com header.i=@nyu-edu.20150623.gappssmtp.com header.b="vP6y73+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgAGUzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:55:32 -0500
Received: from mx0b-00256a01.pphosted.com ([67.231.153.242]:39510 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgAGUzc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Jan 2020 15:55:32 -0500
X-Greylist: delayed 1419 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jan 2020 15:55:31 EST
Received: from pps.filterd (m0119691.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007KTFAI110707
        for <git@vger.kernel.org>; Tue, 7 Jan 2020 15:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=TcQDiwV3wNCJU53iHtKlRsF78Bmqu+FeceS0bQTcGaQ=;
 b=SPQHjkxnQhDuf38dPo8CVM9eOAKryEQfEiYvEPJd30Z2MYYObC2RkX6w7LK6pfS9dS+b
 RPHh3WktH9s+MhySd2Yz6s900aqPHfYTc0nN7SCdlfiDEmHgWLuc0AwXCsWgYuRwHFIu
 3rTLbQdVZmw6Vswr2h+3AaZWC9tZba+g7t3Gz1CFbNyIcmfiPud1F659UCE+pMyqqyUS
 O+D3s1mEWOWC8X11pFlTzmbjSgtZgSTs+6l7vLwkd8z8Hg12diVGUxZwcwd7oxWKvd18
 wwUar0GEo4XomrMEOev6DoPRMHHQRSTTqDzkrHu4RM5IWBdITA7bOhQmrYt6tXllV6YV LA== 
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mx0b-00256a01.pphosted.com with ESMTP id 2xcxye29mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 15:31:51 -0500
Received: by mail-qk1-f200.google.com with SMTP id a73so606412qkg.5
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 12:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TcQDiwV3wNCJU53iHtKlRsF78Bmqu+FeceS0bQTcGaQ=;
        b=vP6y73+v1Vvy0i86DKQJbbZ84aczKcKNsfuj1VRQ9uMsDqsi2K+QVjJm5MHYPXuobH
         wSoZMZ6pHo0AMhogtgWTfBtOsIn/darUwnZGRngZ3gDI1NmbrtI9EcnxSNT6fHjiYiU9
         Jmsq/MK/PPfA+SY1vjuG9IG3MyvTgLn9rtYc52vdP/xNUR+7zqE6JUdtCYQCU09NG964
         j164zanSGvHmBfPetVBY7F/4aXynCShDSdW+uXETqGD3P8BrDfpTgGm1jN8fjN5lsQuI
         4qq8CeApRRXkmw0XIS+QEwfeDiah7ozHMX/nQaVnVv+k3hfh3Pz/DI0RbCIJFaHX1qgC
         gbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TcQDiwV3wNCJU53iHtKlRsF78Bmqu+FeceS0bQTcGaQ=;
        b=Sd6dHIyCWNI90UEaSxuQH13JxbXSvJkZJvuZpZQHmK/jVXS4hfwiO5b17KbASoCeKV
         lLf0qCIt51Tu+oI8e+HRL6rmLyWJABAt9aYIqE8ESxCJ+vZZyR8VMzNeg9P60uTzXPqZ
         CqNrPVuJDoBh56+7VQUPXmL+Z9i1cXRybQ5no6zFzjyNvKBB5D8Xb7G+D790sovXs2y+
         L//rp2xzVuB0NfUaLDcP4I5BfBWlGTLn0i7ZC+hBIMTEVCUWZazA2eio6+NoNGQXxiLf
         noM5ymUM58P3tUbKBte1dqmXBoOG1lKZ7CvUJwGFz3QXMNKMPI6T9Uk7UjiE26fNq6nn
         jWow==
X-Gm-Message-State: APjAAAU8Eu82o0COXWBDh3j2j9795HTi93065j2C2lXLWphBr4RmIFxQ
        8HQWrFveqmXqkvYi3O6APydsz06lel1rGlXMIHicAebexuCYaATQrzC9mbxLykaYqGMQ3MlQ558
        7mv7BFPdz9Gk=
X-Received: by 2002:a37:356:: with SMTP id 83mr1126738qkd.409.1578429111132;
        Tue, 07 Jan 2020 12:31:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxPcVdF3g0N9NMQl5fSKqSrN6GWnhHtxf61dXx1+PQgVBo5R2vkHF6Xrg0pwx+NHPR6vfsLEQ==
X-Received: by 2002:a37:356:: with SMTP id 83mr1126728qkd.409.1578429110948;
        Tue, 07 Jan 2020 12:31:50 -0800 (PST)
Received: from LykOS.localdomain (216-165-95-145.natpool.nyu.edu. [216.165.95.145])
        by smtp.gmail.com with ESMTPSA id h28sm358337qkk.48.2020.01.07.12.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 12:31:50 -0800 (PST)
Date:   Tue, 7 Jan 2020 15:31:48 -0500
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Kevin Daudt <me@ikke.info>, git <git@vger.kernel.org>
Subject: Re: SHA-1 chosen-prefix colission attack
Message-ID: <20200107203147.r33c5plp5g7pmxmj@LykOS.localdomain>
References: <20200107173111.GB923852@alpha>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="suvszgllakc5mvnj"
Content-Disposition: inline
In-Reply-To: <20200107173111.GB923852@alpha>
X-Orig-IP: 209.85.222.200
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=449
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=7
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070162
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--suvszgllakc5mvnj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> > As a side result, this shows that it now costs less than 100k USD to
> > break cryptography with a security level of 64 bits (i.e. to compute
> > 264 operations of symmetric cryptography).

Just to clarify:

    As a stopgap measure, the collision-detection library of Stevens and Shumow [SS17]
    can be used to detect attack attempts (it successfully detects our attack).

At the end of section 7.0,

Cheers
-Santiago

--suvszgllakc5mvnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAl4U6rMACgkQRo8SLOgW
IpXtgQ//dOwRVrgB137R/fxPygbto6F6JNQoVTpsK8NCXc95oGJQo8ytx5+Aj/Bh
QbYq+8Gr75Lou3OmawfM5sDREVUV8SxV7ESCmQN+rMR9N/NVnFy9uTsmvvfn4sM5
EMyMZLUR4ZYhP4+aFbt3rYnhxiCf/Ez2ddVIKT1wDSB3UexhN5y9nnu3+hizdext
KKbUmlQCxl55X6iPa0DP1HQK8YE/rhUP1QUXSNuAcyyaFgRfBUCs+u0uiq7Lp742
pw+uYDYOaw8/bJ8tTxaCaafhqw5/vqpJGUF2QN9enlP2y5uKmbZgckvbJJ2KOl3Y
lzuo3v/A6jdu2GwsYau07NMIf/75ADie6+PVTRauawL4qvW8BOLf1Mbi4eU4QG+D
er16pXtFZzTXmh9EXXe8IupgBc5dXkW5lP6cfH9E89Goy5SQv1tr3Ojzurq6a/tl
NH7w5/jaihaZTc9hNp1bNJLXaEky05/ez5LIsrQNu3AwIPMNyMVkzmXad5p7UHgz
GvgpBlt9DjAsIdHjr1WVDZrMO1hhmmUzOAFqC/rZMrYfc+PRoKWZi0lEXIZK2ZmC
GWR/iCSabn10xFSrC3+SsggD45OXWqQblv2M4c7fB4HYyvVX2O91SwvMtEmVaQNb
UfylEbI3BvLw/DFwtcOf/ER+WZr4s8EyNTW+055RypFe8Oqiay4=
=ck0U
-----END PGP SIGNATURE-----

--suvszgllakc5mvnj--
