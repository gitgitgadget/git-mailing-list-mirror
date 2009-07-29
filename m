From: Johan Herland <johan@herland.net>
Subject: Re: [RFC 06/11 v2] fast-import: Add support for importing commit notes
Date: Wed, 29 Jul 2009 04:41:07 +0200
Message-ID: <200907290441.08246.johan@herland.net>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
 <200907280343.56586.johan@herland.net>
 <7vskgg1bbt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	barkalow@iabervon.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 04:41:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVz6V-0003PV-Md
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 04:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756239AbZG2ClM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 22:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbZG2ClL
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 22:41:11 -0400
Received: from mx.getmail.no ([84.208.15.66]:64307 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750971AbZG2ClK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2009 22:41:10 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNI007KKVGM1I90@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Jul 2009 04:41:10 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNI0043VVGKO340@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Jul 2009 04:41:09 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.29.22715
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <7vskgg1bbt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124303>

On Wednesday 29 July 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > +External data format::
> > +	The data content for the note was already supplied by a prior
> > +	`blob` command.  The frontend just needs to connect it to the
> > +	commit that is to be annotated.
> > ++
> > +....
> > +	'N' SP <dataref> SP <committish> LF
> > +....
> > ++
> > +Here `<dataref>` can be either a mark reference (`:<idnum>`)
> > +set by a prior `blob` command, or a full 40-byte SHA-1 of an
> > +existing Git blob object.
> > +
> > +Inline data format::
> > +	The data content for the note has not been supplied yet.
> > +	The frontend wants to supply it as part of this modify
> > +	command.
> > ++
> > +....
> > +	'N' SP 'inline' SP <committish> LF
> > +	data
> > +....
> > ++
> > +See below for a detailed description of the `data` command.
> > +
> > +In both formats `<committish>` is any of the commit specification
> > +expressions also accepted by `from` (see above).
>
> Doesn't this make fast-import language incapable of add notes to anything
> other than commits?  As far as I remember, there is no such limitation in
> the underlying data structure on git notes, even though the git-notes
> sample Porcelain might have such a restriction.

It does (probably because the default notes tree is "refs/notes/commits").

> We recently hit a similar unintended limitation that we regret in the
> fast-import language, didn't we?

I don't know. Must have slipped past my mailbox.

> Although personally I do not think it is a big deal if we cannot tag or
> add notes to trees, I am pointing it out in case other people care.

I copied the semantics from the 'tag' command, for no particular reason 
(except following the git-notes procelain). Expanding 'notemodify' (and 
'tag') to cover all types of objects is fine by me, unless there are good 
arguments otherwise. Shawn?


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
