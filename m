Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F2AC433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 18:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbiCRSSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 14:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbiCRSSy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 14:18:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B8912759E
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 11:17:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t24so2580804wra.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=korea-ac-kr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RY3sts++6yldbHHMfAMWbOdeGyT2M3Yo2r4vOQS5m3s=;
        b=lGzneL759Pc5JEEh2kiD6rsl+LF6NniwHAKQ83DJ1H7zG6HL7Gqimhpa2NHHQVMdc+
         bXV+mIfaOIunK9mdAFvRLfUD4/6q7rXm+2jk+5XRrfvasVvLT1Wfpr8+vy8FcHbOF1dn
         sjt5Xf1omhbZkWNkfcnxtW/l3pEUgV3OWr2Eex/4R4DXhIGEJptMI3+YMHqDA8zh73Hc
         5sM/uMEsZ5v0UxZfMHJrPYfvNPcnF6B5CKPhZ6o6cJGKU7XMbZTC6hbzMQ9qbQAwxdU5
         SxddKNMFV1xvi2Ucz50AuqY33Jyqw/ZtHYNxUbLtj2sX5bQ82yB2R3HQJ4yBwVxPLqm0
         vO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RY3sts++6yldbHHMfAMWbOdeGyT2M3Yo2r4vOQS5m3s=;
        b=BnsAE37d1lvcebVgYXof6ifTDuwey5TI9dZMktjdctBPpuWjUBqFAX6NMv4aoHCiGG
         UpbA2Pu2TYBwji/aThk8a+dc5b2QjQ5/qEuz1QnXJvGQaWjhoCuegcZpHL/kNepKlf+f
         ar2iGVvzJ4i0029hL68aSdRdb9T9Q7cHvfydi7F7IChKdiptB1TMbn8hvvtxRzdvURA4
         y50xfYZdUx7S1Vq4pRDGZm40Z0Cn+sFoPCMAx1LpqErTiXgqJ7L5GsJRU6x3hrnDTcvs
         Mly8zj/Q1M/APFpdKk6dQTKz6roYD98nmFG26UmCOyg6CyJdpvqBVtVBRg5b0IYo1GSi
         1zFA==
X-Gm-Message-State: AOAM530IVNBZjWqfHLWEyiL5ytkQTjej/iL8xSlPiOQnhs733EsrRN0U
        sWKyjXgxGK3BUBRKy/sU4fJVeRp8nO6JL8OQHgELapey+MKzdg==
X-Google-Smtp-Source: ABdhPJxPvfVR8XMM1cwyXrGfk69tySp4FXsyCMs1KJ9eSNH7YXa/Y0UaaJV3m0Y0gTUHZYO2yqkYBdlKSoj5Zb1RUFY=
X-Received: by 2002:a5d:6208:0:b0:203:dde4:c76e with SMTP id
 y8-20020a5d6208000000b00203dde4c76emr9089460wru.273.1647627452056; Fri, 18
 Mar 2022 11:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAPb83E-Y8grG7MVWqjqPH6SsdZ2JJ62XUeQAe=Wb_zgn0RL90A@mail.gmail.com>
 <xmqqtubv9n1i.fsf@gitster.g>
In-Reply-To: <xmqqtubv9n1i.fsf@gitster.g>
From:   =?UTF-8?B?4oCN7Jqw7Iq57ZuIWyDrjIDtlZnsm5DshJ3Ct+uwleyCrO2Gte2VqeqzvOygleyImOujjOyXsA==?=
         =?UTF-8?B?6rWsKOyerO2VmSkgLyDsu7Ttk6jthLDtlZnqs7wgXQ==?= 
        <seunghoonwoo@korea.ac.kr>
Date:   Sat, 19 Mar 2022 03:19:24 +0900
Message-ID: <CAPb83E-9=dLoc7ywHjw58Boxp9wkPaAXFy+UH+HJUE9tUzw=_A@mail.gmail.com>
Subject: Re: Possible bug reports for git-credential-libsecret
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I previously determined that code can cause unexpected behavior because:
  (1) the vulnerable code of "credential.c" patched in CVE-2020-5260
(vulnerability related to newline characters) identically exists in
the "git-credential-libsecret.c" file, and
  (2) the test code (please see below) that should be failed, which
was added in CVE-2020-5260 patch, did not be failed in
git-credential-libsecret.

--- TEST CODE for CVE-2020-5260 ---
test_expect_success 'url parser rejects embedded newlines' '
               test_must_fail git credential fill <<-\EOF
               url=3Dhttps://one.example.com?%0ahost=3Dtwo.example.com/
               EOF
---------------------------------------------------

However, as you said, if the data has already been purified from
credential_write_item and then flows to credential-libsecret, it
doesn't seem like a big deal.
Thank you for your response.

Best regards,
Seunghoon Woo

2022=EB=85=84 3=EC=9B=94 19=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 2:40, J=
unio C Hamano <gitster@pobox.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> "=E2=80=8D=EC=9A=B0=EC=8A=B9=ED=9B=88[ =EB=8C=80=ED=95=99=EC=9B=90=EC=84=
=9D=C2=B7=EB=B0=95=EC=82=AC=ED=86=B5=ED=95=A9=EA=B3=BC=EC=A0=95=EC=88=98=EB=
=A3=8C=EC=97=B0=EA=B5=AC(=EC=9E=AC=ED=95=99) / =EC=BB=B4=ED=93=A8=ED=84=B0=
=ED=95=99=EA=B3=BC ]"
> <seunghoonwoo@korea.ac.kr> writes:
>
> > Recently, I noted that the vulnerability patch (CVE-2020-5260) for
> > "git credential" is not applied in the "git-credential-libsecret"
> > program (./contrib/credential/libsecret/git-credential-libsecret.c).
>
> The code in credential.c touches the data directly obtained from the
> outside world.  It opens a pipe to backends like credential-store
> and credential-libsecret and feeds the data that is cleansed by the
> code you saw in credential.c::credential_write_item() to these
> backends.
>
> What these backends write come from these keyring storage systems.
> If you look at other backends in contrib/ and also credential-store
> and credential-cache, you'll see similar code to give "username=3D%s"
> and "password=3D%s" back to us in all of them.
>
> Do you have a reason to suspect that these keyring storage systems
> the backends talk with can be as malicious as the data source the
> CVE patch tried to protect us against?  If an attacker can already
> contaminate the contents of the keyrings these backends read from
> and write to, they do not have to use "git credential" as their
> attack vector, I would suspect.
>
> So I would think it is natural to expect that the patch you saw is
> the only defence you need.
>


--=20

Best regards,


Seunghoon Woo

Korea University Dept. of Computer Science and Engineering

Computer & Communication Security Lab.

seunghoonwoo@korea.ac.kr

(+82)10-8147-9308
