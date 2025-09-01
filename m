Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4281C27
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734769; cv=none; b=pKE14AnWbADj4vl1biJUjobXQqDsik3uL2QS0SevNQcuDLOSqG4S33ozfDtKUuanYnv0wibYyoQfFlWmapxOtRQYZ+y4l7r4LA0NazOaSUlaYL4IKBzMd4EvzIzDX93JuMkPvsk9X+zvbNR2hrcV7UdQQEKZ01Ue9MD9ayGotOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734769; c=relaxed/simple;
	bh=J81v/XNGVmcDf6k8A0nK/A8YZw1MyWHV4ngmxkvh3p8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTsvgu3kd+0/XpAVRoj+RWWkjbZ0RLLrO2l8mdexNJuVPCdlSEaMqIGykJPhDZZjUmFxcqtrpVntig6PekSNPMR9mAyyWp2iVfyfHg9hLEZcDKag1+Grwnxnpyr46MsTGwrBOBEhaQf3qwFCBgD14wgsuybC2x/JgZkxWcpJFGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SASNddw7; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SASNddw7"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5290c67854eso2672282137.3
        for <git@vger.kernel.org>; Mon, 01 Sep 2025 06:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756734767; x=1757339567; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J81v/XNGVmcDf6k8A0nK/A8YZw1MyWHV4ngmxkvh3p8=;
        b=SASNddw7qxtIWF88OUpvpBk34KBXYWYmzrGp/RgjxXY5CDl0PD1VspmhmWTXCgX9pE
         2F02tbJ6SJW0gcjaSENQ686rf6HUP51v8XAW3KVxm9sNAjv0FWduXR70ev0+b0Cks5uG
         mBvZwkZ1bMgF/TCn7DanlleksbJGqLEcAfRRCg2OzYR1qwlC/RD8aJFF/M4Xg12dwZr7
         +c4UNLJH/oVpIKzPPdcoyOO02zp/IXt7uTyjgTUrePG1qgOwjpZMedTWkPOjUFXCACZF
         4KEodTIxvG/7AseF6YErRLKYj31I8QWJ5bBqP2vS5unI9gzUqB9dTvmCz4wGydT5HZZj
         6kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734767; x=1757339567;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J81v/XNGVmcDf6k8A0nK/A8YZw1MyWHV4ngmxkvh3p8=;
        b=p6Ile6vUhf47PAfFB6659kX7/40HfcBPWekYpIOljrUTwLbGEQ8auibYbPTfIibj8u
         9YN6B4o6XF1QmpqmMvvRIE+wePyNTKGDfnpmENyYGcsW8iXH/B7FGweF9XBu0DQWVp/n
         bo1UYN5xf9pP9Do/maOaG/sjRLbjHAMkOOWn2YugHnRvCCzbASYskm7Sqvn7Evjj+6LC
         +kG5m/XI1R5Mbiq/h8EjreFlLqoUvkVPPtZAj8znQouU9cxWfUVdX5zYeQmgEH+oWqUk
         YZuIqrB9gCbUERMi3E4Sy/7opt9unvEP9PPdWdXLDxE2ReW/ebsRZRBfl7f0yIJ5uWIW
         a0VQ==
X-Gm-Message-State: AOJu0Yx+r15RaKFduUnWUIpwojx88zQw7NM04aHiBDTOT+vxCIYq4Xs6
	ljj6DI79Ek9Lap391MzH1AJlRlMnxYAge1+ZLPfY380TPjy5e4tkRgr/5BgIog7PBrRH86axlhP
	lvznFIU80XvQp0jltpBEVTeQrkwaaT9Y=
X-Gm-Gg: ASbGnctaJa72RhUvkYFFcefdCrxopAHX23B0PFvOY0p3dukb0M3TNzBj+7xTK/KW8uY
	qgl6MozKWBEHWsIqxpipFU6IMcLyemtfkZHkk9DxtTJaSw5hjzOzNb/Ae107OmFGGrR2XxPZvwp
	lT8+yMNLKNp+IGsJPvbcF6PS34YhDPlTI2Y+KUGYmEVEN0/popFzgL4twdvjNyhfGqb4T8JFEUd
	WdyRW996I0Jpt1vkAiUSkxCgmI51z1ZJZ0yv2FASguiTrjD7DK5
X-Google-Smtp-Source: AGHT+IE2ePDkrGlN3TS7bry+jX0tHnIJZCuzv4sgCE4nZB8OWoPFOzbaxXG17VD16ass9b4djK9tFLEUOd1nZTnIIms=
X-Received: by 2002:a05:6102:41a6:b0:524:4800:77a8 with SMTP id
 ada2fe7eead31-52b1974d764mr2240273137.5.1756734766742; Mon, 01 Sep 2025
 06:52:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Sep 2025 06:52:46 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Sep 2025 06:52:46 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aK3jNK82FILr2GuT@ArchLinux>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
 <aK3jNK82FILr2GuT@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 1 Sep 2025 06:52:46 -0700
X-Gm-Features: Ac12FXxeNs3oZzK5vEdWkrL3ErMkUsy8MRgzZKa9f2yvyrTfnyz_ge9Y0AhViAg
Message-ID: <CAOLa=ZRiG_6TD7ff=F+C2De1WqBSYHLc+Ev7NDbCtF3hFreP=Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] refs/reftable: add fsck checks
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000bc9c80063dbdaf34"

--000000000000bc9c80063dbdaf34
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> On Tue, Aug 19, 2025 at 02:20:59PM +0200, Karthik Nayak wrote:
>> This series adds the required infrastructure and also some fsck checks
>> for the reftable backend.
>>
>> Since the reftable backend is treated as a library within the Git
>> codebase, we don't want to spillover our internal fsck implementation
>> into the library. At the same time, the fsck checks need to access
>> internal structures of the reftable library which aren't exposed outside
>> the library.
>>
>> So we solve this by adding a 'reftable/fsck.[ch]' which implements and
>> exposes a checker for the reftable library and returns specific errors
>> as defined by the library. We then add glue code within
>> 'refs/reftable-backend.c' to map these errors to errors which Git's fsck
>> implementation would understand. This allows us to separate concerns.
>>
>> This series then adds some checks on the stack ('reftable/tables.list')
>> level of reftable, namely:
>> 1. The table name is as per the spec
>> 2. The number of tables are consistent
>> 3. The tables.list has a newline at the end of file
>> 4. The table names follow correct index sequences
>>
>> I also plan to send in follow up series's which will implement further
>> checks and go into deeper layers (tables, block, references).
>>
>
> Thanks for your patches, it's very nice to see that we begin to
> implement the consistency checks for reftable backend. And I have left
> some comments.
>

Thanks for your comments and the review. I'll send in a new version soon.

> Thanks,
> Jialuo

--000000000000bc9c80063dbdaf34
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 94bb1e62cf77eeac_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pMXBTd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0JNQy9vRGRlTjg5OG9rNWJvRjBwRE1YKzlMRjR3WApGUWtMSzFPVno3
Z3MwaDRTSlhtM0RWUlBrU3UrSWxlSGhjQm5JZGo3TnBheTl3RU9BajluNmxBSEFtZmlONE1iClZF
VFpZZlZNOENvRmtGS2pFbFhmUGVXVFJmWHpMdTZiVzd6RFlONmxuemNMdkIyVUJURk5yZGpNOE5t
T0dkMUsKN013cE12YzNTd1phTGRSOWtvVUYycElVbVpKNDdJOXhBMXVuaCtHTXpCUU1PeTdFZzhG
dHMrNEE2dW8vczBEUwo2UFExcHlGcUJESUpGN3p0TFRKd1Z0VWpEYjE0eVg0YktNNHowazJMeG9k
WC8yR3JKQVEwMTFwNFdqNXVZVWMrCndGaGtEM1ZFb21QajI1dTh5MmdyZVpYL0IxWkczVGpPdmVq
WlRKMVZrWHMxNkFGZ0NjOThmeFRWKzM2alN1SmkKRGtseGhKQko0T1RFZjF5aFppcVlVSEZ1NnM4
cHVnMWx0MWFoeStxdE1oQ1cvWm9yditaSWtaTXJya09WRk1QTAp2cDVwTW00WUlkWEhoYVRpTXQw
c3NncnNCU3RybjNQb0piQURPVllVSEhma3RlYWltZm0zQlB5Z1FTUXhLK1V3CjV2QUs0TVNudzFK
UU9CejN0NFJBUXBzZ1ZoamZRS1hmTUpCOUVQcz0KPThOTDIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bc9c80063dbdaf34--
