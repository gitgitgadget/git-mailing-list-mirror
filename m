From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: RFC: grafts generalised
Date: Wed, 2 Jul 2008 19:59:44 +0200
Message-ID: <20080702175944.GC16235@cuci.nl>
References: <20080702143519.GA8391@cuci.nl> <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 20:00:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE6dH-0001Fp-7k
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 20:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbYGBR7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 13:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbYGBR7q
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 13:59:46 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:59374 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbYGBR7q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 13:59:46 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id CA95B5465; Wed,  2 Jul 2008 19:59:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87170>

Dmitry Potapov wrote:
>I don't think that the grafts file is the right place for this kind of
>information.

Yet the grafts file is exactly the place where this type of
"overlay-information" is being placed now.  It seems to be the natural place.

> Perhaps, it would be better to have a separate file or
>even a directory with files where commit-id identifies a text file with
>a new commit object, which should be placed instead of an old one.  So,
>it will be easy to tell git filter-branch to use this new information.

Not quite sure why this makes it easier.  The point is that there
is not supposed to be a grafts file in a proper repository.  Thus,
having a lot of these files means a larger disruption to the core, and
I'd like the core to be as efficient and lean as possible given an empty
grafts file.  So I'd prefer to keep it to one file.

>However, if you want more than just ability to edit commits in a text
>file but also inspect changes using normal git commands and gitk (as it
>is possible with grafts), it will require changes to the git core, which,
>perhaps, not difficult to implement using pretend_sha1_file(), but I am
>not sure that everyone will welcome that...

I'd want to avoid a plethora of files, and the changes that can be
specified are supposed to be partial overrides, not complete rewrites.
So using pretend_sha1_file() is a bit overkill and more than I was
aiming for.

The point is, that the changes in grafts (as they are now) are *not*
used when cloning.  I.e. the only thing you mess up is your *own*
repository, not someone else's.  I.e. you can't make someone remote
think that the repository has been altered.  That would require git
filter-branch, which immediately changes all the historical SHA1s, and
makes the changes in history blatantly visible.
-- 
Sincerely,
           Stephen R. van den Berg.

You are confused; but this is your normal state.
