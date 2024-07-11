Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FBB156993
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699180; cv=none; b=jAFZhhPRRHIVIjawFAmHPGeipHscd3HxWmK44gLMoGHZJtRs/k7cy2lO9CVg4VhL8T03BGpusLpf13LVHUVDnw0VssQNZcXoAPs7epuT5uhvl6h7jbtP2cpKLZkyK57xiJCFZjvMs3OFbKOQYnYrTKpivVUshdPpeztM2GnqCss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699180; c=relaxed/simple;
	bh=Sqh1wIoCAlHh1pXz4JIXFrXJDoiWU1TmqXEhRybs3EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIR3IToG4l/XQ/dE4YZem0jdgSAfaIppY/NZfqpkwPSMX0zKBc0c8KV0tQXS3qIj94VcxW6FrjOIpYiUelCWNLo9Fn4ZV/tvSuwT67lHtHIn/55vwoGfWh/gWPe8TZZl/XhjOhDXNn2c+2YUbaDCXtlOKrv+Y1xjBgUrAM1OZHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiFGE0eC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiFGE0eC"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b07bdbfbcso1418853b3a.0
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720699178; x=1721303978; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T/dmMZPzGnCeIHMqeQRe7QL3K8I3xB9T+XnRFXj9USY=;
        b=MiFGE0eC7CKZdm9pExd2lpKFZk+/No/5Ad/Sh35Ob6ibpHcuxI8X2U5lIX/96UH0OV
         KgFPeq8yTPHM3SWG3NpjkCoTCOTmqlam3uQvo9REV8I5ntF0y+yxmK8fO1G6oCnhvnnq
         qmRn97MVlhQB55ysXX1v+jDAb/fqBCRxdXcL6ReGrjGcEJLhYtGDngGzfiQxM5lpwlYI
         yFS1AS8VtOMdZYmHdfqUItrNJF3tAcWz/WDngQBqRHwJraub/CcU7leV/8ddCfKhbmwN
         LgZTFLB9v7JoaPdfndHAPodfFDLxiw860uXxppKUHuknxAo4v5tY1tKFB3+NSdDCZtLO
         BWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720699178; x=1721303978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/dmMZPzGnCeIHMqeQRe7QL3K8I3xB9T+XnRFXj9USY=;
        b=Di7fU5FHJZxx7Qnja0hx99SIh4AqiDyTA72P2JTVS5/QMGhVenEtAqtDIZAYSjWZ5P
         XezNJBsHfa/vFB5sF8TLUFTgwotbk7Ovk6FTTicGXQUWojYjirdDFQHn6fiJjG4xJna1
         2dD6IeW0BZ12atqQYypXYw/65G2otT0fAxL+80+utE1ChjZp1+NuwpRcogCaRVH/TfE/
         iUytswjwEXnLkQO8gkasY/T8eUvC2o5S+O5StOiX17UFn85FZ3qYM+KSZPajSHuVqUWt
         KL+R9H4XtdRpASzVDiORpCylR5aG5AB9D2O6yJcdqPXeAved45g7AWX9taGjbYwGTsja
         whuQ==
X-Gm-Message-State: AOJu0YzwYNS+nvEyfiY6ZODDM+HAY2ztvnTHwDU+l/fAd7O3/5NKGGj+
	QxAgZvF2fmGPiCvsmBoIp+Y/tmLtuHnEjkBFvhsov+/ywke3a6/lMrg6aA==
X-Google-Smtp-Source: AGHT+IG9edxc5zjcTqethHyItGsId2S3KaqitUAODcdmlUz/K7VbV18A8lFr7EnlGwg2RYGzBbTaJA==
X-Received: by 2002:a05:6a21:b96:b0:1c1:795c:2652 with SMTP id adf61e73a8af0-1c3b78318b8mr1774140637.25.1720699178279;
        Thu, 11 Jul 2024 04:59:38 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438993c0sm5494720b3a.29.2024.07.11.04.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 04:59:37 -0700 (PDT)
Date: Thu, 11 Jul 2024 19:59:39 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v10 03/10] fsck: add a unified interface for
 reporting fsck messages
Message-ID: <Zo_JKyCHrN_lJFAx@ArchLinux>
References: <Zo6eJi8BePrQxTQV@ArchLinux>
 <Zo6e61kSAvuvBvBS@ArchLinux>
 <xmqqv81dufg0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqv81dufg0.fsf@gitster.g>

On Wed, Jul 10, 2024 at 02:04:15PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > The static function "report" provided by "fsck.c" aims at checking fsck
> > error type and calling the callback "error_func" to report the message.
> > However, "report" function is only related to object database which
> > cannot be reused for refs. In order to provide a unified interface which
> > can report either objects or refs, create a new function "vfsck_report"
> > by adding "checked_ref_name" parameter following the "report" prototype.
> > Instead of using "...", provide "va_list" to allow more flexibility.
> 
> Like strbuf_vinsertf(), it is a good idea to have "v" in the name of
> a function that takes va_list, but fsck_vreport() would probably be
> a better name here.  Arguably, the original report() is misnamed (as
> a printf-like function that takes format string, it probably would
> have wanted to be reportf() instead), but unless we are fixing that
> at the same time, calling this fsck_vreportf() would probably be too
> much.  Consistently misnaming it by omitting the final "f" would be
> fine.
> 

Yes，I will rename it to "fsck_vreport".

> At this step it is still not clear if the previous step was really
> needed; you have this "v" thing that is designed to be usable by
> both reporting issues around objects and issues around refs, but we
> will hopefully see why when we read later patches.

From my perspective, I think we should put the previous commit after
this commit. I agree with you that if we put it later, it will be
much clearer and eaiser to understand.

> > diff --git a/object-file.c b/object-file.c
> > index 065103be3e..d2c6427935 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -2470,11 +2470,12 @@ int repo_has_object_file(struct repository *r,
> >   * give more context.
> >   */
> >  static int hash_format_check_report(struct fsck_options *opts UNUSED,
> > -				     const struct object_id *oid UNUSED,
> > -				     enum object_type object_type UNUSED,
> > -				     enum fsck_msg_type msg_type UNUSED,
> > -				     enum fsck_msg_id msg_id UNUSED,
> > -				     const char *message)
> > +				    const struct object_id *oid UNUSED,
> > +				    enum object_type object_type UNUSED,
> > +				    const char *ref_checked_name UNUSED,
> > +				    enum fsck_msg_type msg_type UNUSED,
> > +				    enum fsck_msg_id msg_id UNUSED,
> > +				    const char *message)
> 
> That is somewhat annoying reindentation.  What happened here?

The original code's indentation breaks. There are one more space in each
line like the following:

  static int hash_format_check_report(struct fsck_options *opts UNUSED,
                                       const struct object_id *oid UNUSED)
                                       ...

I think I could fix this by the way.



