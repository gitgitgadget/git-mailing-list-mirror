From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/12] Towards a better merge resolution support
Date: Mon, 01 Sep 2008 03:38:25 -0700
Message-ID: <7vod38w3q6.fsf@gitster.siamese.dyndns.org>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com>
 <20080901094412.GB3993@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 12:40:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka6pQ-0008Iu-R3
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 12:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbYIAKin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 06:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbYIAKin
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 06:38:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbYIAKim (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 06:38:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 49EE35BF5D;
	Mon,  1 Sep 2008 06:38:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BC3C65BF5C; Mon,  1 Sep 2008 06:38:37 -0400 (EDT)
In-Reply-To: <20080901094412.GB3993@blimp.local> (Alex Riesen's message of
 "Mon, 1 Sep 2008 11:44:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2430CD88-7812-11DD-8BB1-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94568>

Alex Riesen <raa.lkml@gmail.com> writes:

> ... IOW, copy the commit
> resolution from some other merge commit. Maybe can be a way to use
> rerere mechanism with that?

If you know which merge I did you want to steal from, you can prime your
rerere database by pretending to be me, doing the merge.  Something like:

	$ git checkout $merge^1 ;# detach to the parent of merge
        $ git merge $merge^2 ;# pretend you were me to redo it
        $ git diff -R $merge | git apply --index ;# and get what I did
	$ git rerere ;# have rerere record the resolution
