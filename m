Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB82D2B9CF
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256086; cv=none; b=f++UrBFMVGqHK4yqNpbC/QDk9uGrjh98Ra8HUsJRY/Kt7JJiAe1scvxCOGyhBebPqQ/TstikGo5+I3OCKoPj3HMQf8rC/RZ+nGKmO/mI2++pmJ+0JJnzqH0ezsAjc745zrbgcQzAzi1TMwAObaww0+2kMSSWY3g7v0HNvIS+qCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256086; c=relaxed/simple;
	bh=Y72MH3A7xTkROrQbJ/hyV7Lwp11Jrxxxl0iP4NYesWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0RaTwlP8trEfn4ZanbYduiT6l4Ux29L+ZaGoGCB8Zxh6aSskNPEGn76y2UPSNotCPwUMVqh3R7omRqA6acNf5DFWISN9wHOqD6Nkfvp7NrK9KFC1tATPCj4dKxedDrsUG0+34U2RNEXtpprMmCFKl5e4ErAqlGeTCWGiXSaIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPmseLEU; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPmseLEU"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21e45ece781so1065769fac.0
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 17:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709256084; x=1709860884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHowtYe6yZA7kXHY3VoPtmQMW0yzv0oTzHp9iG9rjOI=;
        b=TPmseLEUg53JtIh2+1pRYBP7Gbdg7AnvlFsT+ixTLNoEt/ac/kkOGpB1ev611QBec+
         13Y29SugLrE6iqv9uUEIm2WvCEkhGnTo2lSG7oadrDmYo6FmBxr7FhszR8blfOXTLPbw
         DuuTcEAKLcwJ3djv8JIP1WzGBlwtztE5pdlX4POUHkAwX2Dhrz2N2dLpahMvLdQACkuA
         SXCs8Q5fSzXFcD2SCFEOjPQGfp0BLlJsdCei8eG9zHlhmt/zquxgwFIiHOE+n+jIcfZ7
         znR/QWN8Zqir4XE92gI7uX9ffHNIa7wQ364JlHbECxg5IPsyDZDOm53CQCUIbD5hgBIj
         9HtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709256084; x=1709860884;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nHowtYe6yZA7kXHY3VoPtmQMW0yzv0oTzHp9iG9rjOI=;
        b=nh7TB5pWJZGum8Ps1jExzSJfeHgZbgQX/apAWHWeloRE6uXD6flx9Klrntfa4NlreI
         vPaNNBrCIDAWQ/sDT6QTy7vQ4bu/5Cq7vVFW14qGCiJ82G/K4aN+772MFsuYrn7gvf0q
         KEseM9m8Uv0CRujEjv1Ffw6WdwKmgm6CHsF6bHjR1rN0ldZE9UJT1XV/YuzgCn9TS+4L
         IPaj/oe+wwewIrbx0feGGz4/olJ3Vbi+sykalJU5RghnfT0GokFN3NYONPpYHRnu7Is6
         AZbx+5+fEvI+s5hKPj9gLSeAFdVW/qD0VN0mS84G67TjOyUkhtvaCjpb5SjBPxIreS3N
         rqrw==
X-Gm-Message-State: AOJu0YxaBQVLBN3NNM7RqJQXdx/5Sj4NkhwFl+D/S9t0y18GFsrO++M6
	sGhR3rfbXC+OJ6znR3q8B7PS2Nbe5X15ciLQl3arRiR/BNfWSKHCklSXc5r/hqw=
X-Google-Smtp-Source: AGHT+IFi/jOg2GuEPU2GL+WXuZpCj7xFpTnighyINnIVMwGtcpnmh8zEDZjxvCSfjzrMwSppRq6WXg==
X-Received: by 2002:a05:6870:37cd:b0:220:9862:a2dc with SMTP id p13-20020a05687037cd00b002209862a2dcmr202990oai.57.1709256083812;
        Thu, 29 Feb 2024 17:21:23 -0800 (PST)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id pd8-20020a0568701f0800b002208de5348asm741176oab.49.2024.02.29.17.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 17:21:23 -0800 (PST)
Date: Thu, 29 Feb 2024 19:20:42 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 1/2] refs/reftable: don't fail empty transactions in repo
 without HEAD
Message-ID: <xcbwno3x7tzcg77rtfkaqtqcgll32vhx5mlhcvlclew6lkkofu@h5jzvft55uvv>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>
References: <cover.1709041721.git.ps@pks.im>
 <95be968e10bd02c64448786e690bbefe5c082577.1709041721.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95be968e10bd02c64448786e690bbefe5c082577.1709041721.git.ps@pks.im>

On 24/02/27 03:27PM, Patrick Steinhardt wrote:
> Under normal circumstances, it shouldn't ever happen that a repository
> has no HEAD reference. In fact, git-update-ref(1) would fail any request
> to delete the HEAD reference, and a newly initialized repository always
> pre-creates it, too.
> 
> But in the next commit, we are going to change git-clone(1) to partially
> initialize the refdb just up to the point where remote helpers can find
> the repository. With that change, we are going to run into a situation
> where repositories have no refs at all.
> 
> Now there is a very particular edge case in this situation: when
> preparing an empty ref transacton, we end up returning whatever value
> `read_ref_without_reload()` returned to the caller. Under normal
> conditions this would be fine: "HEAD" should usually exist, and thus the
> function would return `0`. But if "HEAD" doesn't exist, the function
> returns a positive value which we end up returning to the caller.

In what context are reference transactions being created before the
refdb is fully initialized? Is this in regards to repositories
initialized with the reftables backend and used during execution of a
remote-helper? I was originally under the impression that a partially
initalized refdb would appear as the reffile backend before being fully
initialized.
> 
> Fix this bug by resetting the return code to `0` and add a test.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

-Justin
