Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5341A6160
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356713; cv=none; b=Fp7jqmZ4DMBJC2o8mi8HZh5l1vV50jzfr7Y+f/kZIDChtJ/KYxWEOht7TSkJaN2Lx/eVQ9e6ZIOQjzpSnUxKH28oBsLVSiroStpIdLvuTlPd0e/z1NVjyY8wXbJeuKxNXVeBodLUVfdXV7bN5EPYIjGEiAwMGgO8JD8kWwTg2k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356713; c=relaxed/simple;
	bh=oeCpx6FK34H0iFZItmcZthYkgKNhg9pdcWX8/NVtYtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MplHgvWDQXbJMpGio5yNqxls8VQhvPX5PXsfZUmXmLcRTzM0oqDFE4Vbin3gjGHBjGrvsK/YSmWi4N83D6l7eFGTxedSvIjl4HC4NQOHnKzfTmEGLMsxkkBna4SJ0RKi03Bbvg+Q8D0GBWGDfqH0mO+3JZCaqlKLnLA1+kcxWWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i45LOdSz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i45LOdSz"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d150e8153so23088b3a.0
        for <git@vger.kernel.org>; Tue, 30 Jul 2024 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722356711; x=1722961511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XzO7gcWsHCLaUxVM9HHeHETXtsVIMrOI6dTUhJnDjGY=;
        b=i45LOdSz5Wli7LtfGw93Lvy93fCP8GgaO2vB2dYQpiilKTiD/52O1HpIrGGZmdFhM4
         0r8UpiaoSEeu3ngAYSxZLMWqQpa2DpMV1t7Lm4SqKchgo4wd7eXPg4c15QJvy2P/oGid
         oUMUM9K6nUvXlRTMUWAlEHnt5xxeRupTePPcKuHw1rGH2sSq/gg4GzbHi4ZERzibxGqC
         TesoGPCswFy6cFwcqgSirb9OleCSJG0OWDFO8/Y87hGT0UAn4Ug/w3moEo6Pump2RIi3
         RIktKsXjm/m4GcYCWAg62MELetuYpRGpBrCju9p07ltpH4EsLdRBapiJ6qUdCtU4nuzI
         8VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722356711; x=1722961511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzO7gcWsHCLaUxVM9HHeHETXtsVIMrOI6dTUhJnDjGY=;
        b=VJkH96mfxt7OY6cG7N42kdVgy9ZCz+mmiVVSnRCZYYkaEI9KGO+aYQRVcDjJy900Hi
         2qBqppkXCfivDi+ioK3nYrrlMyV+yCv0TsdrFyYeCTtq7gJ6m1PhQdhZOsVxHyf/Vmo/
         sLq1PKKAuWqKfwD9D76KHYP+m7O8cdw0SAACrkxVltK1f852VpWpnhcy6oU9vvYVHfaK
         QEMpGoTgEx3tZQ6p36zVRDeZowItqMIyQWWjCgcGNXH8dXeu13FupCLClb2bdf1aobfB
         CFUe1Ipi/iO1R+HJ4K6PQ94pgc9tdKBHIYrP+OSHrpkIHqkBalLSX22CujW+wrvQHAP3
         Va2g==
X-Gm-Message-State: AOJu0YwiSL6y7qg8SJC9dmlgZMSq3o9LfeBGT1ERuakIJA971O4V9JSD
	xySH7EacaxNNzJJvNl4N1OaKMoeYSvZM1aeO/ie/ohMAmTdqJo8X
X-Google-Smtp-Source: AGHT+IFPecFUtH3xXOjeCU3i7D7BFw6BQC8p15eRZLW9dc6frsJ3hfjRCohfTrVtfTOWmyM6wvVeXA==
X-Received: by 2002:a05:6a00:181f:b0:70e:cf57:93da with SMTP id d2e1a72fcca58-70efe400dabmr4627961b3a.2.1722356710403;
        Tue, 30 Jul 2024 09:25:10 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead812723sm8599765b3a.113.2024.07.30.09.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:25:09 -0700 (PDT)
Date: Wed, 31 Jul 2024 00:25:31 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 10/10] fsck: add ref content check for files
 backend
Message-ID: <ZqkT-3aAi6msd9K4@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeY3Dhj-Fo-bZ2k@ArchLinux>
 <Zqik-iqO4-yNuIn7@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqik-iqO4-yNuIn7@tanuki>

On Tue, Jul 30, 2024 at 10:31:54AM +0200, Patrick Steinhardt wrote:
> On Mon, Jul 29, 2024 at 09:27:56PM +0800, shejialuo wrote:
> > Enhance the git-fsck(1) command by adding a check for reference content
> > in the files backend. The new functionality ensures that symrefs, real
> > symbolic link and regular refs are validated correctly.
> > 
> > In order to check the trailing content of the regular refs, add a new
> > parameter `trailing` to `parse_loose_ref_contents`.
> > 
> > For symrefs, `parse_loose_ref_contents` will set the "referent".
> > However, symbolic link could be either absolute or relative. Use
> > "strbuf_add_real_path" to read the symbolic link and convert the
> > relative path to absolute path. Then use "skip_prefix" to make it align
> > with symref "referent".
> > 
> > Thus, the symrefs and symbolic links could share the same interface. Add
> > a new function "files_fsck_symref_target" which aims at checking the
> > following things:
> > 
> > 1. whether the pointee is under the `refs/` directory.
> > 2. whether the pointee name is correct.
> > 3. whether the pointee path is a wrong type in filesystem.
> > 
> > Last, add the following FSCK MESSAGEs:
> > 
> > 1. "badRefContent(ERROR)": A ref has a bad content
> > 2. "badSymrefPointee(ERROR)": The pointee of a symref is bad.
> > 3. "trailingRefContent(WARN)": A ref content has trailing contents.
> 
> I think it would have been fine to stop at the preceding commit as it
> clearly demonstrates how the whole infrastructure is supposed to work.
> Additional checks like those you add here would then be a good candidate
> for a separate patch series. This would help you get the first patch
> series landed faster as you really only have to focus on setting up the
> baseline infrastructure.
> 
> Feel free to keep or drop this patch as you prefer though, I don't want
> to discourage you aiming higher. Just keep in mind that the more you add
> on top the longer it takes to land a patch series :)
> 

I will drop this patch in the next version. Actually, in the very former
version, I didn't realise that the effort to set up the infra is so
much.

> > +	/*
> > +	 * If the ref is a symref, we need to check the destination name and
> > +	 * connectivity.
> > +	 */
> > +	if (referent.len && (type & REF_ISSYMREF)) {
> > +		strbuf_addf(&pointee_path, "%s/%s", gitdir, referent.buf);
> > +		strbuf_rtrim(&referent);
> > +
> > +		ret = files_fsck_symref_target(o, &info, refname.buf,
> > +					       referent.buf, pointee_path.buf);
> > +		goto clean;
> > +	} else {
> > +		if (trailing && (*trailing != '\0' && *trailing != '\n')) {
> 
> In case the ref ends with a newline, should we check that the next
> character is `\0`? Otherwise, it may contain multiple lines, which is
> not allowed for a normal ref.
> 
> Also, shouldn't the ref always end with a newline?
> 

This is a very interesting question here. Based on my experiments, I
have found the following things:

It's OK that regular refs contain multiple newlines. And git totally
allows such case. The current code does not handle multiple newlines.

For symrefs, it allows spaces and newlines, for example:

  ref: refs/heads/master   <space>
  ref: refs/heads/master \n\n\n

But for such case, git will report error:

  ref: refs/heads/master   garbage

And ref can be end with a newline or not. Both will be accepted. Junio
have told me that there is no spec really. So, I ignore multiple
newlines for regular refs and also ignore multiple newlines and trailing
spaces for symref.

> Patrick


