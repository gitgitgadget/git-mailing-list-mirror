Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EB21A83F9
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754163074; cv=none; b=LOQtbrbh/RHV7t/oAznPclk1vjEH36pL+RmKsxyHe/y5Y0WyxilKKTlaZ0/39ZsBJ4v0KzqinzC5ZvGeKp8IzOzezDLzjvPeaPcLi/GhcwnNqy8DFliH1JnfMVnc04R17jPL6LodvohYtu2w6jhPxZnpTM/q9iKVRxHzCjFNdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754163074; c=relaxed/simple;
	bh=HdvublJm16QDVBZDWRO0psA3GQWcb8E4D0DPptjHHNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6nySdn0GjvlmFTqShrJ788rwb3Exp8ldwUpyDRyA1Q7bnB0Fd/3gEGpgrW/XeKdYJhanK4V2AUyP22D6Vga3ilmeMZIndQD6p6rUddWGMNw/Vn7AqbLGq/4HJAcKtqHjpjYOGUwOJwuyY+seIUO5XAlsSh8yDbEEpV7xDtjeWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Y8Wz168n; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Y8Wz168n"
Received: (qmail 13797 invoked by uid 109); 2 Aug 2025 19:31:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HdvublJm16QDVBZDWRO0psA3GQWcb8E4D0DPptjHHNw=; b=Y8Wz168nfvyWgb+ayVuU5ARW7YrShp6TrA5KJxzhnPC/ZLuKZCmEM6zq9DYTeFnRhDA9V65TZponlJOCGyeh2/s2GqharP1VJ+vF7Vub4YKhdLYNfRzCAFCw3T1TQroEhxHyOn5G9YSmoTSh8BS1XrYLNoMfK3x27CclfwG3KK6SdsdiKi2yPaI3vWXaDeuPBmkx/euQQJ4Ld0sIQjfcqz3QmwnJzq8B73dCbGWee0EfUqWddE1MCqml+A5QXyRbPyscyy54DIiHTqMG5ReMJIVDXHAR8VoAwcbM3sEDfKeb2GLLfcDdizLpnyH0xRUbjnBlI6Uv3W4TrPuhpTbSFw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 19:31:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19847 invoked by uid 111); 2 Aug 2025 19:31:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 15:31:12 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 15:31:10 -0400
From: Jeff King <peff@peff.net>
To: Justin Su <injustsu@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Fetching upstream remote fails if repo was a blobless clone
Message-ID: <20250802193110.GA1774743@coredump.intra.peff.net>
References: <CAB=S_8+LMsSpnRWQZwK2Dj63WdcPy1vp+aJ=erDbf_aaPoU3cA@mail.gmail.com>
 <20250802093226.GF3711639@coredump.intra.peff.net>
 <CAB=S_8JYbFHJ6WQSyzGO5ns8Fe-NPCdyKjWLmRrsZ1UiZJsReg@mail.gmail.com>
 <CAB=S_8+aDwMNQkawY-Mod35EDm20mi_=xmmwfngU6As799ppqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB=S_8+aDwMNQkawY-Mod35EDm20mi_=xmmwfngU6As799ppqw@mail.gmail.com>

On Sat, Aug 02, 2025 at 02:28:24PM -0400, Justin Su wrote:

> Turns out this was because I had `transfer.fsckObjects = true` in my
> global config.
> 
> I think you should be able to repro if you change the last command to
> `git -c fetch.fsckObjects=true fetch upstream`.

Thanks, I can reproduce easily now. The object in question isn't
mentioned directly in the pack at all, as an incoming object or as a
delta. It's mentioned by a tree, c5b8c11446. And then when we fsck, we
hit it via fsck_walk_tree(). And then when we've finished indexing the
pack, we check for any objects that were mentioned but which we don't
have. And we don't have 0020d54b979, so we barf.

I assume what's happening is that 0020d54b979 is contained in the origin
repo, but we don't fetch (because of the blob:none filter). And then
when we talk to the upstream repo, it assumes we _do_ have it because of
the commits that we claimed to have. And that looks like the case. In
the partial clone we can do:

  $ git rev-list --objects --all --missing=print-info | grep 0020d54b
  ?0020d54b979cc8cf59a13406f98bfe515b190559 path=src/features/navigate.rs type=blob

There it is, mentioned by the origin repo.

So it is perfectly normal for us to be missing this object, and
index-pack is wrong to complain. Curiously, there's this code in
fetch-pack.c:

                  if (args->from_promisor)
                          /*
                           * create_promisor_file() may be called afterwards but
                           * we still need index-pack to know that this is a
                           * promisor pack. For example, if transfer.fsckobjects
                           * is true, index-pack needs to know that .gitmodules
                           * is a promisor object (so that it won't complain if
                           * it is missing).
                           */
                          strvec_push(&cmd.args, "--promisor");

which you'd think would kick in here. And I confirmed that the
index-pack which barfs is passed that option.

So I dunno. Clearly there is a bug, but it's not clear to me how this
code is actually supposed to work.

Doing this:

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0a5c8a1ac8..e01cf7238b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -262,9 +262,14 @@ static unsigned check_object(struct object *obj)
 		unsigned long size;
 		int type = odb_read_object_info(the_repository->objects,
 						&obj->oid, &size);
-		if (type <= 0)
+		if (type <= 0) {
+			if (is_promisor_object(the_repository, &obj->oid)) {
+				obj->flags |= FLAG_CHECKED;
+				return 1;
+			}
 			die(_("did not receive expected object %s"),
 			      oid_to_hex(&obj->oid));
+		}
 		if (type != obj->type)
 			die(_("object %s: expected type %s, found %s"),
 			    oid_to_hex(&obj->oid),

makes the problem go away. But I feel like I'm probably missing
something (and that function is rather expensive to run, though maybe
not so bad if the alternative is crashing).

+cc Jonathan Tan as the author of the code comment above for any wisdom.

-Peff
