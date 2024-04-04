Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7843F28FA
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247380; cv=none; b=LRsQGztrA8ATRD9e+gw1PRg5ADNaeaEjKKKTx0eWg/N2BrqsgmzFCQzeIwz8VPhd66HD9n5/HWUPGmik05v1DB4Cc1yfz+xydmCOZzO28T5P/W6euWTAjjLZAE8JuSBzwbq/ViQFUUfKJPbPcHDTNQQLVa66ePgeO1ABaZ8w4u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247380; c=relaxed/simple;
	bh=o9D3l13SsZ5xn7rgSrk1fR7v1LVWLJx0SCufB+XoGZk=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=t5q1pFpULNf6h+zh7MXAqw+E/vhOvP2LtKhe4iRhODjnbe+H77XIog+6SFY7cjLz9T8pqbOmWe9tTuWSa5cs5TylHhppA61WE4aEzB60x4/MIyvVNVbbkSDmtfgb1aPsnRDdi4NGO/C59C3RpuOYoznYag0quubQtdlZdkDU1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gearset.com; spf=pass smtp.mailfrom=gearset.com; dkim=pass (2048-bit key) header.d=gearset.com header.i=@gearset.com header.b=IveRyznx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gearset.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gearset.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gearset.com header.i=@gearset.com header.b="IveRyznx"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4162c9cd7cfso2223525e9.2
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gearset.com; s=google; t=1712247375; x=1712852175; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o9D3l13SsZ5xn7rgSrk1fR7v1LVWLJx0SCufB+XoGZk=;
        b=IveRyznxZY16ldaMehXl9lvplEmd5XLQHtYy6s0MUqMTZAi52TBiECBtRi9shDyjh5
         mRKF13q5JuP+W5mNACdZCQeFVr3wyT4fdjaRrQy8mkHtAUOrjgj3LRy7V+BYkruulM4z
         ODMo7NtZmOUXbiJ5Uji3JxGhgb1bUb/SDOEx6Io7YBNzjArWBk56Yy0W0ndYFnuTZZdo
         o+4XVQ821A6HoNyqhcIocdl3EfzsviW0RYqteEiFDZeOrfK7L/lnmEFFn5abLHRqf3HK
         ZlLJlp7zDxmH38hgh4ihyTG/y7CbiJOvtFNgIjZQMeM4uLh3PAG/aMocpXOuUFHRJD20
         WNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712247375; x=1712852175;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9D3l13SsZ5xn7rgSrk1fR7v1LVWLJx0SCufB+XoGZk=;
        b=Y/lC/CN67lzY9oiLRmk89FSnUAGASBENU4uJ28Zf1wEfAP/KSxkSEsINLQ7yl0RnPG
         EjvpejvtxhhprbP05MUvDtKV2fa7pgAnVLAckXAdL+3CHS/XaFmyBmqgUCJprDaB7BA0
         fA5poqTihNtAtO81Svopau0r2ZhpDuFhJP/t2gJpVwLLVUabx8lJ83Et28KO+1UUMaaT
         GnoQ/tss2RwUeKDwyWjiXDYflLHMSwXdwQ9FDYBUXPQhZg9aHYERneif2MrV9ZkysaOx
         O106JO95i6SW2fF82Nts9Ws/7X7T7vr7ni66gupWHTsOmu45Lv4bFClTp1toNU+WFvzv
         FUrg==
X-Gm-Message-State: AOJu0Yzp0uziqyzp++Z3lvZ1fSI3NAtEpaue0l9+BkY78LqQXYr6JEcL
	KjpNVpUOhAz3dTxA058Nt7lOL/nlVRqx1iAzrz/6LF14YKkJYPuC+24izQcy2XjCHzBvz28p+Sc
	M6oE=
X-Google-Smtp-Source: AGHT+IHDHoRW7x+3uGdkQrJLEwRPXT5cCKyjRBtyWDfHZ7YJJreP4nG5z2TXqj/h9z/n6Ek9vnSoOg==
X-Received: by 2002:a05:600c:3c92:b0:415:5fe4:bdb4 with SMTP id bg18-20020a05600c3c9200b004155fe4bdb4mr2793124wmb.7.1712247374636;
        Thu, 04 Apr 2024 09:16:14 -0700 (PDT)
Received: from smtpclient.apple ([185.140.18.131])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c4fcb00b0041488895a37sm3177597wmq.33.2024.04.04.09.16.14
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2024 09:16:14 -0700 (PDT)
From: Matt Cree <matt.cree@gearset.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Unexpected git merge exit code when killing merge driver during
 ancestor merge
Message-Id: <75F8BD12-7743-4863-B4C5-049FDEC4645E@gearset.com>
Date: Thu, 4 Apr 2024 17:16:05 +0100
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hello all. I have observed some strange behaviour when exiting a custom =
merge driver that I was wondering if there=E2=80=99s any reason for =E2=80=
=94 I think it may be a bug but I=E2=80=99ll leave that to you to =
decide.

I=E2=80=99m configuring that merge driver to exit during a merge at the =
first sign of conflicts =E2=80=94 the exact nature of the rules for the =
decision to exit early isn=E2=80=99t too important I think though so =
given it=E2=80=99s =E2=80=98work stuff=E2=80=99 I=E2=80=99ll leave some =
details out.

Here is my current understanding of how the ort strategy will deal with =
this.

- Ort runs the merge driver with the parameters for the current file to =
be merged
- When the driver returns exit code 0 is returned it is treated as =
having no conflicts
- When the driver returns exit code 1-128 is returned it is treated as =
having conflicts
- When the driver returns exit code 129+ is returned it is treated as =
some kind of error scenario


Then subsequently
- If all files returned exit code 0 during the merge git will return =
exit code 0 i.e. no conflicts
- If any file returned exit code 1-128 during the merge git will return =
exit code 1 i.e. conflicts
- At any time if the driver returns 129+, git will stop merging and =
return exit code 2 i.e. error?

However, when setting up a criss-cross merge scenario and =E2=80=98short =
circuiting=E2=80=99 the merge during an ancestor merge, I get exit code =
134

Here=E2=80=99s a couple of quick scripts that help recreate the =
situation =
https://gist.github.com/mattcree/c6d8cc95f41e30b5d7467e9d2b01cd3d

The logs also show=20

```
Assertion failed: (opt->priv =3D=3D NULL), function =
merge_switch_to_result, file merge-ort.c, line 4661. =
./run-recursive-merge.sh: line 162: 78797 Abort trap: 6 git merge =
$featureC --no-ff --no-commit
```

I thought it might be worth raising as a bug here but I=E2=80=99m not =
too sure really =E2=80=94 I suppose the short circuiting logic I have =
introduced may not be a desirable use case from the git elders point of =
view, but I reckon the difference in behaviour depending on whether =
it=E2=80=99s an ancestor merge or a final merge seems to indicate to me =
that this is not intentional.
Hopefully someone knows a bit more about this.
