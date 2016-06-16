Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16E51FE4C
	for <e@80x24.org>; Thu, 16 Jun 2016 21:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbcFPVGm (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 17:06:42 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36531 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbcFPVGl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 17:06:41 -0400
Received: by mail-qg0-f49.google.com with SMTP id v76so32263936qgv.3
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 14:06:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GG8ALRefY508LlgDh6JHNPsvpKgLSuTNjv+zvNa1WKs=;
        b=bkD9vYQwxXx6SQS5Z6jhdHSL0RZW13qzttJs5wRKQ6O6LK4PvXqMysJHEKm8pHNoSS
         KETWLSdxBxXUEtNu8RN1WnVccZw9f0hdFIffRW6A6sBYEUbBuhNJuIgoo90FdPjQpXNT
         GgwKwn/YhhHoV4xVXJK1GKVBBn+Cb9/tsBwneoRgAGODwbN9fEEAQACveWDnKgky5+DT
         ghP3i8DoTMBcMYS33S9OVeCFiqLMq4Z7K+8sbKLy+FBVIfjnP/zbChYt8I8rlJTwT4wZ
         /Wb9/rnctNzWzcTHNTG3ZjB29ssgaZhkDdqkPO0430dK0fUYa2lJAHVgekIp4OnxTruD
         FU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GG8ALRefY508LlgDh6JHNPsvpKgLSuTNjv+zvNa1WKs=;
        b=CkR4PsiNHXUrNb8mk0BmoRpqHP8N2q2Igz+dYy5yImMkf65R5Ix9QCFB4hd5jOumfr
         jdhHOLOQXcPZ3tLTp1/niiG/XQZaS9CzwyEBz5jTN29BSLhHQ1NFklX6FGvEf0gPwr6i
         hm01HJIzfpUcldqMgYF2s2lM7Gy2eaaddxQroJ59e94mLu0HV1t/QelOhX7buummSrDN
         +202Qe9qdvhJTDsTk1FoWQpkuHZcZiaFxo9vDzj/pfKO/9yEyQ9RBbecWHSJPDShtMit
         uIHGOkEQBp7wz7Vd5mBCNaaYzlmF9YZZlysQyZGQWuOTo99rJQJqk/LAU691130zlIMn
         0EbQ==
X-Gm-Message-State: ALyK8tIIOogvZZHFo1w54h9IyM5/KQfdAAr1/SkkjkQmcxMDd4WUkNaj+s3n14LOP06uW7a8YqqAOrubpo8eVifj
X-Received: by 10.140.94.134 with SMTP id g6mr7015281qge.76.1466111200662;
 Thu, 16 Jun 2016 14:06:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.42.226 with HTTP; Thu, 16 Jun 2016 14:06:40 -0700 (PDT)
In-Reply-To: <xmqqlh24516i.fsf@gitster.mtv.corp.google.com>
References: <20160616174620.1011-1-sbeller@google.com> <xmqqlh24516i.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 16 Jun 2016 14:06:40 -0700
Message-ID: <CAGZ79kYHO8q_CmePBxFUYxmhY6V_dS4M3djxCOrz5iJx_vFC-Q@mail.gmail.com>
Subject: Re: [PATCH] diff compaction heuristic: favor shortest neighboring
 blank lines
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> because there is less space between line start and {end, def bal}
>> than for {do_bal_stuff, common_ending}.
>
> I haven't thought this carefully yet, but would this equally work
> well for Python, where it does not have the "end" or does the lack
> of "end" pose a problem?  You'll still find "def bal" is a good
> boundary (but you cannot tell if it is the beginning or the end of a
> block, unless you understand the language), though.

Good point.  I found a flaw in my implementation
(as it doesn't match my mental model, not necessarily a bad thing)

We take the minimum of the two neighbors, i.e.

+                do_bal_stuff()
+
+        common_ending()

is preferrable to

+                do_bal_stuff()
+
+                common_ending()

and in python the example would look like:

    def foo():
        do_foo()

        common_thing()

+    def baz():
+        do_baz()
+
+        common_thing()
+
    def bar():
        do_bar()

        common_thing()

and breaking between

        common_thing()

    def bar():

is more favorable than between

        do_baz()

        common_thing()

because in the first former the count of
white space in front of "def bar():" is smaller
than for any of "do_baz()" and "common_thing()"


>
>> +static unsigned int leading_blank(const char *line)
>> +{
>> +     unsigned int ret = 0;
>> +     while (*line) {
>> +             if (*line == '\t')
>> +                     ret += 8;
>
> This will be broken with a line with space-before-tab whitespace
> breakage, I suspect...

How so? We inspect each character on its own and then move on later
by line++. (I am not seeing how this could cause trouble, so please
help me?)

Going back to python, this may become a problem when you have a code like:

 def baz():

        do_baz()

        common_thing()

 def bar():

+       do_bal()
+
+       common_thing()
+
+def bar():
+
        do_bar()

        common_thing()


but this was fabricated with a typo (the first definition of bar
should have been bal),
(Also it doesn't worsen the diff, as it is same without the heuristic)

once that typo is fixed we get:
(both with and without the heuristic)

        do_foo()

        common_thing()

 def baz():
        do_baz()

        common_thing()

+def bal():
+
+       do_bal()
+
+       common_thing()
+
 def bar():

        do_bar()

        common_thing()

Clearly it can also be intentional to have 2 methods with the same
code for historical reasons, (even without the blank line after the
function definition this produces the same result)

When playing around with various diffs I could not find a thing that
this patch makes worse, it only fixes the actual issue.
(I realized Peff actually attached a script to produce a bad diff, which
is gone with this patch)

Thanks,
Stefan
