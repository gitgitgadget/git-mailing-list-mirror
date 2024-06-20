Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A621A4F04
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875683; cv=none; b=omD8aQcUSvjUoi4yMhONi8pFuu7OEXb7JMW0K/9DtQG+/GXspX5lbNGqqAh0C2BD1Qu9bTxcPc67T47K9AWE41m6aZvP0dk5kiSWR6n320Rhnd63SzfoVkVn0xUQbx1s88IY9MFlqgqcvIVpwKezR/tilJBe+NhtiuvdPGhCLgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875683; c=relaxed/simple;
	bh=FGIfkjZKUK14aE2abCX0xlMrtTQOsHdVp1ny6gHWFxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvPyf6MRgKrFA1L95j5/7inTkiNX6Wd/Tp3UhF0kIvt4OGCkUEnyU5i6h6Bq/WC/Nw26oSzPuzSv6gL+jZ1Dp0u2FWZ4k64C1DyYbVe9c4apNCtHUbrS2MB+QhdVMVyI8r6l8BsDbHq/1Ne9+ZlXYfchOqRJqdBDRSO0vAzXuIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqKA5koH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqKA5koH"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70627716174so610954b3a.3
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718875682; x=1719480482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y0TGzlCEb853cGwayOuMMsoAZfD1FaTki4wUEufwaKk=;
        b=SqKA5koH+qCt1J6fuVMzmhE4e6nkPzJ7/VvXrUGiCULhvTU+YzerDjP6Rz7Byr6b+U
         RnoVspuEMgxRFrMc/hfmbTEBZoBT2Gv1+T/lLh3TzW9yzW6w0Ctei6t4F9nhcJb2lt5S
         tbH8dHfAJrMSYgkrsZGHScrsuOpjlyWIPffw1Q2e8WyCMhHpXc95di+jpR31S937heOy
         mUMtVKbObkbBabOfwllKHoffATkh2sVXRgZKYk2LGLBqucWFtbhskcMt+mZNtXgmFdOQ
         AKbBHsGi9TAUxogdIbHvjcXklh2l7DxMfYlF9oXAofIEzB3DJyosRo1Gq23FKKp7dgpN
         iQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718875682; x=1719480482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0TGzlCEb853cGwayOuMMsoAZfD1FaTki4wUEufwaKk=;
        b=UKaYY18sP/BH5jRvp6uH8e/neIVmzg00X50Hqs8Hwm+xX4S+3BUK5bTTa45Y6dn3Te
         kvvI7mWodm2H3WUNDWSRUkxNdCkz1fEMPuxV37zzWXw649qSAbBOzVHxt8EtnfzkYldz
         iTbw3bXqZ6UrEUJkumyvcOBC8kwgLB9IINtg9uvyx7U+G+ZETqTOzRdIVm6JpE+97tM/
         G8VYxuDKsltk10BXrasKCCTNZdJvG+SAGfekhs+CL6ZCQr2cA85IiOCItnyiJZCiG5yc
         JbApx9P6X5WuYHM4yN7O+HYiKWoEyVWMUdWD7B9Llwi04elX0/cJLQKssFlZwXbB+7eN
         wFRw==
X-Gm-Message-State: AOJu0Yx70l6aCKTMrUmPPyVYtY0hc9bE38N8ZNl06j0uUaddyIHcfGoQ
	09fek+/fuUtF3HfFrI14vxL5dHBx/cFzKacRqf/XcQNOuyj/cNcFmKcKZ9UG
X-Google-Smtp-Source: AGHT+IH3Nd+tsIubv+c9BvJZUxvnzWzPiqx+sT39VRnGtlcAtqdTm0EvxZgfh8C2LHJIuu9g/sQMtA==
X-Received: by 2002:a05:6a00:9a5:b0:706:2a99:7ad with SMTP id d2e1a72fcca58-7062a99085dmr5291301b3a.0.1718875681366;
        Thu, 20 Jun 2024 02:28:01 -0700 (PDT)
Received: from google.com (182.51.125.34.bc.googleusercontent.com. [34.125.51.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706384f40aesm2341590b3a.93.2024.06.20.02.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:28:00 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:27:58 +0200
From: Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t5500: fix mistaken $SERVER reference in helper function
Message-ID: <ZnM3I11IRporu4sj@google.com>
References: <20240619125255.GA346466@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619125255.GA346466@coredump.intra.peff.net>

Hi,

Jeff King wrote:

> This happens to work out because the "server" directory from the first
> test is still hanging around, and the contents of the two are identical.
> But it was clearly not the intended behavior, and is fragile to cleaning
> up the leftovers from the first test.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5500-fetch-pack.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Restating to make sure I understand correctly.

fetch_filter_blob_limit_zero is a helper for parameterized tests
taking two parameters.  The first is the path to a repository we will
clone from, and the second is a clone URL to clone from that
repository.  (That way, we can reuse the same logic for multiple URL
schemes.)

Those tests each do the following:

- set up $SERVER containing a test commit and allowing partial clone
- clone from $URL to client
- make a new commit in $SERVER, that client doesn't have
- fetch to catch up, with --filter=blob:none
- assert that the new commit was fetched and new blob wasn't

And in that assertion, we want to get the name of the new commit and
new blob from $SERVER, not client, since we wouldn't want a side
effect of causing them to be fetched in the process.

Alas, in a copy-and-paste gone wrong, 07ef3c6604 gets the name of the
blob (but not the commit) from "server" instead of $SERVER.  And this
happens to work because the first time we call this helper, $SERVER is
"server".  The only reason this happens to work at all is that we're
looking at a blob id; if we looked at the commit id, then the
timestamps wouldn't have matched.

Thanks, the fix is obviously correct.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Particularly telling that the author of 07ef3c6604 introduced this
typo while trying to make the tests _more_ robust.

Once the library code is ready for it, this might be a good candidate
for moving most of the test cases into unit tests and just having one
or two less repetitive integration tests.

Thanks for catching and fixing it!

Jonathan
