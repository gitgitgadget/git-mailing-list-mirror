From: Philippe De Muyter <phdm@macq.eu>
Subject: Re: identical hashes on two branches, but holes in git log
Date: Thu, 21 May 2015 22:37:57 +0200
Message-ID: <20150521203757.GA2711@frolo.macqel>
References: <20150519132958.GA21130@frolo.macqel> <xmqq617oa75l.fsf@gitster.dls.corp.google.com> <20150519214719.GA12732@frolo.macqel> <xmqqiobop67k.fsf@gitster.dls.corp.google.com> <20150521071518.GA8675@frolo.macqel> <B2DD947EDB314A2C878567932ECB974E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu May 21 22:38:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvXEF-0007gC-Mw
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 22:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544AbbEUUiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 16:38:04 -0400
Received: from smtp2.macqel.be ([109.135.2.61]:60036 "EHLO smtp2.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756164AbbEUUiC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 16:38:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp2.macqel.be (Postfix) with ESMTP id 7C524130CFD;
	Thu, 21 May 2015 22:37:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hiYOClrgF+cW; Thu, 21 May 2015 22:37:57 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by smtp2.macqel.be (Postfix) with ESMTP id CDB6D130CE5;
	Thu, 21 May 2015 22:37:57 +0200 (CEST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id AFA3FDF06BC; Thu, 21 May 2015 22:37:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B2DD947EDB314A2C878567932ECB974E@PhilipOakley>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269658>

On Thu, May 21, 2015 at 08:58:35PM +0100, Philip Oakley wrote:
> From: "Philippe De Muyter" <phdm@macq.eu>
> To: "Junio C Hamano" <gitster@pobox.com>
> Cc: <git@vger.kernel.org>; "Jeff King" <peff@peff.net>; "John Keeping" 
> <john@keeping.me.uk>
> Sent: Thursday, May 21, 2015 8:15 AM
> Subject: Re: identical hashes on two branches, but holes in git log
>
>
>> On Tue, May 19, 2015 at 03:12:31PM -0700, Junio C Hamano wrote:
>>> Philippe De Muyter <phdm@macq.eu> writes:
>>>
>>> > On Tue, May 19, 2015 at 09:01:10AM -0700, Junio C Hamano wrote:
>>> >> Philippe De Muyter <phdm@macq.eu> writes:
>>> >>
>>> >> > Trying to understand, I have eventually done "git log" on my >> > 
>>> branch and
>>> >> > on v3.15 with the following commands :
>>> >> >
>>> >> > git log v3.15 --full-history --decorate=short | grep '^commit' > >> 
>>> > /tmp/3.15.commits
>>> >> > git log --full-history --decorate=short | grep '^commit' > >> > 
>>> /tmp/mybranch.commits
>>> >>
>>> >> Either
>>> >>
>>> >>     git log --oneline v3.15..HEAD ;# show what I have not in >> theirs
>>> >>
>>> >> or
>>> >>
>>> >>     gitk v3.15...HEAD ;# show our differences graphically
>>> >
>>> > This shows the commits in my branch starting from the most recent > 
>>> common point,
>>> > thus my commits, but I see differences in the files not explained > by 
>>> my commits,
>>> > but by the fact that many older commits (between v3.13 and v3.14) > are 
>>> missing on
>>> > my branch, but still in both branches I have a commit called v3.14 > 
>>> with the
>>> > same hash.  Is that normal ?
>>>
>>> Sorry, cannot parse.  Neither of the above would show files, so just
>>> about the place where you start talking about "I see differences in
>>> the files", you lost me.
>>
>> Look at the other part of the thread, with the discussion with Jeff and 
>> John
>>
>> The light has come, and what I understand is:
>>
>> don't trust the default (ordering) mode of 'git log' :(
>
>
> Surely the question now should be "What should the man page say that would 
> have explained the default ordering mode in an understandable way, rather 
> than the current misunderstanding?".
>
> What 'ordering' were you 'trusting' (presuming) anyway? The current default 
> mode doesn't actually say anything about the order anyway (as you've 
> discovered).

I have used 'git log' on the current 'master' branch of the linux kernel
to find at which point in the history a commit - that I know is disruptive
for my work and that I know by name because I have seen it passing on a
mailing list - had been applied.

'git log -decorate=short' showed it happening between v3.14-rc1 and v3.14-rc2,
but after

	git checkout v3.14

I did not find the effects of the commit in the files that should have been
affected by the commit.

I expected at least that a commit listed between two tags on the same branch
was really applied to that branch between those two tags.

Philippe
>
>>
>> I surmise this happens only when 'git merge' has been used.
>>
> --
> Philip 
