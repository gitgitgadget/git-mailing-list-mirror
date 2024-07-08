Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85CEEC7
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452755; cv=none; b=VoNSsNMPBYYMNbZSKiVRxy9mzqtg0Y3yChagLQveydcjAik+iz31FRKAZMGjrpaoGFJ3DyTOHFgKrKIvUBIqbanoiV62cbx3XkLFnTTooTwC36L33xyWz1LrgFq+9fOJjzKg4zlcRG9bsU49a/2oNmP29dOdEakbYTUK8+zwps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452755; c=relaxed/simple;
	bh=H0doF3Z8Aq/Kynq6UGWoLnOk4HpIJAG8zDp4hQfqqRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU2wYPPhq/GBk6kOJ0yMyJn86fTDAIdHDjjtTz1qDIizk5EibcOkchxAtCzcb04a99wDgRlndSpaWl3+f4JCUptCrjrJWbZpR89lurndR8a4sjClsPqds+oZ7WJeQ+Mfjf9fGjjNBl2zIXZuXpfLrrPl3w1iRb9Jf17DGAEydCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTer/66G; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTer/66G"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fb3e9e32ffso15643045ad.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 08:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720452753; x=1721057553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKIY6XEcFPBfFd8+OxU9LoGwhVVI2eJAsM5/lLzjqNA=;
        b=LTer/66G9iB6ix0AByNl4FynSFacPG76E1CGo0wEZsTnElXJCYihszcpj982wrIYb5
         9c1dXs125ggtxh/2lwDsuCS0V5jCjn0MqK4fbSC5R/DjqWnMQxRKdfmYIJOlNpm0tvte
         q10q8svx9gZaIcIpnROAmW8IlE2xU4K40RCv6Y4mCVLxALm4OJ6bmgP7KTYvUOxq2aWD
         CZz/1iTgIpHLTGbww4wmT+3tGh9yuvrJ+Bb2f8FKuJqUENZ9JjGxheQwheEPo6yRweOI
         9ZEcl1Y7wH89b5vxvNjhqOImQsm4eTqNVHQFiAncu1iTPJJbVSDu4oWQc7A0EKfQJ5TF
         ZqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720452753; x=1721057553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKIY6XEcFPBfFd8+OxU9LoGwhVVI2eJAsM5/lLzjqNA=;
        b=ks0g8zRkZQ7eVQfPdpgvdvcRRlwkuIrXkB2rKlOHwZTzzdJ4EHUOR3aV+lvKSO8uzO
         0wBgvJrKxoL//1lhJwmd/JK+KUvdUabDd/574y9qOlWeq5ui8FKrPWxbIEiHUAMmuKQT
         TfP3/KPPVEALIaZco/MAfCLSwb32OmjPLGBuNOGJngULB5B3EMJ7Zw1iF+Kb0VzF7fgb
         iJYnoTct3HW6WsRoe5TgZw3pzHunpYx7Umf0ssnOJBGZKanZ1IGOY7lZ7qw+mI954IkS
         xfaXh1UJXuzC9paR1hjsIgzZjH2z41AVxOZq1SHNQfRV/n845IkO3k8o2fsAu/1025aw
         iLgQ==
X-Gm-Message-State: AOJu0YzJ0/N+agWQ9lGjkCHutL1lVHlBWdRHdfAF4T3WzrXU+c+mZJ9w
	HEZSoo0QkVv6mCgIzGHZPjq63Pe92ONi3ZViDGMMfZTS20SVyBliBKYMHw==
X-Google-Smtp-Source: AGHT+IGJG7hn3pqfmvZ4C/WNhCJHAy1CI0C3/yC8u99SjsLbU2lkeIVvfgjThAJgUESHpwNzThYPfA==
X-Received: by 2002:a17:902:e546:b0:1fb:6ea1:5e with SMTP id d9443c01a7336-1fb6ea103c4mr29484125ad.44.1720452752810;
        Mon, 08 Jul 2024 08:32:32 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb2845c7aesm86925445ad.179.2024.07.08.08.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 08:32:32 -0700 (PDT)
Date: Mon, 8 Jul 2024 23:32:31 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v8 3/9] fsck: add refs-related options and error
 report function
Message-ID: <ZowGjztkmQnUkD5w@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
 <ZovrI1yRmS0X2BHu@ArchLinux>
 <CAOLa=ZSgZMmfJWcPdKYyLrO-Mo0G-TKj3pYRREjvLt_ypuEk6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSgZMmfJWcPdKYyLrO-Mo0G-TKj3pYRREjvLt_ypuEk6g@mail.gmail.com>

On Mon, Jul 08, 2024 at 07:49:43AM -0700, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > Add refs-related options to the "fsck_options", create refs-specific
> > "error_func" callback "fsck_refs_error_function".
> >
> > "fsck_refs_error_function" will use the "oid" parameter. When the caller
> > passes the oid, it will use "oid_to_hex" to get the corresponding hex
> > value to report to the caller.
> >
> > Last, add "FSCK_REFS_OPTIONS_DEFAULT" and "FSCK_REFS_OPTIONS_STRICT"
> > macros to create refs options easily.
> >
> 
> Carrying over from the previous commit, couldn't we simply do something
> like:
> 
>     diff --git a/fsck.c b/fsck.c
>     index eea7145470..32ae36a4fc 100644
>     --- a/fsck.c
>     +++ b/fsck.c
>     @@ -1202,17 +1203,33 @@ int fsck_buffer(const struct object_id
> *oid, enum object_type type,
> 
>      int fsck_error_function(struct fsck_options *o,
>      			const struct object_id *oid,
>     -			enum object_type object_type UNUSED,
>     +			enum object_type object_type,
>     +			const char *checked_ref_name,
>      			enum fsck_msg_type msg_type,
>      			enum fsck_msg_id msg_id UNUSED,
>      			const char *message)
>      {
>     +	static struct strbuf sb = STRBUF_INIT;
>     +	int ret = 0;
>     +
>     +	if (checked_ref_name) {
>     +		strbuf_addstr("ref %s", checked_ref_name);
>     +		if (oid)
>     +			strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
>     +	} else {
>     +		strbuf_addstr("object %s", fsck_describe_object(o, oid));
>     +	}
>     +
>      	if (msg_type == FSCK_WARN) {
>     -		warning("object %s: %s", fsck_describe_object(o, oid), message);
>     -		return 0;
>     +		warning("%s: %s", sb.buf, message);
>     +		ret = 0;
>     +		goto cleanup;
>      	}
>     -	error("object %s: %s", fsck_describe_object(o, oid), message);
>     -	return 1;
>     +	error("%s: %s", sb.buf, message);
>     +
>     +cleanup:
>     +	strbuf_release(&sb);
>     +	return ret;
>      }
> 
> 

However, "fsck_error_function" will be used as the callback for
object-related checks. I don't think we should use one function to
incorporate all the situations.

For example, if we pass both "checked_ref_name" and "oid" here, how does
this one function knows whether we handle refs or objects. Although we
may use some flags here to choose the different situations, it's bad
idea from my perspective. Adding a new callback here will be cleaner.

> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> > Signed-off-by: shejialuo <shejialuo@gmail.com>
> > ---
> >  fsck.c | 22 ++++++++++++++++++++++
> >  fsck.h | 15 +++++++++++++++
> >  2 files changed, 37 insertions(+)
> >
> > diff --git a/fsck.c b/fsck.c
> > index 7182ce8e80..d1dcbdcac2 100644
> > --- a/fsck.c
> > +++ b/fsck.c
> > @@ -1252,6 +1252,28 @@ int fsck_objects_error_function(struct fsck_options *o,
> >  	return 1;
> >  }
> >
> > +int fsck_refs_error_function(struct fsck_options *options UNUSED,
> > +			     const struct object_id *oid,
> > +			     enum object_type object_type UNUSED,
> > +			     const char *checked_ref_name,
> > +			     enum fsck_msg_type msg_type,
> > +			     enum fsck_msg_id msg_id UNUSED,
> > +			     const char *message)
> > +{
> > +	static struct strbuf sb = STRBUF_INIT;
> > +
> > +	strbuf_addstr(&sb, checked_ref_name);
> > +	if (oid)
> > +		strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
> > +
> > +	if (msg_type == FSCK_WARN) {
> > +		warning("%s: %s", sb.buf, message);
> > +		return 0;
> > +	}
> > +	error("%s: %s", sb.buf, message);
> > +	return 1;
> > +}
> > +
> 
> We don't free strbuf here.
> 

Yes, I made a mistake here. I should not define the "sb" static, will
fix it in the next version.

> >  static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
> >  		      enum fsck_msg_id msg_missing, enum fsck_msg_id msg_type,
> >  		      struct fsck_options *options, const char *blob_type)
> > diff --git a/fsck.h b/fsck.h
> > index f703dfb5e8..246055c0f9 100644
> > --- a/fsck.h
> > +++ b/fsck.h
> > @@ -135,11 +135,19 @@ int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
> >  						   enum fsck_msg_type msg_type,
> >  						   enum fsck_msg_id msg_id,
> >  						   const char *message);
> > +int fsck_refs_error_function(struct fsck_options *options,
> > +			     const struct object_id *oid,
> > +			     enum object_type object_type,
> > +			     const char *checked_ref_name,
> > +			     enum fsck_msg_type msg_type,
> > +			     enum fsck_msg_id msg_id,
> > +			     const char *message);
> >
> >  struct fsck_options {
> >  	fsck_walk_func walk;
> >  	fsck_error error_func;
> >  	unsigned strict:1;
> > +	unsigned verbose_refs:1;
> 
> Nit: Here we have the subject 'refs' towards the end of the name.
> 
> >  	enum fsck_msg_type *msg_type;
> >  	struct oidset oid_skiplist;
> 
> but here we have the subject 'oid' at the start of the name. Perhaps we
> can rename this to 'skip_oids'?
> 

I agree. "skip_oids" will be more meaningful. I will fix it in the next
version.

> >  	struct oidset gitmodules_found;
> > @@ -173,6 +181,13 @@ struct fsck_options {
> >  	.gitattributes_done = OIDSET_INIT, \
> >  	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
> >  }
> > +#define FSCK_REFS_OPTIONS_DEFAULT { \
> > +	.error_func = fsck_refs_error_function, \
> > +}
> > +#define FSCK_REFS_OPTIONS_STRICT { \
> > +	.strict = 1, \
> > +	.error_func = fsck_refs_error_function, \
> > +}
> >
> >  /* descend in all linked child objects
> >   * the return value is:
> > --
> > 2.45.2

