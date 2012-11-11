From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Sun, 11 Nov 2012 19:48:14 +0100
Message-ID: <CAMP44s1m8sAD9D0F-6b=+dm_AvLb_4_f7h=3A_VMYMDUEcTW7g@mail.gmail.com>
References: <20121108200919.GP15560@sigill.intra.peff.net>
	<509CCCBC.8010102@drmicha.warpmail.net>
	<CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
	<509E8EB2.7040509@drmicha.warpmail.net>
	<CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
	<509EAA45.8020005@gmail.com>
	<CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>
	<509FD9BC.7050204@gmail.com>
	<20121111171518.GA20115@sigill.intra.peff.net>
	<CAMP44s1mny-fBCxywM0V=AgEoxV5EZdDWc_0NK3gepcKf32nww@mail.gmail.com>
	<20121111181406.GA21654@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 19:48:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXca5-0000Jh-Rb
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 19:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab2KKSsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 13:48:16 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41611 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360Ab2KKSsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 13:48:15 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5572162obb.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 10:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lt537yiWkDREPfzQ2BwQ4znZGPRKpmtT9P8ybRyXqWA=;
        b=dG+UonpN0yjytwyqVEOqjaJyWWg4gbKq0dLOZPNv9ZgCvNwQLqAyZY3xEoohVmvquT
         nbC+lcm1/CB/t0/z3l0YkoBZzYfe4yydp1pdb/GV0+RSoMyoWEz+NxdWe7ZVYuDvPFw4
         ZzLvJhdvuR/aQ0EMnycFViFee6SVr3DXfFfW4npDqHyhKSY+XeHiKj5kvkK8SQxDO9XI
         0ZWtva+KCX3522Y+K6/SVuWiH4K7UeTlJ+oTBW6qiL461mc4Gp9pPk81QggGnnAH69cu
         KfvqK/kvRJDGX1iSPoYzBChEd4I3LuJdKxj5icr0MQXJh5FKLjkiH5qcYn+TUyIUAI3H
         CkRg==
Received: by 10.182.194.70 with SMTP id hu6mr13650446obc.4.1352659694307; Sun,
 11 Nov 2012 10:48:14 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 10:48:14 -0800 (PST)
In-Reply-To: <20121111181406.GA21654@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209438>

On Sun, Nov 11, 2012 at 7:14 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 11, 2012 at 06:45:32PM +0100, Felipe Contreras wrote:
>
>> > If there is a standard filter, then what is the advantage in doing it as
>> > a pipe? Why not just teach fast-import the same trick (and possibly make
>> > it optional)? That would be simpler, more efficient, and it would make
>> > it easier for remote helpers to turn it on (they use a command-line
>> > switch rather than setting up an extra process).
>>
>> Right, but instead of a command-line switch it probably should be
>> enabled on the stream:
>>
>>   feature clean-authors
>>
>> Or something.
>
> Yeah, I was thinking it would need a feature switch to the remote helper
> to turn on the command-line, but I forgot that fast-import can take
> feature lines directly.
>
>> > We can clean up and normalize
>> > things like whitespace (and we probably should if we do not do so
>> > already). But beyond that, we have no context about the name; only the
>> > exporter has that.
>>
>> There is no context.
>
> There may not be a lot, but there is some:
>
>> These are exactly the same questions every exporter must answer. And
>> there's no answer, because the field is not a git author, it's a
>> mercurial user, or a bazaar committer, or who knows what.
>
> The exporter knows that the field is a mercurial user (or whatever).
> Fast-import does not even know that, and cannot apply any rules or
> heuristics about the format of a mercurial user string, what is common
> in the mercurial world, etc. It may not be a lot of context in some
> cases (I do not know anything about mercurial's formats, so I can't say
> what knowledge is available). But at least the exporter has a chance at
> domain-specific interpretation of the string. Fast-import has no chance,
> because it does not know the domain.
>
> I've snipped the rest of your argument, which is basically that
> mercurial does not have any context at all, and knowing that it is a
> mercurial author is useless.  I am not sure that is true; even knowing
> that it is a free-form field versus something structured (e.g., we know
> CVS authors are usernames on the server server) is useful.

It is useful in the sense that we know we cannot do anything sensible
about it. All we can do is try.

> But I would agree there are probably multiple systems that are like
> mercurial in that the author field is usually something like "name
> <email>", but may be arbitrary text (I assume bzr is the same way, but
> you would know better than me).  So it may make sense to have some stock
> algorithm to try to convert arbitrary almost-name-and-email text into
> name and email to reduce duplication between exporters, but:

Yes, bazaar seems to be the same way.

% bzr log
------------------------------------------------------------
revno: 1
committer: Foo Bar<foo.bar@example.com> <none@none
branch nick: bzr
timestamp: Sun 2012-11-11 19:41:10 +0100
message:
  one

>   1. It must be turned on explicitly by the exporter, since we do not
>      want to munge more structured input from clueful exporters.

Agreed.

>   2. The exporter should only turn it on after replacing its own munging
>      (e.g., it shouldn't be adding junk like <none@none>; fast-import
>      would need to receive as pristine an input as possible).

Agreed.

>   3. Exporters should not use it if they have any broken-down
>      representation at all. Even knowing that the first half is a human
>      name and the second half is something else would give it a better
>      shot at cleaning than fast-import would get.

I'm not sure what you mean by this. If they have name and email, then
sure, it's easy.

And for the record, I've have encountered this problem also with
monotone. There's quite a lot of strategies to convert names to git
authors.

Cheers.

-- 
Felipe Contreras
