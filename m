Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40D55201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 21:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbdBTVZG (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 16:25:06 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33691 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbdBTVZE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 16:25:04 -0500
Received: by mail-pg0-f67.google.com with SMTP id 5so14508497pgj.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 13:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jGSbn4bCidTU6HGRUcHI9LNiMP6M7S5I0He4dRpzPtw=;
        b=FLC7hrcTyAM8CBJBNBA2Wbzupm3H0halEY0i++Novihm0XfsAoV+M82BZvZ6aIJ6fV
         A70aMxCKC/V7+BnJFExiYdGiuXo/bB9geUYGvTIPd/aD5V2kPJeUtv90SP8VbN1B/igx
         bkOOwE1jYK/vVx0F00RWm/h+OJ5tNhibrshVUq6EK4UWGrrWisAvKQJnJQ0UeF/7mCnH
         KTfQbCmY0VpovNrOqNmYmRbDu+n04MgCiA9KvH0AhxFF+mQrK2sLTywvM2/p3M1DqmY6
         YTiPnrk8/xd4gEZDFX+cQyIksuqtrDPHSj/tSKRxdX5BpvtpIHbqRV7kdI0baEDZgCnc
         1HwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jGSbn4bCidTU6HGRUcHI9LNiMP6M7S5I0He4dRpzPtw=;
        b=MqA3QgUfWshnQgPQszIYniRm2G8dSjfk+/PDViBWdBAu830rBXtJ9JVIt8Y8RBfcyp
         hXL9TwwTmJw5PtHSrgZcob+5Bx9PEOer9oIghlOcnJ1q9MADlbhJUOrGHVusCi9SmDVK
         ykX5z6qMCZxSwCkdKtyseEH2QvpkxPiLtdjFe1h5L3Qa7LtS2Dw+0kQtKPM3qWVDcG8S
         /Jto1uqjI8Wm708fPtv7p+eI/UNK610qYql4lHCvqp7Sw2JlfghYpbN7prjhT87w40Nj
         E+cNpjo8ta42toMwefq6mY81yh1SNc8hRXEXEhP4xKgJ9spyG1y+T/OigOfgqjPZxjWZ
         UVgw==
X-Gm-Message-State: AMke39kg/6ioXJa1LitQ6wpsrq+ZcGZxNOSt5BAiHsCvdRfmGMLCbxgZHgi0OPxgEdotpA==
X-Received: by 10.84.208.227 with SMTP id c32mr34325733plj.71.1487625903171;
        Mon, 20 Feb 2017 13:25:03 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:71d2:895f:c7:4f5e])
        by smtp.gmail.com with ESMTPSA id 64sm36719395pfq.112.2017.02.20.13.25.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 13:25:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Crowe <mac@mcrowe.com>
Cc:     git@vger.kernel.org
Subject: Re: git diff --quiet exits with 1 on clean tree with CRLF conversions
References: <20170217212633.GA24937@mcrowe.com>
        <xmqqr32wqxr6.fsf@gitster.mtv.corp.google.com>
        <20170217221958.GA12163@mcrowe.com> <20170220153322.GA8352@mcrowe.com>
Date:   Mon, 20 Feb 2017 13:25:01 -0800
In-Reply-To: <20170220153322.GA8352@mcrowe.com> (Mike Crowe's message of "Mon,
        20 Feb 2017 15:33:22 +0000")
Message-ID: <xmqqlgt0imhe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Crowe <mac@mcrowe.com> writes:

> I think that if there's a risk that file contents will undergo conversion
> then this should force the diff to check the file contents. Something like:
>
> diff --git a/diff.c b/diff.c
> index 051761b..bee1662 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3413,13 +3413,14 @@ void diff_setup_done(struct diff_options *options)
>  	/*
>  	 * Most of the time we can say "there are changes"
>  	 * only by checking if there are changed paths, but
> -	 * --ignore-whitespace* options force us to look
> -	 * inside contents.
> +	 * --ignore-whitespace* options or text conversion
> +	 * force us to look inside contents.
>  	 */
>  
>  	if (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
>  	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
> -	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL))
> +	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL) ||
> +	    DIFF_OPT_TST(options, ALLOW_TEXTCONV))
>  		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
>  	else
>  		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);

Thanks.

You may be on the right track to find FROM_CONTENTS bit, but
I think TEXTCONV bit is a red-herring.

This part of diff.c caught my attention, while thinking about this
topic:

	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
	    DIFF_OPT_TST(options, EXIT_WITH_STATUS) &&
	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
		/*
		 * run diff_flush_patch for the exit status. setting
		 * options->file to /dev/null should be safe, because we
		 * aren't supposed to produce any output anyway.
		 */

and the body of this "if" statement loops over q->queue[].  It is
about the "even though we prefer not having to format the patch
because we are doing --quiet, we need to see if contents of one and
two that we _know_ are different are made into the same thing when
we compare them while ignoring various forms of whitespace changes".
So one and two that are removed in earlier step because they were
truly identical may not be penalized if you flip FROM_CONTENTS bit
early on.

Having said that, DIFF_FROM_CONTENTS is about all paths this options
structure governs, not just paths that have eol conversion defined.
When you say "diff --ignore-whitespace-change", that applies to all
paths.  The eol conversion is specified per-path, so ideally the
FROM_CONTENTS bit should be flipped if and only if one or more of
the paths would need the conversion (i.e. does the helper function
would_convert_to_git() say "yes" to the path?).  I however suspect
that necessary information to do so (i.e. "which paths we are
looking at?") has not been generated yet at the point of the code
you quoted.  setup comes (and must come) very early, and then
q->queue[] is populated by different front-end functions that
compare trees, the index, and the working tree, depending on the
"git diff" option or "git diff-{tree,index,files}" plumbing command,
and you can ask "would one of these paths need conversion?" only
after q->queue[] is populated.  Hmm.....

Another thing is that ALLOW_TEXTCONV is not a right bit to check for
your example.  It is "do we use textconv filters to turn binary
files into a (phony) text representation before comparing?".  People
use the mechanism to throw JPEG photos in Git and have textconv
filter to extract only EXIF data, and "diff --textconv" would let us
textually compare only the EXIF data (which is the only human
readable part of the contents anyway).  

It might be a good idea to also flip FROM_CONTENTS bit under "diff
--textconv", and ...

> This solves the problem for me and my test case now passes.

... but I suspect that you were misled to think it fixes your issue,
only because "--textconv" is by default enabled for "git diff" and
"git log" (see "git diff --help").  I think you are saying that if
you always set FROM_CONTENTS bit on, you get what you want.  But
that is to be expected and it unfortunately penalizes everybody by
turning an obvious optimization permanently off.

Also "--textconv" is not on by default for the plumbing "git
diff-index" command and its friends, so it is likely that "git
diff-index HEAD" with your change will still not work as you expect.

A cheap (from code-change point of view) band-aid might be to flip
FROM_CONTENTS on if we know the repository has _some_ paths that
need eol conversion, even when the particular "diff" we are taking
does not involve any eol conversion (e.g. "is core.crlf set?").
While it may be better than "if we are porcelain (aka ALLOW_TEXTCONV
is set), unconditionally flip FROM_CONTENTS on", it is not ideal,
either.

This almost makes me suspect that the place that checks lengths of
one and two in order to refrain from running more expensive content
comparison you found earlier need to ask would_convert_to_git()
before taking the short-cut, something along the lines of this (for
illustration purposes only, not even compile-tested).  The "almost"
comes to me because I do not offhand know the performance implications
of making calls to would_convert_to_git() here.

 diff.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 051761be40..094d5913da 100644
--- a/diff.c
+++ b/diff.c
@@ -4921,9 +4921,10 @@ static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
 	 *    differences.
 	 *
 	 * 2. At this point, the file is known to be modified,
-	 *    with the same mode and size, and the object
-	 *    name of one side is unknown.  Need to inspect
-	 *    the identical contents.
+	 *    with the same mode and size, the object
+	 *    name of one side is unknown, or size comparison
+	 *    cannot be depended upon.  Need to inspect the 
+	 *    contents.
 	 */
 	if (!DIFF_FILE_VALID(p->one) || /* (1) */
 	    !DIFF_FILE_VALID(p->two) ||
@@ -4931,7 +4932,16 @@ static int diff_filespec_check_stat_unmatch(struct diff_filepair *p)
 	    (p->one->mode != p->two->mode) ||
 	    diff_populate_filespec(p->one, CHECK_SIZE_ONLY) ||
 	    diff_populate_filespec(p->two, CHECK_SIZE_ONLY) ||
-	    (p->one->size != p->two->size) ||
+
+	    /* 
+	     * only if eol and other conversions are not involved,
+	     * we can say that two contents of different sizes
+	     * cannot be the same without checking their contents.
+	     */
+	    (!would_convert_to_git(p->one->path) &&
+	     !would_convert_to_git(p->two->path) &&
+	     (p->one->size != p->two->size)) ||
+
 	    !diff_filespec_is_identical(p->one, p->two)) /* (2) */
 		p->skip_stat_unmatch_result = 1;
 	return p->skip_stat_unmatch_result;


