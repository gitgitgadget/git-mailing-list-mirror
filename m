From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Sat, 7 Sep 2013 23:13:10 -0500
Message-ID: <CAMP44s16RZ9JguL=NPcD8TE-gdG7vGEa5KLHzv4bf_VLLEhPRw@mail.gmail.com>
References: <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
	<20130903111006.GJ29840@goldbirke>
	<CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<20130903150855.GK29840@goldbirke>
	<20130903170419.GA29921@google.com>
	<xmqqli3co7ov.fsf@gitster.dls.corp.google.com>
	<20130904171356.GD2582@serenity.lan>
	<xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
	<20130904183559.GA3465@sigill.intra.peff.net>
	<CAMP44s3O=cHAtHOj41MccBDOausukb49MV-E6jib6n6czs+p3Q@mail.gmail.com>
	<20130908040615.GA14019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 06:13:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIWNB-0008Rg-8v
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 06:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238Ab3IHENN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 00:13:13 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:62962 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab3IHENM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 00:13:12 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so4046063lbj.13
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 21:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BdPIlyTj6t11hq1LszZOmVxBJHTIlDZ15PQlkXWjAAE=;
        b=ADiLuDllldZsiBYvxE6P2GZR0yW0ZFPUPvVEI9WMNJC0NfREj+jVBF8QLmvqc0gkO8
         0iPML3PdDYLdu7LqLbFRmbU/Jn1NNoVMwIwpDywis/prVkC/nitYh4dUkwHrMmwsqtMM
         8EnuIFeU05nfgig2+jwXo7Pyd4lpJIHWZq0k+FxCFgMbUz53TeDBQKIQAVvAI5C3icCZ
         EhOdWqO+8oehG0brg1/Kr465iKSTNbIJNkAZDhJLor3zEoAL94j0S0oqfugHBLBTCZ8+
         1VBwBibJpkxj39xb+fAsdAXt9Miap8Zt5uHr/FQS+V+egFxEDK+hbxZb2N7aQLbDuvZs
         DHjw==
X-Received: by 10.152.29.103 with SMTP id j7mr9650322lah.7.1378613590830; Sat,
 07 Sep 2013 21:13:10 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 21:13:10 -0700 (PDT)
In-Reply-To: <20130908040615.GA14019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234172>

On Sat, Sep 7, 2013 at 11:06 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 07, 2013 at 10:11:49PM -0500, Felipe Contreras wrote:
>
>> > Though I prefer the current, I can certainly live and adapt to a changed
>> > standard, and I do not mind doing so if there is a good reason. But I've
>> > yet to see any argument beyond "it is not what I like". Which to me
>> > argues for the status quo as the path of least resistance.
>>
>> Didn't Junio already provided reasoning?
>
> If the reasoning is "cmp(actual, expect) makes more sense to humans"
> then I do not think it is universal.

No.

---
A(ny) sanely defined "compare A with B" function should yield the
result of subtracting B from A, i.e. cmp(A,B) should be like (A-B).
That is what you feed qsort() and bsearch() (it is not limited to C;
you see the same in "sort { $a <=> $b }").  The definition naturally
makes "cmp(A,B) < 0" like "A < B" and "cmp(A,B) > 0" like "A > B".
---

> Otherwise why would so many
> existing test frameworks do it the other way?

Which many existing frameworks do it the other way?

>> Here's more; human semantics:
>>
>> Computer, compare A with B
>> cmp(A, B)
>>
>> Why would I write?
>>
>> cmp(B, A)
>>
>> Could you even construct an English sentence that starts with B, and then A?
>
> "Computer, given that we expect B, how does A differ?". Or "Computer, we
> expect B; does A match it?"
>
> Or any number of variations. I'm sure you will say "but those seem
> awkward and unlike how I think about it". But that was my point; it
> seems to be a matter of preference.

Really? You think any sane human being would prefer:

Computer, given that we expect B, how does A differ?

To:

Computer, compare A with B

-- 
Felipe Contreras
