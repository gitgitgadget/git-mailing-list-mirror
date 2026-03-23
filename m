Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82138759C
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774259161; cv=none; b=Nhiww9eVTQ++oJOV5C/glzFxIMEmk5TRF43cT0T5EOXF3jpNgvSJefKRBMRXj1KBO1FT705UcZvmVQyGlfIGYRaep033GimCJL+S3AQAwtWqKBQxcL6VOGpEFvpk+HV5amvoKTAWncgcSaYBgONTqS3xf6/DpIGmfOX0oOWBfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774259161; c=relaxed/simple;
	bh=OuUChCUWRml/dK28Vxzq+sACAIsw32MRQMZq+FqXkHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRz8Munhe9k8tipygSP2oVr5zJB5PvvtaOb44w/b+yDcIdcGjPNnQ3tTz9aFUo1/qdMEBA4jsXSWYH66Gyz4uKtpQ335O9BOjey3pEKe415xXHUo17uaHhE29GqgcIspT+CDXdk6PmgGNI9aAujzwZ2Ju7mRMyEPM/CmK5kLf74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae5XHtht; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae5XHtht"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82a67ce6969so2940556b3a.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 02:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774259159; x=1774863959; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RJU6Zr4HFdcXd7XYO5vIBtVeN3SewXqK3ZiTKq520AM=;
        b=Ae5XHthtDl4VanM2toi+pi1cL5ca1S+AsmxVcdCxVpo1gnl0uaDtmCZ7WI1rfaXHnn
         Hnfu2Mon6LQtQgQQxN7PU2tGGmoaAqlB0/ULJ7RzZABC2FUmQM74TiTmGOWS4nGArTxA
         ikUeujHady7pdujBPTBrGnEAfeEqs5g312GChk3fSecJjfjpWeRH98NwuROuPQKU7aPp
         WtqN3iRPRIqo9ETydJNVzVBm0npKvEKF7DfqLy9PJAXbIZCxVpK1Ve7i0XlgCCr0OvKs
         7u2roqK6LwOYMZmfbX4Gh2C4Z23Qg36xFCUQnm3vGDcQb69OApcItJYeBbFSg4LVqExu
         Bnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774259159; x=1774863959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJU6Zr4HFdcXd7XYO5vIBtVeN3SewXqK3ZiTKq520AM=;
        b=UibY/ix8kvW6eEl5viZfTf1oZgQqMM2FUaxHvwZJbY/BRK1icvgmleBWf07Lq9WvjP
         ndIPAsE5g6k1m8qYnJRiIJv5Mu2d+7lgWcdC+sUSX+ZWm4NwOnzDdmmWG/Q3MA4xClsQ
         ypHA0icXBqVKk4YV6L78+VSlhcNFHj7T5x/sXAw54co4Xq8QkOC0ytZHvO22BKgZSc/f
         GlyibK+iNqzoarLQ8gZcGRY6o7wSHBgoTpzW15eBozyNtuxr2OQLx196TPQh4UVOaiOs
         RHngSEC2FRyqEKnH990iMORCHHV0Hy5PZ7KCdxj8PQ/Bh+UIMylTBT1KpWlzH803oqnd
         fzcg==
X-Forwarded-Encrypted: i=1; AJvYcCVWVbS6tYLClj7iLbDCqGz7x6ghEBBTaUHJVHcDYb2vIe2BoKsVpgXxrjIAk/J3LH3VwAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkt1hxwC5OZ8T66qVYlzwe56JbCAJMgsZaJYx70kp3158eUNgJ
	jMsdYm3S+7vmnIw8wvjhthk0Cxk6ToC+1YkiPc0qnKDifUPw8GFmx+QyoRsydeINLGg=
X-Gm-Gg: ATEYQzyMNmKFyKMaqfr+yszPKHBrhPR0JlD7dvVp3oqFzRys/XfQDKb34IuxxCd82+O
	WQOfdrotmC43kTk9Ta6zhQaWDrjFJvxPTn1EuXhLN6B4xR/NV5dGMlZ3pnrLEuyqmHZ/EF8UH0T
	1B1Ya/BG6gqM76zUL6xdYyvDXvqubu9Cko1BmnUFczxGR3vm0IVUO+StLdH73P3huUlaVTApD/7
	J9Vc2hk8bewePA+hRtqXYTxkbB3J1uq6QcQx8moKJtkC872f4mgF1iWKFQtIa5HsewXOeAvYHZs
	Y9zx8bwj8kfCDmEQ9w4iNheF5Pl+BZX1R8+Z+qd0LevCQ5EqHtmSXLq2STpA3KI9Kh7moOQBG7V
	ZgKOSU4c6ve/DhovOPiqNkSzN0KARQ2v+D7xF19Oh/nwzzqy9SEqfk3tsoLOVgueVxcCHbrC0ID
	GWkrMidxqs2PioGwDfWCDzQ/kt0fxOWZYTAZ7WI3Xtsg1aQf1dFRXDMqAk66QJpkcqpDCOcxknR
	jE+kOVnpEWqHjWHYeBd3ly1dfpL9Bz0Wlh41BrCcBKF/Rg0u2hYGcM=
X-Received: by 2002:a05:6a20:7d9a:b0:366:2447:6778 with SMTP id adf61e73a8af0-39bcec29441mr11257383637.53.1774259159198;
        Mon, 23 Mar 2026 02:45:59 -0700 (PDT)
Received: from ThinkPad-E14-Gen-6 ([220.158.168.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443cc2ddsm6890003a12.24.2026.03.23.02.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:45:58 -0700 (PDT)
Date: Mon, 23 Mar 2026 15:15:43 +0530
From: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
Subject: Re: [PATCH v1] path-walk: fix NULL pointer dereference in error
 message
Message-ID: <acELx_n-RK3qwz1Z@ThinkPad-E14-Gen-6>
References: <20260320114823.3151961-1-ysinghcin@gmail.com>
 <CALnO6CDnwYaAPhp67kaYWtV48ULjWAR6ks1khVXmSs1oWUbRDQ@mail.gmail.com>
 <994f92e9-3576-455a-a142-0fefc559131c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <994f92e9-3576-455a-a142-0fefc559131c@gmail.com>

On Fri, Mar 20, 2026 at 12:14:19PM -0400, Derrick Stolee wrote:
> On 3/20/2026 11:16 AM, D. Ben Knoble wrote:
> > On Fri, Mar 20, 2026 at 7:50 AM Yuvraj Singh Chauhan
> > <ysinghcin@gmail.com> wrote:
> >> @@ -171,7 +171,7 @@ static int add_tree_entries(struct path_walk_context *ctx,
> >>
> >>                 if (!o) {
> >>                         error(_("failed to find object %s"),
> >> -                             oid_to_hex(&o->oid));
> >> +                             oid_to_hex(&entry.oid));
> >>                         return -1;
> >>                 }
> >>
> >> --
> >> 2.53.0.582.gca1db8a0f7
> > 
> > Interesting find. I was hoping to see an easy way to reproduce hitting
> > this code, and after grepping around a bit I found a few places that
> > end up in this code (git-backfill and git-repo being the primary
> > callers of walk_objects_by_path), but on second glance I think "!o" is
> > current dead code.
> 
> I can appreciate that the existing code is clearly incorrect, so
> tooling scanning code for defects would find this even if we can't
> easily create a test case to demonstrate it.
>  
> > Still, fixing such obviously wrong dereference is good, but I wonder
> > if we should go further?
> > 
> > You mentioned git-backfill with a tree missing from the local odb; do
> > you have a short reproduction script or test-case?
> 
> I imagine that it would be difficult to set up such a case, but maybe
> it would follow these steps (based on existing 'git backfill' tests
> that start with a partial clone):
> 
> 1. Make a bare, blobless partial clone of the server repo.
> 
> 2. Explode the client repo's object store into loose objects.
> 
> 3. Delete a loose tree object, but one that isn't a commit's root
>    tree. It must be a child tree.
> 
> In this case, we should hit this issue. Blobless partial clones
> expect all reachable trees to exist locally and so are not prepared
> to download missing trees on-demand.
> 
> Thanks,
> -Stolee

Thanks for the suggestions on how to reproduce this.
I traced through the code paths and believe the scenario described
(blobless partial clone, explode objects, delete a child tree) would
not actually reach the '!o' branch. Here is my reasoning:

When add_tree_entries() encounters a child tree entry whose OID is
missing from the ODB, it calls lookup_tree(). Since the OID was never
previously registered in the parsed object hash, lookup_object()
returns NULL, and lookup_tree() falls through to create_object() which
allocates a shell object. So 'child' is non-NULL, 'o' is non-NULL, 
and the '!o' check is not reached.
The missing object would instead fail later: when the path-walk tries
to visit the child tree via a subsequent add_tree_entries() call,
repo_parse_tree_gently() attempts to read it from the ODB, fails, and
returns the "bad tree object" error at the top of the function.

The '!o' path is reachable when the OID in a tree entry was
"previously registered" in the parsed object hash with a different
type. In that case, lookup_blob() or lookup_tree() calls
object_as_type(), which detects the type conflict and returns NULL.
This is what happens with a corrupt/confused tree that references a
commit OID as a blob entry, the commit was already registered during
the revision walk, so object_as_type(obj, OBJ_BLOB, 0) returns NULL.
For v2, I've added a test that exercises exactly this path:
    # Create a tree with a blob entry pointing to a commit object
    commit=$(git rev-parse HEAD)
    bad_tree=$(perl -e 'print "100644 confused\0" . pack("H*", $ARGV[0])' \
    "$commit" | git hash-object -w --stdin -t tree)
    git pack-objects --path-walk --all /tmp/test-pack <<< "$bad_tree"
This constructs a tree where mode 100644 (blob) has a commit OID.
During --path-walk, the commit is registered as OBJ_COMMIT by the
revision walk via --all, so when the tree entry is processed,
lookup_blob() → object_as_type() returns NULL, triggering the bug.

Please review

Sincerely,
Yuvraj
