From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 5/5] implement @{publish} shorthand
Date: Sat, 15 Feb 2014 11:50:10 -0000
Organization: OPDS
Message-ID: <9D08338A41454F778D03FB2E9F4B7DD1@PhilipOakley>
References: <20140108093338.GA15659@sigill.intra.peff.net> <20140108093716.GE15720@sigill.intra.peff.net> <xmqqob32s08p.fsf@gitster.dls.corp.google.com> <20140124213521.GA26602@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 15 12:50:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEdl3-0000AR-Mk
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 12:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbaBOLuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 06:50:03 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:9006 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752400AbaBOLuA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Feb 2014 06:50:00 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnYXADBT/1JZ8YjN/2dsb2JhbABZgwaEEYU+tnUBAgEBgQ0XdGkBAYEfAQEUAQQBAQQBCAEBGQQRHgEBIQsCAwUCAQMOBwECAgIFIQICFAEEGgYHFwYTCAIBAgMBhTgHAYITGQynQqFCF4EpjQ9JgnY1gRQEjymbJoMtPIEt
X-IPAS-Result: AnYXADBT/1JZ8YjN/2dsb2JhbABZgwaEEYU+tnUBAgEBgQ0XdGkBAYEfAQEUAQQBAQQBCAEBGQQRHgEBIQsCAwUCAQMOBwECAgIFIQICFAEEGgYHFwYTCAIBAgMBhTgHAYITGQynQqFCF4EpjQ9JgnY1gRQEjymbJoMtPIEt
X-IronPort-AV: E=Sophos;i="4.95,850,1384300800"; 
   d="scan'208";a="449790428"
Received: from host-89-241-136-205.as13285.net (HELO PhilipOakley) ([89.241.136.205])
  by out1.ip03ir2.opaltelecom.net with SMTP; 15 Feb 2014 11:49:58 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242186>

From: "Jeff King" <peff@peff.net>
Sent: Friday, January 24, 2014 9:35 PM
> On Thu, Jan 23, 2014 at 04:16:06PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > In a triangular workflow, you may have a distinct
>> > @{upstream} that you pull changes from, but publish by
>> > default (if you typed "git push") to a different remote (or
>> > a different branch on the remote). It may sometimes be
>> > useful to be able to quickly refer to that publishing point
>> > (e.g., to see which changes you have that have not yet been
>> > published).
>> >
>> > This patch introduces the <branch>@{publish} shorthand (or
>> > "@{pu}" to be even shorter).

Just to say that I'm not sure that "publish" is the best word for this 
concept.

To my mind something is published when some form of editorial oversight 
has been applied to the works. Such an understanding would better match 
the 'upstream' concept (e.g. $gmane/240230 jch/9Jan14). This should be 
distinguished from 'self-publishing', and again from 
'vanity-publishing'.

In terms of the triangular work-flow such a 'publish' repo is somewhere 
between a vanity publishing, and self publishing (depending on the level 
of code cleanliness;-)

One of the problems, just like the 'staging/index' discussions, is the
lack of suitable word for the new working concepts that perfect
reproduction has brought.

At best, I considered terms such as "home" repo, "depository" repo and 
"self" repo, and the many synonyms of publish, store, copy, duplicate, 
etc. without much success.

Finding a right term or phrase for the concept will be important to 
ensure some clarity and distinction between the upstream and one's 
'home' repo. Perhaps "self-storage" might be borrowed from that 
new(-ish) industry.

>> >                                            It refers to the 
>> > tracking
>> > branch of the remote branch to which you would push if you
>> > were to push the named branch. That's a mouthful to explain,
>> > so here's an example:
>> >
>> >   $ git checkout -b foo origin/master
>> >   $ git config remote.pushdefault github
>> >   $ git push
>> >
>> > Signed-off-by: Jeff King <peff@peff.net>
>> > ---
>>
>> As there is no @{pu} in publish_mark() as far as I can see, and also
>> I found it is a bit unclear what the example in the last paragraph
>> wants to illustrate, I'll reword the above as the following before
>> merging it to 'next'.
>
> Yeah, I think the @{pu} was just a silly omission from the code, 
> though
> I agree after our discussion that we should just stick with 
> "@{publish}"
> for now.
>
> I am not sure why I said "git push" at the end. I would have thought
> that:
>
>  $ git rev-parse --symbolic-full-name @{publish}
>  refs/remotes/github/foo
>
> would have been the right command to demonstrate. The text you 
> suggested
> is fine, though I think you can simply drop the "git push", as it does
> not add anything.
>
> As far as merging it to 'next', I had not really intended it to go 
> that
> far. :) It was more for Ram to use as a base. I find some of the
> refactoring questionable, including:
>
>  1. The meaning of branch->pushremote is subtly different from that of
>     branch->remote. Ram's followup refactoring did a better job of
>     that (but he is missing the patches on top to finish out the
>     feature).
>
>  2. We are duplicating the "where to push" logic here. That should
>     probably be factored out so that "git push" and "@{publish}" use
>     the same logic.
>
> And of course there are no tests or documentation. It might work,
> though.
>
> I don't mind if you want to merge it and do more work in-tree, but I 
> do
> not think it should graduate as-is. And you may want check from Ram 
> that
> he is not in the middle of his own version based on the patches he 
> sent
> earlier, as reworking them on top of mine would probably just be
> needless extra work.
>
> Are you planning on having request-pull use @{publish} as a default? I
> saw you cc'd me on that thread, but I didn't have any opinion besides
> "sounds like you could use it here".
>
> -Peff
> --
Philip 
