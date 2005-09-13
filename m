From: Junio C Hamano <junkio@cox.net>
Subject: Re: dumb transports not being welcomed..
Date: Tue, 13 Sep 2005 15:29:07 -0700
Message-ID: <7v7jdkwqj0.fsf@assigned-by-dhcp.cox.net>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net>
	<20050913211444.GA27029@mars.ravnborg.org>
	<7vacig1wrb.fsf@assigned-by-dhcp.cox.net>
	<7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net> <432750E1.3020508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 00:38:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFJHL-0006Nr-NF
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 00:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbVIMW3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 18:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVIMW3K
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 18:29:10 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:15030 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932490AbVIMW3J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 18:29:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050913222907.YIPP9510.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Sep 2005 18:29:07 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <432750E1.3020508@pobox.com> (Jeff Garzik's message of "Tue, 13
	Sep 2005 18:21:21 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8500>

Jeff Garzik <jgarzik@pobox.com> writes:

> Junio C Hamano wrote:
>> The file $GIT_DIR/info/refs was introduced to solve this by
>> listing the available refs for discovery, and hooks/post-update,
>> when enabled, runs update-server-info to update the file (among
>> other things) whenever you push into the repository.
>
> This is helpful.  I'll run git-update-server-info before each push, now.

Just to make sure I am not misunderstanding you, is your "publish"
workflow like this?

    - do your work on your private machine
    - git-update-server-info in your private repository
    - rsync that out to master.kernel.org

If so, then "before each push" makes sense.  

I know you understand the following but this is for other people
on the list.

The hooks/post-update I was talking about assumes a different
"publish" workflow:

    - do your work on your private machine
    - git push master.kernel.org:/pub/scm/...

and you have hooks/post-update enabled in the repository on
master.kernel.org; the counterpart program for 'git push' which
runs on master.kernel.org updates the info/refs and objects/info/packs
file over there once your push is done.
