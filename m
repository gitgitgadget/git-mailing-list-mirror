Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50602C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 22:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiG0WAr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 18:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiG0WAq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 18:00:46 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353853D5B6
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 15:00:45 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10e615a36b0so183116fac.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CYNxKHbawhLikfhwAO4lYXoWI9uWkXbGUww7XzZIoic=;
        b=M+ePW7YTZhhGPsEKnNOOGIbx12S/ta2QnY1ExYgMUbT8i/2awB6s9LVQ9qvksB1MaA
         tZtkYOyPMwtpsvD22tGPa5zp1u+jKRnVvpxV2SJwHwZCZ+peCMUwFh1OuS7QcJzf1ZOk
         JlAgVr/VZk46tjvJ5NBG1INwg80nLj8ixZyXtH8UAW+p893tf+4QIPuZeHgZWFuzYNSL
         95fi5B+tCxRKX2fD2UqpyevoVyTJ0uTyEQ9ZaPzpKwjRJKmOkM+cxRtbXE0HfEowKpFT
         HVZPLaKouRvEpq8OisqG1wx39dx2Dng2bFCkwW/MX3h61LH57bYOFqWSXI32zpBq1FBR
         o8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYNxKHbawhLikfhwAO4lYXoWI9uWkXbGUww7XzZIoic=;
        b=X/FIIdQ/dIFCC4iILIeL3/Vl+lbyLbiraSKXyOXnYTsWWqsIHL4pN+ZlHRz0C9yRKo
         64SENhBeqFnEI4fXbUNGKF5YaivswC2ff79gTI1itmd0ocT4Zo663cH2JInrbXHRUXOe
         B/qaDpOns6DJ4S35CzIBytQU44NTaU48F6fAVp4I5/R1L6gs1oJikkdQFNaoZug0kyOe
         eN61fTAB03qvCyNsZR9XTWR/mE+G1GiW4daXRz3mUaMSeA8fjcDnSSomUIz5zqeR9UVF
         jmz2akL1/Zr9RY26ZesDCtW20fcGQLcf93QsJpSvv1nNincW4ht6w2dtkdMynRrqLO/G
         BkWw==
X-Gm-Message-State: AJIora+63CVfvuXK0Z8MJ1F4eISlV5MsE98p+M74ny8qJSWT2K5mg7Rj
        t5AnZlGRBn8Eq+b1JN3s+8O+T+HpLk3tc6goRbTtDQ==
X-Google-Smtp-Source: AGRyM1uk4YBp/jAKESnm2eoGBvioIcqwStXyeeuXRggwJbB8uY2UmNYrhy82HPkCAaAE/UwBnoTslmWobd+RBDme2lE=
X-Received: by 2002:a05:6870:c0d2:b0:10d:7752:e02e with SMTP id
 e18-20020a056870c0d200b0010d7752e02emr3238199oad.236.1658959244352; Wed, 27
 Jul 2022 15:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220718214349.3379328-1-calvinwan@google.com>
 <20220726210020.3397249-1-calvinwan@google.com> <CABPp-BGvDLvmj720PFzsjrZrYuYauprL6JeOQhiQ4BjtfjF7Dg@mail.gmail.com>
In-Reply-To: <CABPp-BGvDLvmj720PFzsjrZrYuYauprL6JeOQhiQ4BjtfjF7Dg@mail.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 27 Jul 2022 15:00:32 -0700
Message-ID: <CAFySSZB6bB0qqCv5EPmJBJY9RbDRFv8JDYj89W+ND_Jw6Ys1kA@mail.gmail.com>
Subject: Re: [PATCH v6] submodule merge: update conflict error message
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Well explained.  One very minor suggestion: perhaps change "id of the
> commit" to "id of the submodule commit" just to make it slightly
> clearer that this information would take work for the user to discover
> on their own?  (When I first read it, I was thinking, "but they have
> the commit, it's what they passed to merge", before I realized my
> error.)

ack

> Sorry for not catching this in an earlier round, but merge_submodule()
> has four "return 0" cases, for particular types of conflicts.  Those
> should probably be switched to "goto cleanup" or something like that,
> so that these messages you are adding are also provided if one of
> those conflict cases are hit.

I didn't send these four "return 0" cases to cleanup because I thought
the error message wouldn't accurately reflect the resolution steps. Is
merging or updating the submodule still the correct resolution? The
first three cases are for a null o/a/b, and the fourth case is for a missing
local submodule. Also in cleanup, the subrepo is cleared but the
subrepo hasn't been initialized/failed to initialize in these four cases.

> >         object_array_clear(&merges);
> >  cleanup:
> > +       if (!ret) {
>
> And here's another item I have to apologize for not catching in an
> earlier round.  We should also require !opt->priv->call_depth as well
> in this if-condition.  If merging of merge bases produced a submodule
> conflict, but the outer merge involves two sides that resolved the
> inner conflict the exact same way, then there's no conflict at the
> outer level and nothing for the user to resolve.  If users don't have
> any conflicts to resolve, we don't want to print messages telling them
> how to resolve their non-existent conflicts.  And if there is still a
> conflict in the submodule for the outer merge as well as in the
> recursive merge(s), we don't want to list the module twice (or more)
> when we tell the user to fix conflicts in their submodules (especially
> since that means we'd be telling them to merge multiple different
> commits for the single submodule, which could get confusing).

ack.

> > +               for_each_string_list_item(item, csub) {
> > +            const char *abbrev= item->util;
>
> Messed up indent here?

Looks like going from my editor to `git format-patch` messed
something up here.

> > +               for_each_string_list_item(item, csub)
> > +                       /*
> > +                        * TRANSLATORS: This is a line of a recommended `git add` command
> > +                        * with multiple lines of submodule folders.
> > +                        * E.g.:     git add sub \
> > +                        *                   sub2 \
> > +                        *                   sub3
>
> Why does such a message need to be translated?  It's literal text the
> user should type, right?  I'm not sure what a translator would do with
> the message other than regurgitate it.

It doesn't. My point was to let the translator know that the only text
in this print is for a git command. I should probably add that context
to the comment though.

> > +                        */
> > +                       if (first) {
> > +                               printf("       git add %s", item->string);
>
> But if you did mean for there to be a translation and a TRANSLATORS
> note, then did you forget to translate it by calling _()?

Same reasoning as above.

> > +                               first = 0;
> > +                       } else {
> > +                               printf(" \\\n               %s", item->string);
> > +                       }
>
> Can we put braces around this for_each_string_list_item() block?  Or,
> as an alternative to the whole block, do you want to consider:
>
>    strub strbuf tmp = STRBUF_INIT;
>    strbuf_add_separated_string_list(&tmp, ' ', csub);
>    printf(_("    git add %s"), tmp.buf);   /* or maybe remove the
> translation; not sure what the point is */
>    strbuf_release(&tmp);
> ?  It is likely easier to copy & paste, and might be understood by
> more users (I'm not sure how many are aware that command lines can use
> backslashes for line continuation), but on the negative side, if you
> have a lot of submodules it might make it harder to read.  Even if you
> don't like space separated, though, you could still use this strategy
> by changing the second line to
>
>     strbuf_add_separated_string_list(&tmp, " \\\n               ", csub);

This is a much cleaner implementation, thanks! If my goal is to make
submodule merging easier for newer submodule users, then I think it's a
good assumption to remove any additional possible points of confusion,
aka with the "command lines can use backslashes for line continuation",
so I'll swap over to spaces.

> > +       print_submodule_conflict_suggestion(&opti->conflicted_submodules);
> > +       string_list_clear(&opti->conflicted_submodules, 1);
> > +
>
> It would be more consistent to have things allocated in merge_start()
> continue to be cleared out in clear_or_reinit_internal_opts().  This
> kind of breaks that pairing, and you're already making sure to clear
> it there, so I'd rather remove this duplicate string_list_clear()
> call.

ack.

> >         /* Also include needed rename limit adjustment now */
> >         diff_warn_rename_limit("merge.renamelimit",
> >                                opti->renames.needed_limit, 0);
> > @@ -4657,6 +4717,7 @@ static void merge_start(struct merge_options *opt, struct merge_result *result)
> >         trace2_region_enter("merge", "allocate/init", opt->repo);
> >         if (opt->priv) {
> >                 clear_or_reinit_internal_opts(opt->priv, 1);
> > +               string_list_init_dup(&opt->priv->conflicted_submodules);
>
> This works, but there is a minor optimization available here if you're
> interested (I understand if you're not since you're already at v6).
> Assuming you make the important opt->priv->call_depth fix, you can
> replace string_list_init_dup() with string_list_init_nodup() here.
> The paths aren't freed until clear_or_reinit_internal_opts() which
> (under the assumption previously stated) isn't called until
> merge_finalize(), which comes after the call to
> merge_display_update_messages(), which is where you use the data.
>
> (As repository paths are used all over merge-ort.c, the optimization
> to store them in one place (opt->priv->paths) and avoid duplicating
> them is used pretty heavily.  It's more important for a lot of the
> other strmaps since they'll have a lot more paths in them, but it is
> kind of nice to use this optimization where possible.)

Thanks for all the context of this one. I agree it's minor, but any place
we can provide a better example to future contributors seems like a
more than worthy reason to make this change :)
