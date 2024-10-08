Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B091DE8AA
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389891; cv=none; b=Naevxfk3DqUtWODwWEqyf/cK5bWdBWyvgwGwgw7WDC5snfuOl7ynMy2UERYKOfdpTTFj5148xsE/ClKc8gXDOnoPwr/0EBPxzrq0pBysP/5cCnG8XyqmUUDwBBQzP0jBZLAaATbSztDG4vPk3GfMc4uZowS5p60Zz3FUU9kR8jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389891; c=relaxed/simple;
	bh=vo/e0tzP6w/gc76KTOF9rXFZIIud0i80yZZExXgdD1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfQAThxBtN5+gNC00SYn7iIo9+DOWtVXTeMxkWMbczIMLkwsQiCftjsZINdH27O5J5dbMJug6K3jH+LlPgU0vcJsOS6hAv5TNPQ5dY7Dg4wvbsMI9h3RHs9JTV8JDZTi5n+OljueQ+z02Ge/IOWomP/XXAtvDEtI81PKIPP0xH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8Uf2m5V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8Uf2m5V"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b90ab6c19so59037545ad.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728389890; x=1728994690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=csSBfFUOzUfoJYjy2ZQ0dhGR0ByTWlFxCqYoVaURuA0=;
        b=R8Uf2m5VAbpSsBB+oM9++hzfHdxi5SjelB33pio/BUxtLmVEvKpLGc9HcfyhrzmOqF
         TL/NHIE50q+t6TXn2CnX2la1VmQzskSaKiDgRyOFgaumqqDXM0lo0bcSCF5dR+m01w4U
         NNPSY7Titf36dDjzN1GpheE7L5ooNjG2n2SQjnb3MQCXVDLt/u4pPzf1Axq3ebJMs0fd
         QMjaHN/jm77sU1pcVyF8uCZmQnw3XcTJ6KGLILNKHVQ8tQfjQ7mKYTgMBWPudqZ0hUHi
         oEumkmjQ/0HmD8yMKcShDwqaH62OIz9kv0Bi/ek3x6tbPp4sZMmUjdy7LWBbWBo8HHBd
         6qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728389890; x=1728994690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csSBfFUOzUfoJYjy2ZQ0dhGR0ByTWlFxCqYoVaURuA0=;
        b=upidgb2kQZiw45qIGPwNjsRSVm5tXhZUbFABJP7aJgsRnPzGCd0em/koVm1shvDwc7
         sygfj7O+R6Fu4ReUW6+vqidTjmCWkSG1bq0H/HdrME2yU1NMG5DvDAj+zCuHhKQ8Lboi
         K3ZnjQ2QATf3i0Jgh29KaFGVMra2UZM6LYuCOIPfqcy386DLZBTTF7Nr0OmBCF9bxq6v
         AzoJTXBXuja6wyoFCUtOLdOimx84kZv4uPSEK05UAZqXIEngdefL5iAx/zqYXv6lSQZI
         IXQTzIN1KE777Q7mNCl+QiV6HvvW3X41WWY7x3M6wrom9EDczsW6ZwUkzBPl/QYxD119
         9R/A==
X-Gm-Message-State: AOJu0YxXFdtR5caNB3UK53XWbulL+mhzG0LlEzl3IY76PscOzgIrr651
	vXnjSe0oUz3G1VJe2+orOZcc/ztNhYUOFi6RU46FCZmyMKiwWhAx
X-Google-Smtp-Source: AGHT+IF9oYcjrKX57VX1wfauSg43eceFHV1GClEJaxq6rb9lwzufydEmknREjxPJ+F1QMKnZVB9kig==
X-Received: by 2002:a17:903:32cd:b0:20b:8341:d531 with SMTP id d9443c01a7336-20bfde659d3mr240302485ad.4.1728389889863;
        Tue, 08 Oct 2024 05:18:09 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13968d40sm54259275ad.200.2024.10.08.05.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:18:09 -0700 (PDT)
Date: Tue, 8 Oct 2024 20:18:18 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 5/9] ref: add basic symref content check for files
 backend
Message-ID: <ZwUjCnxPw0NObj5d@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-vbvQym1R4KJk@ArchLinux>
 <CAOLa=ZQGaLJTJ-bcSYD1mcsgCD8ayHYzXatmK2iyz4gDodvvKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQGaLJTJ-bcSYD1mcsgCD8ayHYzXatmK2iyz4gDodvvKA@mail.gmail.com>

On Tue, Oct 08, 2024 at 12:58:16AM -0700, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > We have code that checks regular ref contents, but we do not yet check
> > the contents of symbolic refs. By using "parse_loose_ref_content" for
> > symbolic refs, we will get the information of the "referent".
> >
> > We do not need to check the "referent" by opening the file. This is
> > because if "referent" exists in the file system, we will eventually
> > check its correctness by inspecting every file in the "refs" directory.
> > If the "referent" does not exist in the filesystem, this is OK as it is
> > seen as the dangling symref.
> >
> > So we just need to check the "referent" string content. A regular could
> 
> seems like we're missing the noun here, a regular what?
> 

It should be "a regular ref". I copied the original commit message and
may carelessly type "daw" in vim to delete the "ref". Thanks.
