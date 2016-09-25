Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79C320985
	for <e@80x24.org>; Sun, 25 Sep 2016 17:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754994AbcIYRpy (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 13:45:54 -0400
Received: from smtp-d-2.talktalk.net ([78.144.6.130]:4003 "EHLO
        smtp-d-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754801AbcIYRpx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 13:45:53 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Sep 2016 13:45:53 EDT
Received: from PhilipOakley ([92.22.14.73])
        by smtp.talktalk.net with SMTP
        id oDMybGQNcY8RwoDMybMLkA; Sun, 25 Sep 2016 18:37:41 +0100
X-Originating-IP: [92.22.14.73]
X-Spam: 0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=s3hTT1v+Ga0DGbyEgXsr4Q==:117
 a=s3hTT1v+Ga0DGbyEgXsr4Q==:17 a=8nJEP1OIZ-IA:10 a=yPCof4ZbAAAA:8
 a=FoUaokYameP4tvls3lQA:9 a=wPNLvfGTeEIA:10 a=S0nwPmyas4QA:10
 a=2lfDSYhZ3Z6b8uxcDO-Z:22
Message-ID: <E7D489891E404823BF34F48E7B9E5618@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Vegard Nossum" <vegard.nossum@oracle.com>, <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        =?iso-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
        "Kevin Bracey" <kevin@bracey.fi>,
        "Vegard Nossum" <vegard.nossum@oracle.com>
References: <20160925085511.12515-1-vegard.nossum@oracle.com>
Subject: Re: [RFC PATCH v2] revision: new rev^-n shorthand for rev^n..rev
Date:   Sun, 25 Sep 2016 18:37:42 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfOeEpogl4dk6/pdeZKO07xGfkIn9RugX0/zPBOuXCH4nvqdL0WA/3ASZXEH1a8qdt9IDGmB1y8mSv0VYX1HPNRfHM1RIzgs0HCWR5ZvokcXlojUDuIor
 VcPzSNqS/i+US3xISmHZ0NzCH8TU9eX4cjwvoox3L4nevHRedf8QiiM11Zhb5Og1bPKl1lErp8Unbn3oyyfz4OgJP7qLch9YcIlc1sBgRU5ttuH95oHGacsH
 S3IJbDUvT4JZZJF+YrqxYltaH5XryuzQOfbxdZscwUr/FCyk+kAfoSkn13Bu/CLXj58wZgvzctb+I72T59JinQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Vegard Nossum" <vegard.nossum@oracle.com>
>I use rev^..rev daily, and I'm surely not the only one.

Not everyone knows the 'trick' and may not use it daily.

Consider stating what it is useful for (e.g. "useful to get the commits and 
all  commits in the branches that were merged into commit" - paraphrased 
from the doc text)

> To save typing
> (or copy-pasting, if the rev is long -- like a full SHA-1 or branch name)
> we can make rev^- a shorthand for that.
>
> The existing syntax rev^! seems like it should do the same, but it
> doesn't really do the right thing for merge commits (it gives only the
> merge itself).

.. rather than the commit and those on side branches).

>
> As a natural generalisation, we also accept rev^-n where n excludes the
> nth parent of rev,

> although this is expected to be generally less useful.

Presumptious? for a two parent merge, surely(?) rev^-2 will give you what 
has been going on on the main line while the branch was being prepared... 
compare A^- and A^-2.

>
> [v2: Use ^- instead of % as suggested by Junio Hamano and use some
> common helper functions for parsing.]

As others noted, stick the note below a three dash line following the sign 
off (it can be part of the commit message after the sign off. It's also a 
useful place for including any cc: list when using format-patch and 
send-email.
>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
> Documentation/revisions.txt | 14 +++++++
> builtin/rev-parse.c         | 28 ++++++++++++++
> revision.c                  | 91 
> +++++++++++++++++++++++++++++++++++++++++++++
> revision.h                  |  1 +
> 4 files changed, 134 insertions(+)
>
> diff --git Documentation/revisions.txt Documentation/revisions.txt
> index 4bed5b1..6e33801 100644
> --- Documentation/revisions.txt
> +++ Documentation/revisions.txt
> @@ -281,6 +281,14 @@ is a shorthand for 'HEAD..origin' and asks "What did 
> the origin do since
> I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
> empty range that is both reachable and unreachable from HEAD.
>
> +Parent Exclusion Notation
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +The '<rev>{caret}-{<n>}', Parent Exclusion Notation::
> +Shorthand for '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
> +given. This is typically useful for merge commits where you
> +can just pass '<commit>{caret}-' to get all the commits in the branch

s/get all the/get the commit and all the/ ?
It could be misread as a way of selecting just those commits that are within 
the side branch without including the given commit itself.

> +that was merged in merge commit '<commit>'.
> +
> Other <rev>{caret} Parent Shorthand Notations
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Two other shorthands exist, particularly useful for merge commits,
> @@ -316,6 +324,10 @@ Revision Range Summary
>  <rev2> but exclude those that are reachable from both.  When
>  either <rev1> or <rev2> is omitted, it defaults to `HEAD`.
>
> +'<rev>{caret}-{<n>}', e.g. 'HEAD{caret}, HEAD{caret}-2'::
> + Equivalent to '<rev>{caret}<n>..<rev>', with '<n>' = 1 if not
> + given.
> +
> '<rev>{caret}@', e.g. 'HEAD{caret}@'::
>   A suffix '{caret}' followed by an at sign is the same as listing
>   all parents of '<rev>' (meaning, include anything reachable from
> @@ -339,6 +351,8 @@ spelt out:
>    C                            I J F C
>    B..C   = ^B C                C
>    B...C  = B ^F C              G H D E B C
> +   B^-    = B^..B
> +   = B ^B^1              E I J F B
>    C^@    = C^1
>    = F                   I J F
>    B^@    = B^1 B^2 B^3
> diff --git builtin/rev-parse.c builtin/rev-parse.c
> index 76cf05e..ad5e6ac 100644
> --- builtin/rev-parse.c
> +++ builtin/rev-parse.c
> @@ -292,6 +292,32 @@ static int try_difference(const char *arg)
>  return 0;
> }
>
> +static int try_parent_exclusion(const char *arg)
> +{
> + int ret = 0;
> + char *to_rev = NULL;
> + char *from_rev = NULL;
> + unsigned char to_sha1[20];
> + unsigned char from_sha1[20];
> +
> + if (parse_parent_exclusion(arg, &to_rev, &from_rev))
> + goto out;
> + if (get_sha1_committish(to_rev, to_sha1))
> + goto out;
> + if (get_sha1_committish(from_rev, from_sha1))
> + goto out;
> +
> + show_rev(NORMAL, to_sha1, to_rev);
> + show_rev(REVERSED, from_sha1, from_rev);
> +
> + ret = 1;
> +
> +out:
> + free(to_rev);
> + free(from_rev);
> + return ret;
> +}
> +
> static int try_parent_shorthands(const char *arg)
> {
>  char *dotdot;
> @@ -839,6 +865,8 @@ int cmd_rev_parse(int argc, const char **argv, const 
> char *prefix)
>  /* Not a flag argument */
>  if (try_difference(arg))
>  continue;
> + if (try_parent_exclusion(arg))
> + continue;
>  if (try_parent_shorthands(arg))
>  continue;
>  name = arg;
> diff --git revision.c revision.c
> index 969b3d1..0480f19 100644
> --- revision.c
> +++ revision.c
> @@ -1419,6 +1419,93 @@ static void prepare_show_merge(struct rev_info 
> *revs)
>  revs->limited = 1;
> }
>
> +/*
> + * If 'arg' is on the form '<rev>^-{<n>}', then return 0 and
> + * '*to_rev' and '*from_rev' will contain '<rev>' and '<rev>^<n>',
> + * respectively.
> + */
> +int parse_parent_exclusion(const char *arg, char **to_rev, char 
> **from_rev)
> +{
> + char *caret;
> + unsigned int n = 1;
> +
> + /*
> + * <rev>^-{<n>} is shorthand for <rev>^<n>..<rev>, with <n> = 1 if
> + * not given. This is typically used for merge commits where you
> + * can just pass '<merge>^-' and it will show you all the commits in
> + * the branch that was merged.
> + */
> +
> + if (!(caret = strstr(arg, "^-")))
> + return 1;
> + if (caret[2]) {
> + char *end;
> + n = strtoul(&caret[2], &end, 10);
> + if (*end != '\0')
> + return 1;
> + }
> + *to_rev = xstrndup(arg, caret - arg);
> + *from_rev = xstrfmt("%s^%u", *to_rev, n);
> + return 0;
> +}
> +
> +static int handle_parent_exclusion(const char *arg, struct rev_info 
> *revs, int flags)
> +{
> + int ret = 1;
> + char *to_rev = NULL;
> + char *from_rev = NULL;
> + unsigned char to_sha1[20];
> + unsigned char from_sha1[20];
> +
> + struct object *a_obj, *b_obj;
> + unsigned int flags_exclude = flags ^ (UNINTERESTING | BOTTOM);
> + unsigned int a_flags;
> +
> + /*
> + * <rev>^-{<n>} is shorthand for <rev>^<n>..<rev>, with <n> = 1 if
> + * not given. This is typically used for merge commits where you
> + * can just pass <merge>^- and it will show you all the commits in
> + * the branches that were merged.
> + */
> +
> + if (parse_parent_exclusion(arg, &to_rev, &from_rev))
> + goto out;
> +
> + if (get_sha1_committish(to_rev, to_sha1)) {
> + if (revs->ignore_missing)
> + goto out;
> + die("Unknown revision %s", to_rev);
> + }
> +
> + if (get_sha1_committish(from_rev, from_sha1)) {
> + if (revs->ignore_missing)
> + goto out;
> + die("Unknown revision %s", from_rev);
> + }
> +
> + a_obj = parse_object(from_sha1);
> + b_obj = parse_object(to_sha1);
> + if (!a_obj || !b_obj) {
> + if (revs->ignore_missing)
> + goto out;
> + die("Invalid revision range %s", arg);
> + }
> +
> + a_flags = flags_exclude;
> + a_obj->flags |= a_flags;
> + b_obj->flags |= flags;
> + add_rev_cmdline(revs, a_obj, from_rev, REV_CMD_LEFT, a_flags);
> + add_pending_object(revs, a_obj, from_rev);
> + add_rev_cmdline(revs, b_obj, to_rev, REV_CMD_RIGHT, flags);
> + add_pending_object(revs, b_obj, to_rev);
> +
> + ret = 0;
> +out:
> + free(to_rev);
> + free(from_rev);
> + return ret;
> +}
> +
> int handle_revision_arg(const char *arg_, struct rev_info *revs, int 
> flags, unsigned revarg_opt)
> {
>  struct object_context oc;
> @@ -1519,6 +1606,10 @@ int handle_revision_arg(const char *arg_, struct 
> rev_info *revs, int flags, unsi
>  }
>  *dotdot = '.';
>  }
> +
> + if (!handle_parent_exclusion(arg, revs, flags))
> + return 0;
> +
>  dotdot = strstr(arg, "^@");
>  if (dotdot && !dotdot[2]) {
>  *dotdot = 0;
> diff --git revision.h revision.h
> index 9fac1a6..ca5bebc 100644
> --- revision.h
> +++ revision.h
> @@ -243,6 +243,7 @@ extern int setup_revisions(int argc, const char 
> **argv, struct rev_info *revs,
> extern void parse_revision_opt(struct rev_info *revs, struct 
> parse_opt_ctx_t *ctx,
>         const struct option *options,
>         const char * const usagestr[]);
> +extern int parse_parent_exclusion(const char *arg, char **to_rev, char 
> **from_rev);
> #define REVARG_CANNOT_BE_FILENAME 01
> #define REVARG_COMMITTISH 02
> extern int handle_revision_arg(const char *arg, struct rev_info *revs,
> -- 
> 2.10.0.rc0.1.g07c9292
>
> 

