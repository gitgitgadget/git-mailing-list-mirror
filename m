Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E728467B
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 23:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065090; cv=none; b=E7oVcj6fzsLioa5g1AIHtY0eGjpU4vI/K+ghFCEj4ZKVw91Lbeg8eO00PFy7/ad5dVpJq+6C7W4CniKrn12Rh3NgYYvNwr7UqdYkL9FcyFzo2nOKN4nV7uplvSfOu8gpTkBtS/HXLtQfbBdtjaawNdcVnhz1HQsNCtXDGfe639I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065090; c=relaxed/simple;
	bh=3NN7YsBpPA+Pdt7j5+ujZ2gUDipFfgMs5jZ/DLrx6/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ4O1cLewzxrqFfk6wWlrnJ+2gfpmOV0bxFlpi3HT4qYs/IOMJ49OlPVuX/BfKqoOIpVNjuDMCiWqrriTKzfP3qfS/5dKMmgnscyBm816EuGjya+U4sIcAa82+C0b68SwPFpk8xywQg5cRdlpGfGM7EB7dXkUGpXRftfcj7W+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ICDJS6j2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ICDJS6j2"
Received: (qmail 103212 invoked by uid 109); 16 Sep 2025 23:24:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=3NN7YsBpPA+Pdt7j5+ujZ2gUDipFfgMs5jZ/DLrx6/w=; b=ICDJS6j2lBm+kJCFJds7n2Q75u+hj27nWLi85it0WfGRhJAQjsXnRLcy4dxQEl8rKuZlUnN+o9ThNxqViAgZFLqEOohuJJH5Xejr4HwKXMJbbVm7qHMDmLVmgNRnZf3bSKNEfIPp0/zU3u1C1ZAsW0fAsJCGS+HhkWraLcIh0NZJoX0O1a7oF6Aq2whS4P1YbnBs36Wo1Z2RjukaG8CKsl2TvORQxEbkxIGqe3CYvFiNDDtjRBsl3jAK1izdg5B4nx8RlNHxRhZ6WtPT76dzhIAqxWD09erFhQamB8x46Fu12fEIywpqFoItKGDfTKLKrV2sENFcU8MJ9BA6jYRfdQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 23:24:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 168496 invoked by uid 111); 16 Sep 2025 23:24:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 19:24:46 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 19:24:46 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 0/8] you-still-use-that??: improve breaking changes
 troubleshooting
Message-ID: <20250916232446.GA1189675@coredump.intra.peff.net>
References: <cover.1757446619.git.code@khaugsbakk.name>
 <cover.1757879060.git.code@khaugsbakk.name>
 <xmqqy0qffrri.fsf@gitster.g>
 <e4fc3b83-15ca-4844-92c6-1f41169161ed@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4fc3b83-15ca-4844-92c6-1f41169161ed@app.fastmail.com>

On Tue, Sep 16, 2025 at 10:47:58PM +0200, Kristoffer Haugsbakk wrote:

> Thanks.  This is (maybe you surmise or know already but) a
> problem when on the branch itself as well.  I did some compiling
> `WITH_BREAKING_CHANGES=YesPlease` and it seems that 07572f220a8
> (whatchanged: remove when built with WITH_BREAKING_CHANGES, 2025-05-12)
> made it a hard error to call `whatchanged` after its death:
> 
>     $ ./bin-wrappers/git whatchanged
>     fatal: cannot handle whatchanged as a builtin
> 
> This seems fine, although I would have expected it to say something more
> neutral like “command not found”.

I think the breaking-changes code for whatchanged did not update the
Makefile appropriately. If I build with that flag:

  [make sure it is not here]
  $ rm git-whatchanged

  [now build]
  $ make WITH_BREAKING_CHANGES=YesPlease
    [...]
    BUILTIN git-whatchanged
    SUBDIR templates

  $ ls -l git-whatchanged
  -rwxrwxr-x 140 peff peff 12104368 Sep 16 19:15 git-whatchanged*

So we have linked it in the usual way we do for builtins, so that
git-whatchanged would "work". But of course since it is not in the
builtin table, it does not:

  $ ./git-whatchanged
  fatal: cannot handle whatchanged as a builtin

And then because it exists in the exec-path, "git whatchanged" thinks
that it can run the dashed form, so it produces the same message.

We probably need this:

diff --git a/Makefile b/Makefile
index e11340c1ae..9311da5bb1 100644
--- a/Makefile
+++ b/Makefile
@@ -883,7 +883,9 @@ BUILT_INS += git-stage$X
 BUILT_INS += git-status$X
 BUILT_INS += git-switch$X
 BUILT_INS += git-version$X
+ifndef WITH_BREAKING_CHANGES
 BUILT_INS += git-whatchanged$X
+endif
 
 # what 'all' will build but not install in gitexecdir
 OTHER_PROGRAMS += git$X

but annoyingly an old build will leave git-whatchanged in place and
cause the same confusion. And git-status won't even notice that it's
leftover because .gitignore mentions it. But we can't drop it from
.gitignore until the non-breaking-changes builds go away entirely. Yuck.

> What I don’t understand though is this:
> 
>     $ ./bin-wrappers/git -c alias.whatchanged=status whatchanged
>     fatal: cannot handle whatchanged as a builtin
> 
> People have been saying that people can at least alias `whatchanged` to
> `log <something>` and then it will work after the removal.  But now that
> it has been removed (according to the commit message) its spirit lives
> on and prevents reusing the name?

I'd have thought the alias took precedence over the stale executable
file. But it can't, because "whatchanged" is no longer marked as
deprecated in the builtin list. Because it's not in the builtin list at
all! So it is just a "normal" non-deprecated external command from the
perspective of git.c, and you are not allowed to override it.

So I think the alias code is working as expected, but the stale file is
causing the same confusion as above. Deleting it makes everything work.

-Peff
