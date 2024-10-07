Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22017279E
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728343869; cv=none; b=u+h9tyWobMXt2tkYk2vfGoFyQw2COtSgwfaoVuvnwJQD93sT9wTAnAyiLYMQzrus0GmSb0aQO95IVJtM/iWEbR7BKq0SSKh5/4odAaPC/v9lkyDn/Wm1rjTva1SQ/G7VSUyMP+f0NP9w2u6b23Xg40cc15iB2rJSLziQhjEXaUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728343869; c=relaxed/simple;
	bh=pkftUGNVFsEisPPuO1v64EgBVKbmWiIvwwZ7muiv3RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNlt4w9DYz45cCJKN54/BGGg4AjOir1ffcC1jcmcTK8Cuea6gbtPKne45SmhgxcSfNXh6f+Yt9J/Xvnu0pMAB2JYAk+4Xh/nqKUFRePhIIbt5NeKF3LIj+vxD1qNRnOUC0kp273nR2gMZTMxTBRvKbReZ3ulf0pREVh1K1B8bQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rZBuEfOn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZBuEfOn"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b3d1a77bbso87275ad.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728343866; x=1728948666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvCvjIcXr5Clua5toMXg2s8L13nJ3TZnjL4le0OVIMk=;
        b=rZBuEfOn4U/g7aKuoZbHcWThpHVup8GdPo5ZffoDTdnnY43Yjc+xFfxXHshSBr2Lj7
         GX4FxjnWLxN9LBW2o1ZRxqYq1kU9/BwN6AZtK/JbfCRBCij/5ytLnVx3XH133w5JlUZC
         sE4oR1JesH9YDMLfjy3kwj+Zo313pMnd7Cnr3yx3i9CK4h+GfpUj5e9wZhgQD728wL9n
         W/e+6qSTZHFegmwFh3XAnM1ynCxzxhRZLee1tYTvVlAxFQOD/hMrmyPXbqd3FgGEEv57
         StlRcfvVMZ2wSV1sFFx0lbAh936A9L/+5GDttRbIvHNZ7bJlotRwgAIHVZfatjWhNSpo
         GFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728343866; x=1728948666;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvCvjIcXr5Clua5toMXg2s8L13nJ3TZnjL4le0OVIMk=;
        b=LmJ6KYgHYT+LgwbtPw6JUePwI4Q9JvuwPqqoy9x23apGAaog6JdIv+DczJA2MrJ7Ce
         svrq0aMkErz6+XqFRfpTuCarWr5wTAG9WA9eHYP4NWlN6SAD9lcwZXZaG6pK1XLY3Z84
         lFNJikH+EbmelGTJ1pqsM16LwYfMsChq6Ogouj826M/2/obGGa3NC8LTdJ1gMn4sX9K8
         qO0vx5r0pLIndEPWDk8JQBVPfF7v0OzfW0J5XeohmfLbeMdWbqKZk4RfODQ+iDOQPeeD
         Z5IEG8PhRVncjAAUF0mHtod9iB9wpBPpLEEFnAcKsG4SHGqFbteZixRbrDE4oWp51nhn
         36GA==
X-Forwarded-Encrypted: i=1; AJvYcCV+tQkfIuzbO6eoltQCq1nw4uEdI9go56DWhyOjYfJwkTL6UJYM6nRpZHO8exCIziXmlpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpgQh4VEvbzbqyzkmmd2Izbu1P3WgxkHwedxT9Fr/Ff811CjJS
	csgicjGip3D/7QpLl3G8LbeFYzoq/gY1p8n/utw8JPE7SUVpLUEv/uPHUcVeZw==
X-Google-Smtp-Source: AGHT+IEzwdYIWQBIFMiyDlpY72+grEdwP8agoqyVc+k5Ll5UMr3oZFaPX+B2WTkcU5rnJtVOe3b2nQ==
X-Received: by 2002:a17:903:41d2:b0:206:9e8f:7cb with SMTP id d9443c01a7336-20c4ff9e95amr1244065ad.2.1728343866198;
        Mon, 07 Oct 2024 16:31:06 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:2b15:5dbe:c4f0:bf3f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4780fsm4938343b3a.124.2024.10.07.16.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 16:31:05 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:31:00 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com, 
	dsimic@manjaro.org, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/6] libgit: add higher-level libgit crate
Message-ID: <paya2jpm67x3zfkwtttcjrkfe7ai63ez3scrtarbdolkcmxvbq@yant6zn63p4z>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com, 
	dsimic@manjaro.org, phillip.wood@dunelm.org.uk
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-5-calvinwan@google.com>
 <xmqqv7z8tjd7.fsf@gitster.g>
 <xmqqcylcpnah.fsf@gitster.g>
 <CAFySSZBECCQafaLEv80WoK6SMovwC97-tf9gh_btPc+8OuP4NA@mail.gmail.com>
 <xmqqttene2ya.fsf@gitster.g>
 <honvpowfa6zze7p56pcefrzokjjawcc43du7vuxbdbjbv2vzlv@eskr2npegzxd>
 <xmqqo74kj4ys.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo74kj4ys.fsf@gitster.g>

On 2024.09.18 09:34, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > We want to namespace types as well as functions, as Phillip pointed out
> > in 47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com.
> >
> > Is there a reason why we need the shim struct from your
> > xmqqcylcpnah.fsf@gitster.g and can't just cast directly like so:
> > ...
> >  int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest)
> >  {
> > -       return git_configset_get_string(cs, key, dest);
> > +       return git_configset_get_string((struct config_set *) cs, key, dest);
> >  }
> 
> Not at all.  I just didn't see your intentions in the patch if all
> you wanted to do was merely to flip names, or wanted to leave the
> possibility to allow the wrapped ones to optionally have different
> shape (e.g. for bookkeeping purposes for either the host environment
> or the shim layer).  If it is merely "we do not want to expose these
> names but we want bit-for-bit identical data", then you do not need
> extra logic at all---the casts would be suffficient[*].
> 
> PS. I am not feeling well today, so please expect delayed and/or
> sparse responses.
> 
> 
> [Footnote]
> 
> * Building objects that go to libgit.a, partially linking them to
>   resolve internal references, and then rewriting the symbol table
>   of the resulting relocatable object file to expose only the entry
>   points and data you want to show to the rust world to whatever
>   names you want, would be a less gross solution, I would imagine.
>   You only then need to write a (fake) public_symbol_export.h file
>   that will never has to be seen on the C side, but to be seen as
>   the header to describe that C library to the rust side (and
>   obviously you do not need public_symbol_export.c file only to keep
>   these casts).

I don't think I'll have time to experiment with this approach for V4,
but I'll put it on our list of future work. For now I'm just keeping
public_symbol_export.{c,h} as-is and casting to avoid exposing the
unmangled struct name.
