From: Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com>
Subject: Re: [RFC PATCH 0/2] Add support for multi threaded checkout
Date: Thu, 18 Dec 2008 22:16:57 +0100
Message-ID: <494ABDC9.9060001@morey-chaisemartin.com>
References: <3BA20DF9B35F384F8B7395B001EC3FB3265B2A01@azsmsx507.amr.corp.intel.com>
Reply-To: devel@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Pickens, James E" <james.e.pickens@intel.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 22:18:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDQGM-0001ak-8T
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 22:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbYLRVRI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Dec 2008 16:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbYLRVRH
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 16:17:07 -0500
Received: from 29.mail-out.ovh.net ([87.98.216.213]:37734 "HELO
	29.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753837AbYLRVRF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 16:17:05 -0500
Received: (qmail 10850 invoked by uid 503); 18 Dec 2008 21:17:30 -0000
Received: from unknown (HELO mail422.ha.ovh.net) (213.186.33.59)
  by 29.mail-out.ovh.net with SMTP; 18 Dec 2008 21:17:30 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 18 Dec 2008 21:17:02 -0000
Received: from agrenoble-152-1-22-165.w82-122.abo.wanadoo.fr (HELO ?192.168.10.200?) (devel@morey-chaisemartin.com@82.122.21.165)
  by ns0.ovh.net with SMTP; 18 Dec 2008 21:17:02 -0000
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <3BA20DF9B35F384F8B7395B001EC3FB3265B2A01@azsmsx507.amr.corp.intel.com>
X-Enigmail-Version: 0.95.7
X-Ovh-Tracer-Id: 13676587645171781320
X-Ovh-Remote: 82.122.21.165 (agrenoble-152-1-22-165.w82-122.abo.wanadoo.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103494>

Pickens, James E a =E9crit :
> Even in that case it will have *some* impact
> from locking/unlocking the mutex, but I think it would be in the nois=
e.
>
> James
> -
I guess you could do something like :

#define checkout_lock()		core_threaded_checkout ?pthread_mutex_lock(&ch=
eckout_mutex) : (void) 0
#define checkout_unlock()		core_threaded_checkout ?pthread_mutex_unlock=
(&checkout_mutex) : (void) 0

It should be faster when you don't actually use threaded checkouts, as =
you won't unnecessarily lock/unlock your mutex.=20

Have you looked at the perf from local to local? I'm just curious.

Nicolas Morey-Chaisemartin
