Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE05332EBB
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343389; cv=pass; b=VrsXneCEMH/6u/LOg8marS1aRrnv3K7jJM9MvBn04Ucfi81v58DUVlbmyt6SlpeD55/zI/48+xG/XJ5Qs9dpHVgpd4OWwYzYhlyhvB0xf98LtrNzqXFob2jEFpHYWyYVsTQxLVH4/6AAmRIwNrlMpzozGL/JotR/xVP6HMN580c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343389; c=relaxed/simple;
	bh=bYRTcDHt5bqvFSFXKxNhDQZxGZbd1LtMupajuaq+NXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYVM8rLUjgdy2Ct67CrrKn9KZKFVx9diIbGCUQO8/ijicWLYkV96kHysZnxZ4vUyaoOBvS+/PdGEWglar0WUlfSnrv277o2ZrBos7lmDGtQ65M8cZ1UwBIxzKvFMgDNv4C75ylndbwI/DCjqsIkvWxnzBgMBXXTX0EiwR8K2nzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQFYZ0aw; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQFYZ0aw"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca069c8so3851785ad.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 06:36:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790343387; cv=none;
        d=google.com; s=arc-20260327;
        b=h9pmIdYOfsYQTeVA5t/NCWwV/w44Xxa0PSHd7+m62iSkzSySiUNGCEeU/gUCqWmw1M
         B6OLAmoD4mRTyL7piSBsJylIO+eguETa6X+s/dtcL7STb5BcVXWjceEVegKF7PCiDDBN
         qiBEDm1ScoFV19vPr7ld4vL3FriSsjc059BvZRV0VprMtWX7fsQ17DjAYopE42jhgWxT
         7GX/dVhNWtr6pof/6OTsInp9fX6vJSpvJ6klHJENYtPz+tiXTq9NK8tLn9Dq725A0Ewa
         3aYDTaQ8lVeowKOfEEnv+y70RrqVpAaT5wINHqYp7IuvA4zgDMojWF5BeqGITHS0xrW9
         KIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oXp4DY3P8a/93R5GS2uoBqnEI87o6GUqYCQh/rYUfqU=;
        fh=glCaWXGmc6Mqjg6YULaf99bOD5gPB3stA6YjpvEjc7c=;
        b=iGntno6wCOViinkfQYt0FRkD9b3Q+36bsmmJN18g7vK+oxglUHnoxtYGAUW3Bdjsfe
         TQ3Mq4j3dmdnkrnQw54aJm9rqtmiVGe4PhAfDGpbqoXvO0BvZOuzPq+Kkj0zPoId1IM/
         4PxcjNUoaDNZHl8qGKEuSWz722LanqbaeQH0mkEjUAvpZpQPU7IXZQOhwfYMg3XbrxxW
         WTDbnjW+IC5dVlbzJgvonVfYgx3DHymHDkoToVzEBVdIsgRsMGTuyXLY2RmRFVUrG2uk
         cPWTmsgFz0Q/p1Pkcic/pkMtl9m6kpe5IEfsetw7DKB+4fHw4hfnnuZb5e+PAePSUfCt
         1xCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790343387; x=1790948187; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oXp4DY3P8a/93R5GS2uoBqnEI87o6GUqYCQh/rYUfqU=;
        b=kQFYZ0awZcyZDspjoy8+2frDL8ZuahqxGZTFlHBBXQik/OjgdOmUbcCC90wspnOCag
         Wo+0EbLYVU/sNKUA3mrGfrwbVCM213cbe38FNF8IJpJJhg2B5rg97GIrl8KnqGyL1s5z
         jQpJltT/vqxF56QiFamlLEWFH5a6sEsFEbB4arq9kx2z1S/+br2WHcwCIP1FaYS7BkBY
         FqJ2rBnTx8IBtfdwOrQ0rtPpVrOE7Q9Q1tiPt3IXJFzapqfMujzKni8hMw8ddu+rqjKO
         aGzkCsU60soYyRCWJvQWsiULiOUiPIZYineSnlMpO8f+yUJPh6DFqcy0xyHsG6ZeW2Ni
         5vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343387; x=1790948187;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oXp4DY3P8a/93R5GS2uoBqnEI87o6GUqYCQh/rYUfqU=;
        b=oXIAiWTLTuVSbX08bRCu8kJ1a+AVrtZmvq1JiuLgy/Hpniwj5haV9jYysxzPJYHTKC
         LN1tdgqmAmkZuhLRlU78tsVuVW2L3sRxutytifAOzmbXezDmHJfl5ALziOrYtBBooWdN
         /fSs7/S/P5EboRhC4hKIJKzYYQIl0aiL2YtoQbhzzI5KyP+I/tFOjIVRhYfJlqrsNAG0
         5p7atKN3xtv3Hn44UzjgGpFzWZpbmxVTBYs2VDFnOC1kALQfj0xvBz+h+FdRj7LclAWZ
         UmuX2g8YcoJMI1ztrQ/hTQ8OVsOUUW/vOqQidocB3yeYhzZERND4oG/fJpG0zeJ2l5Jp
         glNg==
X-Gm-Message-State: AFuF++nlBN/P2J/OBCQvZF61AzwUJpdskLbSdjgXRZX2WMWngATTN05d
	IlePZF1dlzlN9pgbRwt5XpuUFTY8ZGd6ZnHQJBk4gH8JQjULywxtRfbPT2hhW2gHIYRhejtVgsd
	Rd0g0XermfVgoO8/bky2+zsW6ejpgDFi3enkl
X-Gm-Gg: AYBFou3IRo7rdD47Vz5cUcb8KFMrHT6RhWNUotqU/jJMEKhhbm/VCUkedw3ARtlwC8B
	MofEeJF09g4cltpm6Lz21DPieT1yc48ebdrXzitSpta3S2IzE69eEQ5XcNYY1ZKUyTa+Oq4NmGx
	L2NsvJ/stXM7PmmaElewsh31HB9DPhH5iudtM0oCQ54i7ck8rqly6JmBQOAtC6VrZq918GvyrAO
	1o6NEfQusvdUaC4K4I9QTSGgkV3aTvEukDlA7d/smZnbJlr8bG74ZECyugPW+ozrHx7nG79n2QM
	4h37HKYT0WW1uIR6j9Kejo0GNh+XaQYAribOvQQgQc9EW6S3NM9pLN7KS2vtx1vAN3FJPR3s+d0
	wyA0/HR/qVBmRFQa/G3pmQJp2GwDwkBN8eBzLCHw2M9u2+HB9NWc7U6VL32fKbKeehLy0JNz+Kz
	olTfZXT6c=
X-Received: by 2002:a17:903:8c5:b0:2df:9e2d:863e with SMTP id
 d9443c01a7336-2df9e2d8d7fmr5319865ad.41.1790343386970; Fri, 25 Sep 2026
 06:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790168285.git.ben.knoble@gmail.com>
 <5bd4b78cace8ba8c8887c78f739bde3513dfda28.1790168285.git.ben.knoble@gmail.com>
 <232f2bf6-04d8-4a54-b4e9-51b5ee79799f@gmail.com>
In-Reply-To: <232f2bf6-04d8-4a54-b4e9-51b5ee79799f@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 25 Sep 2026 09:36:15 -0400
X-Gm-Features: AclHuK9Q1HvRSPDKxEF7nzdBz2bQ2JTvzO9VgWBY6N48OwZAvY0yktT22VmvdTs
Message-ID: <CALnO6CDTaunaBby+Gy4B5vxiHES3DHpybv8Eq2JPvQ1cteGzrw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] t: test failed "stash apply --index"
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, Victoria Dye <vdye@github.com>, 
	Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Thu, Sep 24, 2026 at 5:42=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Ben
>
> On 23/09/2026 13:58, D. Ben Knoble wrote:
> > The next commit will refactor index handling for applied stashes, so
> > let's make sure we cover conflicted index merging, too.
> >
> > Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
> > ---
> >   t/t3903-stash.sh | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> >
> > diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> > index 721158606f..3958ab3c8d 100755
> > --- a/t/t3903-stash.sh
> > +++ b/t/t3903-stash.sh
> > @@ -374,6 +374,24 @@ setup_stash() {
> >       test_cmp expect actual
> >   '
> >
> > +test_expect_success 'stash apply --index leaves everything untouched o=
n failure' '
> > +     git reset --hard &&
> > +     echo test >other-file &&
> > +     git add other-file &&
> > +     git stash &&
> > +     echo unrelated >file &&
> > +     echo unrelated >another-file &&
> > +     git add another-file &&
> > +     git diff-files >expect &&
>
> diff-files shows the worktree blobs as null object ids, so comparing
> this before and after stashing only tells us that the same set of files
> have unstaged changes, not that the unstaged changes are the same.
> Adding "-p" would check the worktree files are unchanged.

I confess I played with diff-files and diff-index manually before
trying to construct this test case, and I still don't totally
understand how they're being used in the test just prior=E2=80=A6

Anway, it looks to me like "diff-files -p" is the same as "diff -p"
(albeit without some niceties like color-moved applying automatically
from config), so that would make the test quite a bit more
complicated, no? (The "index $sha1..$sha2" line would change=E2=80=A6)

Since we know what the expected contents are, perhaps we can simply
assert on those.

Hm. I spent some time with test_pause in the previous test, and I
think my concerns about that line changing are moot. But, asserting on
the contents is also a bit silly (as that's what the blob IDs are
doing for us in the output).

> > +     echo conflict >other-file &&
> > +     git add other-file &&
>
> I wonder if we should to add "git diff-index --cached HEAD
>  >expect-index" here so we can check the index is unchanged as well. For
> the paths that have unstaged changes we're already checking the index
> object ids via "diff-files", but I think in theory it would be possible
> to have an identical change in the index and worktree that is not picked
> up by that.

So, this test sets up an intermediate state prior to attempting to unstash =
where

- another-file is new in the index & working tree (content: "unrelated")
- other-file is modified in the index & working tree (content: from
"6" to "conflict")
- file is modified in the working tree (content: from "bar" to "unrelated")

And we should still be there when finished. (I wonder if, like the
previous test, we should have a file that differs from itself in the
index and working tree?)

So overall, I'm thinking

- (old) diff-files only shows file is changed
- diff-files -p shows us changes for file, better (and won't show the
other 2 files unless they've become unstaged)
- diff-index --cached HEAD helps us check all the index changes

Phew! Thanks for reading my rambling thinking aloud :)

--=20
D. Ben Knoble
