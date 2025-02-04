Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA10821480F
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738677550; cv=none; b=nOpH4SDPBaRX/+CTKhoUYgb4mMSHXNKkwIU5NErwZsFLkDZeQaY9Udo2wQ+xUHCAbNsRsE1pTonySPCBFOGX7pXvjWYZTk8xpltuuOqCW4bZ0Zh62aQfT37sl99AcoEa/4YpmOf0wBQX6dgyOWzlxbTT3lrn9GJHy0eMAmduq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738677550; c=relaxed/simple;
	bh=PavSxqFInzPJeM3IjTs6VN4lVgs5/WSs9W7QhU5zMzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQk2O8M7DoFvu7p4wK7OetPy17zUPFkeGNEQpwhf3LAzjiAfpWZnFrDj1r5qrwy9AqZwGpNAPZbBPmAxqEiAEwSenNRndPWnrXgwDhqsZLZxvyKe52ARhFMYnlDr9uxh5lUewMtmxwI02yTK4uPaeF0mHpAqFoPL/KCUuGXtY9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFDm6svO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFDm6svO"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30613802a04so54719681fa.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 05:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738677547; x=1739282347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaY0Rw72iN0hGcFvycthtePdEmQt49T8WGMSUyfDuQ0=;
        b=OFDm6svOVPxLsIi8koD0oFuDF0cAO4tWxkHysio6mhYInDby27o0p/qzTvOf0mVFyG
         xl2Rb62eAb5mv9yjHAXrw3rszird+d7o2sCGULEnrEbRT/i4bzKNR55epskYz8/pCzSV
         zr8VRWh3ADaNCfcqz18gd+VGVvu6IuLo6Vy30JqD5vxX1xyWSPkmWQr9IKQA3JzooAqP
         FLYa3ss098V3q88CZ9AtFv7/QGPTWbZUyHCUjeN9N9O5PMNyJZKdFjbTP3HlXJPaE9xv
         iYcxTRqfOHWO45q9zgpAycxRuEHZrPcOb8IZWv+LbD9jZW0N4J5yPd71vpqV6b6kH1+K
         9hiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738677547; x=1739282347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaY0Rw72iN0hGcFvycthtePdEmQt49T8WGMSUyfDuQ0=;
        b=QdzQdkfVaPvPK4VUrMsndYSgyEo5hcaxi/fCn3AK8NkwYyPNJsiM1xEFP1J8FrJrO/
         5QZcLZpLcwazUdb/yor+8cJK520K46IJhpZ/xVl3n5TCBHfA7GIRLaMecLx7CN8+xXW1
         ZPLjXDHoN7/vldpaHnLDvdMFeovZWwwX/CeN35SWS/hNFKmRciwRuunxuyFSgofoZOvT
         nqEujr6WP54+jRLxzMxqDLSYa+UvdioFD45X8/kPV/18B7vLFAIrJaPN57PzPHxF6SCJ
         g6Qo9OTtwVjdJbYOVY38zPARdeMfeHqH9CsDm7fbssD7TZSRUnUbK2i2XLaqgdyYk01g
         JruA==
X-Gm-Message-State: AOJu0Yykr6CLWe6I61TShlk6mbUcA0HSD8xI/PdoIiKXoD9rJJVJlbl6
	d+3Kc3bgSzNRdXW9Vt9tbigqYzE3uOQa5EBBTCeQjRZ1GYCBZpSK7KxZ/XPN80+1gUg19yECZxg
	wgpoUQKJ38cu8BVcKRgc6GwZJZRw=
X-Gm-Gg: ASbGncuhBdhIoBo1WRh6RvmFNUxSRl2zb08gcd3BkFxzeVX0RYj9LPUABv4K4L6Nt20
	nphgkVt2hjPFXbPIObEP0WhmHRQXtPmvJR7LGBvIVd+Er1WBEssNvj47HAOBEWzq648MpYppRtp
	E=
X-Google-Smtp-Source: AGHT+IHQZ5EEbVygKseKXUk6oDovSFVARAiqzDv0byM9gtarg8fGy3mjR0D8Lf3fLENQPy06N5vUzXHk3/gKI5OKpuY=
X-Received: by 2002:a05:651c:198b:b0:302:3356:3a98 with SMTP id
 38308e7fff4ca-3079690e18emr91481531fa.37.1738677546393; Tue, 04 Feb 2025
 05:59:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201064202.76116-1-meetsoni3017@gmail.com>
 <20250204040558.34766-1-meetsoni3017@gmail.com> <20250204040558.34766-2-meetsoni3017@gmail.com>
 <CAOLa=ZShqCkyabVK2PU-XXpx9QS3_W=9QMH6ioJB=t8Ec2NYqg@mail.gmail.com>
In-Reply-To: <CAOLa=ZShqCkyabVK2PU-XXpx9QS3_W=9QMH6ioJB=t8Ec2NYqg@mail.gmail.com>
From: Meet Soni <meetsoni3017@gmail.com>
Date: Tue, 4 Feb 2025 19:28:55 +0530
X-Gm-Features: AWEUYZmRRJ2UzG4EtANKhUTcvOh_66N6__ILJxSfTDB-6tLYXEb9S-0SqDWpXkE
Message-ID: <CAPhwyn32CmjtKu5ivxS9=AJ-h+5GskDUp=rUGvofv-aWLhH8Ng@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4 1/5] remote: rename function omit_name_by_refspec
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, shubham.kanodia10@gmail.com, 
	Jacob Keller <jacob.e.keller@intel.com>, Junio C Hamano <gitster@pobox.com>, 
	Pavel Rappo <pavel.rappo@gmail.com>, Jacob Keller <jacob.keller@gmail.com>, 
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, Matthew Rogers <mattr94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Feb 2025 at 14:30, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Meet Soni <meetsoni3017@gmail.com> writes:
>
> > diff --git a/remote.h b/remote.h
> > index bda10dd5c8..66ee53411d 100644
> > --- a/remote.h
> > +++ b/remote.h
> > @@ -261,11 +261,7 @@ int resolve_remote_symref(struct ref *ref, struct =
ref *list);
> >   */
> >  struct ref *ref_remove_duplicates(struct ref *ref_map);
> >
> > -/*
> > - * Check whether a name matches any negative refspec in rs. Returns 1 =
if the
> > - * name matches at least one negative refspec, and 0 otherwise.
> > - */
> > -int omit_name_by_refspec(const char *name, struct refspec *rs);
> > +int refname_matches_negative_refspec_item(const char *refname, struct =
refspec *rs);
> >
>
> Nit: The first sentence is now duplicated by the function name as
> mentioned in the commit message. But aren't we loosing information by
> removing the second sentence?
>
Correct. I considered keeping the second sentence for clarity, but that oth=
er
function signatures in the codebase don=E2=80=99t include comments solely d=
escribing
return values. To maintain consistency with the existing style, I
opted to remove
it. Let me know if you think an alternative approach would be better!
> >  /*
> >   * Remove all entries in the input list which match any negative refsp=
ec in
> > --
> > 2.34.1
