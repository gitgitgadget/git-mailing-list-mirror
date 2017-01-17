Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1969820756
	for <e@80x24.org>; Tue, 17 Jan 2017 20:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdAQUNL (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 15:13:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:40420 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbdAQULr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 15:11:47 -0500
Received: (qmail 22640 invoked by uid 109); 17 Jan 2017 20:05:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 20:05:06 +0000
Received: (qmail 20870 invoked by uid 111); 17 Jan 2017 20:06:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Jan 2017 15:06:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jan 2017 15:05:04 -0500
Date:   Tue, 17 Jan 2017 15:05:04 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: clarify multi-line brace style
Message-ID: <20170117200503.3iwaedrgfq544b4i@sigill.intra.peff.net>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
 <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
 <alpine.DEB.2.20.1701161251100.3469@virtualbox>
 <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701161746200.3469@virtualbox>
 <20170116220014.bwi5xi2br56lyqsw@sigill.intra.peff.net>
 <20170116220821.4tji5mrfcdbdpfuo@sigill.intra.peff.net>
 <xmqqfukhfpcc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfukhfpcc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 17, 2017 at 11:39:31AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> I think this is pretty clearly the "gray area" mentioned there. Which
> >> yes, does not say "definitely do it this way", but I hope makes it clear
> >> that you're supposed to use judgement about readability.
> >
> > So here's a patch.
> >
> > I know we've usually tried to keep this file to guidelines and not
> > rules, but clearly it has not been clear-cut enough in this instance.
> 
> I have two "Huh?" with this patch.
> 
>  1. Two exceptions are not treated the same way.  The first one is
>     "... extends over a few lines, it is excempt from the rule,
>     period".  The second one, is ambivalent by saying "it can make
>     sense", implying that "it may not make sense", so I am not sure
>     if this is clarifying that much.
> 
>     If we want to clarify, perhaps drop "it can make sense to" and
>     say
> 
> 	When there are multiple arms to a conditional, and some of
> 	them require braces, enclose even a single line block in
> 	braces for consistency.
> 
>     perhaps?

Yeah. I obviously was adapting the original text, and I think I left too
much of the wishy-washy-ness in. As the point of the patch is to avoid
that, let's take your suggestion. A re-rolled patch is below.

Now the patch is at least self-consistent. The bigger question remains
of: do we want to dictate these rules, or did we prefer the vague
version?

I _thought_ the vague rules were doing fine, but this whole discussion
has made me think otherwise. And I'd just as soon not ever have to
repeat it. ;-/

OTOH, I really do not want to review a bunch of patches that do nothing
but change brace style (and I am sure there is a mix of styles already
in the code base).

>  2. I actually think it is OK to leave some things "gray", but the
>     confusion comes when people do not know what to do to things
>     that are "gray", and they need a rule for that to be spelled
>     out.
> 
> 	When the project says it does not have strong preference
> 	among multiple choices, you are welcome to write your new
> 	code using any of them, as long as you are consistent with
> 	surrounding code.  Do not change style of existing code only
> 	to flip among these styles, though.
> 
>     That obviously is not limited to the rule/guideline for braces.

The existing document says:

    Make your code readable and sensible, and don't try to be clever.
    
    As for more concrete guidelines, just imitate the existing code
    (this is a good guideline, no matter which project you are
    contributing to). It is always preferable to match the _local_
    convention. New code added to Git suite is expected to match
    the overall style of existing code. Modifications to existing
    code is expected to match the style the surrounding code already
    uses (even if it doesn't match the overall style of existing code).
    
    But if you must have a list of rules, here they are.

I guess that is the place to expound on how to interpret the rules. I
dunno. Some of the individual rules that go into "gray areas" already
spell out the "surrounding code" rule.

-Peff

-- >8 --
Subject: [PATCH] CodingGuidelines: clarify multi-line brace style

There are some "gray areas" around when to omit braces from
a conditional or loop body. Since that seems to have
resulted in some arguments, let's be a little more clear
about our preferred style.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/CodingGuidelines | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 4cd95da6b..a4191aa38 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -206,11 +206,38 @@ For C programs:
 		x = 1;
 	}
 
-   is frowned upon.  A gray area is when the statement extends
-   over a few lines, and/or you have a lengthy comment atop of
-   it.  Also, like in the Linux kernel, if there is a long list
-   of "else if" statements, it can make sense to add braces to
-   single line blocks.
+   is frowned upon. But there are a few exceptions:
+
+	- When the statement extends over a few lines (e.g., a while loop
+	  with an embedded conditional, or a comment). E.g.:
+
+		while (foo) {
+			if (x)
+				one();
+			else
+				two();
+		}
+
+		if (foo) {
+			/*
+			 * This one requires some explanation,
+			 * so we're better off with braces to make
+			 * it obvious that the indentation is correct.
+			 */
+			doit();
+		}
+
+	- When there are multiple arms to a conditional and some of them
+	  require braces, enclose even a single line block in braces for
+	  consistency. E.g.:
+
+		if (foo) {
+			doit();
+		} else {
+			one();
+			two();
+			three();
+		}
 
  - We try to avoid assignments in the condition of an "if" statement.
 
-- 
2.11.0.651.g41f4a5c4e

