Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A382EBBB8
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184620; cv=none; b=pJtJYFQ7NSdcFd6LhXtqdBVqSTH+25X+ulw9N/0TcvIME60nDMeX7x6gjwWKWgcbzx80XTtkVtMHlLNAJ5C9I03E55jOqEVjPZDQiWjPC3sSbexiHqbn8OacsFfdDrRdZ8Ddigz8amnUNWwlGSr1Mb21ZkteaAhQPvcaPXQMsvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184620; c=relaxed/simple;
	bh=23tGl7dRcaB+5mmJ4xCbDfW+Qk2F7+WrblHQs7Fywj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jved9uYuxFus1Fqhe8+BazsmG3aAhqiFCTflYRUC8wnjv/M7Gtzbt8TiLcmnCHRFhcm0c94ubfXHDLMitUl13QKv4eQlAVfO4CnzIYAWgfU6i3egSvoMeKii71X5dFGORWloArZvciyK71FYqyfr+pdgXwYtzCiinNXeovhLUgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pISUVrF/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BDb3t2TB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pISUVrF/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BDb3t2TB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pISUVrF/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BDb3t2TB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pISUVrF/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BDb3t2TB"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DC381F79D;
	Tue, 17 Jun 2025 18:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750184616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYQ6moc2h/d5X3jRIGJucbC3C04dKHowOgASY+2Pa7E=;
	b=pISUVrF/DcedqgrtFzhRIn9jKX5f/LzlSHzVCU3zoCUl4WcMcY+EHi2LQSGCwAKDNjYiXD
	gKHQTx+BIlvsNspwSenMlk9bTpa9w1X3h4ZtxGWXKLylLjzLn4ZJcJm89F6qubAf5lRF96
	Rd/C3xQwZXE2BGtzYQVSP+xhGT1OK7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750184616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYQ6moc2h/d5X3jRIGJucbC3C04dKHowOgASY+2Pa7E=;
	b=BDb3t2TBOIQnPy5GIkzrPP6WUrVvMt7DBi6IZzEZRIOanJWN+4OR9SH7VmLvf/1HeXoOLs
	ji0RCF00owTV13Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750184616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYQ6moc2h/d5X3jRIGJucbC3C04dKHowOgASY+2Pa7E=;
	b=pISUVrF/DcedqgrtFzhRIn9jKX5f/LzlSHzVCU3zoCUl4WcMcY+EHi2LQSGCwAKDNjYiXD
	gKHQTx+BIlvsNspwSenMlk9bTpa9w1X3h4ZtxGWXKLylLjzLn4ZJcJm89F6qubAf5lRF96
	Rd/C3xQwZXE2BGtzYQVSP+xhGT1OK7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750184616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYQ6moc2h/d5X3jRIGJucbC3C04dKHowOgASY+2Pa7E=;
	b=BDb3t2TBOIQnPy5GIkzrPP6WUrVvMt7DBi6IZzEZRIOanJWN+4OR9SH7VmLvf/1HeXoOLs
	ji0RCF00owTV13Dw==
Date: Tue, 17 Jun 2025 20:23:35 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Rename detection fails on symlinked files
Message-ID: <aFGypy83l9DSPvF4@kitsune.suse.cz>
References: <aFFN9UHCspTjliMv@kitsune.suse.cz>
 <CABPp-BFdEn8rYu+FW+CdgrKNDUGBY9h6ePSH-vjYy-f_Pji0-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFdEn8rYu+FW+CdgrKNDUGBY9h6ePSH-vjYy-f_Pji0-Q@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Tue, Jun 17, 2025 at 10:44:23AM -0700, Elijah Newren wrote:
> Hi,
> 
> On Tue, Jun 17, 2025 at 4:16 AM Michal Suchánek <msuchanek@suse.de> wrote:
> 
> I think your subject might be slightly misleading, and that a more
> accurate subject might be: Rename detection is not performed for files
> still present in the target version.  Let me explain why and you can
> check if I'm understanding your problem setup correctly.
> 
> > commit 5d51b10d8b5206ef5eeb9d214237b2ec2e0b789e (HEAD -> master)
> > Author: Michal Suchanek <msuchanek@suse.de>
> > Date:   Tue Jun 17 13:08:51 2025 +0200
> >
> >     rename file
> >
> > diff --git a/somefile b/somefile-renamed
> > similarity index 100%
> > rename from somefile
> > rename to somefile-renamed
> 
> So you've renamed a file, detected at the time you run git log -p.
> 
> > ln -s somefile-renamed somefile
> > git add somefile
> > git commit --amend
> 
> Here, you reintroduce the original file, as a symlink, and amend the commit.
> 
> > commit 377d9bd045aed61c7be55482f3c98f8f9d04a33d (HEAD -> master)
> > Author: Michal Suchanek <msuchanek@suse.de>
> > Date:   Tue Jun 17 13:08:51 2025 +0200
> >
> >     rename file
> >
> > diff --git a/somefile b/somefile
> > deleted file mode 100644
> > index a53032b..0000000
> > Binary files a/somefile and /dev/null differ
> > diff --git a/somefile b/somefile
> > new file mode 120000
> > index 0000000..fc49048
> > --- /dev/null
> > +++ b/somefile
> > @@ -0,0 +1 @@
> > +somefile-renamed
> > \ No newline at end of file
> > diff --git a/somefile-renamed b/somefile-renamed
> > new file mode 100644
> > index 0000000..a53032b
> > Binary files /dev/null and b/somefile-renamed differ
> 
> If I'm understanding the behavior that bothers you, it doesn't seem to
> be related to symlinks.  You could create any regular text file
> unrelated to the original somefile (or even introduce a submodule) and
> place it in somefile and amend the commit, and you'd see that the
> rename wasn't detected.  For example, replace your `ln -s/git add/git
> commit --amend` sequence with
> 
> $ echo content >somefile
> $ git add somefile
> $ git commit --amend
> 
> and you'd see that there was no rename detected from the original
> somefile to the new somefile-renamed.  By default, if the file is
> present in both the source and the destination, it is not involved in
> rename detection.
> 
> > Can the rename detection be fixed to detect symlinked files as well?
> 
> Symlink renames can be and are detected, by default.  For example:
> 
> $ ln -s somefile old-symlink
> $ git add old-symlink
> $ git commit -m old
> $ git mv old-symlink new-symlink
> $ git commit -m new
> $ git diff HEAD~1
> diff --git a/old-symlink b/new-symlink
> similarity index 100%
> rename from old-symlink
> rename to new-symlink
> 
> But from your example, you're not renaming a symlink, so instead of
> "Can rename detection handle symlinked files?", your question really
> is more of "Can a renamed file be detected even when some other
> file/link/submodule is immediately placed where the renamed file used
> to be?"
> 
> git assumes, by default, that a file which exists in both the source
> and destination are "related" and will only look for renames in
> deleted or added files.  Allowing git to mark a file as both a delete
> and an add even when it's present in both the source and the target is
> the job of break detection, which is not turned on by default.
> Further, break detection and rename detection have a bug or two when
> used together (brought up on the mailing list by Junio some years
> ago), which might need to be fixed for your example to work as you
> expect if you try to turn on break detection.

There is indeed something fishy going on:

git show -B100 (or any value of B, really)

commit 377d9bd045aed61c7be55482f3c98f8f9d04a33d (HEAD -> master)
Author: Michal Suchanek <msuchanek@suse.de>
Date:   Tue Jun 17 13:08:51 2025 +0200

    rename file

diff --git a/somefile b/somefile
deleted file mode 100644
index a53032b..0000000
Binary files a/somefile and /dev/null differ
diff --git a/somefile b/somefile
new file mode 120000
index 0000000..fc49048
--- /dev/null
+++ b/somefile
@@ -0,0 +1 @@
+somefile-renamed
\ No newline at end of file
diff --git a/somefile b/somefile-renamed
similarity index 100%
copy from somefile
copy to somefile-renamed

> Also, not sure how deep your interest in break detection goes, but
> merge-ort was written with some implicit assumptions that break
> detection is _not_ active.  Trying to retrofit it to support break
> detection might take a significant chunk of work; and even if someone
> is motivated to make it work, it'd defeat the safety of every
> optimization added to it (making it orders of magnitude slower), and
> also tack on a significant performance penalty on top of all that
> (break detection is not cheap when at least one side of the merge has
> a significant number of files modified).

Does merge-ort at least refuse to run with break detection enabled?

This is mainly for examining changes, following a file trough history, and
such. When it comes to that there are other merge strategies besides ort so it
may not be completely hopeless trying to merge across renames, too.

Thanks

Michal
