Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947822081
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733041194; cv=none; b=fwxrv5aBpKYhBUZNfu9AvecjCLKzivyFrIM+/aQMQO2KYfI90M3TQpHCTrdCy/odIzxCJvCzWP6vBOZq6PKT6uKewuvgdYAv8E1JSRFpnj9a6ZvL368coqNkZpK1T7QDgsHf2uGb693Z8UoL0GPXQvkydr1R0gpK3U+S9HUVK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733041194; c=relaxed/simple;
	bh=pa5HQsQjxoaF4Bt8AqiZS+eEzwNyPmowNtfBg909LDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCU+fGP1MKW5OpEKuDapQ0/pMUbHy+1SsurD03BDNuC3cCUivlhQA0W+amQIvZfKDbsVRm/8Ct7I9iJpYqA9UBXspI1REitr7TQtNVsI5lV//01JFfwqvY/BWHT+Tv6OK6veyb3iwHtFlqNt9q0Xro6hbHKTPwDUf+enNwRsXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxtPxB4v; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxtPxB4v"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee69fc0507so1350536a91.0
        for <git@vger.kernel.org>; Sun, 01 Dec 2024 00:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733041193; x=1733645993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hHSjbUnx5wlX0PRSVSyipFSSGbqHV8+r1IVfGa1Ih0=;
        b=RxtPxB4vJK/elry60NcwwotEKOrgr7qv3P98u+0dAMCuLyEr+j4yfCQCl4VMOJsUg4
         7PajKtLI+vnvLmpMJ31sIjRAVk3BTpWEihOf9eqM24XWezM9WVDS9gaLveSlYT5e1zfl
         /jg4qwEqifv7pOYmufD0abVtX0PIMIB94yjE4D+xAY7R/Lm8TMG8Rz0ZAFgu/GckIeJb
         WhuLZyUVw09ZXnL6Ly3iqM/GAnDee7QfHC6BIVQonH68NUiSKxNY3wcg7vLufk5+D1av
         qU4NijAPda0HwaHPGMWvGY5Py6zgI+Hcw0asg+DeZ9+s4PieLqwLWQLCdeROOeC0tE09
         +/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733041193; x=1733645993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hHSjbUnx5wlX0PRSVSyipFSSGbqHV8+r1IVfGa1Ih0=;
        b=cYTZN+MbIM1TEgCszAuQo/ElHpgSSSlDGcLCsdrY6Bdp1gdwtNYIcV5EpB7sy8oMYO
         g4bBfa4YY0sn8V0FBCiW3leArEoN8NhFu4qq5MhldF0W9swd4PDsBcZto0kVuH3UuRVG
         teUnUZ2gY4jqGOkAG4Sthpx2UtX1qy1H/DCdFT+YsAKQ6RCg8UG1+lPSfTQUhJklFKHn
         6/iz+Mds1c0ScVDfKSsKB/fQgEwmgmxXbO7VO/Qx7I2o7On9Qp2mBQ1E6LqdwBCU9pmA
         ioeHTYgkA9I/k618mzdi+rXaMT/X041dNLlOWTmrgLh0tyCMu8m8rmJuiNbyuuECtU4Y
         zrqg==
X-Forwarded-Encrypted: i=1; AJvYcCUjEN7hGgvaz95RIIa4XLrvfucH3GZp+vglgMhrFte67OObAnKibOQxt2APnRnaoZbrEw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJzKEbrEi0+s3UVqtAuxLcCQ8uGQsk9z/YuxsCpU2PkXX4oOd0
	xh6vxicr9QN/Ra7Y3E6uZjA0OtluHFW1O6tQpzcurg3XIn0sv3VeAvbtFQ==
X-Gm-Gg: ASbGnct+MqoP62QxHQECXBhf+XzqcAXfBW3Fx7vk41TNWiLbiVqYZA4s4FQ8SKNybrx
	56EtUYTDLTd9jSUNfnmvXwTtmQtUWCvzMMT8xr6shRXPm/rVR5YMK+PsfgUmo525AOzVq+rtIx+
	EedZWAs2EVBFWETNDrAwNf2lORCyB2XfYrR1YcWvBeehNFyVwwhWDpi0m7Ce21Lzmq5CQ/Ip2V7
	+HbK4uB4Da0T1rDOTBS1YWe66dWX4Lo8gDQlWoH5T/NoY1cpJs=
X-Google-Smtp-Source: AGHT+IGXpzvXKfJgp7SnLfBBbHYOHYxBZS3K9hrQASCgNOOd7pbFCrPty5ol2ktqVXKlUdkdFEwjvg==
X-Received: by 2002:a17:90b:3887:b0:2ee:acb4:fee0 with SMTP id 98e67ed59e1d1-2eeacb500d4mr2324017a91.16.1733041191202;
        Sun, 01 Dec 2024 00:19:51 -0800 (PST)
Received: from five231003 ([2405:201:c006:3236:84ae:420:d0d6:11c0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee5a8a7f5csm4033153a91.14.2024.12.01.00.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 00:19:50 -0800 (PST)
Date: Sun, 1 Dec 2024 13:49:46 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: add "notes" atom
Message-ID: <Z0wcIgL8++gm4kt+@five231003>
References: <D5N39IJA0WDQ.2WH1MNIP77X2J@ferdinandy.com>
 <xmqqsersyrch.fsf@gitster.g>
 <D5NP6QUUBWBL.7OUG34RUIE2S@ferdinandy.com>
 <Zz4Wr1YY7HxRARoc@five231003>
 <xmqqserlh3ak.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqserlh3ak.fsf@gitster.g>

On Thu, Nov 21, 2024 at 08:51:47AM +0900, Junio C Hamano wrote:
> Kousik Sanagavarapu <five231003@gmail.com> writes:
> 
> > +static void grab_notes_values(struct atom_value *val, int deref,
> > +			      struct object *obj)
> > +{
> > +	for (int i = 0; i < used_atom_cnt; i++) {
> > +		struct used_atom *atom = &used_atom[i];
> > +		const char *name = atom->name;
> > +		struct atom_value *v = &val[i];
> > +
> > +		struct child_process cmd = CHILD_PROCESS_INIT;
> > +		struct strbuf out = STRBUF_INIT;
> > +		struct strbuf err = STRBUF_INIT;
> > +
> > +		if (atom->atom_type != ATOM_NOTES)
> > +			continue;
> > +
> > +		if (!!deref != (*name == '*'))
> > +			continue;
> > +
> > +		cmd.git_cmd = 1;
> > +		strvec_push(&cmd.args, "notes");
> > +		if (atom->u.notes_refname) {
> > +			strvec_push(&cmd.args, "--ref");
> > +			strvec_push(&cmd.args, atom->u.notes_refname);
> > +		}
> > +		strvec_push(&cmd.args, "show");
> > +		strvec_push(&cmd.args, oid_to_hex(&obj->oid));
> > +		if (pipe_command(&cmd, NULL, 0, &out, 0, &err, 0) < 0) {
> > +			error(_("failed to run 'notes'"));
> > +			v->s = xstrdup("");
> > +			continue;
> > +		}
> > +		strbuf_rtrim(&out);
> > +		v->s = strbuf_detach(&out, NULL);
> > +
> > +		strbuf_release(&err);
> > +	}
> > +}
> 
> I suspect that this was written to mimick what is done for describe.
> 
> The describe codepath has a (semi-)valid reason to fork out to a
> subprocess, as computation of describe smudges the object flags of
> in-core object database and it is not trivial to call into the
> helper functions twice.
> 
> But showing notes for a single commit is merely an internal call to
> get_note() away, so unless the note object is not a blob (which
> should be absolutely rare), spawning a subprocess for each and every
> ref tip feels a bit heavier than acceptable.  We'd probably need to
> maintain a table of notes_trees, one per <note-ref> used as
> %(notes:<note-ref>) in the format string, and init_notes() on them
> while parsing the atoms, and in this codepath it would be a look-up
> of notes_tree from the table based on the u.notes_refname by calling
> get_note() to learn the object name, plus reading the object
> contents into the v->s member when the note object is a blob (and
> fallback the above code when it is not a blob, which is a rare-case,
> if we really want to handle them).

Hi,
I was supposed to send a v2 a lot earlier but due to time constraints
(my semester is ending and there's work related to that) I've not been
able to work on this.  So if anyone is interested, they may work on this
and submit v2.  I personally think this format would be a nice addition
to the ref-filter framework and Junio's msg above gives a really nice
explanation on how to do things.

I will work on it in the earliest when I find time but just in case
someone else is interested, they may pick this up and work on it.

Thanks
