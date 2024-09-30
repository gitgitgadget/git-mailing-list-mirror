Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9FC29429
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734753; cv=none; b=QXVwKwjL22jZ3CynBuRjCSOlaHQLwiRf8zbDELgv/VZd4sYSpHNrt/pz0D9Fg50pUhT1IkSHlReJVtXJVhEvY89cIUbWAx8YSmtBFL4Vbd2McP2is1Q5Nyf4DLxy3kzh1YGY8/3XjOxfTKvUEc4wqXC6W0c/RH1LgHW1xVb0G1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734753; c=relaxed/simple;
	bh=881GUx5bXYyVUewsH3hQrNJks4QQjLXH44vTfze1Guc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAO/cb+KdAsLEQzSL2AlaHLU2dqgStprpOI3URzhzExYB88XhQXijWsqVsZ3zRdp4M1/BTAnLyOqCxQsLm+ezpvsYqpNR0QmI/Cpd4N1+aeW6vn7GP389HBlRttYhV1WnPILh6Mfc1sd4AQcRzA23iDas9q0rIpJqDvnHN6Tvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvyyvcjZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvyyvcjZ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b3d1a77bbso69395ad.0
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727734751; x=1728339551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ti4u1V9PaA43f82j0bSTELoOw6xNXqV83ARopcwNaCU=;
        b=VvyyvcjZgo6IfFXULMxtMjlz3aTGB8gXVEna1An2cbUpDOtmk2rvLiOc049hY8GdgB
         dORjtUHQRU0jmUsPisopsirq5uBw01pSyyMVgQp49eyDi4pN7UsYNnuzqtYL621JZQD4
         SneIkNMeVabwMjJIzrc9JoI2K7fSMrjCAN/nKb+ZXj2mLltJeGGyAzKoBbX+4k9pn4vL
         81/bBLn52eZYpocFtS0WKchWsPjttxLTpvyEtbCl6094ACsLNIK6d3SIO7oz4t6b0YdE
         jRNuQg/i9lHUvMK9syy/Ac/WGruxfAT+kNx5BJjEdlHD8nwZX0nvXseLLWfpp4Iy03xZ
         1x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727734751; x=1728339551;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ti4u1V9PaA43f82j0bSTELoOw6xNXqV83ARopcwNaCU=;
        b=UHPdbo3g8DmxWoYbJjYZ1S9LGWuPCs5UyVF7Q/0BerSDL+50WfVGbsgNhLntboZ+b1
         Av9J3izU8PEylYBrpSnbrEHCTTllM62e5jwWEu7oVUWD6YlDrn873BpQ9954+d8geXfa
         XKCJBG5opajwqBmzg7d2H/jSSRfiNvbHW2+ii/6JLEDaUJYnae2+nB9huEdBhTyo/pGQ
         ZhunSQnVhS3YKZXswVe3ClrulNP1pl+yQm6hECL83HXWsR37VuHrORmpqpeM1VLe/hzE
         3c4fGLnwY1LjmXvJVqrg9zgehZyTGauyExj6dOLaAw/DewA5+gHXikRKw+TTCn/P85+k
         mYYA==
X-Forwarded-Encrypted: i=1; AJvYcCWd1R13w1s5odtKkPBdJOVKlnGJf7ziyjlWA1ay4UPtec+IsoPLZLXqQobQA9Tejf/Hs/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy15ABJG1yO3qpCv1p1N3XmPlxN/K7uySd+lwENEFdq0lLaoQFy
	9UUCq8XKNw0TX6KEjOnBWvVSk3h8bT6yZcq4savNanekHHhzNY1rAlCNL8aB7g==
X-Google-Smtp-Source: AGHT+IHEtS8HjV1RiQ9mWi6QrjYMGblCy9czsS2R5jPZ+ZZxr/R74EFBxIh1k8ICBfYfaE2YnoeFNw==
X-Received: by 2002:a17:902:f7d2:b0:207:3ddf:34bb with SMTP id d9443c01a7336-20bb07eb04fmr394175ad.9.1727734750511;
        Mon, 30 Sep 2024 15:19:10 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:832e:d9a7:2067:3bf3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e33147sm58713425ad.195.2024.09.30.15.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:19:09 -0700 (PDT)
Date: Mon, 30 Sep 2024 15:19:04 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	karthik nayak <karthik.188@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] refs/reftable: reload locked stack when preparing
 transaction
Message-ID: <c4lz3begoplgde5iimvk4k7cufiyryntccqo46u3fy5qvqauv3@tta5wfg2ik5t>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	karthik nayak <karthik.188@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1727155858.git.ps@pks.im>
 <9ce2d18dff2a655365b609dd86ea484a489c717a.1727155858.git.ps@pks.im>
 <20240927040752.GA567671@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927040752.GA567671@coredump.intra.peff.net>

On 2024.09.27 00:07, Jeff King wrote:
> On Tue, Sep 24, 2024 at 07:33:08AM +0200, Patrick Steinhardt wrote:
> 
> > +test_expect_success 'ref transaction: many concurrent writers' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		# Set a high timeout such that a busy CI machine will not abort
> > +		# early. 10 seconds should hopefully be ample of time to make
> > +		# this non-flaky.
> > +		git config set reftable.lockTimeout 10000 &&
> 
> I saw this test racily fail in the Windows CI build. The failure is as
> you might imagine, a few of the background update-ref invocations
> failed:
> 
>   fatal: update_ref failed for ref 'refs/heads/branch-21': reftable: transaction failure: I/O error
> 
> but of course we don't notice because they're backgrounded. And then the
> expected output is missing the branch-21 entry (and in my case,
> branch-64 suffered a similar fate).
> 
> At first I thought we probably needed to bump the timeout (and EIO was
> just our way of passing that up the stack). But looking at the
> timestamps in the Actions log, the whole loop took less than 10ms to
> run.
> 
> So could this be indicative of a real contention issue specific to
> Windows? I'm wondering if something like the old "you can't delete a
> file somebody else has open" restriction is biting us somehow.
> 
> -Peff

We're seeing repeated failures from this test case with ASan enabled.
Unfortunately, we've only been able to reproduce this on our
$DAYJOB-specific build system. I haven't been able to get it to fail
using just the upstream Makefile so far. I'll keep trying to find a way
to reproduce this.

FWIW, we're not getting I/O errors, we see the following:
fatal: update_ref failed for ref 'refs/heads/branch-20': cannot lock references

We tried increasing the timeout in the test to 2 minutes (up from 10s),
but it didn't fix the failures.
