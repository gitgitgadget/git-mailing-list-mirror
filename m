Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC53B1A4
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091982; cv=none; b=m9+DUjmnDLPkt4zBu2MNTTrU6bzDjFsGnMJziAzv0M/xQN9ChHF11YUucDz05nTjPIUDGWOF1Tt17bp72l0H3RCqu/SYR/eFnCYdPy1tHrNwtjWIHydM7YJP7LB5qOirPdS08ZH5YF5Eg3SgIro8fBS0yzIPezJ+40Z41fDO07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091982; c=relaxed/simple;
	bh=o3E1fPmSW6PZmZs0dYY1NcR6xlF9X6ar+FrxxCofOAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTCa7pFW26YziR35fU7b7ADhq/LG9VdiXi0kQtoEH0XAaAKWcu/XzX0nes/BTVoAG/a0TSZK+fcKj4gT3tfrhzQlykn+wOAg2x++OotHkTgV0L5WKTA7BWhars5+M1vgjY97YBGBDNwxdwXf0cclYbj3KelOKdLx0GR0RbH/XWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPstc5dk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPstc5dk"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d316f0060so3766340b3a.1
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 11:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724091980; x=1724696780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsQAApa8ICAkULxFGOG0o9SfyTYZ03V+eKV4bolQkWw=;
        b=gPstc5dkQnRbEiMwoU+7d+7vx4qzgJJZ+jESAtD7YokAE3g+I9bNtC4KLQz+9MScaf
         3NdCoXQN+FhDw6qufLYE4jyh3HF/HAuo5xaRdT1BlYo/vA3Agf/RWy8RSapEpEOTxv6m
         LI2E6WtgO6fsNbz7WYl2Qfle3k0HuxHkEj21G6lhju8Qy/c6EHxc3xKtyYAs5z79LFVD
         ng1AXheUHXjzBI0FSOHEyQqKkZI13xW+SUyUmkcducLCOxtixEYj3R4jfg7J4TnEqE9d
         jp9GYP3Hy9rEdwqIo1N+9dM/x62y5HwVFmORuu9f9e0Hrh92VrdX05BsuQoxFMbb9lBz
         aL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724091980; x=1724696780;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsQAApa8ICAkULxFGOG0o9SfyTYZ03V+eKV4bolQkWw=;
        b=FzzHU84Z9eNQE/4vNZld0c8RZtv8S1DKj9XGQxHpRE+pk2a3xxhIFBBjsVUyayYqub
         tSzCOriRtiXtfp4guiwhUd8xk/9Tc7sgxlKuouT0F0dVSKzCL+7txaCPitZTJSwc9m+S
         bVezbKMKcqcxEWsx/hT8/HCs6KnhtzSf69HO8jiwGAM6q4UinfG0BD1/wykus3r0wJM6
         +X8TahvPSJwiX7w6eQeXFujLwKBwxK3Sl1xtAqCFD/4slGYnaEVyKpKVAbwLDjqCIJ5U
         /AmP5EWyH6xgYGTlg1IFThnI7QruYQ2b7dDN+rVWu46ze7CN/Goi9FC+T4MiFz5NHnga
         Rgkw==
X-Gm-Message-State: AOJu0YzwErxyp0BwhCKE/jEVBrmnr3QJMMEeMGCfYZRvV304folz+jpL
	kTxtE/YgwfN8hI9N4KQZbrIdLrhuyxk55cjIRMAoQlUjRSbTlVl6B2OufzuCoNA4dtLseglU2X6
	BCw==
X-Google-Smtp-Source: AGHT+IHqyv0MJMGgQPHg+n93TeOY/RbM9KqN7MgIfDN4qFlF0HHD+6qJjhAVMEomneM1aLEpdKl8Tg==
X-Received: by 2002:a05:6a21:399:b0:1c4:d14f:248f with SMTP id adf61e73a8af0-1cac7016ba8mr657841637.13.1724091979488;
        Mon, 19 Aug 2024 11:26:19 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:e4c6:64d5:ef4d:ec80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0739dsm6872127b3a.61.2024.08.19.11.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 11:26:18 -0700 (PDT)
Date: Mon, 19 Aug 2024 11:26:13 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] fetch: add top-level trace2 regions
Message-ID: <erfaq73yp2w2kblymuuohxuj535j5dixdildwhnomv7sfcd2z2@gbtrvnztgkgj>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1723747832.git.steadmon@google.com>
 <c0481f85f8166e520c387f9e9157b142b93d933c.1723747832.git.steadmon@google.com>
 <xmqqh6blsh43.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh6blsh43.fsf@gitster.g>

On 2024.08.15 12:47, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > -	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri) &&
> > -	    fetch_bundle_uri(the_repository, bundle_uri, NULL))
> > -		warning(_("failed to fetch bundles from '%s'"), bundle_uri);
> > +	if (!git_config_get_string_tmp("fetch.bundleuri", &bundle_uri)) {
> > +		int result = 0;
> 
> This needs no initialization.
> 
> > +		trace2_region_enter("fetch", "fetch-bundle-uri", the_repository);
> > +		result = fetch_bundle_uri(the_repository, bundle_uri, NULL);
> > +		trace2_region_leave("fetch", "fetch-bundle-uri", the_repository);
> > +		if (result)
> > +			warning(_("failed to fetch bundles from '%s'"), bundle_uri);
> > +	}
> 
> It is a bit sad that the concise original with straight-forward
> control flow had to be butchered like this to sprinkle tracing code
> in it, but I guess that cannot be helped?  I wonder if it becomes
> much less invasive and more future proof to define the trace region
> in the fetch_bundle_uri() function itself.  Has it been considered?

Moved to fetch_bundle_uri() in v2.


> > @@ -2407,6 +2412,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
> >  		struct oidset_iter iter;
> >  		const struct object_id *oid;
> >  
> > +		trace2_region_enter("fetch", "negotiate-only", the_repository);
> >  		if (!remote)
> >  			die(_("must supply remote when using --negotiate-only"));
> >  		gtransport = prepare_transport(remote, 1);
> > @@ -2415,6 +2421,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
> >  		} else {
> >  			warning(_("protocol does not support --negotiate-only, exiting"));
> >  			result = 1;
> > +			trace2_region_leave("fetch", "negotiate-only", the_repository);
> >  			goto cleanup;
> >  		}
> >  		if (server_options.nr)
> > @@ -2425,11 +2432,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
> >  		while ((oid = oidset_iter_next(&iter)))
> >  			printf("%s\n", oid_to_hex(oid));
> >  		oidset_clear(&acked_commits);
> > +		trace2_region_leave("fetch", "negotiate-only", the_repository);
> 
> OK.  Both error path and normal path we leave the region we entered.
> 
> A complete tangent, but do we have an automated test or code
> analysis that catches us if we forget to leave an entered region
> (i.e., imagine we didn't leave in the else clause after issuing the
> warning---we remain in the region in such an error case, even though
> normally we leave the region correctly)?

It's been discussed before [1], but the general feeling seems to be that
it's not worth the effort / test runtime.

[1] https://lore.kernel.org/git/xmqqbka27zu9.fsf@gitster.g/
