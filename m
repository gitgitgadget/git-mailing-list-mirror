From: tom fogal <tfogal@sci.utah.edu>
Subject: Re: rebuild repo from data, packfiles?
Date: Sun, 21 Nov 2010 12:51:40 -0700
Message-ID: <auto-000024046785@sci.utah.edu>
References: <auto-000024044659@sci.utah.edu> <20101121001643.GB27666@burratino> <auto-000024045093@sci.utah.edu>  <20101121032707.GA11571@burratino>
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 21 20:53:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKFxk-0002ri-9s
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 20:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490Ab0KUTw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 14:52:27 -0500
Received: from mail.sci.utah.edu ([155.98.58.80]:29878 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752433Ab0KUTw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 14:52:27 -0500
Received: from dummy.name; Sun, 21 Nov 2010 12:52:26 -0700
In-Reply-To: Your message of "Sat, 20 Nov 2010 21:27:07 CST."
             <20101121032707.GA11571@burratino> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161869>

Hi Jonathan,

thanks for all your help thus far.  I saw your other message as well,
which was helpful, but I've nothing to contribute to the group other
than "yeah, that helped!", so I'm not going to reply separately.

Jonathan Nieder <jrnieder@gmail.com> writes:
> Sometimes it is possible to recover some specific object with
> detective work; see howto/recover-corrupted-blob-object.txt in the
> Documentation directory for an example of that.

I've been pouring over this and think I understand my issues now.
Following Linus' log --raw ... pattern, I get [1].  If I were to
represent my commits as a list, they'd be:

  936e5e1 ---- 23ffd9c ---- 48fa24c

My problem is that 23ffd9c is now missing due to my stupidity.

Is there any way I could rewrite my history to be:

  936e5e1 ---- 48fa24c

? I imagine that the sha1's would change and the like; I don't care
much about that.  I'm thinking I could do a rebase -i and squash
23ffd9c into 48fa24c... but I can't rebase -i because my history is
broken.  So I'd like to "virtually" rebase -i -- connect 48fa24c to
936e5e1 and vice versa -- but I don't see any commands to do this.

The reasoning is I've got something like 15 "broken link from tree ...
to blob ..." errors in my fsck.  I attempted to correct these Linus'
way, by looking at the diff between, say 936e5 .. 48fa2 and trying to
guess the intermediate diff... this is going to be doable but *very*
hard, and my full history just isn't worth that kind of time ;)

Apologies for abusing your time with this, but thanks much for the
ideas!

-tom

[1]
commit d5210216537e5a37955d5605a2a688edfa28e5b5
Author: Tom Fogal <tfogal@alumni.unh.edu>
Date:   Thu Oct 28 13:05:31 2010 -0600

    Remove controller dependence from VariantArray.

    Only needed it for a few debug messages, and those weren't
    terribly useful anyway.

:100644 100644 23ffd9c... 48fa24c... M  VariantArray.cpp

commit dfa3d3b53a1f21e056a75e23446ef36f377e55bc
Author: Tom Fogal <tfogal@alumni.unh.edu>
Date:   Fri Oct 8 11:31:11 2010 -0600

    VariantArray: support more data types.

    Also reorganize a bit.  Use the boost, aka std types, and use a
    consistent order of widening bit widths for similar methods.

:100644 100644 936e5e1... 23ffd9c... M  VariantArray.cpp
error: Could not read 21ab2742822b0afc8c6a582cab0ba9da5c32e1d3
fatal: cannot simplify commit 096fd9f8ae47a8d3b3fb09e0ce89c924d72cea40 (because
of 21ab2742822b0afc8c6a582cab0ba9da5c32e1d3)
