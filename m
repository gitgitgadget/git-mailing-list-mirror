Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A470BC433DB
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 15:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7154164DDC
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 15:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBSPZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 10:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSPZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 10:25:25 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FEEC061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 07:24:42 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id m2so4618981pgq.5
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 07:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+2QdN0GCc0iE5X37sQGbucsaPB8yTBe4cIVAuRIV9uU=;
        b=oWj4+l5GzPHK42ltDJYRwIDjlztZR4np+hYkpqjD4QWVbnRpeaP7UdMwRXHA/o+HBJ
         4Jq2N82X6g8KGT7lagUJg7Amqzd+M4kTHq5qMCTGEBAFRR0Qa6eTES3acSAbPbnRliBb
         k100kaoAxL2dEfmA3s9c9Mz/h6ZWoR3hXbz3ZbPYW2TWmcc1KTeUVoHQs+IzzvmqAtXy
         a9LsYgjFi4STk+lCtVxkg6IFOKEuhu2vHnJ/9xruq2g5lvo0qTsmphLHcC9j/Ig0qVL2
         AjNXtBrSZAGx4vmotTJM3DT3Wmcgrf5eLDO1ABtMlKfVM0U88kcOS6pqGyxrYYyxNpLD
         89Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+2QdN0GCc0iE5X37sQGbucsaPB8yTBe4cIVAuRIV9uU=;
        b=E6cYSSxW0SeIsWcLY8WRbQdJ5UFREcdDzPqV+zd/mbwa2MuLO9JJ4Ncks7w1TWzY9q
         nMDxDQJX0VKw/mGoJ6J22M2iIVpDAIzP/onXFLe9/WJapZtZ6PmVL8o6p1HwoOPRlszI
         cRToQyaZnWGmUhuulUlsvKlvCNARhktunpPPnvbZSwnfj0YSK4GvYagIRwIK+9tQEA4d
         WAdTTW1TtziRo9y3PdHfo2qIpHZAP8FP95AAsZqtr4ZiI/ImoaQnro9XVFkOMPFx10ws
         li1o5iH9r0vXBY8Q9QW+LRyPi0ZouRXgYBdO8jcLRXkRgvSGa6yb4q0h0I2OKsYmDKwQ
         bseA==
X-Gm-Message-State: AOAM530NlQ2VrtmbI2OuRfKD51qKE3i2MP5Z8HIwbEXCQ1k77KiS3t6G
        ejI/A/kUpeVVMDkuSf1jEAjpZVsWXOQ=
X-Google-Smtp-Source: ABdhPJzKfJ9PaqGlsTNnCvv5LgfzZJIbBd6EEqtHSXDdQpoYbDQiCTA5w8X9CMJyGYDTPfuYNJ0Wzw==
X-Received: by 2002:a63:4b61:: with SMTP id k33mr8901910pgl.76.1613748282336;
        Fri, 19 Feb 2021 07:24:42 -0800 (PST)
Received: from konoha ([122.176.159.190])
        by smtp.gmail.com with ESMTPSA id t4sm9943232pfe.161.2021.02.19.07.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 07:24:41 -0800 (PST)
Date:   Fri, 19 Feb 2021 20:54:36 +0530
From:   Shourya Shukla <periperidip@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        levraiphilippeblain@gmail.com
Subject: Re: [PATCH 1/2] rm: changes in the '.gitmodules' are staged after
 using '--cached'
Message-ID: <20210219152436.GB6254@konoha>
References: <20210218184931.83613-1-periperidip@gmail.com>
 <20210218184931.83613-2-periperidip@gmail.com>
 <xmqqblchdoej.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqblchdoej.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/02 02:03, Junio C Hamano wrote:
> Shourya Shukla <periperidip@gmail.com> writes:
> 
> > +		if (list.entry[i].is_submodule) {
> > +			/*
> > +			 * Then, unless we used "--cached", remove the filenames from
> > +			 * the workspace. If we fail to remove the first one, we
> > +			 * abort the "git rm" (but once we've successfully removed
> > +			 * any file at all, we'll go ahead and commit to it all:
> > +			 * by then we've already committed ourselves and can't fail
> > +			 * in the middle)
> > +			 */
> > +			if (!index_only) {
> > +				struct strbuf buf = STRBUF_INIT;
> >  				strbuf_reset(&buf);
> >  				strbuf_addstr(&buf, path);
> >  				if (remove_dir_recursively(&buf, 0))
> >  					die(_("could not remove '%s'"), path);
> >  
> >  				removed = 1;
> > -				if (!remove_path_from_gitmodules(path))
> > -					gitmodules_modified = 1;
> > -				continue;
> > +				strbuf_release(&buf);
> 
> Since we won't come to this block when doing index_only, we are
> allowed to touch the working tree contents and files.  We indeed do
> "rm -rf" of the submodule working tree and touch .gitmodules file
> that is in the working tree.
> 
> >  			}
> > +			if (!remove_path_from_gitmodules(path))
> > +				gitmodules_modified = 1;
> > +			continue;
> 
> But this looks wrong.  It might be OK to remove from the .gitmodules
> stored in the index, but I fail to see why it is justified to touch
> the working tree file when "--cached" is given.

No no, you are correct. Phillipe pointed out the same thing. I don't
know how I made this mistake.

> > +		}
> > +		if (!index_only) {
> >  			if (!remove_path(path)) {
> >  				removed = 1;
> >  				continue;
> > @@ -396,11 +398,15 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
> >  			if (!removed)
> >  				die_errno("git rm: '%s'", path);
> >  		}
> > -		strbuf_release(&buf);
> > -		if (gitmodules_modified)
> > -			stage_updated_gitmodules(&the_index);
> 
> Assuming that it is somehow justifiable that removing the entry from
> the .gitmodules in the index (again, I do not think it is
> justifiable to remove from the working tree file), we no longer can
> use stage_updated_gitmodules() helper as-is.
> 
> I think you'd need to
> 
>  - Add a variant of remove_path_from_gitmodules() that can remove
>    the given submodule from the .gitmodules in the index entry
>    without touching the working tree.  The change could be to update
>    the function to take an extra "index_only" parameter and a
>    pointer to an index_state instance, and
> 
>    (1) if !index_only, then edit the .gitmodules file in the working
>        tree to remove the entry for path;
> 
>    (2) in both !index_only and index_only cases, read .gitmodules
>        file from the index, edit to remove the entry for path, and
>        add the result to the index.
> 
>    and return 0 for success (e.g. if path is not a submoudle or no
>    entry for it is found in .gitmodules, it may return -1).
> 
>  - Since the previous point will maintain the correct contents in
>    the index in all cases, get rid of gitmodules_modified and calls
>    to stage_updated_gitmodules().  The call to write_locked_index()
>    at the end will take care of the actual writing out of the index.
> 
> if we want to teach "rm --cached" to update only the index, and "rm"
> to update both the index and the working tree, of ".gitmodules".

Yeah, this approach seems perfect. I will do it this way.

> Having said that, I still do not think it is a good direction to go
> to teach low level "rm", "mv" etc. to know about ".gitmodules" (yes,
> yes, I know that some changes that I consider to be mistakes have
> already happened---that does not mean we cannot correct our course
> and it does not mean it is OK to make things even worse).  Such a
> "how does a submodule get managed" policy decision belongs to the
> "git submodule" subcommand, I would think.


Let's do it this way. I will deliver a v2 of this patch, if we get
comments from anyone stating that this should not go forward, then we
will drop this patch or do what is suggested. Else, queue this patch for
now (given that this does not break anything, obviously) and maybe put
up a RFC for the method you suggested. I am saying this because we have
not received any conclusive evidence of whether this patch should carry
on or not (not trying to disregard your take).

What do you say?

