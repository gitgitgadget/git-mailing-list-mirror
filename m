Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB088493
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952945; cv=none; b=gV83ln/Ao7NTwq49/PAcfzqw3mMtOuJZakf26hSevFNVOjxPomUP4BLQxPxG7BxHHf1+AqLlSXw28nlyaACIweF3W60Icru+DUvUsz2oRDQ7VT9E8E4o0RE3gravveJs1IgmcYwZ9aOw+zCXak35PPt1EBeqA9nFGzQOS/qeO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952945; c=relaxed/simple;
	bh=WqGXZgGkq7eaqgx0iv1osdLdpUnsvVoNe6F1lPE0lwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk4jChLKDnZrP+RWLpqufIkztkN61CYtBuQe0TtnCFCGNHy0wlIkEnrUG5SotL9M+gA1UH+89QowFA64u67dAtobuZt1r9X5OHYWE6cwZr7LjV1iyt4piCTWbxKQwK8qWuwgmhoZaYNx8zPNjbVeKfXuv8W6iRD+zhYAUSIeBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GCzYIipm; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GCzYIipm"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e2914e73ea4so3440765276.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 17:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728952943; x=1729557743; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GxKUq1yzfWNRben2C9/5lkwoH6ZIhvA8clpPnGS6LVU=;
        b=GCzYIipm1uuzszbtHCLwvCy4m+rTEmh+1M/zboRsVhmbX+BPlG0i7mubp19nye5D/p
         OoborpylxoWuaG+rsrmsWcHa/rH6eQrIQkhlBtIqQwMGlKGPeqjps/ITXlLYvT8uhZVR
         1vSeGmiHgJ7v+E+5SW7Gcvx2KUGTcT6eeqQ/n0Mx4uKlP0uclux2l6jnu97nsdbl5nXo
         CXGR6AzP+UyMVoVObQbCWJ10n3mGHm0dLBjMYvhTm0fwn/GBfuQZFQUMeXfmewgCFMR/
         8b7vKCDzlAZLIzCZlP4BpatXbJT9F4KXrh9HnZT78jV4B2TCLmBSeXu1PFepKZTNi5hM
         XiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728952943; x=1729557743;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxKUq1yzfWNRben2C9/5lkwoH6ZIhvA8clpPnGS6LVU=;
        b=Z/1XxY9prTp+GfUhTsHST9b02DXFqXH4U4oTEohq6NbT8x/2AhPvwYkqJYWP8JLz2/
         bAUEkqFmA+O27HPKl8td+BDC1LAd9SNrLtafDCeFOtp5hYMRlq6qvbt63zgJHRDaMTmK
         eFYwhzzDO3RqEQU5QoLvR1i72oWv2ICD143ebILwoiN+kBocdL4ODSoABVExd8ddJ6uT
         iKfyAsszJgPD4RGjAE4Zb+xjORqRh8q3nrJRIJNXr6Yue0XsFHMzrhQf6LTBKoXJURMq
         bifWPUIRfbBFA2WUV1uEp9zyGJiO+1Yg5GPr/ZFWdlwJqiq5LYayEwr48E0y60REqetW
         z/xQ==
X-Gm-Message-State: AOJu0YyqVPo77Rsd/ONM8TR/75E6Dn8u071DrlaHX13upKv1pYdmC31n
	kULuBzrCAGQniohpTcmzOPxE1h0iwnGgdcxbaIhwPuEJTgQn84kGe3QytZPiHXc=
X-Google-Smtp-Source: AGHT+IHAM5KY8be4DEZM6KAcug+a5WAYu6pi0OF3t8F2KlzjErmNbDKFKV1XriT+nUPjKLvFeViJ+Q==
X-Received: by 2002:a05:6902:11cf:b0:e25:c6aa:fe23 with SMTP id 3f1490d57ef6-e2919fec2famr10868378276.52.1728952943202;
        Mon, 14 Oct 2024 17:42:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296d06a617sm46164276.54.2024.10.14.17.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:42:22 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:42:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>,
	phillip.wood123@gmail.com,
	Christian Couder <christian.couder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC Outreachy] Leftoverbits, which involve replacing atoi with
 strtol or strtol_i or equivalent.
Message-ID: <Zw26bU17+2SRfv8L@nand.local>
References: <CAPSxiM9FoGBhsnBE4E0Fvq-x_HvyFGGkkhaLNoRdVkvE6CpaZw@mail.gmail.com>
 <ZwqcHDzaR2U2JNu0@nand.local>
 <CAPSxiM_U5ffBCsTrbBqsJK0jUZtAuWSLook8CLKat46CX0QC7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM_U5ffBCsTrbBqsJK0jUZtAuWSLook8CLKat46CX0QC7g@mail.gmail.com>

On Sun, Oct 13, 2024 at 03:46:05AM +0000, Usman Akinyemi wrote:
> On Sat, Oct 12, 2024 at 3:56 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > Hi Usman,
> >
> > On Sat, Oct 12, 2024 at 11:21:13AM +0000, Usman Akinyemi wrote:
> > > Hello,
> > >
> > > I was looking at some #leftoverbits which I can work on and I came
> > > across this conversation.
> > > https://public-inbox.org/git/CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com/
> > >
> > > I followed the conversation and came accross
> > > three instances where I think atoi can be
> > > converted to strtol or strtol_i or parse_timestamp().
> > > These are the three files which I think the atoi can be
> > > replaced with.
> >
> > This seems like a good #leftoverbits to use as an Outreachy
> > contribution. From a brief skim, it looks like this is going in the
> > right direction.
> >
> > But to get help from the rest of the list, please submit this change as
> > a patch or patch series, following the instructions in:
> >
> >   - Documentation/MyFirstContribution.txt, and
> >   - Documentation/SubmittingPatches
> >
> Thanks Taylor, I already went through these as I already sent my first
> patch before.  Also, I already sent a patch as you suggested. Thank
> you very much.
> Usman Akinyemi.

I must be missing something... I don't see any patches from you that
touch e.g., merge-ll.c, which is the first file you mention in this
thread.

Try searching the list archive for:

  f:'Usman Akinyemi' dfn:merge-ll.c

Is this different from the other patches you have sent to the list? My
apologies if I am missing something here.

Thanks,
Taylor
