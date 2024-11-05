Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59371D799C
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811122; cv=none; b=oF1PJIfcZlp8U2pv+8G8DhUZxPBXI6bZ57z7m5m/zrEeE4dyge2IGV61wdwR2OmEMKOGuOJ+kMkB+f42h9qrATz50h06h168sPpu3ZuKVaZeb+qFDYBsuQQwFrbX/wVAWWRQo2RdyGxFzPctbXephv/grSyNu6rVn8IwQ/4PPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811122; c=relaxed/simple;
	bh=b7uOA/VtuY5thTcDX7KEcXUFxntxXQCHargTnidzeag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIG9ZkcVplt0XAEpYOV4b0/eU3SvzY6TqtW1OLn2UK9eQR8w+tiJ15M59L+jLoModnXWD6iFzO87dej+BrTFEejE1f0g5f2752wpn3C/iVpIkpnI4pssWXEvcutSijIM5m30LZBvUbxOmA/NWASsb8IBFrMjjX8oV7873HkxmRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOnaQje4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOnaQje4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cdda5cfb6so52610195ad.3
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 04:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730811120; x=1731415920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aZvNTw2xBPyWuZMTre9IilF3Ot+Hkq4MiBEuCHrk9j8=;
        b=WOnaQje47mCuLNMMdibCFfvYhnXC17SA7OQEH57xUIbEr2piDYhGbjRPTLmLc1TqGK
         dW4NRLVuvIPKfSfQCn2wS5Xe9/d1w/7HwX9CfJ9fDqYeMDfrwrhBUCr/gfmzt5loJcPz
         xNQcAs3f+aH2Q3kF+euBp8aUgKBnzFfBi7GVZKhMCj8AZEK+VFYPacbXiK2Y3oX2hSja
         SKXVX3T4hZ6HnMgtv4Wg1gAepDpBkpVPlqUpjJTbsB/JvmgfIs6+oaFx42NaDHUDYeDw
         4GZTNoq7oHWB4vDmJWOY7X6V9ZNjcRsNsP9NJbg+UhBqs4+igweqGdn0h8B3/hwV604G
         cw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730811120; x=1731415920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZvNTw2xBPyWuZMTre9IilF3Ot+Hkq4MiBEuCHrk9j8=;
        b=gDn+XYhsYaHQd4hnAItxBocet7Zbc8JXhoZ2c9w7mmX12NmOrTsczsX79Q9KMsxnnH
         9Vw210+VW65vNgt92VvqTmXyFQnTGFAjj0D8LDgMIQG82X6SE2Jv0FyeX6rlQKu8aHkG
         bXaE8ttQYC1lWhPX+ks6vQrLTAEBeB578RkY1C33qBwLuVf/fNlDw6G2buhNO/gj7dDC
         zAf/d4iL1a8Dk94c6xAtH2FycEDjFAJDbSe26FtqQEO3R7yJP6Qi0FvGVT8Y7AiaDRfw
         Ty/4khONbiU3goZ40vOY0SQ98a7oDk0vyQgVPRCx/ocQehNuP08f5caYTKBtmOc66WtO
         XLDw==
X-Gm-Message-State: AOJu0Ywqtm9ggqz43rYPM734JlKUfcU0g5+UxwtMj7kCKcOKSPpUrQLk
	GdHUUTebMqxwWxx8uAtI1R0TgqJoDWeoSBY212GtkIqTsNI2sNsp
X-Google-Smtp-Source: AGHT+IEzAQyHaLXVvJ7dGqXIdKMAwiFn6ojqrZYA9Z7P4KNMzVeCznPY/MMJGKKWdTgYSFGLIe1Llw==
X-Received: by 2002:a17:902:ecd2:b0:20c:5263:247a with SMTP id d9443c01a7336-21103c5c5abmr268744385ad.38.1730811119761;
        Tue, 05 Nov 2024 04:51:59 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d380fsm77699665ad.240.2024.11.05.04.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 04:51:59 -0800 (PST)
Date: Tue, 5 Nov 2024 20:52:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/9] ref: support multiple worktrees check for refs
Message-ID: <ZyoVA-p4JXPaKTny@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
 <ZxZYcPwLB5oLTFUo@ArchLinux>
 <ZynFNQ8SnvTJlVdN@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZynFNQ8SnvTJlVdN@pks.im>

On Tue, Nov 05, 2024 at 08:11:49AM +0100, Patrick Steinhardt wrote:
> On Mon, Oct 21, 2024 at 09:34:40PM +0800, shejialuo wrote:
> > We have already set up the infrastructure to check the consistency for
> > refs, but we do not support multiple worktrees. As we decide to add more
> > checks for ref content, we need to set up support for multiple
> > worktrees.
> 
> I don't quite follow that logic: the fact that we perform more checks
> for the ref content doesn't necessarily mean that we also have to check
> worktree refs. We rather want to do that so that we get feature parity
> with git-fsck(1) eventually, don't we?
> 

Yes, I agree. I come across why I wrote such message. Actually, in the
very early implementation, I didn't consider about worktree situation
for the "escape". And I thought I should add support for worktree. So, I
made a mistake.

[snip]

> > @@ -3558,6 +3560,9 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
> >  		} else if (S_ISREG(iter->st.st_mode) ||
> >  			   S_ISLNK(iter->st.st_mode)) {
> >  			strbuf_reset(&target_name);
> > +
> > +			if (!is_main_worktree(wt))
> > +				strbuf_addf(&target_name, "worktrees/%s/", wt->id);
> >  			strbuf_addf(&target_name, "%s/%s", refs_check_dir,
> >  				    iter->relative_path);
> >  
> 
> Hm. Isn't it somewhat duplicate to pass both the prepended target name
> _and_ the worktree to the callback? I imagine that we'd have to
> eventually strip the worktree prefix to find the correct ref, unless we
> end up using the main ref store to look up the ref.
> 

Actually, the worktree won't be passed to the callback. The
`fsck_refs_fn` function will never use worktree `wt`. The reason why I
use `wt` is that we need to print _full_ path information to the user
when error happens for the situation where worktree A and worktree B has
the same ref name "refs/worktree/foo".

I agree that we will strip the worktree prefix to find the correct ref
in the file system. This is done by the following statement:

	strbuf_addf(&sb, "%s/%s", ref_store->gitdir, refs_check_dir);

For worktree, `ref_store->gitdir` will automatically be
`.git/worktrees/<id>`.

In the v5, I didn't print the full path and we even didn't need the
parameter `wt`. However, if we want to print the following info:

	worktrees/<id>/refs/worktree/a

So, just because we need the `worktrees/<id>` information. Actually, we
could also get the information by using "ref_store->gitdir" and
"ref_store->repo->gitdir". However, this is cumbersome and it's a bad
idea. So I change the prototype of "fsck_fn" to add a new parameter
"struct worktree *".

> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index 07c57fd541..46dcaec654 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -13,6 +13,7 @@
> >  #include "../lockfile.h"
> >  #include "../chdir-notify.h"
> >  #include "../statinfo.h"
> > +#include "../worktree.h"
> >  #include "../wrapper.h"
> >  #include "../write-or-die.h"
> >  #include "../trace2.h"
> > @@ -1754,8 +1755,13 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
> >  }
> >  
> >  static int packed_fsck(struct ref_store *ref_store UNUSED,
> > -		       struct fsck_options *o UNUSED)
> > +		       struct fsck_options *o UNUSED,
> > +		       struct worktree *wt)
> >  {
> > +
> > +	if (!is_main_worktree(wt))
> > +		return 0;
> > +
> >  	return 0;
> >  }
> 
> It's somewhat funny to have this condition here, but it does make sense
> overall as worktrees never have packed refs in the first place.
> 

Yes, there is no packed-refs in the worktree. And we need to prevent
calling multiple times.

> Patrick

Thanks,
Jialuo
