From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add git-archive [take #2]
Date: Fri, 08 Sep 2006 14:42:06 -0700
Message-ID: <7vslj2f32p.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>
	<7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>
	<44FED12E.7010409@innova-card.com>
	<7vac5c7jty.fsf@assigned-by-dhcp.cox.net>
	<cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com>
	<7v1wqo400b.fsf@assigned-by-dhcp.cox.net>
	<44FFD00E.5040305@innova-card.com>
	<7vr6yo2isu.fsf@assigned-by-dhcp.cox.net>
	<450019C3.4030001@innova-card.com>
	<7v8xkvqjlq.fsf@assigned-by-dhcp.cox.net>
	<4501D0B8.8060103@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 23:41:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLo6d-0000Bi-T9
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 23:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWIHVlm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 17:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWIHVlm
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 17:41:42 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:4259 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751192AbWIHVll (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 17:41:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060908214140.NJRW13992.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Sep 2006 17:41:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Kxhh1V00b1kojtg0000000
	Fri, 08 Sep 2006 17:41:42 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26716>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
>> Franck Bui-Huu <vagabon.xyz@gmail.com> writes:
>> 
>>> 1/ Allow 'git-upload-archive' command to enable/disable some 
>>> formats. This should be done by 'git-upload-archive'.
>> 
>> Perhaps.  I was thinking about the way how a site administrator can 
>> configure such when upload-archive is spawned via git-daemon (for 
>> users coming from ssh and spawn an upload-archive on their own, it's 
>> their own process and upload-archive has no business deciding what is
>>  allowed and what is forbidden).  Not very many clean ways I can
>> think of unfortunately.
>
> Mmpf, ssh is (one of the things) in my blind spot.  Do you mean a
> ssh+git-shell connection?  One could argue that since this is a
> restricted connection anyway upload-archive _has_ a right to restrict
> archive format etc., too.  On a full, unrestricted ssh connection one
> can start git-archive directly.  I'd do that anyway because I'm used to
> do this with tar. ;-)

Ah, I was not thinking about git-shell and it might want to be
restrictive.

> ... Mmh, maybe an environment variable
> which is set by the daemon can be used?  This is no dirtier than what
> webservers do..

Exactly my thought, except "no dirtier" part I did not think
through but now you said it I tend to agree.

So site administrator can ask git-daemon to export some
environment variable that git-upload-archive notices and
restrict service.  If we choose to we can add a similar facility
to set the same environment variable to git-shell, so services
to retricted ssh users can be limited the same way by the
administrator.  That sounds like a good plan; we do not have
to do that for git-shell until somebody asks.
