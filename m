Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517822CBD9
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771146509; cv=none; b=U3DxM6ErYGgFyF+wPG96rb7TQpB6A3ow+FWZJQv3P2qmf9vVdJqAhkL/u3tDxxNa/JOI9sjBNfv80YDNhfEi5T/2XhLFIvEfSTFMkVAr8o0Ngd6UE+qacGcYYjSwTgf56l4/4rY6YsP+KwBeKE4la1aVlT710pOcc/suh4PKo7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771146509; c=relaxed/simple;
	bh=l4P0spwDoY/uXUMWkU4e8doo0I1l/74En6qc66lzeMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWUzifHW9JlOzBvxjg2Jfmq+2srbOytHD5nrNHZTShrvx/JYmL7Ha+rez9sEPFvQq3xRXfPDg2hSfv3ZWf/fWpbh7yqM++4nWESL5h8OdlOdKIu7BfIqWj2QO7VBFCc6TMzZPLWrRWDxd1VBKMJlsDVUCHkKjn1av5u08csOkbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOp+cP2T; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOp+cP2T"
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c2af7d09533so1523528a12.1
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 01:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771146508; x=1771751308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T875AfIOT1tVdl8J/ekgvL0prTTJ5/raqlcwGXtl2zA=;
        b=EOp+cP2TrVUYX+HKoGhxQcYxw7sXIEgHQ0TZt4A+sgaV5AIzfjG/nKpfZZIYUDphrm
         OXZxgJdtE9PQgA+gNsmZFHaZIF5Y5y5DvEJZ7w3Jc4A0OO1z77m2JWjPpvD7IPF+BR1n
         RvpvK2RIOT8o2LRqBSYL5Y3SsMtoJN1o+BNPPRj1zGlhQ8JIWqmSlW58VPBhC4tQU1uH
         dw/S0RRujdhqD2VY7Zc2iPxjV4gAttkmvIz0LJrw2hG3hvc0SIBdwig3IFR3kVlMXNVF
         25ohZlfGDbSv1d2OrUmegrHn9lDjtemvXRAH0qxAJglCPbTPsKaYMP5hPz1x6uPSv5X0
         5YeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771146508; x=1771751308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T875AfIOT1tVdl8J/ekgvL0prTTJ5/raqlcwGXtl2zA=;
        b=UsS7l3rTaRM+bHj6sLCmbV19Pg83qQQcKX9nK4PpWN5SLcSFXbJ5QwXKU+SReUPnX8
         Z1y7KybUTQMpBzk7OxUDJrNyf9MNCNEu3m9ZgLj2JBp8ah60lkjeGrcXlnVq+BdYxMI/
         j07OXfqWN+bizE9Q/6zCmZNlZ9q1C4okwD3fsfac376ttWTZt2ISeIBdfNm0pq8wbEvk
         WVMzqTTywBPcPM2NRt6AeROFzsqZNiKGo9yzmz+6V8NzlQGksWLdNhqkmILUQk5LgESp
         VJv4OHGT2dz7tHGs1dbVCphmoa26comjjetPS+UnMdQEJXqXgjo882XUpg1875efnsh4
         kwvw==
X-Gm-Message-State: AOJu0Yzai5+PqVv5J7zN7lg5CyA8TucskvUETo9rtFym+8luSSvwNIyc
	egL8CLpc+59hFiBrIhD+VKuG1jnxbKFq2gOHoRkJB6BNOwlQsWcN5R+X0DJCiFWk
X-Gm-Gg: AZuq6aI9fArudYJhPrMvwhcJoP06Xkp+mwCD/5AjPFAwbpmPP1FImAPgrv4E8LCWdIL
	KXDi8YrQZ48D7roWMpzHOpICJPz8VZzzHEzEPB8jaGs7mX3DMw8nxLcGnX4BeE5oaaP8yHlvdG6
	NPkwq5LFFSmy8JaAL2sK+2gw0auFondUr1DBBG+71UcfPH68tlucicBoo2hvg61f0IZbwr0SIvk
	Gbd1eatlFOUc4H3FEhjAk1TXvivKhhClXLUcpEWWs1LZEwqvka7lGer9WMi8TOliZJvkYvQoRJs
	IqyacxwiI3BsIwg3pH8DAY/JxUQ/t2T/ztyIJVJK4iQ6+iWmm45L/TtBeUf8wqBjZbTrGJQl2Kk
	vV6dIrshlyxLDoA0X69pG3nCFz9wkYt3exBCU9kVG8K8I1xyyfl0z135/YuAUNkLxn6mJALXbc0
	i8R78izNOK1cNmmow7VfI1c66ou+tOW6jSuwZA/i6SKV4hskG7y4IP8HJ6zko=
X-Received: by 2002:a17:903:b48:b0:2aa:d600:d03e with SMTP id d9443c01a7336-2ab4cf84015mr76000285ad.18.1771146507747;
        Sun, 15 Feb 2026 01:08:27 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:fbc2:d3c0:56e3:5b63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a84970bfsm5028600a91.3.2026.02.15.01.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 01:08:27 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [RFC][PATCH 2/2] worktree: stop passing NULL as primary worktree
Date: Sun, 15 Feb 2026 14:26:36 +0530
Message-ID: <20260215090815.46544-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
References: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> I've cc'd Eric for a second opinion
>
> On 13/02/2026 22:29, Junio C Hamano wrote:
> > Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> >
> >> diff --git a/path.c b/path.c
> >> index d726537622..4ac86e1e58 100644
> >> --- a/path.c
> >> +++ b/path.c
> >> @@ -408,9 +408,7 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
> >>   				   const struct repository *repo,
> >>   				   const struct worktree *wt)
> >>   {
> >> -	if (!wt)
> >> -		strbuf_addstr(buf, repo->gitdir);
> >> -	else if (!wt->id)
> >> +	if (is_main_worktree(wt))
> >>   		strbuf_addstr(buf, repo->commondir);
> >>   	else
> >>   		repo_common_path_append(repo, buf, "worktrees/%s", wt->id);
> >
> > This is curious.
> >
> > We used to treat "wt==NULL" and "wt->id==NULL" differently.  Now we
> > use repo->commondir for both.  For the primary worktree, it ought to
> > be the same as repo->gitdir, so it should not matter, but makes me
> > wonder what the reason behind this difference in the original.
> >
> > We have been assuming that wt==NULL and wt->id==NULL both meant the
> > same thing: "we are talking about the primary worktree".  But the
> > code around here before this patch seems to behave differently.  Is
> > our assumption incorrect and are we making a mistake by conflating
> > these two conditions into one?
>
> My understanding is that wt==NULL means "use the current worktree" and
> wt->id==NULL means "this is the main worktree". That would explain why
> we use repo->gitdir above when wt==NULL and repo->commondir when
> wt->id==NULL, as repo->gitdir is the gitdir of the current worktree and
> repo->commondir will be the gitdir of the main worktree. If we look at
> the code in wt-status.c that's passing a NULL worktree it wants to know
> about the status of the current worktree, not the main worktree.
>
> I think that we should add a new function
>
> struct worktree *get_current_worktree(struct repository*);
>
> to worktree.c that constructs a struct worktree using repo->gitdir etc.
> The worktree id is the last path component of repo->gitdir when the
> repo->gitdir and repo->commondir differ, otherwise it is NULL. Then we
> can use that function to get the current worktree rather than passing
> NULL when we call wt_status_check_{rebase,bisect} from
> wt_status_get_state(). We should also think about whether we should
> change wt_status_get_state() to take a "struct worktree*" rather than a
> "struct repository*" instead (I've not looked at the callers to see if
> that's sensible).
>
> With that, we can gradually clean up uses of wt==NULL in the rest of the
> codebase overtime and eventually remove support for it from worktree.c
> rather than having a big flag-day patch. I don't think we need to change
> uses of wt-id==NULL.

Thanks a lot for clarifying. This helps solve the doubt regarding the
different usage of !wt and !wt->id in strbuf_worktree_gitdir(). I realize
we have been under the wrong assumption about what wt == NULL represents.

But I still have a few points where I’m a bit confused,

If wt == NULL is meant to represent the current worktree, then what role
wt->is_current plays in the present implementation, and if they both
represent the same thing then wt->is_current wouldn't make sense if wt is
already NULL in the case of a current worktree.

Beyond representation, I’m not quite understanding on how call sites are
logically differentiating on whether the intent is to 'operate on the
worktree we are in' or 'operate on the primary one'.

And I think if we included both in struct repository (r->main_wt, r->current_wt)
so accessing either of them would be a whole lot easier and also would
prevent confusion in the future.

Let me know what you think.

Best,
Shreyansh
