From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-unpack-objects
Date: Mon, 01 May 2006 16:09:22 -0700
Message-ID: <7vu089qr4t.fsf@assigned-by-dhcp.cox.net>
References: <625fc13d0605011552j4189338bx14083657acffc18e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 02 01:09:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FahWL-0006H8-Me
	for gcvg-git@gmane.org; Tue, 02 May 2006 01:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWEAXJZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 19:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWEAXJZ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 19:09:25 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39420 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932310AbWEAXJY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 May 2006 19:09:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060501230924.JJOG17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 1 May 2006 19:09:24 -0400
To: git@vger.kernel.org
In-Reply-To: <625fc13d0605011552j4189338bx14083657acffc18e@mail.gmail.com>
	(Josh Boyer's message of "Mon, 1 May 2006 17:52:44 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19393>

"Josh Boyer" <jwboyer@gmail.com> writes:

> I was playing around with git repack and decided to "undo" the repack
> I did using git-unpack objects.  Below is the output:
>
> [jwboyer@vader linux-2.6]$ git-unpack-objects <
> .git/objects/pack/pack-497d1e639572013de48eeb00cb95738d2ca959e1.pack
> Unpacking 236950 objects
> 100% (236950/236950) done
> [jwboyer@vader linux-2.6]$ ls -l .git/objects/
> total 8
> drwxrwxr-x 2 jwboyer jwboyer 4096 May  1 17:48 info
> drwxrwxr-x 2 jwboyer jwboyer 4096 May  1 17:48 pack
> [jwboyer@vader linux-2.6]$
>
> As you can see, the objects don't seem to get unpacked back into the
> .git directory.  So either I am misunderstanding what that command is
> supposed to do, or it isn't working properly.
>
> Any ideas?

unpack tries to unpack and if it already has the object it
skips.

If you really wanted to do it, here is a way to do so.

	mv .git/objets/pack/pack-49*.pack \
		.git/objets/pack/pack-49*.idx .
	git unpack-objects <pack-49*.pack
