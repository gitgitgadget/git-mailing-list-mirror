From: Tomash Brechko <tomash.brechko@gmail.com>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 14:51:05 +0400
Message-ID: <20070719105105.GA4929@moonlight.home>
References: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 12:51:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBTbM-0002JE-Rr
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 12:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759620AbXGSKvQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 06:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759619AbXGSKvQ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 06:51:16 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:62824 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758562AbXGSKvO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 06:51:14 -0400
Received: by mu-out-0910.google.com with SMTP id i10so765245mue
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 03:51:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=j4otNMJht0k99+eHzWfWimnhnWMWu0uDaqkjIX1RxRhKhDyjwq1gJ0OYWMq0NJDO/no1/DdMiuk3GTfAry2Fce/qDe/okpLJEZ4UJIBZ+YfitCd5tLIuyiNLbZ8PZDvxmliM2f13tYuI0EOhc832UqgfieZGh2K7SnmDWsaWd60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=hNVe5+KZiT47kxWLSAAip8eSLLwox+jjtRoRLZj6kMXbnsP48B79j7mIyLH8AtfB2XGmB2ST/oFbLEVmEjg5IUYgg1FiAg7LfIaK5gZxZeDjxXuAdnvJMpAxvMfS/CL6srd+yc2VT2vEkz8UXhEBQzgx36Kh2P1h5YnbHxpZ82U=
Received: by 10.82.105.13 with SMTP id d13mr3020323buc.1184842272103;
        Thu, 19 Jul 2007 03:51:12 -0700 (PDT)
Received: from moonlight.home ( [80.246.71.156])
        by mx.google.com with ESMTPS id 1sm1859724nfv.2007.07.19.03.51.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2007 03:51:11 -0700 (PDT)
Received: from moonlight.home (localhost.localdomain [127.0.0.1])
	by moonlight.home (Postfix) with ESMTP id 463DA3A8BC;
	Thu, 19 Jul 2007 14:51:06 +0400 (MSD)
Received: (from tomash@localhost)
	by moonlight.home (8.13.1/8.13.1/Submit) id l6JAp5QG008614;
	Thu, 19 Jul 2007 14:51:05 +0400
Content-Disposition: inline
In-Reply-To: <vpqvecgvmjh.fsf@bauges.imag.fr>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52965>

Dear Git fellows,

A year or so ago I too would strongly advocate the need of tracking
empty directories, permissions et al., it seemed so "natural" and
"plain obvious" to me back then.  But since that time I learned to
appreciate the "contents tracking" approach, and now view directories
(paths in general) only as the means for Git to know where to put the
contents on checkout.  This, BTW, is consistent with how Git figures
container copies/renames.

No doubt mighty Git developers can add support for empty directories,
manage to stay backward compatible, think out consistent user
interface etc.  But there's no end to how much information one may
want to store in Git to make it "_file system_ contents tracking
software".  Starting with empty directories, one may argue then that
certain installation trees also need particular file ownership, so
lets store user/group names like tar does.  It was mentioned already
in this thread that in addition to 'rwx' we also would have to store
ACLs (some OSes have only one of these concepts, some both), SELinux
security contexts, perhaps other arbitrary file attributes that may be
part of file system state.

Wouldn't it be better to preserve Git as a contents tracking system,
and add some tools on top of it that can translate file system state
into textual (or binary) form, so it can be stored in current Git?
And then use this textual representation to restore actual file system
attributes/layout on checkout?  And the only change in Git itself
would be some more hooks, for instance one hook before checking out
over the old work tree, and one after the checkout.  Or one can simply
wrap certain Git commands to implement such hooks.

In any case, no one is going to be against the new feature if it won't
break anything for those of us who find the pure contents tracking the
right thing.  And storing empty directories by default may not be
natural for everyone.  So before going into technical details of how
this can possibly be implemented, could someone answer the following:

1 Is Git going to track directories _always_?  Looks like not, because
  in this thread there seems to be a distinction between 'git add DIR'
  and 'git add DIR/FILE', i.e. not everyone is sure if in the last
  case Git should track DIR or not.

2 If Git will track only explicitly mentioned directories, then what
  about recursive operations?  Will it add only files by default, or
  directories too?  Perhaps there will be some --add-dirs option to
  'git add'.

3 Since in certain recursive operations one will want to affect
  directories too, how .gitignore will look?  Most files have a notion
  of extension, so me may say '*.o', but with directories things a bit
  more complicated.  One would want to say "exclude DIR2 only if under
  DIR1 at any hierarchy depth", i.e. exclude paths matching
  qr%DIR1/(.+/)?DIR1/%, and shell wildcards aren't that expressive,
  '*' doesn't cross hierarchy.  Note that we live without this now,
  but this will be the next "natural" demand once directories become
  first class citizens.


This list is surely incomplete.  The point is that before we go into
technical details, let's consider what exactly we are going to
implement, how this will affect current usage model, how (empty)
directory handling will extend to future similar demands, etc.  My
fear is that once some patch is around, it's very tempting to accept
it.  And once it is in, it's almost impossible to remove the feature
later.


Regards,

-- 
   Tomash Brechko
