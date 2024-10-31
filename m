Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA16F1CEE86
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730411008; cv=none; b=nc07/a3A5pbIKeTNW1MSZaox2PzliABRh8N7ClgXj+THwcmk3pI/LuEziEAhGyo4ZP0N4qUzYYeD6weEYyq4gllYOOT/CMAh4zqfam6G2sIWCM/KqIGE/qjMW/SKJOiGgcnRXvJEwWLKrnWWaJaoyn9rp7LOh0v09lwC+QJ7tDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730411008; c=relaxed/simple;
	bh=YUTHid2xyxLSlq+mTwxOztKq0qospOHPyrNXqJL1FxM=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=dbeXP2b+LgVx7Dyg3oCpn8q3+0//Mc9+D5sXOMFkm/3OHyE4SmcATYZTdzCiUEqLImH9aFLBnZXUPeUYURGHaUVtaUBq1vF/+6Y9Y2FgGr+qfVrEhqjA8jTH1JKsDPoRnfWKYxt10WdzaysZEie6PGvzNeTXhPhI7IpPGvpQvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4efsa9WP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4efsa9WP"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e1fbe2a6b1so25365117b3.2
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 14:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730411002; x=1731015802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=unhYqBVSdePKT3NTc5CXSfell0JUrvUJWo1umQ11ulc=;
        b=4efsa9WP0TGn5ntF0SNui65Bkj2fpE27KgsLQzZNa3WhdPiqjfZrfFPFYtQd44i8SU
         xB0R13aN6cdboEjj2kWJBQxlFvfhDfUcp0ijx5KrXCwt7YwtalTLG4AcfXftAk7A2ZfJ
         x8vkg+DrOv2Di8VHk8NiIkfVjnukqYL/dUnXFUlWDoyE8oDGz1VM8Frj8m8QBWKqJy+k
         sIG8QrkpRmmfKX/siGoVQuVP9YmQzt6/YJ98u3yZyQmuo7ev6tp2pWBdGwoy80UzXi93
         MJjB7P45zBD/Y7GYDZpdDfl9ZMvUe0A8yvooX9rCtbdqfjiNpo/Gi632o1KdHvCD4fko
         k0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730411002; x=1731015802;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unhYqBVSdePKT3NTc5CXSfell0JUrvUJWo1umQ11ulc=;
        b=LzW7745lV1goqb1lhBNx5DgyeONc5sNcyf2iJN8oFhHNdSv09gFqpUjVnnRhT+it4o
         BBE8keQXqptZUhKSYcmjihngaBfOk3Qjoto6pCHHr3AkAdKVprvg5nar7DFW2QB6St8L
         qszQyiwE6vMji1IErXvCmQ+achTEsCM+2c7/fufGknjutv0UiWA3ro3flkubz6w17Azv
         gCzjfhHqzSDr5wCYmdGMx8/8YTJ0pBx0xmrdtj3uxeaDGqj9h8M5h59X5Ht2pTMvv0sR
         XBvgotyWuiGb2jYjsizYNdDVA14ikpTzqoZcLaSQ6VMfNpD2Yf8X5CWjBzI+F+TTaBAm
         PKVg==
X-Forwarded-Encrypted: i=1; AJvYcCUn2HnwEkwoo+Gqjf/0KrJVBVoW8lv+SRhJ6x8LewfKjF41ZatyM+YCfGsw2MGNHqdZYJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSo5WsK3jJgEX9NOMwpcFVYFQuYKTDbb+52lI6y3T/IXKaoPXq
	GfCaNM3aOHgBSiUNd5EkzmNc7ihtyKN+XO/ShV1Dc4aGgKQRYaxFz6I7gk6YlZWacOEOoXjjyi8
	3arwzeaYo2dfDiK2cDVsiVYqRxXRqyw==
X-Google-Smtp-Source: AGHT+IGn/DjHGHG5BYfUVL6k1D29ZkWpLx/ab08sSUqLh284MmfVUU0pUzbCpPka9d0H36OevWMKyhkHlJvtTJOnzrqc
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:1f26:d3e7:169a:dbab])
 (user=jonathantanmy job=sendgmr) by 2002:a25:dcd3:0:b0:e28:f231:1aa8 with
 SMTP id 3f1490d57ef6-e3087a416d3mr100867276.2.1730411001617; Thu, 31 Oct 2024
 14:43:21 -0700 (PDT)
Date: Thu, 31 Oct 2024 14:43:19 -0700
In-Reply-To: <ZyPvqPK1s5lUtH+N@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031214319.550776-1-jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] fetch-pack: warn if in commit graph but not obj db
From: Jonathan Tan <jonathantanmy@google.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:
> > However, the action of first looking up the commit graph file is not
> > done everywhere in Git, especially if the type of the object at the time
> > of lookup is not known. This means that in a repo corruption situation,
> > a user may encounter an "object missing" error, attempt to fetch it, and
> > still encounter the same error later when they reattempt their original
> > action, because the object is present in the commit graph file but not in
> > the object DB.
> 
> I think the type of repository corruption here may be underspecified.

Hmm...if you have any specific points you'd like me to elaborate on (or
better yet, wording suggestions), please let me know.

> You say that we have some object, say X, whose type is not known. So we
> don't load the commit-graph, realize that X is missing, and then try and
> fetch it.

Yes.

> In this scenario, is X actually in the commit-graph, but not
> in the object database?

Yes.

> Further, if X is in the commit-graph, I assume
> we do not look it up there because we first try and find its type, which
> fails, so we assume we don't have it (despite it appearing corruptly in
> the commit-graph)?
> 
> I think that matches the behavior you're describing, but I want to make
> sure that I'm not thinking of something else.

Strictly speaking, we are not trying to find its type. We are trying
to find the object itself. (One could argue that if we find out that
an object is a commit, we can then ignore the packfile and go look up
the commit graph file. I'm not so sure this is a good idea, but this is
moot, I think - as far as I know, we currently don't do this.)

But yes, if the object is not in the object DB, we assume we don't have
it.

> You discuss this a little bit in your commit message, but I wonder if we
> should just die() here. I feel like we're trying to work around a
> situation where the commit-graph is obviously broken because it refers
> to commit objects that don't actually exist in the object store.

Yeah, that seems to be the consensus. I've switched it to a fatal error.

> A few thoughts in this area:
> 
>   - What situation provokes this to be true? I could imagine there is
>     some bug that we don't fully have a grasp of. But I wonder if it is
>     even easier to provoke than that, say by pruning some objects out of
>     the object store, then not rewriting the commit-graph, leaving some
>     of the references dangling.

The fetching of promisor objects that are descendants of non-promisor
objects. [1]

I think that the rewriting of the commit graph happens on every repack,
thus avoiding the situation you describe (unless there is a bug there).

[1] https://lore.kernel.org/git/20241001191811.1934900-1-calvinwan@google.com/

>   - Does 'git fsck' catch this case within the commit-graph?

Honestly, I haven't checked - I've been concentrating on fixing the
fetch part for now (and also the bug that caused the missing commits
[2]).

[2] https://lore.kernel.org/git/cover.1729792911.git.jonathantanmy@google.com/

>   - Are the other areas of the code that rely on the assumption that all
>     entries in the commit-graph actually exist on disk? If so, are they
>     similarly broken?

Yes, the fetch negotiation code. It is not "broken" in that it solely
uses repo_parse_commit() which always checks the commit graph, so as
long as the commit graph has everything we need, there will be no error.

There might be other systems that rely both on the commit graph and the
object DB, and thus have an inconsistent view (so, "similarly broken" as
you describe it) but at least in the partial clone case, the severity of
the issue is not as high as in "fetch", because these other systems can
lazily fetch the missing commit and then proceed.

> Another thought about this whole thing is that we essentially have a
> code path that says: "I found this object from the commit-graph, but
> don't know if I actually have it on disk, so mark it to be checked later
> via has_object()".
> 
> I wonder if it would be more straightforward to replace the call to
> lookup_commit_in_graph() with a direct call to has_object() in the
> deref_without_lazy_fetch() function, which I think would both (a)
> eliminate the need for a new flag bit to be allocated, and (b) prevent
> looking up the object twice.
> 
> Thoughts?
> 
> Thanks,
> Taylor

This would undo the optimization in 62b5a35a33 (fetch-pack: optimize
loading of refs via commit graph, 2021-09-01), and also would not work
without changes to the fetch negotiation code - I tried to describe it
in the commit message, perhaps not very clearly, but the issue is that
even if we emit "want X", the fetch negotiation code would emit "have
X" (the X is the same in both), and at least for our JGit server at
$DAYJOB, the combination of "want X" and "have X" results in the server
sending an empty packfile (reasonable behavior, I think). (And I don't
think the changes to the fetch negotiation code are worth it.)
