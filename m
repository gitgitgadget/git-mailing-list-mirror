Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F820210F
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="B7a+di1e"
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D59C422D
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 17:24:53 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a84204e7aeso31368407b3.0
        for <git@vger.kernel.org>; Fri, 10 Nov 2023 17:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699665892; x=1700270692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZtN5jgaqqGr/BZLwZ7401jHKDq3161Mer+aWV0eSgk=;
        b=B7a+di1eZZ+neaFlCR61I5CLgpA7jwZHJdiqW4l1QJ3G72SJwfshIHtuspdjd5HQKk
         M+eNL4IChyDjPGb3ngpRVJXqlT8E4O4ObQevciqn9FqXJeUUuS1DZI35H4MAzm6nN4dQ
         9woLU2gjEtJRp3cfa0fzwWILqErKS2av3mhbPGbK/qb8v5ISVsy4KNnUodYYEwxXrjpr
         mM4xY/8UZPPgeuMLMPNUe9R9tKbQNb5d1A7K1KNP3aMNVCAi8l/tW+D2vX8XjxUmDQDE
         //RwKUJDKREG8KdIck+Ph/IK7i/UsB7g3J4qDGmwoQ3A/KVbtpuzyjpCmFwQgGNAqD/e
         7YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699665892; x=1700270692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZtN5jgaqqGr/BZLwZ7401jHKDq3161Mer+aWV0eSgk=;
        b=cbI1JePz9qTSsAO8GZg7dF/R1HfJqBfZ+UJRlowFv+PNm/JXVlNAS1BsPn9QUXqfjc
         QZGsaH7FxSDflDA1Drv9DZ12MfRFhGX6EWhvRUbQom7Jfu3ReNFGssAGLreZZ9nQqpv9
         eQpIgQY/NbM/0YYIsQe0JOvCBhQCvU5KdLW5ouT2DsVU9sNN1N7pxTRN2xRZhv92J5Pw
         N4R1nn93d+CPfMRrA9PgoKko3/kvI5xyLjlVYfSWyQiPA6vlYzCKMdgcH+LHGSbmnlA9
         a0M6WSncRs63BQRYlLAIb/QMZ+svfLSYmYe3NqoLKKZAAt2FTuX4kQjj33OssdFECUqZ
         m3QQ==
X-Gm-Message-State: AOJu0YxcEepxS2o27dIsAxliV/g9vz3JVo9txxzQ2DTnupA9ZVjX1M8O
	RXaP7TsiLacupm0TRCGZH0WfNQ==
X-Google-Smtp-Source: AGHT+IEauMKA9hoM4kPIsiamEkEewLv4wWM1l87KfxlRbahOD7WDaivb5dGOFvhuwNvjvTo65IJW2A==
X-Received: by 2002:a81:8a04:0:b0:59f:21c1:30b6 with SMTP id a4-20020a818a04000000b0059f21c130b6mr769434ywg.51.1699665892645;
        Fri, 10 Nov 2023 17:24:52 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r7-20020a0cf807000000b0065b1f90ff8csm250218qvn.40.2023.11.10.17.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 17:24:52 -0800 (PST)
Date: Fri, 10 Nov 2023 20:24:44 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, "Eric W. Biederman" <ebiederm@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <ZU7X3N/rqCK/Y9cj@nand.local>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
 <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEfy9VOvimP9==ry_rZXu=metOQ8s=_-XiG_Pdx9c06Ww@mail.gmail.com>

On Fri, Nov 10, 2023 at 03:51:18PM -0800, Elijah Newren wrote:
> > @@ -2108,10 +2109,19 @@ static int handle_content_merge(struct merge_options *opt,
> >                 if ((merge_status < 0) || !result_buf.ptr)
> >                         ret = error(_("failed to execute internal merge"));
> >
> > -               if (!ret &&
> > -                   write_object_file(result_buf.ptr, result_buf.size,
> > -                                     OBJ_BLOB, &result->oid))
> > -                       ret = error(_("unable to add %s to database"), path);
> > +               if (!ret) {
> > +                       ret = opt->write_pack
> > +                               ? index_blob_bulk_checkin_incore(&result->oid,
> > +                                                                result_buf.ptr,
> > +                                                                result_buf.size,
> > +                                                                path, 1)
> > +                               : write_object_file(result_buf.ptr,
> > +                                                   result_buf.size,
> > +                                                   OBJ_BLOB, &result->oid);
> > +                       if (ret)
> > +                               ret = error(_("unable to add %s to database"),
> > +                                           path);
> > +               }
> >
> >                 free(result_buf.ptr);
> >                 if (ret)
>
> This is unsafe; the object may need to be read later within the same
> merge.  Perhaps the simplest example related to your testcase is
> modifying the middle section of that testcase (I'll highlight where
> when I comment on the testcase) to read:
>
>     test_commit -C repo base file "$(test_seq 3 5)" &&
>     git -C repo branch -M main &&
>     git -C repo checkout -b side main &&
>     test_commit -C repo side-file file "$(test_seq 1 5)" &&
>     test_commit -C repo side-file2 file2 "$(test_seq 1 6)" &&
>     git -C repo checkout -b other main &&
>     test_commit -C repo other-file file "$(test_seq 3 7)" &&
>     git -C repo mv file file2 &&
>     git -C repo commit -m other-file2 &&
>
>     find repo/$packdir -type f -name "pack-*.idx" >packs.before &&
>     git -C repo merge-tree --write-pack side other &&
>
> In words, what I'm doing here is having both sides modify "file" (the
> same as you did) but also having one side rename "file"->"file2".  The
> side that doesn't rename "file" also introduces a new "file2".  ort
> needs to merge the three versions of "file" to get a new blob object,
> and then merge that with the content from the brand new "file2".  More
> complicated cases are possible, of course.  Anyway, with the modified
> testcase above, merge-tree will fail with:
>
>     fatal: unable to read blob object 06e567b11dfdafeaf7d3edcc89864149383aeab6
>
> I think (untested) that you could fix this by creating two packs
> instead of just one.  In particular, add a call to
> flush_odb_transcation() after the "redo_after_renames" block in
> merge_ort_nonrecursive_internal().  (It's probably easier to see that
> you could place the flush_odb_transaction() call inside
> detect_and_process_renames() just after the process_renames() call,
> but when redo_after_renames is true you'd end up with three packs
> instead of just two).

Great analysis, thanks for catching this error. I tested your approach,
and indeed a flush_odb_transaction() call after the process_renames()
call in detect_and_process_renames() does do the trick.

> What happens with the odb transaction stuff if no new objects are
> written before the call to flush_odb_transaction?  Will that be a
> problem?

I think that the bulk-checkin code is flexible enough to understand that
we shouldn't do anything when there aren't any objects to pack.

> (Since any tree written will not be re-read within the same merge, the
> other write_object_file() call you changed does not have the same
> problem as the one here.)
>
> >@@ -4332,9 +4349,13 @@ static int process_entries(struct merge_options *opt,
> >                fflush(stdout);
> >                BUG("dir_metadata accounting completely off; shouldn't happen");
> >        }
> >-       if (write_tree(result_oid, &dir_metadata.versions, 0,
> >+       if (write_tree(opt, result_oid, &dir_metadata.versions, 0,
> >                       opt->repo->hash_algo->rawsz) < 0)
> >                ret = -1;
> >
> > +
> > +       if (opt->write_pack)
> > +               end_odb_transaction();
> > +
>
> Is the end_odb_transaction() here going to fail with an "Unbalanced
> ODB transaction nesting" when faced with a recursive merge?

I think so, and we should have a test-case demonstrating that. In the
remaining three patches that I posted to extend this approach to 'git
replay', I moved this call elsewhere in such a way that I think

> Perhaps flushing here, and then calling end_odb_transaction() in
> merge_finalize(), much as you do in your replay-and-write-pack series,
> should actually be moved to this commit and included here?

Yep, exactly.

> This does mean that for a recursive merge, that you'll get up to 2*N
> packfiles, where N is the depth of the recursive merge.

We definitely want to avoid that ;-). I think there are a couple of
potential directions forward here, but the most promising one I think is
due to Johannes who suggests that we write loose objects into a
temporary directory with a replace_tmp_objdir() call, and then repack
that side directory before migrating a single pack back into the main
object store.

Thanks,
eaylor
