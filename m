Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDB2C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C33A4610FB
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbhJGKYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 06:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhJGKYK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 06:24:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F685C061746
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:22:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y1so3578535plk.10
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8vimf4S3apxCAFUKJJ/mBCX0IsxzjMvb7fnLfpmsFas=;
        b=Pw/sVYVBr8ciu1JiYup9mED6J/EOchvT1USeIu6lr/y5KjiM70mPHfrNssRiKCJhi+
         PJb0rRsAuxHrQ4hgBs1ORKzldXG4KaZja/kK22ReZyfHhIy/Puugh97q3XHwJTx80F3s
         6MTGYZlzmt7eFQRDYShKXrS7+LNNbVInBORZZJ92sOD4ED8pKcAnkcbOim0YQBmH5hbF
         TqBJ13/2rbeS6AsFOV2MWl7zpQAL9OShy9C7Ab0554DML27sekWPOSOPKMSbs0KUnYXV
         ahDhKdPoDRVWSk4IzadWag4K8EWDBkn2wN2n+UaFYi2e9cxaogt3/1b06TzSxQuccvs4
         jNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=8vimf4S3apxCAFUKJJ/mBCX0IsxzjMvb7fnLfpmsFas=;
        b=dIQ/oj2cvV1jwRg5MAkVfjYoybjzdNyAWJ4LXULgLsBfodcNgWvk5e9q/lF57RprZM
         zPxVaSa22HkT+KGTNvzJRnbCzMD0gtlGC6yoFftXGcIJBfMImabDNoE6/U5paG6aLTye
         0cGiEShb+472Ybqenq2KOjUqPtUZ7PzS1SMToR7qRyoHB0FPFV0ZH2BTQnxFnU7UwAFH
         VHpfvXkJTKvLTZd5O8vh3yJ9z7BDupMC8w3mUy2gbQ3vYGs4gUy5O4wJNgSlcP/t4Z6e
         IXP3++0TqDpDD+QC6/79u/wYIGX2E2o4qjkLzzOBKBA4/4XenJClDI7Ll3X4WH2Dffrh
         Fgvw==
X-Gm-Message-State: AOAM5331EiXQePiTDP+NdyEBlXnAMkYRvEDVG7jbQmCo0iiJxQ2qxZDo
        4c6g/cq8dB09MsvbU7UKXpfKcQNkLeuUglC6tLdrERWNLsc=
X-Google-Smtp-Source: ABdhPJwcP/xGrUQnsIPiZlEpHy2q8WcWSo0yzd2vLHl6u3MNdm+7WSkHiz53edF6H3UQq6auGLIKvzJz1YUaOJmcRlU=
X-Received: by 2002:a17:902:8bc1:b0:13d:e884:125a with SMTP id
 r1-20020a1709028bc100b0013de884125amr2949114plo.38.1633602136523; Thu, 07 Oct
 2021 03:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAP_xbc=PZq2Qs8KUVYJVofpTxucf43TeSm8Bk4Pxcb0wn70KjQ@mail.gmail.com>
In-Reply-To: <CAP_xbc=PZq2Qs8KUVYJVofpTxucf43TeSm8Bk4Pxcb0wn70KjQ@mail.gmail.com>
From:   Rene Hutschenreuter <rene.hutschi@gmail.com>
Date:   Thu, 7 Oct 2021 12:22:05 +0200
Message-ID: <CAP_xbc=ag3+Bkvwtou4ZaYrnVm67kb37=oZEc5eTx8FsufhV=Q@mail.gmail.com>
Subject: Re: Security issues with openssl.exe
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Sir or Madam,

in our company we currently use GIT for programming tasks. Furthermore
we use a VPN to connect to the company network.

This VPN now prevents this connection due to a security problem with
the "openssl.exe" in the GIT installation folder:
- C:\Program Files\Git\mingw64\bin\openssl.exe

Description-Text: In order to decrypt SM2 encrypted data an
application is expected to call the API function EVP_PKEY_decrypt().
Typically an application will call this function twice. The first
time, on entry, the \"out\" parameter can be NULL and, on exit, the
\"outlen\" parameter is populated with the buffer size required to
hold the decrypted plaintext. The application can then allocate a
sufficiently sized buffer and call EVP_PKEY_decrypt() again, but this
time passing a non-NULL value for the \"out\" parameter. A bug in the
implementation of the SM2 decryption code means that the calculation
of the buffer size required to hold the plaintext returned by the
first call to EVP_PKEY_decrypt() can be smaller than the actual size
required by the second call. This can lead to a buffer overflow when
EVP_PKEY_decrypt() is called by the application a second time with a
buffer that is too small. A malicious attacker who is able present SM2
content for decryption to an application could cause attacker chosen
data to overflow the buffer by up to a maximum of 62 bytes altering
the contents of other data held after the buffer, possibly changing
application behaviour or causing the application to crash. The
location of the buffer is application dependent but is typically heap
allocated. Fixed in OpenSSL 1.1.1l (Affected 1.1.1-1.1.1k).

Could you please provide a new Git version with an updated openssl.exe
to fix this security issues?

Best regards
Ren=C3=A9 Hutschenreuter
Developer
