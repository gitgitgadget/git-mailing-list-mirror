Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76B11CF293
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528548; cv=none; b=Li+Ui3wfpUoMTKEQ1ZMdxiFTQmEsG+trWCN77aLsr8lpAxRjSINAps6m0R1CE1gUmzjqhOK7IHQXlhIeOKrLd2PwwPPzKfLh6G+OuIfij+KR2PNMoe1KlT/oVUQA1fm4vgA0oelcAq1u8pYxK00naySrPJ/d9ysRUQXGESjf7kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528548; c=relaxed/simple;
	bh=5/n0eBxWDAutUhqxa39OF6AqEa+zlehXwke38IhBxEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsT+wj/SoGyarYJWWiczhpfUlINfWF0ItRoLuEA9M/P8+fEM42IFRtecvQNl4Aag423e0k+Zw8Bjxvj3zlHpJ5ZtHJ+HmPuD4zpgiR8/Hx2FK4kPeolczVWfq4rw1BrRqM7e/W7MhnwvvhOsELmSb8SpEJ1DW5oSLpxOZ2Zg1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Tc7TnCfn; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Tc7TnCfn"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e3c3da5bcdso47886917b3.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729528545; x=1730133345; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5/n0eBxWDAutUhqxa39OF6AqEa+zlehXwke38IhBxEg=;
        b=Tc7TnCfn+PMa1HVsJnBQd0x6Ns/FyBPfqKRRiEEeDicEPRrVN6yX0aOVMH4cdCwLiI
         nxBcwKviQyWusIhwiNd4WukFzDhIxoytLAEzVnoBW9qvIEI5Gk6lz7AYNyYrD5H7pdsV
         lLlwcO4A8qgYKc0SXWBxdsiPBGu22vaphvb9xYa9kHIlhkQoCBchZN2h712VZkghQWmg
         kTB5XQL6ETdvjdShJkISOIdTjR4qamwufsMs2QFPn1crRiS8eVOpH1qI+Im0hWqaVK0e
         baE+hitVDGhaJwRPASKp5+kRSBuES5IsOJ0SWl9lTDr5Cp7EsF46Gem2Tacd2rUMSSgc
         V1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729528545; x=1730133345;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/n0eBxWDAutUhqxa39OF6AqEa+zlehXwke38IhBxEg=;
        b=Ontgs9zc3w5NuR0DBQUdd4d4Lc9Dd8OUdTY0igxhhmKIrQZlXw+Z1nANRDIQ/prVjG
         1nEHu6AWp66kUwzDEpY/HLvOxCZkjX0gVc+1nwt4SfLM3bNxfNswiiEZ1NfUm0EzLlZy
         QDyW6Tae0Nm3TZB00iOeS8rxrU1OAVwjROCTPIIKSXBQYbOPA2cp0+Nv4v9M+KyPtFDo
         1nJjNjllbSQwIl3FTmcD663uDMcWHuOCMjEiKA6PGuebOpqee0EQA+1ZTWHocyPJTFc9
         uhf0Li2zOvpQ9BDxnauPlUFSEu5N4hUWV+Jca0wZ9LbwSD4PMUiW1B5u5dsusmCfYVaz
         gZfw==
X-Forwarded-Encrypted: i=1; AJvYcCXHmqlt4QCh3BlFo1qlUU/zZHGgC652GVZYtstUNUn6lWLxBKPROeZTzCP23/sn+M6vW6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMhoP9OHiE35UzFrvSUwRYlN1+eH99UbKB91Zy287ipKmjf0WM
	c4rXwxB7UtKUPNSkSMxd4LTDCDVXhmZZIYSRLWaZHc6RLy+Hh+7L+lfCJj6GaCw=
X-Google-Smtp-Source: AGHT+IE6Ou/FVuvJTyE/HOFRDciuZRESd/PxVqAk7v1mi80UvGQUcVAlSzhL7oyAf2wySz1tNjlW/A==
X-Received: by 2002:a05:690c:6f87:b0:6dd:beee:9218 with SMTP id 00721157ae682-6e7d3b848a3mr4245987b3.30.1729528544207;
        Mon, 21 Oct 2024 09:35:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a619afsm7261967b3.56.2024.10.21.09.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:35:43 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:35:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,
	Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] imap: replace atoi() with strtol_i() for
 UIDVALIDITY and UIDNEXT parsing
Message-ID: <ZxaC3o05fZNOWsf/@nand.local>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
 <c09c7b3df0d7eac3069cee45cddc49a76da2503e.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHIk-gH0Onpt15@pks.im>
 <CAPSxiM-wLZfA1+1zvfjW-PN=Zpjrgy3KR9c_jrb=we7vhvoUYg@mail.gmail.com>
 <ZxZKQrc0Ch_YA1IV@pks.im>
 <CAPSxiM9BuOCXSstZCm5B9dR6D0rg5vB23T0xNT3xAOJihQy0BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM9BuOCXSstZCm5B9dR6D0rg5vB23T0xNT3xAOJihQy0BA@mail.gmail.com>

On Mon, Oct 21, 2024 at 02:38:40PM +0000, Usman Akinyemi wrote:
> On Mon, Oct 21, 2024 at 2:01 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Mon, Oct 21, 2024 at 12:27:05PM +0000, Usman Akinyemi wrote:
> > > On Mon, Oct 21, 2024 at 12:20 PM Patrick Steinhardt <ps@pks.im> wrote:
> > > >
> > > > On Fri, Oct 18, 2024 at 01:53:00PM +0000, Usman Akinyemi via GitGitGadget wrote:
> > > > > From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > > > >
> > > > > Replaced unsafe uses of atoi() with strtol_i() to improve error handling
> > > > > when parsing UIDVALIDITY, UIDNEXT, and APPENDUID in IMAP commands.
> > > > > Invalid values, such as those with letters,
> > > > > now trigger error messages and prevent malformed status responses.
> > > >
> > > > The line break after "letters," is a bit funny.
> > > I just noticed that I will change it.
> > > >
> > > > It would also be nice to point out why this commit doesn't add any new
> > > > tests. I guess the answer is that we don't have any tests for
> > > > git-imap-send(1) at all, which is too bad, but a fair excuse and not a
> > > > problem of your patch. So introducing such tests would be too much to
> > > > ask.
> > > I can try, but, why was it not introduced before, is there a reason ?
> >
> > I think it's mostly that we'd have to have an IMAP server available to
> > test sending emails properly, so the test setup would be comparatively
> > involved. Nobody felt like doing that, and thus we don't have any tests
> > :)
> Ohh, I see. I have not set up an IMAP server before though. I can take
> it up but might require some level of guidance.

I think what Patrick is saying is that it's probably not worth the
effort to do so for an automated test, especially if the code change is
trivial by comparison.

Thanks,
Taylor
