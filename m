Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18811FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 23:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbdBJXh0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 18:37:26 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35085 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdBJXhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 18:37:25 -0500
Received: by mail-pg0-f66.google.com with SMTP id 204so4100487pge.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 15:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Kt/NYAv8d3ywus/vpcH0P8dAvM+IMtpWXFPDXd1WPz8=;
        b=cKet99bBRclCNBlTnyxfXzLC/SdVFD8ZPfrqz6zMWREQ8nbHlUbrFZCigEsrYWnDLH
         Zr4mYURzEL9IHMeeifvJKG/LQxP7QebvpyZpFzhkRWuy07aQlr3THq3Lr33OvDMBx8QF
         IkiVeeMyv2yJ+UzwAZK0a1AlCTjlnlQ0ffsGa0CYS17bR12E+gvbat673vI2UZNSEfBU
         PnIkAsuiPxtZTrYaCuQ0leGHiZmzANbrqTiFDr90qma4npPtE07fZQlXUlEvveDSIKI4
         +H04CFK3KMYRNgCsOvM2r1iplbOauqr+LYPiu0fjmC7p6odP6TCsoTZYg/UP8Twk+Ad0
         PI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Kt/NYAv8d3ywus/vpcH0P8dAvM+IMtpWXFPDXd1WPz8=;
        b=Aq7m7WjuYr/5ZVO/Z6iZ/TYEjT9jBjcHOsb55DTiqv3Y0mhI4lTctw+aHpCL6f2HUm
         RTuztl0I+RZT/Esw0YMifccROVInhyU1D4LNQRMOOeyJ6HcD8pjXccb+mI3yRcxRxENN
         yeYRD8AeEu4I5yJ1yHXZbreGOWs8hJR7m99xJUwaclatKFPA1prLuW0VaVL6ldX3QyVt
         OFbANq3Mury9LQNIBHCgxmL3tCekuh+MScVkSWaO7DhFVEzdsBUiuoLdoCPlvpNsvhNP
         LGKb1t7V36cxQdrDs5HGP8KUgYVSrJ0ud7iPTolg1D3OOtJwPUgAGsW1Ux1gjElPDjtZ
         1Kpg==
X-Gm-Message-State: AMke39m5++RAGa2cGOvvV0FdPz7GooUOYe6TSnVF1qlZebg2Mu4YlLaZcu4ytlXNLbIOFA==
X-Received: by 10.99.50.132 with SMTP id y126mr14020467pgy.8.1486769750641;
        Fri, 10 Feb 2017 15:35:50 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id s8sm7576645pfj.30.2017.02.10.15.35.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 15:35:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     git@vger.kernel.org, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 1/2 v3] revision.c: args starting with "-" might be a revision
References: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
        <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
Date:   Fri, 10 Feb 2017 15:35:47 -0800
In-Reply-To: <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
        (Siddharth Kannan's message of "Fri, 10 Feb 2017 18:55:25 +0000")
Message-ID: <xmqqh941ippo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

> @@ -2234,11 +2235,18 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  			}
>  			if (opts < 0)
>  				exit(128);
> -			continue;
> +
> +			args = handle_revision_arg(arg, revs, flags, revarg_opt);
> +			handle_rev_arg_called = 1;
> +			if (args)
> +				continue;
> +			else
> +				--left;
>  		}
>  
>  
> -		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
> +		if ((handle_rev_arg_called && args) ||
> +				handle_revision_arg(arg, revs, flags, revarg_opt)) {

Naively I would have expected that removing the "continue" at the
end and letting the control go to the existing

	if (handle_revision_arg(arg, revs, flags, revarg_opt)) {

would be all that is needed.  The latter half of the patch is an
artifact of having ane xtra "handle_revision_arg() calls inside the
"if it begins with dash" block to avoid calling it twice.

So the difference is just "--left" (by the way, our codebase seem to
prefer "left--" when there is no difference between pre- or post-
decrement/increment) that adjusts the slot in argv[] where the next
unknown argument is stuffed to.

The adjustment is needed as the call to handle_revision_opt() that
is before the pre-context of this hunk stuffed the unknown thing
that begins with "-" into argv[left++]; if that thing turns out to
be a valid rev, then you would need to take it back, because after
all, that is not an unknown command line argument.

I am wondering if writing it like the following is easier to
understand.  I had a hard time figuring out what you are trying to
do, partly because "args" is quite a misnomer---implying "how many
arguments did we see" that is similar to opts that does mean "how
many options did handle_revision_opts() see?"  The variable means
means "yes we saw a valid rev" when it is zero.  The rewrite
below may avoid such a confusion.  I dunno.

 revision.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index b37dbec378..e238430948 100644
--- a/revision.c
+++ b/revision.c
@@ -2204,6 +2204,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		revarg_opt |= REVARG_CANNOT_BE_FILENAME;
 	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
+		int maybe_rev = 0;
 		const char *arg = argv[i];
 		if (*arg == '-') {
 			int opts;
@@ -2234,11 +2235,16 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			}
 			if (opts < 0)
 				exit(128);
-			continue;
+			maybe_rev = 1;
+			left--; /* tentatively cancel "unknown opt" */
 		}
 
-
-		if (handle_revision_arg(arg, revs, flags, revarg_opt)) {
+		if (!handle_revision_arg(arg, revs, flags, revarg_opt)) {
+			got_rev_arg = 1;
+		} else if (maybe_rev) {
+			left++; /* it turns out that it was "unknown opt" */
+			continue;
+		} else {
 			int j;
 			if (seen_dashdash || *arg == '^')
 				die("bad revision '%s'", arg);
@@ -2255,8 +2261,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			append_prune_data(&prune_data, argv + i);
 			break;
 		}
-		else
-			got_rev_arg = 1;
 	}
 
 	if (prune_data.nr) {
