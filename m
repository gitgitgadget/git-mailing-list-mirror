From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Sat, 7 Sep 2013 23:52:10 -0500
Message-ID: <CAMP44s1uasvGmCMkMF2N0eTMgOdksG0HqeidXK+159HAi4jkpA@mail.gmail.com>
References: <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<20130903150855.GK29840@goldbirke>
	<20130903170419.GA29921@google.com>
	<xmqqli3co7ov.fsf@gitster.dls.corp.google.com>
	<20130904171356.GD2582@serenity.lan>
	<xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
	<20130904183559.GA3465@sigill.intra.peff.net>
	<CAMP44s3O=cHAtHOj41MccBDOausukb49MV-E6jib6n6czs+p3Q@mail.gmail.com>
	<20130908040615.GA14019@sigill.intra.peff.net>
	<CAMP44s16RZ9JguL=NPcD8TE-gdG7vGEa5KLHzv4bf_VLLEhPRw@mail.gmail.com>
	<20130908042649.GC14019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 06:52:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIWz5-0007Dn-UL
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 06:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab3IHEwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 00:52:13 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:56888 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab3IHEwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 00:52:12 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so4056738lbi.11
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 21:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NFDq0FKpUjI3ZPQ85TU+LaOzTdLZF8iokFrzZapshH4=;
        b=PY7TGPRoD2EU0XMwaC7jzBajgkPCoV5kC2409GF5gS3WYua9kAQAmAvevDwr/BifAi
         Lg+yIUg5IGiQI/B9cvI3G7kO8YH152TdEztexevPpXfMGHr+uyJaVP/BVIHYDUKjA6dv
         gAuZ5AcGxJlEmBVkJnrFPaqA2K1HHi45/8tj1sfOwm012zonAdD5JNs+S5Sn3iqkeYPV
         2abBJAtWGQcpRceiL+fMQJJS0K9/CTCHBOe1ljfD/5PGP4esMXMCJ2Se2z86W67hH+HN
         RBHrzpL8OGOVFtnnII97jzo4FHBe+Muduc0dlnBm9CBcq5VTRZVwAqcR3kNPYPb4HVyt
         1Ijw==
X-Received: by 10.112.154.70 with SMTP id vm6mr10110699lbb.1.1378615930675;
 Sat, 07 Sep 2013 21:52:10 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 21:52:10 -0700 (PDT)
In-Reply-To: <20130908042649.GC14019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234180>

On Sat, Sep 7, 2013 at 11:26 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 07, 2013 at 11:13:10PM -0500, Felipe Contreras wrote:
>
>> > If the reasoning is "cmp(actual, expect) makes more sense to humans"
>> > then I do not think it is universal.
>>
>> No.
>>
>> ---
>> A(ny) sanely defined "compare A with B" function should yield the
>> result of subtracting B from A, i.e. cmp(A,B) should be like (A-B).
>> That is what you feed qsort() and bsearch() (it is not limited to C;
>> you see the same in "sort { $a <=> $b }").  The definition naturally
>> makes "cmp(A,B) < 0" like "A < B" and "cmp(A,B) > 0" like "A > B".
>> ---
>
> Ah, you mean "if you think that the compare function should behave like
> C *_cmp functions, it should be A-B". Perhaps it is simply that I do not
> think of the function in those terms, but more like "show me the
> differences from B to A".

But that is the problem, you are unable to ignore the implementation.
You don't see test_cmp(), you see 'diff -u'.

>> > Otherwise why would so many
>> > existing test frameworks do it the other way?
>>
>> Which many existing frameworks do it the other way?
>
> John mentioned JUnit, NUnit, and PHPUnit earlier in the thread. I
> believe that Ruby's Test::Unit::Assertions also has
> assert_equal(expected, actual).

That's because they all do first expect, then actual.

assert_equal( expected, actual, failure_message = nil )
assert_not_equal( expected, actual, failure_message = nil )

That's why.

>> > Or any number of variations. I'm sure you will say "but those seem
>> > awkward and unlike how I think about it". But that was my point; it
>> > seems to be a matter of preference.
>>
>> Really? You think any sane human being would prefer:
>>
>> Computer, given that we expect B, how does A differ?
>>
>> To:
>>
>> Computer, compare A with B
>
> I already said that is how I think about it. If you want to call me notn
> sane, feel free. But I do not see that this line of discussion is going
> anywhere productive.

Again, that's because you are already thinking on the resulting diff,
based on the 'diff -u' command, but that's not in question here. Even
if test_cmp() didn't return an diff (it just ran cmp), it would be
useful, as ultimately we want to test for failures. Ultimately what we
want is to check that A is equal to B, so it's natural to tell the
computer "compare A with B", and if you don't think so, then yeah, I
think you are insane.

-- 
Felipe Contreras
