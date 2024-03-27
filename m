Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F436E
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532173; cv=none; b=gkStY245MOlF1mDEDKuDGevi43o1A6AldpHptVW1ES94b1qIA2NL4UXxNB6SCGhdt7xIgYwD8nWLhAFI6UohnBFu1FiyusjxNOdDRX5xVpNoPBguvr0/pqN+xZPKnr5EwiFSE9EsoqYBL0SmRbDxpTS5DfrVejpt8nD8EzpZVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532173; c=relaxed/simple;
	bh=s5YyIlZFT0lDmBmxZ9t0F1ArWHD30p8xWvcDmpLK/V4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=M1WRTcevGiynCunJf5W8UnlAXVSfhwqAhIOH6JRNa8nqct9Tdkka2aJPpKMjolsaxiJ5jq7IAuiDBCC+s/ZDf9x8h9BI3Qltjtde4ScCsYOQa9bUnsVlIDBZt3vtxU7o75C1EtPNjV1WRsSBNzxYNbhJ31pkCPUl06TjAx6WA7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cP2OYoQy; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cP2OYoQy"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d6fc3adaacso3916471fa.2
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 02:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711532169; x=1712136969; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pkcDd4kwupOTm9QldxxmygXgRIKy9oZTcJj0+Sy2NQ4=;
        b=cP2OYoQy8b7u6G6Is+AbR67wN+YljiZhnuJG2q4/haxmcMOGe+lmrrw1f4TAg3HOkr
         P2CCDn2I26bWsPPCXDtmYVkVAD7WED1m6GfNXsS1Zk5bSrj7LoSaD1wWfkyu6TddLmaG
         /oOkKrflwr/eEx8J7RCbpVO2pZCRG5WcdvFQok7ETVq4JhmHZeXGprL391a1miABDROJ
         ESNYlLn4fikVgov9McSqQmHRRdClQoPKlrEyomDR3pypFY3MF8aY50uGUJSUZ2QFiZqU
         CHqBdw0Nnm2dWQ9iINlnczIIbKrRJ20Hs2Otbg6lvmCMq3Ug+UbYwsISiPIt2oHa1fsk
         k4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711532169; x=1712136969;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pkcDd4kwupOTm9QldxxmygXgRIKy9oZTcJj0+Sy2NQ4=;
        b=bt6Urz1ZGTRCdB4UUztrZ05RFrfNdzmbEjV2vYSXZdsxLK7aGP4yZgPjGkwrDwZ6J3
         cGO+t+WDDVfU+NKojp+5QywOrZTsmxWXwJFP78rHH84JURJ2O5uckaHLYI784CTn90Qd
         nlWPw7sCGoYcMflA4CQvsHNbY4T8lW6boG+jZXViKK2Uc/y98Cuvjqfk/TTztuvyVh6N
         OOcfQFybEsDoGvO8p0YTh0zoGBqYMfcReYo1ndqWH9Dkkovbe7YBelaH8QBALJzAEBJJ
         CFTu9HAjDAmkkwF3qCOyr1E21mhAI/VjG9WYryWaD7zO7PeHbDw1kQK9XCaKDmu6OICN
         sMBQ==
X-Gm-Message-State: AOJu0Yx5ip8buLu8mHIHAIQNwWnDQHNUd3wTdhl383faZbBAx+q/ElJl
	gJtn6nEzhBZD1kfcChWB9cpmZB4Go7v46csTDvs+/5RgnYGOFk6s97231I38lIyBo/Sskn4zoUT
	UanwDZwGR/MQjV90XlS+Ew4vyoRa2XU1HnvB6Og==
X-Google-Smtp-Source: AGHT+IGuDoOr82WOalP1IFPA+Y3vHDJ1f8j0OZHd69Ho/ckDxQfi4X4RVcDIXIYLkb4ZNfDQrbi0jaP7/8GcLA6AFJE=
X-Received: by 2002:a2e:9b1a:0:b0:2d4:6aba:f1a3 with SMTP id
 u26-20020a2e9b1a000000b002d46abaf1a3mr1232960lji.6.1711532168820; Wed, 27 Mar
 2024 02:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aishwarya Narayanan <aishnana.03@gmail.com>
Date: Wed, 27 Mar 2024 15:05:57 +0530
Message-ID: <CAHCXyj3Now+ZrA+w+L-sQAtAMZ8REru=3uF_Y3Xdt=7CSf=pYQ@mail.gmail.com>
Subject: GSoC 2024 [PATCH]
To: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000f1d88f0614a122c6"

--000000000000f1d88f0614a122c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Git Organization,

I hope this email finds you well. I've prepared a patch to address an
issue related to the handling of exit codes in our test suite
concerning the Microproject idea Avoid suppressing Git=E2=80=99s exit code =
in
test scripts. The changes ensure that the exit code of the write_utf16
and write_utf32 functions is properly captured and not suppressed,
improving the reliability of our testing process.
I kindly request your review and any remarks or changes you may have.
Please accept my apologies for any mistakes or oversights. Thank you
for your time and attention.

Best regards,
 Aishwarya Narayanan

--000000000000f1d88f0614a122c6
Content-Type: application/octet-stream; 
	name="t0028-working-tree-encoding.patch"
Content-Disposition: attachment; 
	filename="t0028-working-tree-encoding.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lu9m1xdb0>
X-Attachment-Id: f_lu9m1xdb0

RnJvbSAxNDkzYzgzNGIyMzczMjI2OTkyZDZjNThmODg1NDllN2JjOGRmZDQwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBaXNod2FyeWEgTmFyYXlhbmFuIDxhaXNobmFuYS4wM0BnbWFp
bC5jb20+CkRhdGU6IFdlZCwgMjcgTWFyIDIwMjQgMTQ6NDc6NDAgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBUaGUgY2hhbmdlIGVuc3VyZXMgdGhhdCB0aGUgZXhpdCBjb2RlIG9mICB3cml0ZV91dGYx
NiBhbmQKIHdyaXRlX3V0ZjMyIGlzIHByb3Blcmx5IGNhcHR1cmVkIGFuZCBub3Qgc3VwcHJlc3Nl
ZC4KCi0tLQogdC90MDAyOC13b3JraW5nLXRyZWUtZW5jb2Rpbmcuc2ggfCAxMSArKysrKysrLS0t
LQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS90L3QwMDI4LXdvcmtpbmctdHJlZS1lbmNvZGluZy5zaCBiL3QvdDAwMjgtd29ya2lu
Zy10cmVlLWVuY29kaW5nLnNoCmluZGV4IGFkMTUxYTM0NjcuLmYzNzJjMTRiYzAgMTAwNzU1Ci0t
LSBhL3QvdDAwMjgtd29ya2luZy10cmVlLWVuY29kaW5nLnNoCisrKyBiL3QvdDAwMjgtd29ya2lu
Zy10cmVlLWVuY29kaW5nLnNoCkBAIC0xOSwxMCArMTksMTMgQEAgdGVzdF9leHBlY3Rfc3VjY2Vz
cyAnc2V0dXAgdGVzdCBmaWxlcycgJwogCWVjaG8gIioudXRmMTYgdGV4dCB3b3JraW5nLXRyZWUt
ZW5jb2Rpbmc9dXRmLTE2IiA+LmdpdGF0dHJpYnV0ZXMgJiYKIAllY2hvICIqLnV0ZjE2bGVib20g
dGV4dCB3b3JraW5nLXRyZWUtZW5jb2Rpbmc9VVRGLTE2TEUtQk9NIiA+Pi5naXRhdHRyaWJ1dGVz
ICYmCiAJcHJpbnRmICIkdGV4dCIgPnRlc3QudXRmOC5yYXcgJiYKLQlwcmludGYgIiR0ZXh0IiB8
IHdyaXRlX3V0ZjE2ID50ZXN0LnV0ZjE2LnJhdyAmJgotCXByaW50ZiAiJHRleHQiIHwgd3JpdGVf
dXRmMzIgPnRlc3QudXRmMzIucmF3ICYmCi0JcHJpbnRmICJcMzc3XDM3NiIgICAgICAgICAgICAg
ICAgICAgICAgICAgPnRlc3QudXRmMTZsZWJvbS5yYXcgJiYKLQlwcmludGYgIiR0ZXh0IiB8IGlj
b252IC1mIFVURi04IC10IFVURi0xNkxFID4+dGVzdC51dGYxNmxlYm9tLnJhdyAmJgorCXRlc3Rf
dXRmMTZfcmF3PSQocHJpbnRmICIkdGV4dCIgfCB3cml0ZV91dGYxNikgJiYKKwl0ZXN0X3V0ZjMy
X3Jhdz0kKHByaW50ZiAiJHRleHQiIHwgd3JpdGVfdXRmMzIpICYmCisJdGVzdF91dGYxNmxlYm9t
X3Jhdz0kKHByaW50ZiAiXDM3N1wzNzYiOyBwcmludGYgIiR0ZXh0IiB8IGljb252IC1mIFVURi04
IC10IFVURi0xNkxFKSAmJgorCWVjaG8gIiR0ZXN0X3V0ZjE2X3JhdyIgPiB0ZXN0LnV0ZjE2LnJh
dyAmJgorCWVjaG8gIiR0ZXN0X3V0ZjMyX3JhdyIgPiB0ZXN0LnV0ZjMyLnJhdyAmJgorCWVjaG8g
IiR0ZXN0X3V0ZjE2bGVib21fcmF3IiA+IHRlc3QudXRmMTZsZWJvbS5yYXcgJiYKKwogCiAJIyBM
aW5lIGVuZGluZyB0ZXN0cwogCXByaW50ZiAib25lXG50d29cbnRocmVlXG4iID5sZi51dGY4LnJh
dyAmJgotLSAKMi40NC4wLndpbmRvd3MuMQoK
--000000000000f1d88f0614a122c6--
