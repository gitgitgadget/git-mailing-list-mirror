From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git push (mis ?)behavior
Date: Wed, 3 Oct 2007 12:25:22 +0200
Message-ID: <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp> <buobqbgmv6z.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 12:25:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id1QO-0006yC-8m
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 12:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbXJCKZn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 06:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbXJCKZn
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 06:25:43 -0400
Received: from wincent.com ([72.3.236.74]:46918 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193AbXJCKZm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2007 06:25:42 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l93APP2s015304;
	Wed, 3 Oct 2007 05:25:26 -0500
In-Reply-To: <buobqbgmv6z.fsf@dhapc248.dev.necel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59818>

El 3/10/2007, a las 10:57, Miles Bader escribi=F3:

> To the extent that a command _is_ "dangerous", there's always a =20
> tradeoff
> between convenience and "danger".  Some systems (e.g. those aimed at
> newbies) might have as a goal to do the absolute minimum with every
> command and always, always, err on the side of safety.  I don't =20
> think git
> is that system.

While much of this debate can be shortcircuited simply by making the =20
behaviour configurable, I would like to take you up on the point that =20
you raise here.

If we're going to talk about what kind of system Git is then consider =20
this:

- it's inherently distributed and this design actively encourages =20
users to treat their local repositories as sandboxes where things are =20
tried out, perfected, and then pushed out into the public via one =20
means or another

- it's built from the ground up to be good at branching and merging; =20
this, combined with my previous point, means that users are likely to =20
have multiple heads and often some of them will be "works in =20
progress" that aren't yet ready for publication

So it's in that light I see accidentally pushing more than you =20
thought you would as "dangerous"; when you make this mistake you're =20
basically making stuff available that's not yet ready for =20
consumption, and by its nature this mistake is basically =20
irreversible: you can't really "unpush" what you pushed, you can only =20
push out additional amendments which correct it.

So, in this light, when you say:

> What's "dangerous" for newbies, often ends up being what doesn't
> correspond with their mental model.

I don't know how much it has to do with mental models. I think in =20
this case it's a bit simpler than that where you make the mistake =20
once or twice and very quickly learn that "git push" means "push =20
what's in my repo", not "push only what's on my current branch". It's =20
a *very* easy lesson to learn if you get burnt and hardly requires =20
any adjustments to ones "mental model".

I personally would be in favour of changing the default because I =20
tend to work on a particular branch at a time and then want to push =20
*that* out -- generally I'm thinking about one general area or one =20
task at a time, and that means one branch at a time; I almost never =20
think along the lines of getting all my branches into shape at once =20
and then pushing them out in a batch. I think this is more likely to =20
be a common pattern, although obviously that remains speculation at =20
this point.

Changing the default would be great for people like me; by not having =20
to pass additional parameters to git-push I save some keystrokes. If =20
I ever want to push everything an "--all" switch would do the job. =20
But if people prefer to keep the old default then there'll =20
be .gitconfig for people like me. In any case I think more people =20
need to speak up on the topic so that we can find out what most =20
people really think about changing the default.

Cheers,
Wincent
