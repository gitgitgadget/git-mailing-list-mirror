Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9715C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 00:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiJGAsP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 20:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiJGAsM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 20:48:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00255BCBA4
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 17:48:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so3317692pjl.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 17:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DR/zBcmOkP5QmiR36PI5V+HxdLlbgRjxen+ZReTrJMk=;
        b=DY3G+/J+kSutPF9fO0iurhQYQ2zVSZN4OJrQAZ5O9keHN0YTTXQodtTq2//igQFETj
         LlYLXPjodLGIGoqiJH59q/3TOcF5npEqNA+PKh0zvqo4h6gwyqv2Vv2SUYgdENi4ligv
         kpKjuiqRhpXJ1aPHdeYELho+qBWQEVQsg9Z+JTK97U1BCKq1FkS9njH2cFtG+ALwCpTO
         9JMgRQzKyAWxhc7imfjA8N0srjsdwakVoeTOh1s/s6AndNgRBAwu9itTud//4pXlSmxC
         4xt0qq7eS6w0nzNfDoOWGuOeek14+X7nxAmETXyKMykYGDmB2jcsrwboKHoB63wwAfvX
         OdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DR/zBcmOkP5QmiR36PI5V+HxdLlbgRjxen+ZReTrJMk=;
        b=iIF2PjmigXFDTyBZtl/nJkQg5Eo4yk4E+S2SZggBz9VVa4JGuxb/OzhO7KP15RuwaE
         9XVME0fxCVLxc7Hftmr0iY64Nnx3HmVltbrDIw+A9e0YaOqg+PvpJfxw6JiUF/ak85It
         7X4ami+An7e/YTUvPqWcEeM0lkarvN3k1xkFU3/LOmla7JkcZxpo+gvzvP+UKKwRHaYQ
         VhPUX90XZeMlEMGQRfyNKF41xS3wmage+WAFRc3ahd84OcjpZDvLYFGUC2Gy5iRRHApg
         ppHXtjKkIEvfRAEGysmxxjwNnB0ytoe5eUkhedZlgIrATCy5iczi4Zr/21RkIWdRe9Kc
         Fb5w==
X-Gm-Message-State: ACrzQf2tCPvnk9WFTml7DeuspRnuByIVaHJXP/Ub469HW06yFViXN1Wo
        jka5zvrA4GQLuUPuu3DG5k6K9Prg9SLUfNQ9
X-Google-Smtp-Source: AMsMyM5fzLA3hKfMChkLSgJJIghrH7FO0dHWS6djwJ393Xs00Y+9o7j6//+RBi++60cMG1dfaeaTCA==
X-Received: by 2002:a17:902:e80f:b0:17f:8408:cc4f with SMTP id u15-20020a170902e80f00b0017f8408cc4fmr2128473plg.127.1665103690429;
        Thu, 06 Oct 2022 17:48:10 -0700 (PDT)
Received: from initialcommit.io ([2600:8801:9c0a:f300:e1a1:5f6f:bdce:54e1])
        by smtp.gmail.com with ESMTPSA id u186-20020a6260c3000000b00561c6a4c1b0sm231481pfb.176.2022.10.06.17.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 17:48:09 -0700 (PDT)
Date:   Thu, 6 Oct 2022 17:48:06 -0700
From:   Jacob Stopak <jacob@initialcommit.io>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, martin.agren@gmail.com
Subject: Re: [RFC PATCH v2] shortlog: add group-by options for year and month
Message-ID: <Yz93RjrJ00A5QvNe.jacob@initialcommit.io>
References: <20220922061824.16988-1-jacob@initialcommit.io>
 <20220922232536.40807-1-jacob@initialcommit.io>
 <xmqqillevzeh.fsf@gitster.g>
 <Yy4sIAHdvp6yRql+@coredump.intra.peff.net>
 <Yz36eFeGyQ3ha1pw@nand.local>
 <Yz4EsT8noIoygk9b@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz4EsT8noIoygk9b@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 05, 2022 at 06:26:57PM -0400, Jeff King wrote:
> On Wed, Oct 05, 2022 at 05:43:20PM -0400, Taylor Blau wrote:
> 
> > This caught my attention, so I wanted to see how hard it would be to
> > implement. It actually is quite straightforward, and gets us most of the
> > way to being able to get the same functionality as in Jacob's patch
> > (minus being able to do the for-each-ref-style sub-selectors, like
> > `%(authordate:format=%Y-%m)`).

Thanks Taylor!! This looks awesome and helped me understand how the pretty
context stuff works. I was able to apply your patch locally and test,
and plan to continue working off of this :D. Like Peff mentioned seems to
be a few usage details to hammer out.

> The date thing I think can be done with --date; I just sent a sketch in
> another part of the thread.

Peff - I applied your --date sketch onto Taylor's patch and it worked first try.

> So here you're allowing multiple pretty options. But really, once we
> allow the user an arbitrary format, is there any reason for them to do:
> 
>   git shortlog --group=%an --group=%ad
> 
> versus just:
> 
>   git shortlog --group='%an %ad'
> 
> ?

Yes I can't think of an advantage of having multiple custom-formatted group
fields. Also see my note on this below related to your comment on specifying
multiple groups.

> >  void shortlog_add_commit(struct shortlog *log, struct commit *commit)
> >  {
> >  	struct strbuf ident = STRBUF_INIT;
> > @@ -243,6 +266,8 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
> >  	if (log->groups & SHORTLOG_GROUP_TRAILER) {
> >  		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
> >  	}
> > +	if (log->groups & SHORTLOG_GROUP_PRETTY)
> > +		insert_record_from_pretty(log, &dups, commit, &ctx, oneline_str);
> 
> I was puzzled at first that this was a bitwise check. But I forgot that
> we added support for --group options already, in 63d24fa0b0 (shortlog:
> allow multiple groups to be specified, 2020-09-27).
> 
> So a plan like:
> 
>   git shortlog --group=author --group=date
> 
> (as in the original patch in this thread) doesn't quite work, I think.

My first patch addressed this by specifically handling cases where the new
grouping options were passed in-tandem with existing options, and making sure
only a single shortlog group was generated. But if we're generalizing the custom
group format then it might be unecessary to even allow the custom group in tandem
with most other options (like 'author' and 'committer'), since those options can be
included in the custom group format. The trailer option might be an exception, but
that could possibly just be handled as a special case.

> We probably want to insist that the format contains a "%" sign, and/or
> git it a keyword like "format:". Otherwise a typo like:
> 
>   git shortlog --format=autor
> 
> stops being an error we detect, and just returns nonsense results
> (every commit has the same ident).

Small aside: I like how Taylor re-used the --group option for the custom format.
IMO it hammers home that this is a grouping option and not just formatting or
filtering which can be confusing to users sometimes when doing data analytics.

But your points here all still apply. Maybe detecting a "%" sign can be the way
that git identifies the custom format being passed in. In conjuction with the %
identifiers, this would still enable users to add in some arbitrary constant label
like --group='Year: %cd' --date='%Y', without affecting the grouped/sorted results
since all entries would then include the "Years: " prefix (or postfix or however
they decide to write it).

The one case that should probably be handled is when no % sign is used and no other
matching flags like --author or --committer are either, because currently that will
just group all commits under 1 nonsensical group name like "autor" as you mentioned.

> I think you'd want to detect SHORTLOG_GROUP_PRETTY in the
> read_from_stdin() path, too. And probably just die() with "not
> supported", like we do for trailers.

Glad you said this because I applied this in my original patch with the explicit
--year and --month groups. Didn't seem to be an obvious use-case with the stdin 
even though my original year and month values could possibly be read from the git
log output supplied as stdin. But for a generalized group format seems even more
far-fetched to try and make it jive with the stdin version of the command.

-Jack
