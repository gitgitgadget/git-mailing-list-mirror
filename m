Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E539F224CC
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 04:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719548553; cv=none; b=RZdSkojwUdU/eDYrNqYsw0DHXudhMjijjgBKPsqjZ6/r69He0MSerJ/dqJd8lrDTri2m06udLpfKm+9ErmVtgbE0HnYwGorO+BhRBPYqGzo27qwzsI1zXTS8c1nT5SmkbULY32zLOuYjawj3RqxVHkcxOdksxP6Ml2ZdZJebQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719548553; c=relaxed/simple;
	bh=mQCsV4HXz4O2+0xNDFntpzI/8unU1tryEeOjYAwTsn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I53ldeEmUfOuqkUYWFFz75yMcoAVsk3/j8goqDRuqYY7sBnBfCGwBB39NeAw9XnWiQx8toIXmwSRGH8NWZeei/q/Vm8SWqlbkzYOwH15bCSp1zbLB/8rTcF0XY9OKdheiUvn5+XL89Uw0aXRxFdbQGnij3f3g09+U7VySfkdlq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOeYjdLu; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOeYjdLu"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5c21c68b786so82266eaf.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 21:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719548551; x=1720153351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n0dlMxhovSMY/j6KUaqXoYJzJt8b0wGBbeNGg1lohNU=;
        b=aOeYjdLua9ZksySe1eJZmI5/irjCdjasWgzjYHd0qbo55Yvi27qxmORzODabCBiRr9
         aLUaWgDfMdO+nsneybTB1fTWmR9v3wADGQC4PxL1UEbGOSr/pgZeyax+Zz6auvlPmEBX
         Yn2yEm2T134cUky0EJuXfetBVfX3eG1V9x4/c1wwEWqiDxD7TlNdZOo5+u0Tl4mHlLpw
         mx99IHeHrck/QIqCIN0CUhtRgEPYTiTKiAVEKY9OZIluEO1IR+nb/qEHFdaWClq49qxV
         rnnsUbMlur3XNwd8Kqq6q/rOqcTBlxEe2BWW54673erJJSNK430lyR7vU+YVrztIcvmE
         paTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719548551; x=1720153351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0dlMxhovSMY/j6KUaqXoYJzJt8b0wGBbeNGg1lohNU=;
        b=OKZnTOHuHvsK08syn6t4G3b0rzHMzpTh8d1cXokz9x0Daf+8S4aJ8s4Egv5DMFXC7e
         CYXIICb3/ndOqreps/NNfALpQ35G4YHUGFaNcKjgFccDR1wLQq/07jaUsOqx4DkLwae9
         vVH1nco8EirQ82fd/VmEzP8+MbBsJQarbOhj3pObteooQH6NF39ZMpjz0bBKYNUK7opW
         NLMo/Fm/kDIrNuXGO6PbbRJZw56ORdpQwCHuz00a2UMNLsu0Tc9jgfl5fdWsxcq156r2
         hXnUvobK8WiRFMDngh6iEbqZ27TdiR0jOo4LhI6O7xqOuUHsPlByQ2gJcJF2DK/Yj2+y
         bu+w==
X-Gm-Message-State: AOJu0Yzjw688snwzquXHgfXLxyLx13B6zhs5jBqn+VI57Sk1IneQa3Bf
	Sttah/YqIGTsunkYtDvkMp47uSv+r9Kwzm24U4jJDowXJNPjuWu4
X-Google-Smtp-Source: AGHT+IFQO+W25IxUr1cCofwviCmf+Z0FyQjHnE62ZhQOM4eWDmlXRCocyD924Al2RZWRcVyhJAHLRQ==
X-Received: by 2002:a05:6358:430f:b0:19f:2785:13eb with SMTP id e5c5f4694b2df-1a23c180f67mr1697895655d.19.1719548550772;
        Thu, 27 Jun 2024 21:22:30 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac157b3b7sm5559185ad.242.2024.06.27.21.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 21:22:30 -0700 (PDT)
Date: Fri, 28 Jun 2024 12:22:28 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v5 02/12] fsck: use "fsck_configs" to set up configs
Message-ID: <Zn46hGUqz1ZtUpGz@ArchLinux>
References: <Zn2Ah3WDhtOmzrzn@ArchLinux>
 <Zn2BgEw0geZwvr3_@ArchLinux>
 <xmqqzfr6qcx8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfr6qcx8.fsf@gitster.g>

On Thu, Jun 27, 2024 at 02:43:47PM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > Some fields such as "msg_type" and "skiplist" in "fsck_objects_options"
> > are not options, these fields are related to "git-config(1)" which are
> > initialized using "git_fsck_config" function.  Create a static variable
> > named "fsck_configs" in "fsck.c" which aims at handling configs. Thus we
> > don't need to reply on the "fsck_objects_options" to set up the fsck
> > error message severity.
> 
> reply???
> 

Sorry, I often make mistake to type "rely" as "reply".

> As configuration often is used to prepopulate options, I need a lot
> stonger justification to split these into a different structure than
> "'config' is a noun that is different from a noun 'option'".  
> 
> If we intend to have many "option" instances but what these two
> members store will be the same across these "option" instances, for
> example, that would be a lot better reason why we may want to
> separate these two members out of it, but I have a suspicion that if
> we were to use the "union with tags" approach, these two would
> become members of the common part shared between "objects' and
> "refs", i.e. the overall data structure might look more like this:
> 

Actually, I feel really wired for this part. Let me elaborate on this.
"fsck.c::git_fsck_config()" is used to set up the configs. It will
eventually call the "fsck.c::fsck_set_msg_type_from_ids" like the
following:

  void fsck_set_msg_type_from_ids(struct fsck_options *options,
                                  enum fsck_msg_id msg_id,
                                  enum fsck_msg_type msg_type)
  {
    if (!options->msg_type) {
      int i;
      enum fsck_msg_type *severity.
      ALLOC_ARRAY(severity, FSCK_MSG_MAX);
      for (i = 0; i < FSCK_MSG_MAX; i++)
        severity[i] = fsck_msg_type(i, options);
      options->msg_type = severity;
    }

   options->msg_type[msg_id] = msg_type;
  }

In the current codebase, the caller will simply create a "fsck_options"
and setup the fsck error message severity. However, let's see
"builtin/fskc.c", it creates the following two "fsck_options" and it
only uses

  static struct fsck_options fsck_walk_options = FSCK_OPTIONS_DEFAULT;
  static struct fsck_options fsck_obj_options = FSCK_OPTIONS_DEFAULT;

However, the code only uses "fsck_obj_options" to setup the configs. So
it makes me feel so strange. So I just want to make it separation. Maybe
a little wrong here.

> 	struct fsck_options {
> 		enum fsck_msg_type *msg_type;
> 		struct oidset oid_skiplist;
> 		enum fsck_what_check { O, R } tag;
> 		union {
> 			struct fsck_object_options o;
> 			struct fsck_ref_options r;
> 		} u;
> 	};
> 
> by moving these two members out of fsck_object_options and moving
> them to the shared part.
> 
> I dunno.  It is unclear what the real reason is for these two things
> to be extracted out and made to appear totally independent from the
> "options" thing to begin with, and I am not sure if I agree with the
> reason when it is known.
