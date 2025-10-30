Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C242351FD1
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820895; cv=none; b=iItHnMIvUoeYqt9RTYElqG89VZY/BfB5MTXV8FwbHJRZ5yliL2RYtj9L15CiMKMbMgV3u7cZRZYLuOL/fHXK8YjIjW4YTjyGQKQz4DMK2lhYqCRLyHj8j1G4wrKUceUxsWdGFmQEU6EpRZmuUnC6kO1kLcb60S5y0VSK68RYYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820895; c=relaxed/simple;
	bh=Oyk5HrZzZUraZ7FPJ3DroRhjBLBjKxGYEw6NqANd6/w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=L/rC6vzVUgy/dKBv/+f8B6DnQRLcEgjvTRAmoNwuBaOLLgoTjLCDn1P9KZgx+Jgi6+avyBxeXU/xtlhEN6o5wBkRB/FZxPj7962a/3FbSikSC/Zjg1K9nj7C5Tt7EMhaRA2fjPmeCG5ustYw4kwKptBwnzpZhYMb8rvpyrLiBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amx5ioR2; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amx5ioR2"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5db3ec75828so340429137.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 03:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761820893; x=1762425693; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oyk5HrZzZUraZ7FPJ3DroRhjBLBjKxGYEw6NqANd6/w=;
        b=amx5ioR2c4ma+3lYRencR9geKiFKBWQT6PSYG1b6Z5ExRcROgB3RKAsWKd1Lb7Iw+R
         7Exx3puaIfsvmev8HAv2HrWlCvNS1EyRen5wSD5eHa6FU2pSQMrE2FgbECu1u67INltc
         3KQtV/2dbEM+2gDEntHYDoNJgEs/e3PGDHgQywx1+914K6s/u5G5SYi76yatrk97mBi0
         CrXVN6TLpHJv5bvAQ1vN8HeRwgNFgvuRECXMC5HaP++GhzYW4XnNZtj69BAmc85B7f5V
         ZcaIznD1S3q2rvQmWPilHlGC0vhfWmWqhOXSl2Fz5ONzQ/x0XVkPr5wXk7mowbSoV+hw
         hlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761820893; x=1762425693;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oyk5HrZzZUraZ7FPJ3DroRhjBLBjKxGYEw6NqANd6/w=;
        b=OeeN2PHg/9zHrp5lFsp6gPcjVrxrRG9iEDe90dq2Y/U1EFoIu31a+4ArpFD+GkPPVm
         +dnVVbEHjkkfLiQtvfv3bofqwEUOvkyn+XTnxQX+1HAwyWlpDqEaBVmECzBqk7TgDEWP
         ZcImrBwYiQpmG36yu+PrM7ogHcWQmLwIutQpN4Q9IEMqPsjdWvTjZWxw0+DnIwy0O/xc
         8/pRr2Yk5VK9hl/YQjDhd163Av6GxwinLkR5Z97PVpaU/P7EY+XlpE/BN5Nk9/xBr+/4
         2znqNoj2+2EGi+Jt0NM/mESd5Hg+ypQpXfpbwYilJT5tH2SIoH6FfPt2CSxvHi4Zp0K3
         rxWA==
X-Forwarded-Encrypted: i=1; AJvYcCW/RsPzxInhaVbKLzCzCSaHeJODmEXdoLP5hZi/typ2AyqPpMti7DeJtoLIx1P8HikQlag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwueauA4bypbiBhTaqt6AuCb4fm5kJZtGpckf/vEZHdpU1ICo3h
	od73rX3hqnL5Mo0QKti4uG10Zo5Pc4P6DJZi5ogoty7pJoj0KvtP8ckAOnj7gPu6YKGhMYevXMQ
	NFeucRWZ7wzCVl/jh/OdD6hzo3LZyY0CHFZ5h
X-Gm-Gg: ASbGncvNDVj4i15M+EZew3tDt+4Q+fvOq2xTSnKCPMfBl1Bx/MM2/AY1CAy/va9hDIT
	+SCjUy4DS6uwlnKmuIjcecXf7BQCqSlFvMhq95MzA6uynVXRZ4Ry/Q+7MxLfXapHr2YXLi4JR/+
	izVqJT5vdWhhu8lD56jcE6FSWe5gOtZkiucj9m9vtWVGEiubfg0IfxOM/4fuln/kOMRO+dB+wqK
	qppMZUyugIVFosD26qC3GzMXw0aAIDNuIR3zcDgKOpKCbo6MtaedviGHIj6zwfCL0QpqRRMU04h
	Ziyw+dL7hEqEKmDZaQ==
X-Google-Smtp-Source: AGHT+IHQxgfvSV/hyF5Hi90etlgKMlr8P+pbXxeHauh8IhJHNC0XotBZsPsLT0wXkF/ijDiSCvAJpdCzuotoL6lTEMU=
X-Received: by 2002:a05:6102:1613:b0:5d5:f6ae:38bb with SMTP id
 ada2fe7eead31-5db90676f8emr1729332137.36.1761820893051; Thu, 30 Oct 2025
 03:41:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Oct 2025 03:41:32 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Oct 2025 03:41:32 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-3-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im> <20251024-b4-pks-odb-loose-backend-v1-3-1a4202273c38@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Oct 2025 03:41:32 -0700
X-Gm-Features: AWmQ_bk1HBlfnnm4OTtEN72eswUsfV3mAf94eZ4eFxrG_SSpOvPNXmR152Kv1e8
Message-ID: <CAOLa=ZSW_qjsOk7c9dN+tAjmZHCdCsd5aOwaWWFdpJG3KcnbbA@mail.gmail.com>
Subject: Re: [PATCH 03/13] odb: adjust naming to free object sources
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007d17ac06425de46a"

--0000000000007d17ac06425de46a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The functions `free_object_directory()` and `free_object_directories()`
> are responsible for freeing a single object source or all object sources
> connected to an object database, respectively. The associated structure
> has been renamed from `struct object_directory` to `struct odb_source`
> recently though, so the names are somewhat stale nowadays.
>
> Rename them to mention the new struct name instead. Furthermore, while
> at it, adapt them to our modern naming schema where we first have the
> subject followed by a verb.
>

Nit: Would be nice to mention that he renaming was done as part of
a1e2581a1e (object-store: rename `object_directory` to `odb_source`,
2025-07-01).

The patch looks straightforward :)

[snip]

--0000000000007d17ac06425de46a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f27276b826927255_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rRFFOb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGhiQy9vRE9iQlFuRVFJV2RFbUkvSTRIbDJoQnNuYgp2bnlNbzA5d255
ZlpNOVdtODJmN1lIVkxhMjAxUE1WSFNEVGZ6aXRGWVpPWmFxQjBTMnVEV3hseFVkT1dZcjQrCjdL
NUc3a3B0b3E3Q0lMVUxycDVhd1Q0VU9qTDVHU05oNGxTTHpTQmVnUStQckw5NmlkQVUrU0FLS25t
aE1lWloKcWJzbjlvaENNeWZ0aWhVRTByczdNdVBPTEVnd1VRa0ljTWkxaERCSGlDWi9hY1VNMjdM
SElRR0NqZTlwY05JYwo3aW9ydDZrTnZ3bTFBOFZGaWYydFNUR0ZOR2tPTVJnZGV0ckhsOHdPVEhZ
aW4wQjRDRFkrZkx2RDdnbVNkL2RCCjI5L3lyaDdzUGNOQ2NsTDhSRDBDd2V3YjQ4ekZwdEFNNmhy
Uzd2V1c3QVFSUFlyZEJaNVFOWTNvT3NTQlNCN1YKcSszb200RmtlMjFHWTloVjI5Z244Z29ZZ1dD
MktBRlVMQ2dCL2VPZlVRa0hJTWEzaHNMWnlyclFGY0JhaFhMWgp1NkZCbk04Nnh3K0lGb0NVOG8w
M0dnbldFdUR4UFJ5YnhKeEhRMHRNS3pwK1JZaUxsMHYrT2NYRmNUdG5IUTNsClFvVWIySlhTWGxt
OFkvQUZKbTFWN2VUM3R0YnY5NDR3MXhUb2NqOD0KPVhISTIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007d17ac06425de46a--
