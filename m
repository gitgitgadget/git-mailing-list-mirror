From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH v4] Add git-grep threads param
Date: Mon, 9 Nov 2015 13:51:48 -0800
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA1B@mail.accesssoftek.com>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
	<xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>
	<20151104064021.GB16605@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA15@mail.accesssoftek.com>
	<20151109155538.GC27224@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA17@mail.accesssoftek.com>
	<20151109165343.GA29179@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA18@mail.accesssoftek.com>
	<CA+55aFzHic5AN05QkbERFszRC=i3aDDGy9yhXEjgzZjwzFVBLQ@mail.gmail.com>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA19@mail.accesssoftek.com>
	<CA+55aFwV7c6=4mXPuB0c21rK3TSVWEw9JT-kiu35RuMzuHxoVg@mail.gmail.com>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA1A@mail.accesssoftek.com>,<CA+55aFyhBN5fEpB-CLQFhhDyf7nijs_Y3aZCSQAcpVPmruZLFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Victor Leschuk <vleschuk@gmail.com>, Jeff King <peff@peff.net>,
	"john@keeping.me.uk" <john@keeping.me.uk>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Nov 09 22:52:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvuLy-00008M-Gl
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 22:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbbKIVvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 16:51:50 -0500
Received: from mail.accesssoftek.com ([12.202.173.171]:51302 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbbKIVvt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 16:51:49 -0500
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Mon, 9 Nov 2015 13:51:48 -0800
Thread-Topic: [PATCH v4] Add git-grep threads param
Thread-Index: AdEbK+KMcIkJNCgMR223cwvKLxmVwAAC/YlK
In-Reply-To: <CA+55aFyhBN5fEpB-CLQFhhDyf7nijs_Y3aZCSQAcpVPmruZLFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281085>


Correct.

I think adding the option (both to command line and to config file) is good, as long as the IO issues are documented. And default to just the fixed number of threads for now - and with the option, maybe people can then more easily try out different scenarios and maybe improve on the particular choice of fixed number of threads.

> Or maybe the default should be something that isn't even described by any particular fixed number.

> For example, maybe the default that value could be something quite dynamic: start off with a single thread (or a very low thread number) and just set a timer. After 0.1s, if CPU usage is low, start more threads. After another 0.1s, if that improved things, maybe > we could add still more threads...

> Note that "CPU usage is low" can be hard to get portably, but we could approximate it with "how much work did we actually get done". If we only grepped a couple of files, that might be because of IO issues. And if speed does not improve when we move from a 
> single thread to, say, four threads, then we should probably *not* increase the thread number again at 0.2s.

> So I think there are many possible avenues to explore that might be interesting. I do *not* think that "online_cpus()" is one of them, > except perhaps as a very rough measure of "is this a beefy system or not" (but even that is questionable - 32 CPUs is definitely 
> likely "very beefy, so use lots of threads", but even 8 CPUs might still be just a phone, and I'm not sure that tells you a lot, really.
    Linus

Here is my version of note for Documentaion:

        Number of grep worker threads, use it to tune up performance on
        your machines. Leave it unset or set to "0" if you want to use default number
        (currently default number is 8 for all systems, however this behavior can
         be changed in future versions to better suite your hardware and circumstances).


--
Victor
