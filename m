From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Really fix git-merge-one-file-script this time.
Date: Sun, 01 May 2005 14:18:13 -0700
Message-ID: <7vsm16sl0q.fsf@assigned-by-dhcp.cox.net>
References: <7vd5sbz436.fsf@assigned-by-dhcp.cox.net>
	<7vzmveu6zs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505011312080.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 23:12:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSLjo-0006BT-OM
	for gcvg-git@gmane.org; Sun, 01 May 2005 23:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVEAVSW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 17:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVEAVSW
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 17:18:22 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:50562 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262676AbVEAVSR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 17:18:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501211815.HGHZ20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 17:18:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505011312080.2296@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 1 May 2005 13:29:59 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

>> Linus, have you decided to like or dislike the behaviour of
>> git-merge-one-file-script touching the work tree in some cases
>> but not in other cases?

LT> I don't care about the _successful_ merge, since a successful merge is 
LT> basically always followed by a "git-checkout-cache -f -a" anyway (and 
LT> update-cache + remove now-stale files etc).

Let me make sure I understand you correctly before I go
further.  In the above sentence, do you mean a merge that is
_successful_ by merges that:

    (1) "git-remove-tree -m" considers them trivial;

or
    (2) in addition to (1), "git-merge-one-file-script"
        considers them trivial.  That is, only one-side changes
        or removes or adds it, or both sides adds it
        identically, or merge/diff3 merges without conflict.

Which one?

LT> Sounds sane.

LT> On the other hand, I think it would actually be easier to just make your 
LT> "magic SHA1" be just another "stage".

I am undecided on this one but having worked on the diff side, I
think the magic SHA1 of 0{40} would match better with what diff
needs to do.  It would mean "cache is stale, look in the work
tree" to them.

