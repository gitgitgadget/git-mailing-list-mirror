From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH v4] Add git-grep threads param
Date: Mon, 9 Nov 2015 03:36:16 -0800
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA15@mail.accesssoftek.com>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
 <xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>,<20151104064021.GB16605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"john@keeping.me.uk" <john@keeping.me.uk>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 12:36:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvkkJ-0006hn-DE
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 12:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbbKILgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 06:36:19 -0500
Received: from mail.accesssoftek.com ([12.202.173.171]:12447 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbbKILgS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2015 06:36:18 -0500
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Mon, 9 Nov 2015 03:36:17 -0800
Thread-Topic: [PATCH v4] Add git-grep threads param
Thread-Index: AdEWzVX8bis3L0SoQfyxe42LfQy0cQEAG1lC
In-Reply-To: <20151104064021.GB16605@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281048>


________________________________________
From: Jeff King [peff@peff.net]
Sent: Tuesday, November 03, 2015 22:40
To: Junio C Hamano
Cc: Victor Leschuk; git@vger.kernel.org; Victor Leschuk; torvalds@linux-foundation.org; john@keeping.me.uk
Subject: Re: [PATCH v4] Add git-grep threads param

On Tue, Nov 03, 2015 at 09:22:09AM -0800, Junio C Hamano wrote:

> > +grep.threads::
> > +   Number of grep worker threads, use it to tune up performance on
> > +   multicore machines. Default value is 8. Set to 0 to disable threading.
> > +
>
> I am not enthused by this "Set to 0 to disable".  As Zero is
> magical, it would be more useful if 1 meant that threading is not
> used (i.e. there is only 1 worker), and 0 meant that we would
> automatically pick some reasonable parallelism for you (and we
> promise that the our choice would not be outrageously wrong), or
> something like that.

> Not just useful, but consistent with other parts of git, like
> pack.threads, where "0" already means "autodetect".

Hello Peff and Junio,

Yeah do also think it would be more reasonable to use "0" for "autodetect" default value. However chat this autodetect value should be?

For index index-pack and pack-objects we use ncpus() for this, however according to my tests this wouldn't an Ideal for all cases. Maybe it should be something like ncpus()*2, 
anyway before it we even used hard-coded 8 for all systems...

In this case we use "1" as "Do not use threads" and die on all negative numbers during parsing.

Agreed?
