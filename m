From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] doc: document error handling functions and
 conventions (Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf)
Date: Thu, 4 Dec 2014 15:52:45 -0800
Message-ID: <CAPc5daW3+8xjG3z3WgOMfqzWJUiPdcN1-FVgVc0fAjH7tgCa4A@mail.gmail.com>
References: <20141117233525.GC4336@google.com> <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com> <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com> <20141203051344.GM6527@google.com>
 <xmqqzjb4h823.fsf@gitster.dls.corp.google.com> <20141204030133.GA16345@google.com>
 <xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com> <20141204234147.GF16345@google.com>
 <20141204234432.GA29953@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:53:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwgCw-00021l-4J
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933291AbaLDXxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:53:08 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:55112 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776AbaLDXxG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 18:53:06 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so18834053pac.25
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 15:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=siElG8r1b1ZpfX69DBX9k4Lo+AXf4tLm+m7s8XcIlpw=;
        b=pXanHoAn0yGR70L9JEYzRS68RwjruS/ZxFmjttNI59k/4gX2ENCsQ4oTd+7d2Ykds0
         miJ+grgES3qCBCcqaCMohaxQxyVUCbS508aBPe24HGpNZMwLb0yJ1jbP06YmgUXE/S2n
         h55eibcus0DYCfoNQGkutxZZ5RNdyg3CeD3ASECkaDYm9mRXswlhUB3ss271j+hOIC+q
         HYUPKy7rnprJorHI3kN9BliyP+RSf7x7aIJr4dfG1DpE+Ai/nSsj41wQ+Vb7O9mP9TMA
         WL9rMY0cwD54bdvyYbnVIvh4KOQNqid/EU8qt8yVixJVN6FFSEh1UN4AfbquS9h/NMX1
         q2uw==
X-Received: by 10.66.232.168 with SMTP id tp8mr23128361pac.132.1417737185662;
 Thu, 04 Dec 2014 15:53:05 -0800 (PST)
Received: by 10.66.74.134 with HTTP; Thu, 4 Dec 2014 15:52:45 -0800 (PST)
In-Reply-To: <20141204234432.GA29953@peff.net>
X-Google-Sender-Auth: Prqs880qg_VZQftt65RN3vruKW8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260844>

Yeah, that is what I meant. The earlier part will not go to waste no matter
what happens to the discussion.

I am not a fan of char[1024], if only because our error message may have
to mention things whose length is not under our control, e.g. a filename
in the working tree, but I do share your concern that "strbuf"-approach
calls for more boilerplate. I offhand do not have a magic silver bullet for
it, though.

On Thu, Dec 4, 2014 at 3:44 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Dec 04, 2014 at 03:41:47PM -0800, Jonathan Nieder wrote:
>
>> Junio C Hamano wrote:
>> > Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>> >> Here's a draft for documentation on that.
>> >
>> > Thanks; looks reasonable; even if the discussion between you and
>> > Peff took us to a slightly different direction than what you
>> > described here, the earlier description of long established practice
>> > is a welcome addition.
>>
>> I think I see what I misunderstood.  Do you mean "even if we settle on
>> a different API, this documentation of what you started with should be
>> easy to adapt and will make life easier"?
>>
>> In other words, did you mean to say that things are still up in the
>> air (which I agree with) or that the project has already settled on a
>> different direction (which I do not)?
>
> FWIW, that is how I read it (up in the air), and where I thought our
> discussion was.
>
> -Peff
