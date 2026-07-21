Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E7D264A86
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784610327; cv=none; b=cqur68llYVHNdPewtTNl/yZ5nf7yrK7DJtsLmP9fBWZTBS2SDpRA2KMZIfCayRIMl1HrvhF2OpsTF4MCDxaT/jsNBegtDGKfPJ37Z2rr638if63cTcVptDmmtIc7Et6bwaAdX8fHKcw2fWh7Fg0CG1APftgOW9kwTY0dYBhPhCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784610327; c=relaxed/simple;
	bh=vDyeQYdZ1aATyr0lk4e59rv6tKUmA4/eCxjVtSwD1ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYY9KzQXMFWoXGFwNV1qUBIHdK0u+v2SJDMKzrqGk1xFruY1UYTyN42ouT7WhXsR1tLnKLTdZer/ViL8KKpRJimmJLtjsK9zkhRwglFUGnAhkDPqcQL9ok8CNXY3PQSnlBzggBduXKhojGfJTLHcIOvE5JzJncXHwS3SSqE/ynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Fo/WS78w; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Fo/WS78w"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6685483aad2so1992137d50.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 22:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784610325; x=1785215125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rGEShrbSsR/2CDzeczor/gvivWxwUVVy4UICHfhMLKo=;
        b=Fo/WS78wzZ5WJIiopbN4hkGGsZOAanOBkoamTgQvw/6JHKECBKg7Rj4szxiNmlgG5e
         sa3EWomoF/9sNNJo0Ovpos4vZ4dWz5uGSy20QSrua/AU6Qp1lU4AXujPac5k+Zjh1zsL
         Jqi8rC8dt9H5K/V09cVF8FNs9onywvRLriPzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784610325; x=1785215125;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rGEShrbSsR/2CDzeczor/gvivWxwUVVy4UICHfhMLKo=;
        b=p++SJvpB1zKfGbfo9bgMIOE+qMyCUsBNz0lUTcxYYJhq0PLVQ5rGO/kKanxDstpwLq
         5gECLXu2otG6Ln32DggOKM4e0omUSoC8QgmkK/FK1NDpghxWBPCdQfUdS8GbnqbqHNlB
         EYqjBKqxPF7UnBs4lQNuPx+1pjJH78Woo/P7K6WATD2A2eqv7Gn0ikcrk6X1ANR47SM5
         FU4LqdTm4tiwzoUnv4BExNJy46fQ1ZoEvOVuN6bgqU52cG3f1fGbf2beUPUemHwwZgsP
         5CgKU26EqAa0xxN8Gxyor9yuTtJP+Hon/ub5OHD/q3gl5k1AVuVWR1JYu1Rg4EhwxMrQ
         vfZg==
X-Forwarded-Encrypted: i=1; AHgh+Rp97JUAmkwIGZcupUpu1v7wHuh84Ecu5OUXx7udSS5CcJGzG7dL9H1s83gqGiLJUJJdsdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrU4ibphTLdg7f/DrqEli1pTbRlhkZ+E+fHXX/pkYeHRuqipXi
	/v84kkWH1myolqEFG5z8poqvNiivlkMkiV8qPUgRjBV8ZsVWM/YP0d5HkwxWLuVOwazl+yb/WM0
	hoT+18mj2hQ==
X-Gm-Gg: AR+sD136RMU/n2aRRRxTLYxNkI/2LIF3NaXcyVSKYRyi5zjN4wamAule0QnbxOstlY9
	8SdqODQ1cY5bHWMKxsCnouGTpA7fVif7yhtWZayUC694wLwzMotIyEbJy2jWbE1/Q30DOk9t0+9
	m3vOnLnJ3pNQqrbFFRWdig+KskjDVfbfyCL4uCJKoC7DbwA2TyEUyh1gxJYCdwXhTwBQIVJt93m
	fW9QQ6qfWbpgG0X58DtKPTu2FI6P3FvQuluO1thS04BWTA++Hka4TkjzJLMZO7iUvI7LWtPjopa
	psyUUrXy0S6ke25u+DzNoEjoYl6mXRTa4KSrwl7/Oo4Q0gXYWwk/z960Q83s1Ul3SuOBl1kScl4
	PMtw/wWJFNzcZPnEj7TGaHe7nelUaFwVnAeONBBlHg5D+DtnilYD4Jj7pYcbzXrh7pfZwNmReoR
	PRCSz0StHloIxsjmZunhGaSQlDEERm2vfFJZW+JFqwUXJEN2Q8G5fBj8+zbmon89JXRPnbCQ==
X-Received: by 2002:a05:690c:eca:b0:81e:ae6f:ac0a with SMTP id 00721157ae682-81ef277db23mr52093657b3.24.1784610324731;
        Mon, 20 Jul 2026 22:05:24 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42763absm58486567b3.32.2026.07.20.22.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 22:05:23 -0700 (PDT)
Date: Tue, 21 Jul 2026 00:05:21 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Jeff King <peff@peff.net>
Cc: Wolfgang Kritzinger <wkritzinger@atlassian.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: Performance regression in connectivity check during receive-pack
 (git 2.54)
Message-ID: <al7-EaWaW3BYq4Nj@com-79390>
References: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
 <20260721035733.GA581473@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721035733.GA581473@coredump.intra.peff.net>

On Mon, Jul 20, 2026 at 11:57:33PM -0400, Jeff King wrote:
> On Tue, Jul 21, 2026 at 03:17:23PM +1200, Wolfgang Kritzinger wrote:
>
> > `strace` shows that after a push, 2.54 does a failing open() of
> > of numerous loose objects -- once in the quarantine (incoming)
> > directory and once in the main object store -- before finding it
> > in a pack:
> >
> > openat(".../objects/tmp_objdir-incoming-XXXX/ed/58..", O_RDONLY) = ENOENT
> > openat(".../objects/ed/58..", O_RDONLY) = ENOENT
>
> Interesting. Here's a smaller reproduction recipe that shows the issue:
>
>   # clone of git.git, or any other non-trivial repo; it should be mostly
>   # packed
>   src=/path/to/git
>
>   git init empty
>   export GIT_ALTERNATE_OBJECT_DIRECTORIES=$src/.git/objects
>   strace -fe openat \
>     git -C empty rev-list --objects $(git -C $src rev-parse HEAD) >/dev/null
>
> In v2.50, we see almost no loose object open calls, because we check the
> pack first. But in v2.54, we see tons of them.
>
> > 2.50 does not do this. In most customer deployments of Bitbucket,
> > the Git data lives on an NFS share. The extra latency on NFS makes
> > this process of checking for non-existent loose objects take too
> > long, the push essentially hangs at the "Checking connectivity" step.
>
> Yeah, I can imagine. But even on a fast filesystem, we definitely want
> to avoid all of those syscalls. Replacing "strace" above with a timing
> harness, even on a system with fast syscalls and a warm cache, the v2.54
> version is ~12% slower.
>
> > I believe this new behavior was introduced in the recent object
> > database rework. After using bisect, I belive the problem can be
> > traced back to commit 8384cbcb4c.


> Hmm, my bisect ended up at a593373b09 (packfile: refactor
> `find_pack_entry()` to work on the packfile store, 2026-01-09), which is
> nearby. I'm not sure if it might depend on other factors (e.g., presence
> of commit graphs, midx, etc) or my reproduction is not exactly like
> yours, or if one of us messed up bisection.
>
> +cc Patrick as the author of both commits.

I think that both bisection results are equally valid for different
reasons.

Before 8384cbcb4c, 'find_pack_entry()' did

    packfile_store_prepare(r->objects->sources->packfiles);

, then tried each of the stores in order to first see if (1) a MIDX was
available to locate the object in some pack, or (2) failing that, if
there exists some non-MIDX'd pack which could do the same.

Worth noting is that 'packfile_store_prepare()' effectively did:

    for (s = store->source->odb->sources; s; s = s->next) {
        prepare_multi_pack_index_one(s);
        prepare_packed_git_one(s);
    }

Thus preparing the first store also prepared every alternate store,
enabling 'find_pack_entry()' to search through all store's MIDX and
pack lists/sources.

8384cbcb4c changes this such that 'packfile_store_prepare()' now only
prepares its owning source:

    prepare_multi_pack_index_one(store->source);
    prepare_packed_git_one(store->source);

, which is reasonable, but 'find_pack_entry()' still loops over all
sources starting from 'r->objects->sources' and calls the function
'packfile_store_prepare()'. But! It calls that function over the same
argument each time, like so:

    for (source = r->objects->sources; source; source = source->next) {
        packfile_store_prepare(r->objects->sources->packfiles);
        if (source->midx && fill_midx_entry(source->midx, oid, e))
            return 1;
    }

So we never prepare the packfile store from other sources!

In Wolfgang's case, if we have an quarantine store followed by the main
object store, our lookup order will be:

 1. prepare the quarantine object store
 2. search packs in the quarantine object store
 3. search packs in the main object store (which will fail, since this
    list is guaranteed to be empty since we never called
    'packfile_store_prepare()')
 4. search loose objects in the quarantine object store
 5. search loose objects in the main object store
 6. haven't found anything, so we must reprepare
 7. search packs in the main object store, which will now succeed, as
    the previous reprepare called 'packfile_store_prepare()' on the main
    object store's packfile source.

Commit a593373b09 changes things, since it makes 'find_pack_entry()' no
longer operate over the entire repository, but over a single store.
Before searching that store, it prepares it, like so:

    static int find_pack_entry(struct packfile_store *store,
                               const struct object_id *oid,
                               sturct pack_entry *e)
    {
        struct packfile_list_entry *l;

        packfile_store_prepare(store);
        if (store->source->midx && fill_midx_entry(...))
            return 1;

        for (l = store->packs.head; l; l = l->next) {
            struct packed_git *p = l->pack;
            if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
                /* ... */
                return 1;
            }
        }

        return 0;
    }

So commit a593373b09 indeed squashes the bug introduced by 8384cbcb4c,
and when lookup reaches the main store, it prepares the main store
correctly.

But a593373b09 also changes the lookup order, because the caller in
'do_oid_object_info_extended()` already loops over sources!

    static int do_oid_object_info_extended(struct object_database *odb,
                                           const struct object_id *oid,
                                           struct object_info *oi, unsigned flags)
    {
        /* replace objects, cached lookups, etc., ... */

        odb_prepare_alterantes(odb);

        while (1) {
            struct odb_source *source;

            for (source = odb->sources; source; source = source->next) {
                if (!packfile_store_read_object_info(source->packfiles,
                                                     real, oi, flags) ||
                    !odb_source_loose_read_object_info(source, real, oi,
                                                       flags))
                    return 0;
            }
        }
    }

Before a593373b09, that call to 'packfile_store_read_object_info()'
looped over all sources, since it still called 'find_pack_entry()'.

In other words, prior to a593373b09, the lookup proceeded like so:

 1. search packfiles in quarantine
 2. search packfiles in the main object store
 3. search loose objects in quarantine
 4. search loose objects in the main object store

But a593373b09 changes that to instead proceed store-by-store, as
follows:

 1. search packfiles in quarantine
 2. search loose objects in quarantine
 3. search packfiles in the main object store
 4. search loose objects in the main object store

So even with all object sources prepared, every object found in a later
source pays a failed loose object lookup in an earlier one, which I
believe matches what Peff strace'd above.

So both bisections make sense. If the later store has not been prepared
yet, commit 8384cbcb4c is where Git first fails to see its packs and
falls through to loose object checks. If the stores are already
prepared, that problem does not show up, and a593373b09 is where Git
first starts checking loose objects in an earlier source before looking
in a later source's packs.

I think that something like the following (untested) would fix the
immediate issue:

--- 8< ---
diff --git a/odb.c b/odb.c
index cf6e7938c0..aeb2915f0f 100644
--- a/odb.c
+++ b/odb.c
@@ -568,9 +568,28 @@ static int do_oid_object_info_extended(struct object_database *odb,
 	while (1) {
 		struct odb_source *source;

-		for (source = odb->sources; source; source = source->next)
-			if (!odb_source_read_object_info(source, real, oi, flags))
+		/*
+		 * Check all packed sources before trying loose ones. A loose
+		 * miss requires a filesystem lookup, and receive-pack's
+		 * quarantine source makes the main object directory an
+		 * alternate.
+		 */
+		for (source = odb->sources; source; source = source->next) {
+			struct odb_source_files *files =
+				odb_source_files_downcast(source);
+
+			if (!odb_source_read_object_info(&files->packed->base,
+							 real, oi, flags))
 				return 0;
+		}
+		for (source = odb->sources; source; source = source->next) {
+			struct odb_source_files *files =
+				odb_source_files_downcast(source);
+
+			if (!odb_source_read_object_info(&files->loose->base,
+							 real, oi, flags))
+				return 0;
+		}

 		/*
 		 * When the object hasn't been found we try a second read and
--- >8 ---

But...

> I'm not sure of the correct fix. This is working against the whole "odb
> sources are independent and abstract" refactoring that a593373b09 was
> going for. But I think it's an important optimization. I guess the
> abstract version would be that each source has "fast" and "slow" lookups
> or something like that, and we check all fast ones before slow ones. But
> that is pretty gross.

...that fix is breaking the very abstraction that the pluggable-ODB
effort is trying to create in the first place, at least in my
understanding of the project's goals.

> I'll leave it to Patrick to ponder further. I haven't really been paying
> a lot of attention to the odb refactoring.

I am genuinely not sure what the right path forward here is, given that
I do not have a super firm understanding of all of the refactoring that
has taken place here. I would be likewise eager to hear from Patrick or
others with thoughts on how to resolve this.

Thanks,
Taylor
