From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] git-apply - Add --include=PATH
Date: Sun, 24 Aug 2008 14:57:43 -0700
Message-ID: <1219615063.18365.141.camel@localhost>
References: <1219523869.18365.106.camel@localhost>
	 <7viqtrw7up.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 23:58:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXNbs-00084w-BU
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 23:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbYHXV5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 17:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbYHXV5w
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 17:57:52 -0400
Received: from 136-022.dsl.LABridge.com ([206.117.136.22]:1445 "EHLO
	mail.perches.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbYHXV5v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 17:57:51 -0400
Received: from [192.168.1.128] ([192.168.1.128])
	by mail.perches.com (8.9.3/8.9.3) with ESMTP id OAA01152;
	Sun, 24 Aug 2008 14:47:39 -0700
In-Reply-To: <7viqtrw7up.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3-1.3mdv2008.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93569>

On Sat, 2008-08-23 at 17:54 -0700, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
> > Add similar capability to --exclude=
> > Allows selection of files to patch from a
> > large patchset.
> Thanks; I don't see anything fundamentally wrong with what this patch
> tries to achieve.
> 
> > @@ -2996,10 +2996,16 @@ static struct excludes {
> >  	const char *path;
> >  } *excludes;
> >  
> > +static struct includes {
> > +	struct includes *next;
> > +	const char *path;
> > +} *includes;
> 
> Now this is ugly.  You can just add a new variable "*includes" that is of
> exactly the same type as existing "*excludes" without introducing a new
> type.

Yes, it's slightly ugly, but it was less work and much easier for
a human to parse.  I also didn't want to use "struct excludes"
for includes which I thought even uglier.

> You should then find it disturbing that the shared type is still called
> "struct excludes" even though it is now used for things you would want to
> include.  You are right.  You can then either rename it to a more neutral
> name, or (even better) use an existing type, such as "string_list".

I'm on holiday for a few days, but I'll submit 2 patches later:

1. Rename struct excludes to struct path_list
2. Add --includes

cheers, Joe
