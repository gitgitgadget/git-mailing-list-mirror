Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8BE1AB50D
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928667; cv=none; b=W963N5Mz4CDVLdQMynlynXaszVxnDspsJUYsZ6ADtJ/ZlylHkEBaTWRO0gTz+eekFclZelYLmnHz7f7n0wwiLsWB5JElbyG8k2ZTcCTsqPFi8I0zE6WpoHhbLHl+gWQ3LZ5Jjo1oG990Q6gsD5PlTFDNZYcqZCDVFH0aeFdgp5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928667; c=relaxed/simple;
	bh=6WYFIx+DoMKQxRlOLqLsWUPKUeyJtpufFbwHNUC6Sgg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvMkfuq8bTlgULnIrjAKW9iCb9VogMioKGwliGnUb11sNDyDt1r/3H1I1/zX/ywXcN0HjelfBkLs/ny9nNkWzeoHm4OMOUu/WfUqh5Ot/hwhev0wBU9ahTKZRkKDqu8ANE5MTFa+m3maFqiV0aa2nGKk2vfINuEwy+0FcGizD8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LG4ux4zh; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG4ux4zh"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4ba7d775cf5so356689137.1
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 03:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738928664; x=1739533464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tS9828wwe6zJ0jn8CtRar2/fVnVek5e2opb5ka/BvmE=;
        b=LG4ux4zh1FU0XHbQxGNUC9lr/HtSFlqWlfoOEEZh9lX5KJDZPSewBArY8OwvfNQYWS
         20tQAN8B9jjqXl0mrKVoDumHU4ZQ/qmWJgl5ELKFKMow4trIFLAUQxApbvpQQsPnzJJr
         5eqtFR3maF8KPWkK6s6+5stVkR8Qj4xDVVphkfmKiPT8OLKHviQMex0eFUk8S7WOWveU
         O++B2qBPy9jruvnaZ1cXwwFzjpIqfiK8KqVn0c8noE5TwR1AO7tG/8014doMCAdoD906
         f3wnrJ3SNOjlbpPewgTUBRc6XTwKnqvIGlLmbTgCvXtbxeR/ZwDj12+XbGfpqN8+kqMR
         2EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928664; x=1739533464;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tS9828wwe6zJ0jn8CtRar2/fVnVek5e2opb5ka/BvmE=;
        b=ibQtWc7wC4XhdZviC/8pp6s59QBsbABgjiEVcUK+5cfd6QFW8YetA5DpVjQS28FGD2
         i7/HLf5nfd9jZhhWQNi+eqqFx52XLuGt3qy1Bon6N+1iv/p8yvV9mVI/rnKJp2XmEPiJ
         8OfwPjihEiz3GftKucGT/jTz7kM2w1UageM1cCuMdzyKYmGiGrt3fmudLdYD1QYxjzV2
         zaxVrq3NLrZECKht4JlSnqCZLPi29q75r3BezvjBW+5XzXF9BCvxRm/2UyReTQuCH1ub
         vCNupiQPjh9xpRT88SwcA8nrogO2Pio/jgg09c5TWL6nqvhIViC2d1DSE/fu5QGwujKf
         QUeg==
X-Forwarded-Encrypted: i=1; AJvYcCUtaQsV65I7BsiGvHPZexErcd4oXaAleXPuFF4lpgDEZAW+BSUjsrMUoN9pd+tc7PlNep0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2b9Wvr7pNgBuqdeXuTmEhp9BTiqUQX0SRDdCfGD20HCojiM4/
	wV3Gv8TRqLbYhGi82rcLbhrR8SoDGrO02OVT6JSDNda2g2VvjCpaR2Tn9g2XbTQJ+OatgVCQ8eZ
	9G1ArsTXkpO6qKsgUNvddXZBJBpQ=
X-Gm-Gg: ASbGnctFa2I54apNzpcRQ8lqKvnkrEDyd5rPvqfjuLyn1i8t8Ia5C6E/a7PIAj+7dKB
	6yYYgX3iocAa+GIDmlXviPKva12vJAlxZNbP7uvASPwUDYuZrjfjlyNkGoYGzPfIDfRAIZ6ohSi
	dhh5O4AaxVDYlO1EmWQbh0ffVEaeNrJhs=
X-Google-Smtp-Source: AGHT+IHYyWwvVOnTx0gdbBA5KZ1mU6hTowraPpu6qwPPRjKR5nUk9yp+ZNrpjiU1WSLehMUlSvpTaFsbITAMtJoKCIg=
X-Received: by 2002:a05:6102:26c6:b0:4b2:ad50:a99c with SMTP id
 ada2fe7eead31-4ba85da5b5bmr1331085137.2.1738928664472; Fri, 07 Feb 2025
 03:44:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 7 Feb 2025 03:44:23 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 7 Feb 2025 03:44:23 -0800
X-Gm-Features: AWEUYZmJ1jmELQrXaKYR7MC1v-WnGLCOhTokQ9zDeW26hPqbXfs44YATJflr7Kc
Message-ID: <CAOLa=ZSaMLXjObMACFuY+2uGvmpDcV-WdPFj4eyDukmPiC-0=g@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] path: remove dependency on `the_repository`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000005614e2062d8be1d8"

--0000000000005614e2062d8be1d8
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series removes the dependency on `the_repository` from the
> "path" subsystem. The series is structured as follows:
>
>   - Patches 1 to 5 unifyf the interfaces that can be used to retrieve
>     repository paths (gitdir, commondir, workdir and submodule paths)
>     and adapts callers accodringly.
>
>   - Patches 6 to 12 drop repository path functions that had an implicit
>     dependency on `the_repository`.
>
>   - Patches 13 to 16 refactor "path.c"-internal code to stop depending
>     on `the_repository`.
>
> Changes in v2:
>   - Rename variable to `wt_gitdir` for the sake of consistency.
>   - Improve several commit messages.
>   - Link to v1: https://lore.kernel.org/r/20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im
>

Changes look good, I had a look at the range-diff and everything looks
great to me now :)

Thanks

[snip]

--0000000000005614e2062d8be1d8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 790e17438a16dfe_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lbDhoUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meDZNQy9zRzUrcUZ1OHhCZWtjclhqTVRWd0FTc1EvSQozV1NyWHZxbVVi
OVZHQW1qT015QzlwSGNyM1VGOXBqL0luWWFhM1RncWhVVjIzRlU2ZzNDVDUwVmRvMm5DSjBnCnNk
VWRPNURMMStqVDFnWGJyQjhIVHRMTWpIeTM5ajU1MVVEZU5BLzBQMGF3RGJOZjFZdnRCNTRmQWdt
TVZiVzkKUjFMUkhrbGZTTUV5NGdQRE1HT2JKVGt1VTNCMnZKYjVNUElhRkRRMkpFVjRodTJCenJB
MUpjYkR3cWNHRzJ4YgozQyt6Nnp3UXIrQWRjY3NQM3doVmZKZmM1VmZRNjA5blJ6ZlpqdEZaU2lE
Q3hROEdiTUh1ekkzK2RVNlE4MUVwCkREN3crY05UREdHT1NHdEJjRCt5NzFqVVIwWVZxZlAwVnph
elNXa3dyZ09mV290RHJ0L3Bac1ZSZWpjQnNRSlIKdmlxK1V4RFZOK2tsaVoxTGtBUDdqZW5PRExM
RFNjaUxJUExVb0dPcnlxZWpDSE13cVJNSTlTSTVxVWVRcHd6cQpab1NsUlBuZEpFaVhOVEg5ck9Y
cUNmWkVTY3o4aFFISElVU2t2b2Jtakl0eTY3MXZKTE9jYm9pNFhDQ09waWxqCjM3VW1FdnBOQXFh
RWZKUHpnd3ZFUkY2RjFTSC84OVpLOWxTTkhZaz0KPWpITXoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005614e2062d8be1d8--
