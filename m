Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D6A392C5A
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 05:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103720; cv=none; b=KfvvvNO2171u05cIKlVcOPVZuSHtg1Ane0RKx1/6JPuNjZLl5wCZd0PxzCjBNmHe90l0HrxEulr7+sTkrmKIOOKcie3UCnh+RsHQj2Or+feqcOM3NUPd3I/Abmh+AYS8DQonRyanU+dULA+0DnMUbP1YiGITEm46UvG3jnWetF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103720; c=relaxed/simple;
	bh=EADdvPuj+29EpVSpQqsNzmjGHioB9syAhEtz20WIibI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezKJi/B1Mn9GhNEcVPpudLF41n33rZNttQKWAZ/SUiCMQCWZGJHRc/jGXJwn0MXWcO/nTz7rpMPXx31AXLLzoSn0LKo6M5ensJKgiAzCyA2xYq0CMzQ4yM9RkysD+YCo4ftHiFg1C1Ve3wFtCO7psaM1Q+qYI1Ay8MwhKaqWBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HIOAr45E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dQkzEE0F; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HIOAr45E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dQkzEE0F"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B8912EC06A8;
	Fri, 11 Sep 2026 01:15:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 01:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789103717; x=1789190117; bh=OC58O1wADr
	X3BNQsZn7RS74GuFW7enpwA1xPo8vJ32M=; b=HIOAr45ElcZz+yfVmCC+7XisQx
	MUg5lr05aq/koztMrGpf3hgUigPrExu7ubSc3KE/Y5ckUotKCVZ0ootDNjU+M2iJ
	t+YFS3BJj9aVmpYJOk04KVcf98771UCEDWyKqyZJXHjCFYbOGCXe+zKutfBed/5o
	8D3HNeT86F2eMP+gjs7PRV7miFpU1gpZRMB6YQJamw9jwPe4+8yKUl3Z2OxtaGGJ
	BE9pAUoCRTRJPSkQBxDddW1Js9HqzpUUbAXINQtp/E6K3HqcK8MAaFLdGWpoFcQ1
	rUv7MwKWvClyAFsklldgZuUZXak741UaBddmaacibFZjXaCKcpaHsJI9N0TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789103717; x=1789190117; bh=OC58O1wADrX3BNQsZn7RS74GuFW7enpwA1x
	Po8vJ32M=; b=dQkzEE0FA2iZSAo1JYUjiWToO0eIG9rosXL7mEEkIaV62hOGuIG
	yqAX6S4fl4d3BeUdT6I3JXffNDZJpC7FMY1CizFmOaLklNyd9OWLNynNGA0VuL5c
	8dKVWrJMhKupa7RMEVxlXTDLsTwI2573P8adynWpc1duDd9Ui/ubEAQw02BfJiuR
	XQOkRWkdtFOEHdR0/QP+T5UhWX/nnIYXj/0r3Aif94x1n93aMMPRDtMa4d7nF9l8
	8DMjNJ27lLliwG15caXIAw6kWzb8d5wDhMngWZq+7IuOvB8tIusnpqlia+CkbqS7
	l0RGsOMZqxFtHyB41zl/bucaI8u8otPm2Eg==
X-ME-Sender: <xms:ZY6jagXLd0aNJGxQDEYzf_BuK5rmMJboAK5Eq8TuG1LNTRMT99sEIQ>
    <xme:ZY6jarfVMDsNv65uuxQq143nMqmCwiMnyD2mwV3K-tFKAYWyASXoq3zUAB19o0zlD
    EY_YTm0aCFyP96-lUEV9bNtpsarvv9XNMM8PDa805-2knA3QOOJH6c>
X-ME-Received: <xmr:ZY6jasv7k21lCkD7gvSRc1orxNWvbdDUm9O7ehYxT8saCeS7nX4sLoYpyavAabmcIUHoZA>
X-ME-Proxy-Cause: dmFkZTGhwnL4QwGgbDsEbFN4d8PKSZGpSIPYR/SpOnmgVigl0dUlI2jbEkut+8/rkIsDe6
    WxX2sG84RAWhIhfODVlVupHJ7yHjvm5RAkzIeY5b2DA5Z2AWOfcS3T80PPyw/QRKgg0xge
    shIwIKKEZb2FAySOAqT2In6cYLOwEjgw16T42UJ57yJaVFvp4hxxwVjz/01e/DXcwXNtyi
    13xDfV+R49hXK3HGMHL7cFftK1GMbuUqDqE9vSucsQSIg42QhkRX0rZ8gc886WQSZ4QsX2
    MCBzQ3Cqx7O8TwPT46E+3I/lSb8ECTn4pYnsBbm7KmDc8PL2Z74MYQc1Ghjc/Jibq+E5hi
    ngtW0gKKU7tUr7pl2EHRC3SMRDgEaVx1ol09Py326luodQ9/20ZwjWT3xyOV70INI+FQdd
    cbwNXDQqPrUzmrL5NG6Jlyf+RIWzAwxmjel2/oIF4VasAQ0zZBvtwcCGAMQ990nR0jQnT8
    s2GJDyc+LD+dmoQT5yeEGwJheKNDeYQAT2EF/gHXnXsWEN0QljjwUe5iADUro8vfQ5VYpR
    43WlTEuv1bitqBGNh1ak/0lllEx+M1U0QJ47FxEl1F2OYf9py3at/06l2e/bVTv1Rvnr+3
    vRWSs6IatDwmiCkCobKFYoIyL7XoGrb+Br4onQvOpOAjODM8U2A0a3/plHKQ
X-ME-Proxy: <xmx:ZY6jaq_B_0ooASjNKzCtdBXJ9bWqDeuNAHNRPWSN6u47csenIVrGWg>
    <xmx:ZY6jan1uUjteNGx1GR-jMQX1ZyZx2loZXRWrJu1ogMSJaJMWLe494Q>
    <xmx:ZY6javCylZaa-i5hzlyh2R5hOVzy67jDMlQcQgpiUrrWZs7WyxRNQQ>
    <xmx:ZY6jajcY-gdDWN2zOeiefxmIozuNqYWjb3b4K_2VXduznis3VMubVw>
    <xmx:ZY6jajaTWxueFyzDtISXAMRq8eF3Hm7FhTVlIx1M_vNORtXbyR9wKIJa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:15:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9fe8ffdc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Sep 2026 05:15:15 +0000 (UTC)
Date: Fri, 11 Sep 2026 07:15:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 7/9] odb/source: support writing alternates when
 creating the database
Message-ID: <aqOOYI9v8M9VYeNN@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
 <20260909-pks-odb-write-alternates-at-creation-time-v4-7-d8a78ffc32e4@pks.im>
 <CAOLa=ZQaPstiQmXm9=TyWPUxL6X2=Lcqeg6y2XeXzSJDpq-GBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQaPstiQmXm9=TyWPUxL6X2=Lcqeg6y2XeXzSJDpq-GBA@mail.gmail.com>

On Thu, Sep 10, 2026 at 04:10:31AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb/source-files.c b/odb/source-files.c
> > index b7b3a297bb..8fe65d91f8 100644
> > --- a/odb/source-files.c
> > +++ b/odb/source-files.c
> > @@ -64,8 +70,74 @@ static int odb_source_files_create_on_disk(struct odb_source *source)
[snip]
> > +		/*
> > +		 * The alternates file may already exist, e.g. when it has been
> > +		 * seeded from a template directory. Read any preexisting
> > +		 * entries so that we don't end up writing duplicates.
> > +		 */
> > +		orig = fopen(path.buf, "r");
> > +		if (orig) {
> > +			while (strbuf_getline(&line, orig) != EOF) {
> > +				strset_add(&seen, line.buf);
> > +				fprintf(alternates, "%s\n", line.buf);
> > +			}
> > +
> > +			if (ferror(orig)) {
> > +				ret = error_errno(_("unable to read alternates file"));
> > +				fclose(orig);
> > +				goto out;
> > +			}
> 
> Shouldn't this be checked inside the for loop with every `fprintf` call?

There isn't really any need to, as the error indicator on file streams
is sticky. Sure, it would allow us to potentially abort earlier. But
it's unlikely that this really matters in practice.

> > diff --git a/odb/source.h b/odb/source.h
> > index ea8675247e..63f1c0c531 100644
> > --- a/odb/source.h
> > +++ b/odb/source.h
> > @@ -36,6 +36,15 @@ struct object_id;
> >  struct odb_stream;
> >  struct strvec;
> >
> > +struct odb_create_on_disk_options {
> > +	/*
> > +	 * Alternates that shall be written into the newly created object
> > +	 * database. Whether or not this option can be handled is specific to
> > +	 * the backend.
> > +	 */
> 
> Would it make sense to formalize errors thrown by backends, so we know
> when a backend specifically cannot handle alternates?

Maybe, but there's nothing that'd use it. So I'm a bit hesitant to
introduce that right now without us having a way to verify the logic at
all. We may want to eventually introduce such logic though.

Patrick
