Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEEC2110E
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108428; cv=none; b=Cwg5byJGE+/wDGxz1Qf2rYXe/sv3O/6/IDkBnElIziDgloFTYHYNRBJILa9B0vYXrFKyfF6Kfkeus11GIRxoCxc8NfKX+wvv6k/Q6jDuOo89CZiKhcw0R3h5TbPB8QxwJAm9WZL2Dd6fV6u5kB+GFp4o8DX6xaTzfBTxcbvVGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108428; c=relaxed/simple;
	bh=XqzyLOe1c1dwhy3P/CyAj2F/elQUgZUucchS/1+LuPk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HFLhCearMRRM/UE7k9XWuGGTVravV0Bhzc+EFjElFHl/EdjbByuRkRTsr/5p1ffiQV44uBm9xX64ArpjTpCEN5c/GHS3ZzUIkL7zWQkUhmvyPjnCsK/nQJEi+B5sJ6TJwm9t62Ausx2GSaBDBGTpVGDM0WkdYBGUfuvuc0W1b7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YikfJGLh; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YikfJGLh"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-781997d195aso4895465b3a.3
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 21:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761108426; x=1761713226; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqzyLOe1c1dwhy3P/CyAj2F/elQUgZUucchS/1+LuPk=;
        b=YikfJGLhjT5nVgDpTsHN/MZdjuSY/9/HugjM0CWBqd+9l8QngH+BrlRukkMzbcQByP
         lnFrxHll8PmPt5TAXRSWfUCMQuCGDRdOXzam/nT+kM8UxtX77Fe/mdjMGklK1T8L8PjY
         TCygYF9S19Q3vThelF5TGUoqXhGOqglbfqVZHGEaCgxWYboegX2wEWBeFVNQmE3+GlRT
         DkGi2ILembNtI2UdEdO/eoaisUVMHagPYwAQrx1PEMwGv++cYmpMGScq/O2+s2lwXpjQ
         o+um1oiIAh1omRf2foyg9nZHqcyOkpS4fnT26pu7evyvT7g8l7JO6N3t33WtAzyU+qm7
         yhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761108426; x=1761713226;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqzyLOe1c1dwhy3P/CyAj2F/elQUgZUucchS/1+LuPk=;
        b=N4tog5WCc4clmeu1hjnXR3GrN755aifk5cXBG7Pj4mXoCJzKQFg/FOB6w22/rpaPUp
         IIfDg+VLZFaVsH9YK6p6oUu+8oz3ZpwwCv7YAnssu+E7M6ahz8CgTP/Qw6l5/PSw59Ax
         mSVj7t0bG2NnzpqzR4KG/AoI5VL0ucDQFNZcZJVcvkN6Oc8lWFrbNIlCNhEqQm1es10/
         HZuV60TfU6Da7/KbKBcnB4AiKxf3zMcsYhMvSce5v/c+dVKzqaqeGloXlb0q/m+JJ+58
         +2GKmoDIdZ2GBqdBrKFoBQDU11zefFOSngGflTqqf5LhkfTNI6d/sOABVn19HlnfUCRS
         5emg==
X-Forwarded-Encrypted: i=1; AJvYcCUU2S+nmLno1TL5/3MEvRiID4p5HX+nyfbxaBIImb6YJ91eyCE+HgK1TIlZO0wgPuqEqyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx57JHeRSj322vF4PI7h9ekAaL3vVCZSIPHTEykbc9ZIXAxZM5+
	qPHvaMlAoHwCr5XYOTbCcmHJ4cPiTJjv07wROcew66NXXD05JXIG54DG
X-Gm-Gg: ASbGncvWE1OTTszQxnTSuTJRaM6ZdMAytvY46kb0rkZfhxeihOH0BbhadWh+bL8mUv1
	VAWsqhbRsIyZ0fQ2XBPcxDokeRWJi5hIjlNKGgsZqSP0q0x+mmXs8gjWRL7fit5HFMuGLFOW1F3
	TLVt+iFEL51Ejd34ImLPoTAoMp+AuAURf27PPqNQDYWXjHtF1gpWyxnWqoG7LelV96JU1TEcTor
	FPP/9plgtkU9EdYf5HVJhKGj85Rlsx88EpQhsnBsjKO94HI73qwpP61TzWaL05PTDOsxh/fjcLk
	yc7Ur3ksPEspaHdkWz4VOGSS9ydeSOt89Bn9kBxG7sgvBWOhrOPZTIBOAz3dl8JDkqZVbk2X12Q
	oschX7IrXjkL0wmLzmH3GvLgF7r5S5N44W0i5KzcKO9BTdJ+wnAEJqQqehXEFuwDdqwRA6CKLK/
	ubWeiZnYxPcGGNTQvUu0mSr0Xsd3yaBkzP/CB+hGrNUG5ov9A=
X-Google-Smtp-Source: AGHT+IGiH2DQudeiAtkFtlaFAfTzyg56HNjiqEf0sRRIckyTwUwAezb6XwpgpcrLep9bM68ruw1E5g==
X-Received: by 2002:a05:6a00:1884:b0:781:156b:425b with SMTP id d2e1a72fcca58-7a220ae0ff9mr23163890b3a.27.1761108426268;
        Tue, 21 Oct 2025 21:47:06 -0700 (PDT)
Received: from smtpclient.apple (n058152119060.netvigator.com. [58.152.119.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff349dasm13113914b3a.28.2025.10.21.21.47.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2025 21:47:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqy0p4wcac.fsf@gitster.g>
Date: Wed, 22 Oct 2025 12:46:55 +0800
Cc: Jeff King <peff@peff.net>,
 Jake Zimmerman <jake@zimmerman.io>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E76C71D8-103E-4C37-B05C-86DC180BD519@gmail.com>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
 <20251017075153.GA4078773@coredump.intra.peff.net>
 <xmqq7bwt1kyf.fsf@gitster.g>
 <20251018094037.GA1060824@coredump.intra.peff.net>
 <xmqqh5vww7xa.fsf@gitster.g>
 <20251021073640.GB259661@coredump.intra.peff.net>
 <xmqqy0p4wcac.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> /* return 1 if any change is found; otherwise, return 0 */
> static int diff_flush_patch_quietly(struct diff_filepair *p, struct =
diff_options *o)
> {
> @@ -6179,6 +6181,15 @@ static int diff_flush_patch_quietly(struct =
diff_filepair *p, struct diff_options
> int saved_found_changes =3D o->found_changes;
> int ret;
>=20
> + /*
> + * run diff_flush_patch for the exit status. setting
> + * options->file to /dev/null should be safe, because we
> + * aren't supposed to produce any output anyway.
> + */
> + diff_free_file(o);
> + o->file =3D xfopen("/dev/null", "w");
> + o->close_file =3D 1;
> + o->color_moved =3D 0;
> o->dry_run =3D 1;
> o->found_changes =3D 0;
> diff_flush_patch(p, o);
>=20

This would make everything going to "/dev/null" after the =
flush_quietly() call.
I think we need to restore o->file.

Thanks
Lidong=
