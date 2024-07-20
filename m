Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFED1A28B
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 07:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721460270; cv=none; b=c7U2zx1fl4RcX8WiC9ax6JIukfRXQhJtOGDhSALmFOu+bMGuafaKdvDtozvdjAmYU4rP3tFSY3O7CkdlBUBZbC4PXIyLD4bThpMN23/NOzpcssKgACJVFAT8bzfZuHBVbj2tLvRiBFryEh7REwViPFMOb/+ATV89mTCwkKjFbik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721460270; c=relaxed/simple;
	bh=WPlK/PiWNgjqk/7bklqtpciHJSG0jWEH9X0wsydEm/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9tu2aPNio7ptmWzC9pWGNj46alvuHFQodu1rzj9Wt0e6+d/GgJVq43lSPfRvV31bco8HnfO5nbTVoXucRNYHdsk6SL/+7o1WQuai+153hGKCn2qEoRZaRFhrlO02IZM53f7Pon62G52Vidg8EmmUTH9FjeRtnmDLyRJ4g1DGU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAOIIl81; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAOIIl81"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-75c3acf90f0so1760958a12.2
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 00:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721460268; x=1722065068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VyDG4C0JsLzOiQ6cYsLjviXzqZtd6Bf0vAv+q4yhAN8=;
        b=QAOIIl81cFQihdjLj0sIzK0WrAMCMZRHnS8JtHzmItZaD71yUNm+F+BSF46/ufquD/
         1eQxd1co+kWNu//3vybrbXJw53LOmEQQadTY1GApyvQtCbkOyY18qHnCbmXnCPY2Afrq
         CZVbgoGNUYvwYIOC8PTo7H+BsAypslO4CXLy33SKWgHfT3uaZD0ASr0KKuDPHxwNwkyv
         HjVdVwYHccheH7BxtoPUJNem+kXELnoU4kf1XSu6eo3Lr5xDOMvJb2ON7xmzmgTtC/Qt
         4LFtzoqakRqJi9O9Y4emhO26vlSk7FWV9hFdtB5vGhgkVKSy4UOgaqPoRddLnpzcGhC+
         4YAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721460268; x=1722065068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyDG4C0JsLzOiQ6cYsLjviXzqZtd6Bf0vAv+q4yhAN8=;
        b=EYKCqZxGVn23k4kdh5j19fDFQ5yw0eCG005VkVshId2jPbpgg/duQCTIRVBJGIpJ3D
         MTRrahr0GuRYc2Q/UbQ/PF6T3fKtmtdcEN9FtomBj609sC3njpmwn7JI9khC7xRPurZE
         vCZ2yTf/q9KuVQ66BUr0CIayXBkxSv1WyUUHO6KN/aFOs8cxELOGcqrdW+HGvJs+tBrO
         J2wDlIkOBVPjV+bBQ9o+AwcoQ7nxX6GVyY5qseSC7VblNmvTQeGq6DvsWW+5VeroJ4UZ
         aHtcbvXfhZ7rKTfWC33pSs/TuxEqeXneetEAhpY0T2aQqGo4osCDVS5NUHtIIcxnaFA0
         iUig==
X-Gm-Message-State: AOJu0YyIIF7nKPGoVnIDYNU/Ev0Ovope1sRxJLabYK8yZlYxum4ZX2LT
	lS7S+V2lKEdGTCFdgeqxfER6SppensR2SlO5oIOPITnNevJreu2syLznUQ==
X-Google-Smtp-Source: AGHT+IE8sDMtAtLpaK0ZOBziOfiVRk4zDpZDD9i2K/mynWgfU3afYGZZze6devNU5FL199erxCWxnQ==
X-Received: by 2002:a05:6a21:6d99:b0:1bd:2214:e92f with SMTP id adf61e73a8af0-1c4285d350bmr606695637.14.1721460267827;
        Sat, 20 Jul 2024 00:24:27 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb7754a888sm3973423a91.57.2024.07.20.00.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 00:24:27 -0700 (PDT)
Date: Sat, 20 Jul 2024 15:24:38 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v11 02/10] fsck: add a unified interface for
 reporting fsck messages
Message-ID: <ZptmNkRAgQAqgT03@ArchLinux>
References: <ZpPEdmUN1Z5tqbK3@ArchLinux>
 <ZpPFElAYLVtRlq-e@ArchLinux>
 <CAOLa=ZS07xF-MYLoS8O2ynE5DdPJPEEwaPsUR893fYUC+U1ZwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS07xF-MYLoS8O2ynE5DdPJPEEwaPsUR893fYUC+U1ZwQ@mail.gmail.com>

On Thu, Jul 18, 2024 at 06:26:30AM -0700, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
>
> > diff --git a/fsck.h b/fsck.h
> > index bcfb2e34cd..61ca38afd6 100644
> > --- a/fsck.h
> > +++ b/fsck.h
> > @@ -114,19 +114,25 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
> >  typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
> >  			      void *data, struct fsck_options *options);
> >
> > -/* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
> > +/*
> > + * callback function for reporting errors when checking either objects or refs
> > + */
> >  typedef int (*fsck_error)(struct fsck_options *o,
> >  			  const struct object_id *oid, enum object_type object_type,
> > +			  const char *ref_checkee, const char *sub_ref_checkee,
> 
> This makes me really wonder if this is the best way we can do this? This
> seems to solve for the current situation, but what happens if you want
> to also adding the reftable size or packed-refs size here? Would you
> introduce another field?
> 
> would it be better to add a single `const struct *fsck_refs_info`
> instead?
> 
> Perhaps something like:
> 
> struct fsck_refs_info {
>        char *refname;
>        union {
>              struct {
>                     ...
>              } reftable;
>              struct {
>                     ...
>              } files;
>        } u;
> }
> 
> Of course we can fill in the details as we need them.
> 

I agree, we should design an extensible data structure here. I will use
this idea. Because we don't know what we will do in the current time.
However, I think "refname" is not good, instead I decide to use
"ref_checkee", "refname" may let caller think we only check the refname.
However, we need to also check reflog.
