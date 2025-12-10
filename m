Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3630AD05
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380280; cv=none; b=MA7rDWjwXmhhAGEtaqq0TT25s8/wqBDE1SivWkhahlqMu0taGstuiU03MQOAz1OOnNQvI5vBV1OMgT8LzVio7ElRQdV6bxVYWya3HJSd24NYtlFHjYZ2PFZ4esT10dUSwQLakVyWbgZDTBspGt0gleX7JU/dfOldacb9tZzsnGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380280; c=relaxed/simple;
	bh=8n4bUg+FAIiCM4/DNWovVjZLu/HmoJqt1U1naphvyyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a41jOGdmVAC+WEjVPbpnm2A4/ZZXZdbOzUsmcG9PsPzsvQ0aBQKbHaa2s92fOi5lyYbG78zZZLtE2qWB53V6olfFd+xavbRdNIv+Ug2yfTKJ1lmLTT+k4WkmxHVY02Ksc4GayPe0nNdq6o5JkQYeIaS0eokMLJkZ0cw0KDX42lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACE/qoy9; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACE/qoy9"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c6d3676455so3271401a34.2
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 07:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765380278; x=1765985078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6KkTuWcTeDLbpRZoPxAHD1OMYUFEK2KlM/GyOPBAjY=;
        b=ACE/qoy9S/Bxi7D78TwGBep7ooK3Xy5a+6rlR8cL97fID7GdfRUG7BEqxa5WU3dMtk
         dJ29a5bM62StMzi7f0ZCzsJWm+rn75PJrJaPycJzaFJyowPQHYP07OZAnxsOao4ZXIme
         z8NoRTQyDLSVOMaHiNGUVfT5EeFTaNtZPVtB9DCAKyAgbU4czjH4RvJtm+5QycHRqO7/
         IgasTVkPbWtJc7/KZek4jX230U21mw7qKiTDSd8LWLHq6FXrcnO+lsYemh6gxbtGs+i5
         ZRAEcaFsrkUnxAFivYUYU90it/IksgJ9O2z065b6Pv+5X0dCg9JpOTrknWRqnpjWNI+B
         cG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765380278; x=1765985078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6KkTuWcTeDLbpRZoPxAHD1OMYUFEK2KlM/GyOPBAjY=;
        b=NLX8qCIqo/nVrlJv3pahlzW1rlpP9u8yR05X2YRRc3dxJYL1wsbZE1B9pmzNRVIHGx
         25x4Yaeel1fGYl6+++SfcwHRudA2kr+ZtVtry8grzbPbv/xXjCgXEf6B2YvNKFm4dCUP
         kOXD9EbUDL3DhVSnWPSJSzZYbbWJpO2mIgiOl9ysp2OtD5Ua4M9Z6vkYBsYGdfPmmpwi
         2PPjDGyTJh9epr7PJ7PKUg+FwARl0UbgojPkiNAvfAvns1+r0iTcL7usB+1T50xcosqp
         ryVeG9Qu/eP4N0Q+9jt7P4lgKWkqWLkueCOgesAPzUbP7WZSL14JRwrjUyhXcJF08d/7
         FZ2Q==
X-Gm-Message-State: AOJu0YxfolNBTFd5oiZeNArgqyK3VreBpVqeheWLIEIeJGHmqeCfnPRx
	igUqgtM1t9+TLFOeyKokmJgCKC36NTRaGT/NqaoL78HlnMVt6Zzc/VLlGq3tdA==
X-Gm-Gg: ASbGncs97WE1gXtEysqQ3Kv8r6hl6EU7N1xwaqcXuRdXV/56HWBg1PzCT3fXws2a7tN
	NYbfF568UDUYh1zGKEBelzZ9lG+YccrVFwQxkLTyZsbeLzJUozcp+TL8UN/nTYgl88Sa41+NH4c
	YtvGzn/BMhp02l+DxxutW/WTEGckeLKVIEcuXM6bL+qZ68aCjrGC+mc19lKscG+p4OkL6yQbMmk
	S4xaxmJmW8CYZRKHgsufJzBPkwJdnIRYhGKA2JUISxzqW1bxuzr8K+CwaEwgeYWV0zGTeSVKeEE
	atj6fXaC2qZ7nV9OwJHC5OT+Tf1ha4/I0rTOjlfhl4dyFo3HkSEuc81BI5P+E4HLwV2jMT9sMT3
	TUzGUjL2zNLtts769VnD28Xtndh0XzEIu7AV2ZiYEdTmRQpY5uQAsDI94BDqMc5PS2drUGCPK5R
	ts/BH4CsnpaiNxilk=
X-Google-Smtp-Source: AGHT+IE9Mw3Q7etd8k53ff9fkOJkgWkjk1YHZ6iWUQrKAPlDJpwg4Oncn6nuWOAGxuW9XaA3MfYCAw==
X-Received: by 2002:a05:6830:909:b0:7ca:c7bb:e0a5 with SMTP id 46e09a7af769-7cacec38e40mr1439281a34.35.1765380278073;
        Wed, 10 Dec 2025 07:24:38 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95acd8a60sm14626669a34.27.2025.12.10.07.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 07:24:37 -0800 (PST)
Date: Wed, 10 Dec 2025 09:24:36 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] builtin/repo: add object disk size info to structure
 table
Message-ID: <j4pc7xn4jjoyt3ay7clriz4kb2dz7toqluapt3xknm3gzlvitm@ge3ubr4eruw6>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251209225820.2861276-7-jltobler@gmail.com>
 <aTkTGilv-xRRQVHA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTkTGilv-xRRQVHA@pks.im>

On 25/12/10 07:28AM, Patrick Steinhardt wrote:
> On Tue, Dec 09, 2025 at 04:58:20PM -0600, Justin Tobler wrote:
> > diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> > index a98c651f1d..51820cc3f6 100755
> > --- a/t/t1901-repo-structure.sh
> > +++ b/t/t1901-repo-structure.sh
> > @@ -107,7 +121,10 @@ test_expect_success SHA1 'repository with references and objects' '
> >  		|     * Tags           |    132 B   |
> >  		EOF
> >  
> > -		git repo structure >out 2>err &&
> > +		git repo structure >out.raw 2>err &&
> > +
> > +		# Skip object disk sizes due to platform variance.
> > +		strip_object_disk_usage out.raw >out &&
> 
> As mentioned, we can use git-rev-list(1) to compute the expected disk
> sizes.

Thanks, I'll give this a go. :)

-Justin
