From: John Keeping <john@keeping.me.uk>
Subject: Re: git pull & git gc
Date: Wed, 18 Mar 2015 14:58:15 +0000
Message-ID: <20150318145815.GN1369@serenity.lan>
References: <5509836D.2020304@aegee.org>
 <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org>
 <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
 <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 16:04:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYFVw-0005Th-OR
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 16:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839AbbCRPED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 11:04:03 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:56965 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755826AbbCRPEC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 11:04:02 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2015 11:04:02 EDT
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id B5F67CDA697;
	Wed, 18 Mar 2015 14:58:26 +0000 (GMT)
X-Quarantine-ID: <0hHgfWLfRI0v>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0hHgfWLfRI0v; Wed, 18 Mar 2015 14:58:25 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 13541866042;
	Wed, 18 Mar 2015 14:58:17 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265736>

On Wed, Mar 18, 2015 at 09:41:59PM +0700, Duy Nguyen wrote:
> On Wed, Mar 18, 2015 at 9:33 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > If not, I made some mistake in analyzing this and we'll start again.
> 
> I did make one mistake, the first "gc" should have reduced the number
> of loose objects to zero. Why didn't it.?  I'll come back to this
> tomorrow if nobody finds out first :)

Most likely they are not referenced by anything but are younger than 2
weeks.

I saw a similar issue with automatic gc triggering after every operation
when I did something equivalent to:

	git add <lots of files>
	git commit
	git reset --hard HEAD^

which creates a log of unreachable objects which are not old enough to
be pruned.
