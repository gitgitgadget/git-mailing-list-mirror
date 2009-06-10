From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Wed, 10 Jun 2009 21:37:57 +0200
Message-ID: <c07716ae0906101237o5038fc4dle9f11b6f2216652a@mail.gmail.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
	 <4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>
	 <4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>
	 <c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com>
	 <c07716ae0906090526i714bb6c9g4e3d8cf61021af77@mail.gmail.com>
	 <4A2E7EEC.2050807@zytor.com>
	 <c07716ae0906091228s708058d4vea986239a6b458de@mail.gmail.com>
	 <7viqj5kutl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 21:38:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1METct-0003tD-4P
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 21:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174AbZFJTh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 15:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756973AbZFJTh5
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 15:37:57 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:41755 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756943AbZFJTh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 15:37:56 -0400
Received: by fxm9 with SMTP id 9so1051509fxm.37
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 12:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Rh9nR2v3y0XWdmFwTVM1rAwUnMFZxbZUeHmezlGqOk8=;
        b=arKPmBTcgG4Eg/g94ycPpuV6TyQqxwshgG9VmPjmQekoUFwaawZmhxNhkg+4DbKjwS
         2qmIIgD4So5QG++7G+FBlVzI7rYXIpDVHYpBz2afgSw/GrmrsG0WwwAb6rFB7cNhGe0m
         3hg9iFLE3zE1lxZyZJ9wDVjRNoNE59SmUdH0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ed0Y51DUYAT1x2TQJV+duA0tyk5RDRp7t3kPp2B9D4oU8FXZxAlo5kvl7eDqUL+mNm
         jVNU4FpKKs1BOoM1ZuolIS1s+aukrX8zzNSIG6OGll69BrnSr2tCmdjR+Zriwc34XDxf
         jNN0gJOzxk+4NwYzH9j9UsIVp6t8YQxK58k8k=
Received: by 10.103.161.16 with SMTP id n16mr820055muo.79.1244662677595; Wed, 
	10 Jun 2009 12:37:57 -0700 (PDT)
In-Reply-To: <7viqj5kutl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121298>

On Tue, Jun 9, 2009 at 10:37 PM, Junio C Hamano<gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> My opinion is that we should not penalize all the people working on
>> "quite clean" projects and also people working on "not clean" projects
>> who are able to recover, on the pretence that there are other people
>> on these "not clean" projects who are not.
>>
>> I think it's the projects maintainers' responsibility to keep their
>> projects graphs quite clean (and they have the right to ask git
>> developers for the tools to do that).
>
> You seem to be saying that a completely linear history is the only one
> that is clean.

I was thinking about projects that use test suites to make sure new
commits don't break a lot of things.
But I should have said "to keep their projects graph quite clean or to
provide specific information about how to work around potential
problems when bisecting."

> In an earlier message, I illustrated a case where two people independently
> worked on unrelated topic and ended up merging their branches together, to
> illustrate why your "not adjacent in goodness space" algorithm does not
> give "away from untestable ones in topology space".
>
> With your definition, that history is _not_ clean.  I do not think any
> project wnats that kind of cleanness in their history.  You just made the
> word "clean" to describe the history meaningless.

When I wrote "clean", I just mean with not too many untestable commits.

> My take on the issue you mentioned above is that we should not penalize
> the codepath's simplicity too much, only to cater to pathological
> behaviour exhibited on an uninteresting special case of competely linear
> history.

I tried to make a short yet efficient implementation, not to favor a
special case.

> Your algorithm is Ok as an initial cut, in that it is an improvement over
> the "next in goodness space, not even bother to avoid the pathological
> case" algorithm.  But I do not think it is much better than HPA's "try the
> best one if it is not skipped, otherwise pick one randomly", and if we
> wanted to do better and to claim that we pick ones that are _away_ from
> untestable ones, we do need to take topology into account.  That is all I
> am saying.

Ok. I started working on optionaly using a PRNG but I am not sure that
you will want to add another one.

Best regards,
Christian.
