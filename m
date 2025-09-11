Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7780C1A08A3
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757632133; cv=none; b=mesLMr1pASGcnMXyEAq0OUB/HKfE891O7qcgwwdtWxyeq5GJt8XEsHrSqeH86ohoAS30+Zd7Wauk4+dYDYEN39yZUOOqKY2ZLGEMIo2231Pp+AKR08rL7pAVJHVBLTOFjnC3wVyaXzi/rQRQRugwk3xWWJjSjh8VBkRjr57Ugxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757632133; c=relaxed/simple;
	bh=lVbxRLhP8ko029w11DTFXzqY55BJZ/M8Fxq3z/ZQfBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFEvNO5ry0G+1/bmlH5YzNw+tcyyG78GODDx/c+MVv0XBFYMmnT6skY69CGU182Hmhc+5ThsTYZcmFp1mWGIzTJezeaD8Qad2l130gcq3cgbHGD2uLpm7oGTQ54w5zruOnw5JFytoDM+0wCbW6t4v01B7cYykPgnj1xtPx6hUk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=bJ38iMGy; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="bJ38iMGy"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e9baa0310cbso1343610276.2
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757632130; x=1758236930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+dscmgwI2M86panvaaLIzmE9ZrK5gUP2Q0sYAH9+GM=;
        b=bJ38iMGywleE+toL4JJxml7MZEb/nrt0vO51N6gE66O5IpSrDeNalfLKtEbNO/fKom
         ZyEmstQl4sDz+h53H7z4aA8hA9iFS+ozie9OH5KJmEktNAhrjJqYZ+0aKGk+UiEiN/4j
         6XumhSa7S4af7Qu+/DLfDe0/9f3Sv2PI6foPz3VUZhOlg8mR1AmU83BTSHHgEPsXQyxF
         R98TsHyytliD37LzDh3VnnJkgyZfKBvieuWLXkhJ4bsKwooBTOPonOTifdeTDXnPR3d2
         24qE+zKOXHhzvW5zBxLa6xbL5Pn3pMhw9sNFOEtJPBOiYT2Df7Nh3URW2WJMrLYkVq2/
         qV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757632130; x=1758236930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+dscmgwI2M86panvaaLIzmE9ZrK5gUP2Q0sYAH9+GM=;
        b=LcCv8/TAClXYN+sSoJMEYVoh4a6xIXkoCLbqV5Z2DrJKrpEoF1Oz6y0v6xvTPtiVgU
         Jr2DpB2N4z3ea8EfQ4pw9tMfmMmFX66qO54DLrET9tCnI7gr2KBEo/IKCBZ8opsF9M+O
         0U6UqtZ5DNZlq5eHuiU18SOeKynTF9LNZdaRBHdKglPQaP0d68gKqy2/7ZPL2j1wsYl6
         MB93G3xsOL2WapGx0F1vJegVQjtTuMd5V2zumdeIxUBwprCPEq/dBL04iuLnCwO8P6Pf
         hz+hPJ+FKhxT1FgFjbgaIFPRSepz6iXkuSIx9+ZoUlt0BcLxX6HxxcfFQk9nO2DRHHVt
         hzjg==
X-Forwarded-Encrypted: i=1; AJvYcCUsVAsanMo27TjGQhVQeuJWDj/nhe7ThWWugvYsr4XBVFEPfpCpNCIkpVmRblX8Qoro0II=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDaJxAQqgH6W0AtlnoCv8VUPfNkjkmbnj8QnurKCEpqQjD2ay3
	Q+zZM+Fm1yC49GSViLXxMtnCk7N1Pp9OywMHRZK9fjFOfQdRmjuyw0jEcmr+C2BPeFA=
X-Gm-Gg: ASbGncvQpFfNkU2ZoTD8NX7OEDhPgWQiNs1gQH1NTYvP96ohOzxP+htUGr+HilnXHGt
	+uvo6yiyfq94AShq3RCS9dcl9hlSPq0MwRZoVA1XfpoXBI0DS+G7CrX94qSL/dGAiIcibF4RF5d
	F2oDdSk4bY/fWHRJi+//OdHBmLmThj/a5YI5tJSvc5vlyun4RorLYvQ/bKmX7Uv4+8p9ZJ4w9pU
	EhYZtXtglcRu0gbbjUvvQJ6reFLPe3XjI5mjc54KEpdjFU4sz8TKsP5S2y8GXwovmF3nwa6pCzp
	vNcf/beB22KweF7mX9sDpeBlfiKeGOlfsw4Lca5ONfIO6EMAXqlE4CaXy7Cy6BmqFvyx17IkEFY
	S/fUnHCPmh/FJDndaoTHU4AYSHU6YJGtT2dnTup/6yTE3YwvkWbpC8DZX30+lIDHs+Iv7Wlixdn
	WupxJpwv0+EcS9XrsvI7xw7+hntw==
X-Google-Smtp-Source: AGHT+IFItNrqlQH5dL9sNOwkaFMqchhgQ9OtWs0/AJplLYpeNiYNILxMEXoiDQSNOwNE9nSyQIWcEQ==
X-Received: by 2002:a05:6902:5401:b0:e93:46dc:41ce with SMTP id 3f1490d57ef6-ea3d9a7aaeamr808801276.24.1757632130327;
        Thu, 11 Sep 2025 16:08:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-ea3cf26020asm871254276.29.2025.09.11.16.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 16:08:49 -0700 (PDT)
Date: Thu, 11 Sep 2025 19:08:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/6] odb: track commit graphs via object source
Message-ID: <aMNWgD4wKa1a5R8g@nand.local>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
 <xmqq5xdx7qx4.fsf@gitster.g>
 <cf7aeda1-297a-4805-b0ae-e379ce11bbcf@gmail.com>
 <aL67U0-tw7O-y6_X@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aL67U0-tw7O-y6_X@pks.im>

On Mon, Sep 08, 2025 at 01:17:39PM +0200, Patrick Steinhardt wrote:
> On Fri, Sep 05, 2025 at 02:29:50PM -0400, Derrick Stolee wrote:
> > On 9/4/2025 7:12 PM, Junio C Hamano wrote:
> > > Patrick Steinhardt <ps@pks.im> writes:
> > >
> > >> commit graphs are currently stored on the object database level. This
> > >> doesn't really make much sense conceptually, given that commit graphs
> > >> are specific to one object source. Furthermore, with the upcoming
> > >> pluggable object database effort, an object source's backend may not
> > >> evene have a commit graph in the first place but store that information
> > >> in a different format altogether.
> > >>
> > >> This patch series prepares for that by moving the commit graph from
> > >> `struct object_database` into `struct odb_source`.
> > >
> > > Hmph, I am finding the above hard to agree with at the conceptual
> > > level.  In some future, we may use multiple object stores in a
> > > single repository.  Perhaps we would be storing older parts of
> > > history in semi-online storage while newer parts are stored in
> > > readily available storage.  But the side data structure that allows
> > > us to quickly learn who are parents of one commit is without having
> > > to go to the object store in order to parse the actualy commit
> > > object can be stored for the entire history if we wanted to, or more
> > > recent part of the history but not limited to the "readily available
> > > storage" part.  IOW, where the boundary between the older and the
> > > newer parts of the history lies and which commits the commit graph
> > > covers should be pretty much independent.
> > >
> > > So moving from object_database (i.e. the whole world) to individual
> > > odb_source (i.e. where one particular subset of the history is
> > > stored) feels like totally backwards to me.  Surely, a commit graph
> > > file may be defined over a set of packfiles and remaining loose
> > > object files, but it is not like an instance of the commit-graph
> > > file is tied to packfiles in the sense that it uses the index into
> > > some packfile instead of the actual object names to refer to
> > > commits, or anything like that (this is quite different from other
> > > files that are very specific to a single object store, like midx
> > > that is tied to the packfiles it describes).
> >
> > This is an interesting aspect to things, where the commit-graph file
> > is a "structured cache" of certain commit information. It happens to
> > be located within the object stores (either local or in an alternate)
> > but is conceptually different in a few ways.
> >
> > The biggest difference is that you can only open one commit-graph
> > (or chain of commit-graphs). Having multiple files across different
> > object stores will not accumulate additional context. Instead, we
> > have a "first one wins" approach.
> >
> > This does seem to be something that you are attempting to change
> > by including the ability to load a commit-graph for each odb (and
> > closing them in sequence as we close a repo).
> >
> > So in this sense, the commit-graph lives at the repository level,
> > not an object store level. When doing I/O to write or read a graph,
> > we use a specific object store at a time.
> >
> > The other direction to consider is what context we have when we
> > interact with a commit-graph. We generally are parsing commits from
> > a repository or loading Bloom filter data during file history walks.
> > Each of these do not have a predictable nature of which object store
> > will "own" the commit we are inspecting, so it wouldn't make sense
> > to restrict things like odb_parse_commit() over repo_parse_commit().
> >
> > With these thoughts in mind, I have these big-picture thoughts:
> >
> > 1. Patches 1-5 are great. Nice cleanups.
> >
> > 2. Some of Patch 6 is great, including having the I/O methods use
> >    an odb_source to help focus the specific location of the files
> >    being read or written. However, the movement of the struct into
> >    the odb_source makes less sense and should still exist at the
> >    object_database level.
>
> I (probably unsurprisingly :)) don't quite agree with this.
>
> Let's take a step back: why does the commit-graph exist in the first
> place? It basically provides a caching mechanism to efficiently return
> information that is otherwise more expensive to obtain:
>
>   - It contains a cached representation of the graph so that we don't
>     have to parse each commit from the object database.
>
>   - It encodes generation numbers.
>
>   - It contains bloom filters.

I don't think these three things are all on the same conceptual footing.

In the current object storage format, yes, part of the commit-graph's
responsibility is to provide fast access to the repository's commits and
their ancestors. That is a pure optimization that is inherently tied to
the object storage format, which necessitates such an optimization for
certain operations to be efficient.

Generation numbers and changed-path Bloom filters are different. Yes,
they *can* be used to optimize certain operations, but they also provide
*new* information that cannot be otherwise stored in the existing object
format.

Suppose that we have some future object storage backend that stores
commit objects in such a way that querying them natively through
whatever mechanism that store provides is already as efficient as using
a commit-graph file on-disk today. That eliminates the "pure
optimization" aspect of the commit-graph.

But that object store implementation will still want to implement
additional features like generation numbers and changed-path Bloom
filters, because those provide new information that is not purely about
optimizing reads.

> All of which makes sense with the current design of our object storage
> format, because obtaining this information can be quite expensive. But
> let's consider a different world where we for example store objects in a
> proper database:
>
>   - This database may have an efficient way to compute generation
>     numbers on the fly, either when reading an object or when writing it
>     to disk. We cannot currently store that information in the packfile
>     right now, so it needs to be stored out-of-band. But with a database
>     there is no reason why we couldn't immediately compute and store the
>     generation number on each insert.

Yes, but that does not mean that other parts of the code are not
themselves interested in what generation number a commit has for their
own purposes.

>   - This database may have an efficient way to store bloom filters next
>     to a specific commit directly, without requiring a separate file.

Same thought as above.

> So I would claim that the commit graph is specifically tied to the
> actual storage format of objects, and it's not at all obvious that it
> would need to exist if we had a different storage format.

I am not sure I agree here. What I'm trying to say is that though it's
easy to imagine an object storage format that stores objects in such a
way that the commit-graph file's representation of commits is
unnecessary, there is additional information in what we currently call
the commit-graph that is useful regardless of how fast the actual object
store is.

> The goal of this patch series is thus explicitly _not_ to allow loading
> one commit graph per object source. In fact, the refactorings I did
> ensure that we still only ever load a single commit graph.

Right, though if I understand correctly I think there *is* a behavior
change here in that we will happily fall back to an alternate ODB's
commit-graph if the main object store does not have one. That is not how
it works today.

Thanks,
Taylor
