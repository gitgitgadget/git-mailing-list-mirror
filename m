From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Convert open("-|") to qx{} calls
Date: 23 Feb 2006 10:42:49 -0800
Message-ID: <863bi9hq6u.fsf@blue.stonehenge.com>
References: <Pine.LNX.4.63.0602231532470.29635@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0602230738s3445bd86h2d1d670e0ef5daed@mail.gmail.com>
	<86hd6qgit5.fsf@blue.stonehenge.com>
	<7v1wxuhsgw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 19:43:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCLQZ-0003mF-De
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 19:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWBWSm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 13:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWBWSm4
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 13:42:56 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:39546 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750938AbWBWSmz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 13:42:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id DEEEF8F320;
	Thu, 23 Feb 2006 10:42:50 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 32085-01-19; Thu, 23 Feb 2006 10:42:49 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id C9F208F32A; Thu, 23 Feb 2006 10:42:49 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.1.7; tzolkin = 7 Manik; haab = 5 Kayab
In-Reply-To: <7v1wxuhsgw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16656>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> The version of Perl Alex has to use claims to be 5.8, but does
Junio> not understand open($kid, '-|'), and he is trying to come up
Junio> with a workaround.

Ahh, the problem is activestate then.  If that's the case, then amend the code
with a check for $^O (operating system) that falls back to a qx if on
activestate, and hope that filenames aren't a problem.  Unfortunately, I don't
know enough about that to fix it.

But whatever you do, *don't* replace safe_qx with qx() for all other systems,
or you'll be opening up a can of worms for those of us on sensible systems.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
