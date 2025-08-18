Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608619E992
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 20:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755548505; cv=none; b=rC1jaNeyr8N5IiYPoMno0Ptl0U22CFUA9yOBsK6N2TA413XtoXD7Txl2Z4uCKtWnt5a7fSrf4kv0KfqS1s+CZUkIhntQr5/ThOB/JWvm7q1eOSj8nXnBCC2WlnJPa1UHj4IXUvBRLr0freLloUO/vJlgJZIvDl5uL5xQF5gry+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755548505; c=relaxed/simple;
	bh=Mmf9TEuj9T4MbysqzNOXp5ydS6n7r1UYmg5EVOKTdOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAlaBwQ8kwFh1e6WgDHezt0ZQoYQKSKtE/NiENc6HGzuZNjlDgT8WIyLTB4ea+gRw/c/Yt1mUf3o6/7PgPTRuNY5X5CvhzZUupyK9H2XIRxTz6Rh6BTNhUumJ5hRb4emjBUXwqEJVgOKN85P5Kx7lqlNnUbx45z98M2/uk41q2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eBxWXdVd; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eBxWXdVd"
Received: (qmail 23089 invoked by uid 109); 18 Aug 2025 20:21:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=Mmf9TEuj9T4MbysqzNOXp5ydS6n7r1UYmg5EVOKTdOg=; b=eBxWXdVdnYV2ICMpm3GiODcX/88A7qG38WaodI2i0q3twB+XIIsJFU6CL1Z1v0JQ4mjbuEaEq0neSujzrVlfFlMnRsEXIhIvigI2QL/KBXFxPRu1StHUvZOnk7yANDFDk4j8esPBgL3OVRk4IGIF6kv91AYzE27zh/hAg5T86wkuR3490wf6oosc3DuZB2snpEMNbUmIgXD447IajFEG9mMvQkZQl94/MP6kN8/TfuoFJzhv6NJiWEILdSR+NXmAymd+EowsT5fnJ7HJcKqJvFxtm5Sg++xIuVF+UYbt6jLxoxucFcKwB0G8lqGATHiMEd68QhQRcDypohemLLbpCQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Aug 2025 20:21:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29904 invoked by uid 111); 18 Aug 2025 20:21:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Aug 2025 16:21:40 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Aug 2025 16:21:40 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: phillip.wood@dunelm.org.uk, Cheng <prophecheng@stu.pku.edu.cn>,
	git@vger.kernel.org
Subject: Re: Potential Null Pointer Dereference detected by static analysis
 tool
Message-ID: <20250818202140.GA1014353@coredump.intra.peff.net>
References: <AAkArwD3JXZP4EIjvKF0Waow.1.1755044612233.Hmail.2201111603@stu.pku.edu.cn>
 <5303c45e-d95b-4bc8-9cd1-bf4efe6bfbae@gmail.com>
 <20250814232644.GC2937@coredump.intra.peff.net>
 <7f289d4f-0a9d-480d-a5a9-7f4d4d24626b@web.de>
 <20250818044807.GA51803@coredump.intra.peff.net>
 <20250818050545.GA62231@coredump.intra.peff.net>
 <194415e5-2adc-4b3f-98d3-0fde4a288b5c@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <194415e5-2adc-4b3f-98d3-0fde4a288b5c@web.de>

On Mon, Aug 18, 2025 at 09:56:35PM +0200, René Scharfe wrote:

> >   1. What should happen when traversing from HEAD does not find the blob
> >      in question? Right now we print a blank line, which is...weird.
> 
> Weird indeed.
> 
> >      Probably we should either print nothing, or return an error.
> 
> The latter, consistent with "git describe <commit-ish>".

Certainly if we were starting from scratch, that's my thought. I just
wondered if we were stuck with the behavior for historical reasons.

> > If we return an error, should we respect --always?
> 
> The documentation says "git describe <blob>" takes no options.  It could
> learn some, of course.  But does it have to?  Perhaps better keep that
> thing contained.

OK. It is easy to just treat --always like we do in the commit case, but
I'm not sure it's actually useful. Just bailing early to say the option
is incompatible is reasonable.

> >   2. When we are on an unborn branch, we print a confusing message:
> > 
> >        $ git init
> >        $ git commit --allow-empty -m foo
> >        $ git tag foo
> >        $ git symbolic-ref HEAD refs/heads/unborn
> >        $ git describe $(echo blob | git hash-object -w --stdin)
> >        fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
> >        Use '--' to separate paths from revisions, like this:
> >        'git <command> [<revision>...] -- [<file>...]'
> > 
> >      We should probably resolve HEAD ourselves and either bail with an
> >      empty output or an error (depending on what we do for (1) above).
> 
> It already is an error, just needs a better message.  It should still
> report an error even if we were to stick with showing blank lines for
> unrelated blobs.

I think an error here is OK. But if we quietly return no output for (1),
then I think this should do the same. If we return an error for (1),
then yeah, it should remain one here and just get a better message.

> >   3. When we do traverse, if process_object() sees that we didn't find a
> >      commit, we should detect that and either return an empty result or
> >      an error (again, depending on the behavior of (2) above). This is
> >      done by checking is_null_oid(&pcd->current_commit) there.
> 
> OK, ending the search right there might be the best option.  Traversing
> deeper into the forest that we then know to be cursed would be the
> unappealing alternative.

Right. There is no real "deeper" because we know we will never find a
commit.

>   5. When process_object() has a commit, but it is indescribable, it
>      shows an error:
> 
>      $ git describe 5afbe6da1d6ab0b8939343166636b828e561bf35
>      fatal: No tags can describe '3b681e255cd8577a77983958ef7f566b05806cd0'.
>      Try --always, or create some tags.
> 
>      It's not immediately clear that the reported hash belongs to the
>      found commit.  And that suggestion to try --always is misleading,
>      as "git describe <blob>" takes no options according to the
>      documentation.  I'm not sure I like it in general -- can't tell
>      if the command is being snarky with me.

Yeah, describe_commit()'s messages are not really set up to handle
describing an arbitrary commit that the user did not specify.

> > So it all depends on what to do with (1), and for a feature that IMHO
> > should not even exist in the first place, I had trouble summoning the
> > will-power to make this 4-patch series.
> 
> 644eb60bd0 (builtin/describe.c: describe a blob, 2017-11-15) and
> 15af58c1ad (diffcore: add a pickaxe option to find a specific blob,
> 2018-01-04) confuse me; the latter's commit message sounds like the
> former wasn't (supposed to be?) merged.
> 
> I think the issues you listed are independent, though.  Or what's wrong
> with this demo that addresses point 3 in process_object() and 1 in
> describe_blob().  If we want a blank line for 1 then we apply only
> the first hunk.  Or am I missing something?

Yeah, I came up with a similar patch. The question was more of what the
behavior _should_ be, and whether we wanted to align that with an unborn
HEAD. And of course tests for all of these cases.

I'll send out a few patches in a moment (I guess I summoned some
willpower in the interim).

-Peff
