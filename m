Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622D7302747
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583299; cv=none; b=f29aQQQ1RIML9uhHyTJJ71NlRe0JBdfrbCfhy92+9tptYU+5pujs/T4VOSk5XDa9CwrwmzUcj7WCPI2V9qlyweIKwqCn8xjdQlfHnDLVC+G+bLkHxGOTGiZfbTToVhp3fdm/zNjlFfQfutamS1HHVpx3nMEzaFAP//6nyxmk+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583299; c=relaxed/simple;
	bh=OLsp5+rPVIDS7EuwmpvfJZsAdoWVPMyats4UYVzLFOU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIRQojaG+x9/ngNMVh+OF9h6Q9JMW/TojmvcI1S8+bBLxTMORBMmLQ1UOBLNz6dRj95gKssOwrJsC/j6+TXMtOBiDSuUcHSABXZmG8XT6hXcV+FCnLHelvffr9pR6sX3ZUfVsfiJlmcxi97FTUlglxhQp+Sx/S5IJYv8yCFuxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrrlOYZ2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrrlOYZ2"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47118259fd8so36722175e9.3
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 02:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764583296; x=1765188096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E7syEy6V1mvFqof80rUDNBAh38CzIYAWRJbZ6RSnn+8=;
        b=XrrlOYZ23DfVytAGzEG/XB7a3uS+dCq/P5LOUYsVJiTu3oIFQ5kX0C0uCEq7151/j9
         Bb5mOWg8n9/bZz49eLQbS+XfyDmOJ7e7rcHfbsN5VsfnO00UAg22UrlS/k/rYTnJkE7l
         ac0fsSV+4FetsdjpWG3jaIkEKu3YPNaktqlQr9EM7VOOTbyNc5S38B5c53nJd2m7x3Kh
         2c6XGx2QFZusiYegLPIJdX6mbUP/mLnsfM0Udy5iF9wVlAFM8W4482lRKarZ2bi4K7Yl
         hulY05l8Xu6yh1kVCrmhKB/DJTnBeYA9RQyNWLfvUpBptlNIaSHmowg8JdEiqlK18j7x
         it4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583296; x=1765188096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7syEy6V1mvFqof80rUDNBAh38CzIYAWRJbZ6RSnn+8=;
        b=Zi2EH59tQ16v9uJE993CYbpdNYGRP+wlADm8y9WEInKTfh+DrcXLK1Ycfkf2WgDjKl
         MEoM6tDzKf5KAOSVy05nkRbsDEYshSScV9OmfwPurzz0QZ83JhqSmxkpzhuPgvfVbxm0
         Ehk6oidVyrre7uHY5GniJsSH1GvzC6jQZKnWMIH19uTyBB6FyRBZwmH6bYJOhRvc4YDF
         vtzbyvUhXffL0L7knGYi6PkiGV1lkZSGaY7y9EuzWQTtpRo7k7/4014KAgtd5BTRQk2J
         FXm08Skc+AjczNKnzm3qrWGUuijuKg4SXVlXhxDEnTwv3JPn5wEEhTDS+NzIMRx0L5h9
         JOAg==
X-Gm-Message-State: AOJu0YxEYaVKptBOfKiqRr9PD8CP+WHDyJQfBOBbtUYa02KXPvDC5nr3
	jw5n5Iqp5jYAx3E3LZt4L8wRCpA0PBtPcMn3ZC/+Ei/N4UcZLIAbogoeai6+oDXW
X-Gm-Gg: ASbGncv9IbaUIRgrFt/9GsHFw2tYHq7OQitbKMvMVAgvMXN/DxvBZ0N6zCUU4hpEDSu
	axGLvqX21Iibo/rzhFCiFcVzIWFH3KHqEgQjRr+WB3ce4tXaijIbCxcaj/6xr3IEcdBQ8+Lkn9f
	yjWpnZ0mpG6cDVyRfGEcqnD1fWhdJhy6fAODYwXE0PkZAYfxQdJXmEqRRIbEf2+kjW6bu9mN4pW
	Rr7sGZrNa0hSfmuerhQXHRWiqSLt7dbCJCyDrx1tkrFgr5iN7nvLH7bTY/VNtrmh44UihOrC677
	JAAVdQjBc/Wo+ZGi6VnHqCnpuItAsnPLrsIrWGgfTkVEwaGUayieOgEqnVGTn/hxoyYlig89wpi
	JWgJDy1ud0tJgVL1D2uKn+5+k18JG7nBwWZVNGow6xa4bwnZJ84GVnZiwERfuMHNhcI8ZfL9Xph
	mPQIHr17Ul5yNFYZJeffTzhjDrUMAOm4J7520uL8pAt65rA9wSUXrq2Uk=
X-Google-Smtp-Source: AGHT+IGI1iT/TjwE/AjpvLNHRneUNAljopiy01gnTrBPQbOuvmlMBgtQ3wPC5HW/24eqbkP3L1Wrag==
X-Received: by 2002:a05:6000:2307:b0:42b:3bc4:16dc with SMTP id ffacd0b85a97d-42e0f213b9emr25978166f8f.21.1764583295443;
        Mon, 01 Dec 2025 02:01:35 -0800 (PST)
Received: from localhost ([105.117.9.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c3c8csm29303295f8f.2.2025.12.01.02.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:01:34 -0800 (PST)
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
X-Google-Original-From: Abraham Samuel Adekunle <AbrahamSamuelAdekunle@adekunles-macbook-air.local>
Date: Mon, 1 Dec 2025 11:01:43 +0100
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] add -p: show hunk selection state when selecting hunks
Message-ID: <aS1nhwhZ6tZ3w9RT@Adekunles-MacBook-Air.local>
References: <aSxQhqwzT34hIjV8@Adekunles-MacBook-Air.local>
 <xmqqqztfbcbr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqztfbcbr.fsf@gitster.g>

On Sun, Nov 30, 2025 at 10:32:56AM -0800, Junio C Hamano wrote:
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
> 
> > diff --git a/add-patch.c b/add-patch.c
> > index 173a53241e..e70e390506 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -45,7 +45,7 @@ static struct patch_mode patch_mode_add = {
> >  		N_("Stage mode change [y,n,q,a,d%s,?]? "),
> >  		N_("Stage deletion [y,n,q,a,d%s,?]? "),
> >  		N_("Stage addition [y,n,q,a,d%s,?]? "),
> > -		N_("Stage this hunk [y,n,q,a,d%s,?]? ")
> > +		N_("Stage this hunk [y,n,q,a,d%s,?] %s? ")
> >  	},
> 
> Three comments:
> 
>  * These sets of prompts exist for each front-end that uses the
>    interactive patch machinery, and we are looking at the set used
>    by "git add -p".  But the "I came back here with K, or I do not
>    remember which between k and K I came back here with, and I
>    cannot easily tell if the hunk I am looking at is already
>    selected" issue is shared with other users like "git reset -p".

Hello Junio,
Thank you for your review.

Okay, are you suggesting I apply the tweak in all prompt_mode arrays
used by other front-ends. I can see all the others modes (patch_mode_*)
shown in the file.

> 
>  * "chmod +x Makefile && echo >>Makefile && git add -p" would ask if
>    you want to stage the mode change of the path and content change
>    for the path separately.  You may skip, and later come back with
>    K to this question.  The same "hmph, have I selected to use
>    this?" issue exists, no?

Yes true, the issue does exist.
I will fix the change for the others
> 
>  * The existing "[choices]? " was designed to be at the very end of
>    the question, so that the answer given by the user will come
>    immediately after the offered choices.  Adding an overly long
>    "selected" or "deselected" to make it "[choices] selected?" does
>    not give us a pleasant end-user experience.

Okay.

> 
> Also, after you decided on one hunk when you have two hunks, typing
> 'j' or 'k' would tell you "No other undecided hunk".  The phrase
> used here, "undecided", refers to the choice between USE or SKIP.
> To convey the intent clearly, "Select"/"Deselect" feels a rather
> indirect way (i.e. "selected for use" vs "selected to skip") to say
> what is happening.
> 
> Ideally, if we can convey
> 
>     Stage this mode change (you previously decided to use it) [y,n,q,a,d%s,?]?
>     Stage this mode change (you previously decided to skip it) [y,n,q,a,d%s,?]?
>     Stage this deletion (you previously decided to use it) [y,n,q,a,d%sm,?]?
>     ...
> 
> without wasting too many extra display width, that would be great,

Okay this makes sense. But since the display width is something to watch out for,
would something like below siffice?

	Stage this mode change (previous decision: stage) [y,n,q,a,d%s,?]?
	Stage this mode change (previous decision: skip) [y,n,q,a,d%s,?]?
	Stage this deletion (previous decision: stage) [y,n,q,a,d%s,?]?

> but this patch is not quite there, I am afraid to say.

Thank you Junio, I will work towards getting it there.
[...]

Abraham
