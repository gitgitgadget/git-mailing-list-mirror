Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D47C33CB3
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4576320CC7
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 22:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="GIFfuqgq";
	dkim=pass (2048-bit key) header.d=nyu-edu.20150623.gappssmtp.com header.i=@nyu-edu.20150623.gappssmtp.com header.b="MR7Va58z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgA3WaT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:30:19 -0500
Received: from mx0b-00256a01.pphosted.com ([67.231.153.242]:36688 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727495AbgA3WaS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Jan 2020 17:30:18 -0500
Received: from pps.filterd (m0119692.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UMOlBQ063718
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 17:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to :
 subject : message-id : mime-version : content-type; s=20180315;
 bh=audTFPVJL5/Q69cvdZnwyNc0vCMorjJU7HYlJkLdUqM=;
 b=GIFfuqgqYlaMJqcaJoRgEeDOVSI2JOp2ICz4I1+BnXN1fmWaMYYwugczHT30vemeF+in
 vPFlYMGMeUs/Ew0XXr9x72D2JvlmXfEu4ODLC0nwhDfYSjcqAPj8VeoOZdMpUvHbwN5f
 PI/Xc55pxLGV345DDoRU2pRurRSGBOz4yegzyPomM1+CMVu5UaNVVeZUgDeCfoE/jovS
 AqdZSt8itLYBlocUOM/XFngXkP+Dv7j++HjWETo312fxDCLly61KACjwnrNhl91io36t
 G/Wsqga231xtzu0qimzwAOpEzKvnmzhkWIt2UgybMrEqtJPi/qjOt1zPfpaSawcPlvgp bw== 
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mx0b-00256a01.pphosted.com with ESMTP id 2xv5crk9c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 17:30:17 -0500
Received: by mail-qk1-f200.google.com with SMTP id i135so2912677qke.14
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 14:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=audTFPVJL5/Q69cvdZnwyNc0vCMorjJU7HYlJkLdUqM=;
        b=MR7Va58zTm8TxGpXPdImgxGoArr1xRkk9mfka5MrYwfK11FYZ7EFFdBDV4mdfhXumc
         u4nStJdTwUCpQk5r3RiXgILSpA1z2NEvAtvaKcmSO1ylFH3RmBdbc+VjNNZYX5s6pDjx
         uNlk8HywLBhb0CXCd1uM23tO6rcbYhVRZhds5I4Q/9wyUWYp3oo8Ak0zV1GaWxiQMiU5
         Aoz7E3O180Q6FXFYm8qjdKD6xJF1bHSGl7KYIudZxiOSGkk7qUh5JjXU2O8Gm0EE8k4k
         8A3v5lUsfGiGIKB3zIDxsdMGCi6B0uM2Hulrb+dn+YLc/YhMWKNMQUXKhzVzwtlFytha
         aDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=audTFPVJL5/Q69cvdZnwyNc0vCMorjJU7HYlJkLdUqM=;
        b=VlmjNWRC8XmyNUyC6CK2RBVA71smWtactHiYHHMb/vwhSQv1G+lg29/+LGUn48yy4L
         AeAoRdq1uKa/BQAcCsWflOPhiqFyQ8cN82RDLT1Vw0oTH2bkpwImbqIMasT4ZU+OlO2Z
         Neih1HHDz7/1buecUkiMpIpTzuMHjVV8MQpKTfmFdRVLLI6EwRageCvt4DhYD2xYILL5
         ggY+PldegJjNFKwyR5zruS9BahJwzqbM0WWOKGukDI8lwE9s7+DRxF9bIt6zkaioe6sE
         vnGsUXLs/9yb+C77SUiBD92DO/NMnwm7Nn32aSY4fXZztx7tk7AYvVjRt+USYcclsDbx
         oyKw==
X-Gm-Message-State: APjAAAXMhX78dPPKWg5fQ3PNscEfYreqROtFLZRrFpNfRSnrJ9JZUhS9
        vmoN1q/XStYVbcEkxX1CP/Yq5MHZ6RG75bteFusySPACmJASagFRF8swSLkX9FsCXEUJA1ngTQD
        8QA/jMjKOuL4=
X-Received: by 2002:aed:376a:: with SMTP id i97mr2281540qtb.44.1580423416361;
        Thu, 30 Jan 2020 14:30:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdc6DIKXDonOqI1dwyqzZcvgPiW6/nW4I66lda/BnyNhXIX9IkhY/kGbOuYvqFVnWsrzXtPQ==
X-Received: by 2002:aed:376a:: with SMTP id i97mr2281523qtb.44.1580423416166;
        Thu, 30 Jan 2020 14:30:16 -0800 (PST)
Received: from LykOS.localdomain ([2607:fb90:5435:951a:c238:96ff:fe6c:25f])
        by smtp.gmail.com with ESMTPSA id x41sm3937041qtj.52.2020.01.30.14.30.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 14:30:15 -0800 (PST)
Date:   Thu, 30 Jan 2020 17:30:13 -0500
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Git <git@vger.kernel.org>
Subject: change of mail archive?
Message-ID: <20200130223011.tx6gzmaql24zemht@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gujsydnu7muli4e7"
Content-Disposition: inline
X-Orig-IP: 209.85.222.200
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=571 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1911200001 definitions=main-2001300148
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gujsydnu7muli4e7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I just noticed that the archive[1] I was using is missing almost a whole
month of emails. Is there a new "blessed" archive? Sorry if I missed a
memo...

Thanks,
-Santiago

https://www.mail-archive.com/git@vger.kernel.org/

--gujsydnu7muli4e7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAl4zWPIACgkQRo8SLOgW
IpXcKRAAy2iTm7JSR70ELCh5VUS2c2CgjDwlpv4o+q1HF97TFd9WttJk33XGM2kr
/lC+7MWXDG7rRyaa4k74M1cPy/JmCoLuynnbrT7k6Y2RSxCz14Z1ZZtWeZDPdmfd
sEf+Rol0AqG/3s9B43AclMAsS7eh1jelb8jpCxmlonGTBzc1LVdK15VC1TIzbmPh
2E5fG5JEM+QNcWcroNeXvH+wWgUliJ6p0fkJ6Q0/reZUZpQ3/RstPf1+szcZoBYp
Cye5BCG3mn2oohVotqSvF1JLRppzyDdC2QbuVLQ9Kq3a6TzXWvQ/Y9CgzGQU1H4F
XqpEmVldiJ8rt82RN01ePB4c0dpqXWwAo7NIQ1Wq1Z1F6VLJB4X4Ri0YQOeH4ezO
yFhqIOYTzuLl32HJ3pmNXz8AqoqA/PsAD5T/FAq42Jmel2mw9iltghnP1CyEkmyo
ikbfIU2od8zTNq6aygfFn5XRI6ehSK3+lK84V4aIU+z8NSkY207v03srFGkFSGTK
Pqov/pN7C5KXRJs7QAPIoXPYqY34Sqwkes6RBS5Hd0f6giWB7WNbv42VZc54mYE0
l4SumbO0qjFDjaeRtZqfEsaCM0u0QpTz6SiuE87uOmY1roKijunOPfY9mOPspTq8
X8nJNtOgYaNM5gKTJsyBSh7IgS5Lu1BkDPV6a2tb6XFPdVbqOSA=
=XaQf
-----END PGP SIGNATURE-----

--gujsydnu7muli4e7--
