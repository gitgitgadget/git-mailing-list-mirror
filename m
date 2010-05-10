From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [PATCH/RFC] Add [] as an alias for a reference to the empty tree
Date: Mon, 10 May 2010 10:14:15 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74482E511E7@xmail3.se.axis.com>
References: <1273250247-20762-1-git-send-email-pkj@axis.com>
 <20100508045319.GD14998@coredump.intra.peff.net>
 <7vhbmjc6dy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 10 10:14:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBO8N-00051U-F3
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 10:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463Ab0EJIOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 04:14:35 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:52341 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab0EJIOd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 04:14:33 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by miranda.se.axis.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id o4A8EHcB024392;
	Mon, 10 May 2010 10:14:17 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Mon, 10 May 2010 10:14:17 +0200
Thread-Topic: [PATCH/RFC] Add [] as an alias for a reference to the empty
 tree
Thread-Index: AcrubtrZ+O3pXLgmRR+rEV1PcN3WtABpwtOA
In-Reply-To: <7vhbmjc6dy.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146771>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Junio C Hamano
> Sent: den 8 maj 2010 07:25
> To: Jeff King
> Cc: Peter Kjellerstedt; git@vger.kernel.org
> Subject: Re: [PATCH/RFC] Add [] as an alias for a reference to the
> empty tree
> 
> Jeff King <peff@peff.net> writes:
> 
> > Based on past discussions, I suspect other people would be interested
> > in:
> >
> >   $ git diff [index] HEAD
> >   $ git diff HEAD [index]
> >   $ git diff [working-tree] [index]

Interesting. I had not thought of that, but I can see the use for it
in some situations if nothing else but to clarify what is going on.

> > etc. I don't think I would want to type those all the time,...

Well, I have to agree on that, even though I guess they could be 
abbreviated like [i] and [wt].

> If you go that route, why not use INDEX and WORKTREE (all caps) to at
> least avoid the brackets?  I am not personally interested in [] at all,
> but as part of that repertoire of syntactic sugar tokens EMPTY might be
> able to sneak in [*1*]

The reason I choose to use some special characters like [] was that I 
explicitly did not want to touch the normal namespace for references,
since these refs do not actually exist in the .git directory and things
could get a bit surprising if someone actually created a branch/tag
named INDEX...

However, if INDEX, WORKTREE and EMPTY are preferred as syntactic sugar
tokes, then that is fine by me. Unfortunately, I do not have the time
nor the knowledge needed to add support for the INDEX and WORKTREE 
tokens, so I am afraid I will have to leave this as a suggestion for 
the future.

> [Footnote]
> 
> *1* Without that "[]" syntax, the feature is "Meh" for me, but with the
> syntax, it becomes "Yuck".  The reason I am not interested in the
> feature is because I don't see much value in running "git diff EMPTY
> <anything>". Perhaps "git archive" might be what the user really wants 
> to find.

As I mentioned in [1] I am post-processing the generated diff, and then 
the empty tree is just another starting point for the diff. Having to 
get the full content some other way (e.g., via git archive) would just
mean a lot of unnecessary code and special casing in this case.

//Peter

[1] http://thread.gmane.org/gmane.comp.version-control.git/146468/focus=146518
