Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACB22E7378
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532211; cv=none; b=ALMZMUZABp7pNORdZ/BC2des5zkvUi9AMOq2tmP8O4OyaDPvWMjaMbm40B3BYXnbx5eTkQUu7FiXDXuI4nKGBe19TP28FH1krWUxV+fR3AXG1h05jL6c/6PjnECctp5tb393ZBddHFzOd4DcqlsUR5HsBqzFw0PpDWhcRFJ19gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532211; c=relaxed/simple;
	bh=3noPLEoBcL7E0jW5FzuEeLWZOCDafZipnKU1UYX0I9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcGij6PF7OGEGMZSqAX8b2g41JEXkLMD3Wb7gZ9XXb5d1mr3ez/68sS+htoD5juXCh73WqQxVc6FNNCrArmOi5URaKeTCyLANVLX+J6DK6UsgFuyjnoueLVrVloMGIiIiw4glNbkdCFfcrJuW01Dpx8lhVN/wsKbrjat+CzjgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdZd/3Yj; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdZd/3Yj"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb61bbeb25so603972a34.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783532209; x=1784137009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=by5zRUYPzJRqzdQ8eVxQcvN73VnE6J1rfyRpN/1z6qs=;
        b=CdZd/3YjPpn6n8u6AQB8my5lSJuZRSuICcegpzNBxgZ9OA566BabHp8JDj29y2DCt9
         6YLpaqW9gJTOTiWxQCSK7phMGnnPf/TapqicuZ2Ak+cn/3W0Zd92kKBr2zYjelzCcjXW
         bdVYszU+r5bajmvgRibvoFy+cEckAztZlfCo0AeG6dHRK3WZ3iIrPESbX90GHFbchJaZ
         2HMSnbgM2cNaDKLegH1nVcNKZ79lE7/v3Pka9czGvOAEWNedaf4Zu0qSeywWUYYqEp9b
         6Gabd9aHUbEOcRWeAessDWGYjCFFQxFdxxWWhuKEpmB6AVU3JjMxRimLYmbqUcRxd8j2
         jpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783532209; x=1784137009;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=by5zRUYPzJRqzdQ8eVxQcvN73VnE6J1rfyRpN/1z6qs=;
        b=AEYhJVrF7wrMrWxMnItLMUXL3i0HE99F3aLOEt6xArEA6m8hXo6WSIn16DNW5Rd5ax
         SZKpcEpSUTWBdsk5RaG6rYBbCOtlPeuw0vYaU6AgmAWATd2W+ByfnKLke4emv+6g52Ow
         R79w+muAx1iPEbw60g72fY223Qtgmgx20UtIWRjqU7HSWxybV/KCCanGQXd10+DuXBbC
         51279XB892NsNPIQ3Dp2kBXfgStIkGjXGSoS9H2RT5tG+pLEwL1oDUYcWdEqhs7oXn4D
         5xzx8Ew+7KroIB5KFeg0RmaN6YGsj2DXiSx3a7IBEL4hDkOMYD9gTeQpYm2kod+AmuYq
         1jrQ==
X-Gm-Message-State: AOJu0Yy0gNmlIKXgDBGs73rT8yJGVuT6DNvgKlRumVTwvc5/F8iHxiRH
	lF5nFNeJ/a54W1WGgceBNJw0uB8z2EOI8PILts9Zln6876oQtDscqYK3
X-Gm-Gg: AfdE7clrBXeOpq0FaVHrpemFISc3yQ78sswKlNvyzKWi+c0vS98C5zrgSWWi/IFnZm5
	pKuFiOa4RozVhLCSLOavP0CV8QVnDXdfy8+79tjQ+qSbDBoGT/Ma+OSmZV+wDctWjH17qiL97w1
	wxbcLfkN63djsDSP4TMICtydEsQFqf1EGqDejVuv5/gNcYGQcXFqCZ6bHcRO6bhDlymgmfM+u8b
	NMGSqwkyN7BKqP0Orb7VFnyLLDNZtDmCvNI0//ICTlJhcXG4GiuEXXDy0R95o4JLDvyy+wMVMMP
	2OPDnL+TJm0ei+qPeqoEE/hpfLgjD+AAiXcpB+kUWoND5jDg577hMla9pMpCsZxlz3EGgKhvFoO
	QT/c0cyZdPPH3neAz6JAyDbg2azIXcDGLvPnAtPLk7lQjIXnD4DPCiMhY4afJY/qouWEPjJfFxe
	CZ8vML7g==
X-Received: by 2002:a05:6830:3886:b0:7e9:e860:6f2 with SMTP id 46e09a7af769-7ebd00435b2mr2361719a34.31.1783532209330;
        Wed, 08 Jul 2026 10:36:49 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb3f6826sm2270900a34.27.2026.07.08.10.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:36:48 -0700 (PDT)
Date: Wed, 8 Jul 2026 12:36:48 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 00/11] receive-pack: use ODB transactions to stage
 object writes
Message-ID: <ak6KkcSiMR_XpxfZ@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <ak3xYym22Z7PFZ5y@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak3xYym22Z7PFZ5y@pks.im>

On 26/07/08 08:42AM, Patrick Steinhardt wrote:
> On Tue, Jul 07, 2026 at 11:14:01PM -0500, Justin Tobler wrote:
> > Changes since V1:
> > 
> >   - Adapted other "file" ODB transaction helpers to be more consistent
> >     with current naming scheme.
> >   - Removed redundant NULL transaction handling from
> >     `odb_transaction_files_begin()`.
> >   - `odb_transaction_begin()` now returns an error if there is already
> >     an inflight transaction pending instead of setting the `out` pointer
> >     to NULL.
> >   - Updated `odb_transaction_env()` to return an error code and append
> >     environment variables to a strvec provided as an argument.
> >   - Removed redundant setting of tmpdir environment variables for child
> >     processes after tmpdir has been migrated.
> >   - Split changes adding ODB transaction flags into a separate commit.
> >   - Consistently wire the ODB transaction throughout git-receive-pack
> >     code instead of reading it from `the_repository`.
> >   - Updated user facing error message.
> >   - Updated some comments to better document functions/flags.
> >   - Clarified some commit messages.
> >   - Fixed typos.
> 
> I've got a couple smaller nits, but overall I'm quite happy with the
> shape of this series now. Thanks!

Thanks for the review! I'll send another version later today. :)

-Justin
