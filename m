Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D53207
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236272; cv=none; b=HI1wFVeBOOWqIvsak7IScj+2Jxx7vnZGCao+3fmvDRVzd8hhzrA1dP82xmhs8BlofOUNcBvqaTamiTrTJokfPr0AoRbgahu8ELQ0p+gFyHA9auy8ieD66WvBIoFBx8QJDQgsC1fBavr0pfxFJE0z0uFV7owf5ZZRTCSTRa7xiyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236272; c=relaxed/simple;
	bh=nsW1nrdj5OQrUA8R/qIrzcdZVl0tCyvMPfzXVQXgv6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iK/+P2v2l5UuLgbKU3zd10+taHLE+aPmHiNuA7PHVpC012OXarDTa7mt0ton8NfvwhCasU2GsLQkU/ayOj8od4nmq4CIGe/48+qZ/vEIzkC3ypbAkdP74+VEfkOTkcZedbEtBxWJX6Q2PqJOF3AZsSofBtJAadBafswHLFP8qj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EMbUSEWT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EMbUSEWT"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e7fb84f99cso113810917b3.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730236270; x=1730841070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPdEerhlq+X7MEavHBP5Gaq33R34Wclk09/VETFUCOE=;
        b=EMbUSEWTxlnYk5HAF084sKfN0QqSAzj+XR7nrWdpbYJfpahCFXSYoAbuvlZVRCHh6Z
         yBT4XMvzIAjE9xyl/VHV93It0Vw8vk1cBx2DGzvXHzFTF8FK2xwT4EHAdnl+Rpokbo90
         5a6s1HFLSFMiwbXSCf205H7r9JubPbcSieqCL90le8LaTNtPoWB24Vl89A8Y+7ym65Ov
         mWsC38BCSOOjasLzb0bQXvzXZSyXuvobSK1hWfbksXOua/724IXfrT/ni30fQ2I7H3cG
         yAvfcJKHvUT1004m9gyq5hYRBExRDdUktZ8zVNifgMIoTuyT5Mpw7crBJmMA1yPoHdYS
         CY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730236270; x=1730841070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPdEerhlq+X7MEavHBP5Gaq33R34Wclk09/VETFUCOE=;
        b=kw7R1GBQaHCcAC+NvKhLTn/x39T0VBiwaySa8MsNQf6zm2DLcXFGK/kVohKqss/Mvq
         Tb0EzADZw1zIsLLdIdR5L9QeLDzsm/H4hmyiLdaprTgZ9p6+itiuGUh5uou1JJF0viTX
         AFZ3XtmmpY5xlC+SWWTZemcdc/qt/bCA3JMhkXCM2JWQLPGYpCd6Ci87xlGIos+fWCaK
         XIh6q4KX+V/LyqmycPRwGG6HGlyo0gpE76Bt1IMPSQcQdVDzdOaluAtQcRjGJDizxAGX
         5OOxqInx9u5vPCOuUv1vBbLNgpKwoeoSMpj1bPokPhUIBeJ4C6jvMnnqqHGW6hkgOMU3
         Omng==
X-Gm-Message-State: AOJu0YzTMRS3UmYGWLS51Ndt7ro9rAH/i4GL4CucpAVyOgisEuBoCku8
	JE5Zz38KkYYOqH5baAxIxcU1WMfGQ6+xykeT0b0QPLWUVEKmZJH7RceaaR8RdcN895UcioQrU6U
	2TI9H91Fuz/Q53DOr3DdWsxjTxO4l0K2MLlwut6NrKWvITlfArj5uPDRERWLq0KEPPNoUIRDyB7
	/otk6ZuqioBjQ8t73CvfpAtJKqaZeLoKyqiLRVaFGAfc5YIkys5DKFQH00HvIwOFd7YA==
X-Google-Smtp-Source: AGHT+IEKwtWar2kIusiDQ1i0OdDf8XkrbS/YBw9oYGh07qaFBDXVnlR6unfwXwyieZqbKKFaPPz91B2EjSi7Npu9N+KK
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:c9ca:c50e:3acc:7e6b])
 (user=jonathantanmy job=sendgmr) by 2002:a25:c78c:0:b0:e30:cdd0:fc0e with
 SMTP id 3f1490d57ef6-e30cdd182bamr1182276.5.1730236269451; Tue, 29 Oct 2024
 14:11:09 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:11:03 -0700
In-Reply-To: <20241003223546.1935471-1-emilyshaffer@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003223546.1935471-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <cover.1730235646.git.jonathantanmy@google.com>
Subject: [PATCH 0/2] When fetching, warn if in commit graph but not obj db
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"

I mentioned previously [1] the possibility of not running maintenance
steps (commit graph writing and "git maintenance") if no packs were
fetched, but looking at things again, I think that we shouldn't do
that - in particular, if I ran "git fetch --refetch", I would fully
expect the objects to be repacked, even if Git wasn't able to detect
conclusively whether a pack was transmitted.

So I went back to my original idea of detecting when an object is
missing. In trying to balance the concerns of both doing something as
reasonable as possible in such a repo corruption case, and not slowing
down and/or unnecessarily complicating the main code flow, I decided
to detect when an object is present in the commit graph but not in the
object DB, and to limit this detection for objects specified in the
fetch refspec.

Upon detection, we can't fix it due to reasons mentioned in the commit
message, so I decided to print a warning. An alternate option is to make
it a fatal error (instead of a warning) if an object is detected to be
in the commit graph but not the object DB. I haven't thought through the
ramifications of that, though.

[1] https://lore.kernel.org/git/20241028225504.4151804-1-jonathantanmy@google.com/

Jonathan Tan (2):
  Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"
  fetch-pack: warn if in commit graph but not obj db

 fetch-pack.c | 45 +++++++++++++++++++++++++--------------------
 object.h     |  2 +-
 2 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog

