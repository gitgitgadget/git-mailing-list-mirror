Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FF318562C
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613386; cv=none; b=UY0C+hxY4gHbqRf6UYDIEHneCricwp+ipM2WBDOb5BjMbdnIqe+OSONdKnpuLtPLF03snR6sYVkdAQvTFeLDx5wx1AvT8EtqyyOOFTyNjt8gsmyCKrQ1srmqNixoH8/tHle2Zvn9TuJvHFNJeoEv9eT52TqpLeUQmXfEbi2WPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613386; c=relaxed/simple;
	bh=bM6d1clfxvNvmF/2Vs6m6IwVgF1Vcys9ScOWihIQn7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGxoNEaLu5e7XTicaV3wMXu+yYYoT/tPaNGG168gvTEl7sAc53Of0uchYYQnmPzzNkh3Fcls1Gl8MS04Y2NxKejN7mzchm55DD22YRio+guMQutqJOJ5p53XQGSWEKWE/f2VARFi6R8yh/UusUzxTlutLCF2+leasSz+OiGxygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVkyBH+3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVkyBH+3"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70b0e9ee7bcso3845834b3a.1
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720613385; x=1721218185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cz02wSS/NJNoj8WvtWNKBm8QRM32ogMSiVkmx0KrlcA=;
        b=lVkyBH+3ZJTdXqWbGU9XRjkynsjd+L6vTtP2UmLKm74dvPIwS+tel0FMONxj+k+pSy
         yIAZPKpslVjuXGHkjT+o/YiSzmj1PpNUkRh1WMEdX13JFSEfd9EVXiSOM5zUq31/6UtW
         Vzgn6jawDuMuCalwuQ9eQsfEBzgRqYyDdmhDMgRoW1xMejxOILtFooRdpmHHoAmKOvgw
         bD7BQ8wYYCqDFBO/QtEexWqXQNe7WJofO4Md+ip6cjWsw4mYIh5EqPjUgNzMgtDvIEyQ
         b+yQmyVVcG3G1CJVw/k5oT3DwZXK9FbYiJNpExeUlONg1j20kXZhS76ClmsswRd6sx9s
         q4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720613385; x=1721218185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cz02wSS/NJNoj8WvtWNKBm8QRM32ogMSiVkmx0KrlcA=;
        b=XeX442CW4Xk+niWdbXZhSpftxQVreVnlWxw5j00tATatHQWvMrlZQigLwCUTJpyq+p
         GbKO0de0Vy8fe/hiqGgWho/1CTROzvVS1BESFjSEExa0UsOAAeLg10EXpkVs+5gx6n0w
         1VP4CN7Ev6bvgdLpXkiGKJT2PLWUYRSeM/v2+W4uzPa7EMfcEyWEv4SSDld8SC1LQAl+
         LrFuemkcOQR8tZ/AV6E9GRhSpTh9FN/kjC0jyxtCozLTsn/LGGhCe6bwCDXnJ40MicnZ
         OmNsTQnAYo0UptaFgWuIEFR7Risq8WXE+eOlp28JDStw7J422GEdZnqRevVAMbAeAgjf
         WGOw==
X-Gm-Message-State: AOJu0YwlONTyo/igoiSQME9SZ0p45dVqXipbGbtGeyNU+zHJMKhd1oFx
	NxOSZW+cg8adYsIYp4HVo4+Oxener55Kd+SzNXEML+8ggu62YZ7y
X-Google-Smtp-Source: AGHT+IFXCF/II1yZfNEdoYa2GHNuTdZmko/pGr/BGPLNi8YMl3BmGKExbejWl149kRnulfNqxSniOA==
X-Received: by 2002:a05:6a00:3d0b:b0:706:5dfc:7b73 with SMTP id d2e1a72fcca58-70b435660d9mr6779295b3a.16.1720613384438;
        Wed, 10 Jul 2024 05:09:44 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967350sm3610501b3a.103.2024.07.10.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 05:09:43 -0700 (PDT)
Date: Wed, 10 Jul 2024 20:09:44 +0800
From: shejialuo <shejialuo@gmail.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v9 2/9] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <Zo56CEdLdQywXgBI@ArchLinux>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
 <Zo0ufgFhREKlmBFG@ArchLinux>
 <cu3ypjpzpdkazg7w7ho5njcrzvqklzycba3oipwhztlh6lvu6t@wtjew4mj6ku4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cu3ypjpzpdkazg7w7ho5njcrzvqklzycba3oipwhztlh6lvu6t@wtjew4mj6ku4>

On Tue, Jul 09, 2024 at 03:24:50PM -0500, Justin Tobler wrote:
> On 24/07/09 08:35PM, shejialuo wrote:
> > The static function "report" provided by "fsck.c" aims at checking fsck
> > error type and calling the callback "error_func" to report the message.
> > However, "report" function is only related to object database which
> > cannot be reused for refs. In order to provide a unified interface which
> > can report either objects or refs, create a new function "vfsck_report"
> > by adding "checked_ref_name" parameter following the "report" prototype.
> > Instead of using "...", provide "va_list" to allow more flexibility.
> > 
> > Like "report", the "vfsck_report" function will use "error_func"
> > registered in "fsck_options" to report customized messages. Change
> > "error_func" prototype to align with the new "vfsck_report".
> > 
> > Then, change "report" function to use "vfsck_report" to report objects
> > related messages. Add a new function called "fsck_refs_report" to use
> > "vfsck_report" to report refs related messages.
> > 
> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> > ---
> >  builtin/fsck.c  | 15 ++++-----
> >  builtin/mktag.c |  1 +
> >  fsck.c          | 81 ++++++++++++++++++++++++++++++++++++-------------
> >  fsck.h          | 40 +++++++++++++++---------
> >  object-file.c   | 11 ++++---
> >  5 files changed, 101 insertions(+), 47 deletions(-)
> > 
> > diff --git a/builtin/fsck.c b/builtin/fsck.c
> > index d13a226c2e..de34538c4f 100644
> > --- a/builtin/fsck.c
> > +++ b/builtin/fsck.c
> > @@ -89,12 +89,13 @@ static int objerror(struct object *obj, const char *err)
> >  	return -1;
> >  }
> >  
> > -static int fsck_error_func(struct fsck_options *o UNUSED,
> > -			   const struct object_id *oid,
> > -			   enum object_type object_type,
> > -			   enum fsck_msg_type msg_type,
> > -			   enum fsck_msg_id msg_id UNUSED,
> > -			   const char *message)
> > +static int fsck_objects_error_func(struct fsck_options *o UNUSED,
> > +				   const struct object_id *oid,
> > +				   enum object_type object_type,
> > +				   const char *checked_ref_name UNUSED,
> > +				   enum fsck_msg_type msg_type,
> > +				   enum fsck_msg_id msg_id UNUSED,
> > +				   const char *message)
> 
> This is just a suggestion, but I think it would be slightly easier to
> review if the `*_error_func()` renames were done in a separate preceding
> patch. That way the purpose of the renames can also be clearly
> explained.
> 

I agree with this, will change in the next version.

> >  {
> >  	switch (msg_type) {
> >  	case FSCK_WARN:
> > @@ -938,7 +939,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
> >  
> >  	fsck_walk_options.walk = mark_object;
> >  	fsck_obj_options.walk = mark_used;
> > -	fsck_obj_options.error_func = fsck_error_func;
> > +	fsck_obj_options.error_func = fsck_objects_error_func;
> >  	if (check_strict)
> >  		fsck_obj_options.strict = 1;
> >  
> [snip]
> > @@ -166,7 +171,7 @@ struct fsck_options {
> >  	.gitmodules_done = OIDSET_INIT, \
> >  	.gitattributes_found = OIDSET_INIT, \
> >  	.gitattributes_done = OIDSET_INIT, \
> > -	.error_func = fsck_error_cb_print_missing_gitmodules, \
> > +	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
> >  }
> >  
> >  /* descend in all linked child objects
> > @@ -209,6 +214,13 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
> >   */
> >  int fsck_finish(struct fsck_options *options);
> >  
> > +__attribute__((format (printf, 5, 6)))
> > +int fsck_refs_report(struct fsck_options *options,
> > +		     const struct object_id *oid,
> > +		     const char *checked_ref_name,
> > +		     enum fsck_msg_id msg_id,
> > +		     const char *fmt, ...);
> > +
> 
> I think I mentioned this in a previous reply, but it was missed. Not a
> big deal, but it might be nice to document `int fsck_refs_report()`
> here.
> 

I will improve this in the next version.

> -Justin

Thanks,
Jialuo
