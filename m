From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Remove branch by putting a null sha1 into the ref file.
Date: Sat, 23 Sep 2006 13:22:30 +0200
Message-ID: <200609231322.30214.chriscool@tuxfamily.org>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org> <200609230645.37773.chriscool@tuxfamily.org> <7vu02zuhya.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 13:16:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR5Uc-0008R3-GB
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 13:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWIWLQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 07:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWIWLQT
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 07:16:19 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:50560 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750881AbWIWLQS (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 07:16:18 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with ESMTP id D382075C12;
	Sat, 23 Sep 2006 13:16:16 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.4
In-Reply-To: <7vu02zuhya.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27581>

Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > If we move ".git/refs/heads/frotz/nitfol"
> > to ".git/deleted-refs/heads/frotz/nitfol" when we remove this ref, we
> > only need to try to rmdir all subdirectories under
> > ".git/refs/heads/frotz/" and then ".git/refs/heads/frotz/" to see if we
> > can
> > create ".git/refs/heads/frotz", and if we can, we won't
> > resurect "frotz/nitfol" because ".git/deleted-refs/heads/frotz/nitfol"
> > still exists.
>
> I am not sure if that would be workable.  I suspect that you
> would need to do quite an involved sequence in "git branch" to
> make this sequence to work with .git/deleted-refs/ scheme:
>
> 	git branch frotz/nitfol
>         git pack-refs --prune
>         git branch -d frotz/nitfol
>         git branch frotz
>         git pack-refs
>         git branch -d frotz
>
> After deleting frotz/nitfol you would create frotz/nitfol in
> deleted hierarchy.  Then when you delete frotz you would need to
> create frotz in deleted hierarchy, but you cannot, without
> losing frotz/nitfol.

You are right, so what about moving ".git/refs/heads/frotz" 
to ".git/deleted-refs/heads/frotz.ref" 
or ".git/deleted-refs/heads/frotz~ref" (because "~" is forbidden in ref 
names).

Christian. 
