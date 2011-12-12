From: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Mon, 12 Dec 2011 16:34:05 +0100
Message-ID: <4EE61EED.50604@ursus.ath.cx>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org> <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org> <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Leif Gruenwoldt <leifer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 16:45:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra83z-0003hs-1y
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 16:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175Ab1LLPpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 10:45:06 -0500
Received: from brln-4d0cbd2c.pool.mediaWays.net ([77.12.189.44]:10069 "EHLO
	here" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750952Ab1LLPpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 10:45:05 -0500
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Dec 2011 10:45:05 EST
Received: from [192.168.0.14] (unknown [192.168.0.14])
	by here (Postfix) with ESMTP id 3DF8E1A1C56;
	Mon, 12 Dec 2011 16:35:02 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20111110 Icedove/3.0.11
In-Reply-To: <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186914>



On 10.12.2011 16:27 Leif Gruenwoldt wrote:
>  On Sat, Dec 10, 2011 at 1:30 AM, Junio C Hamano <gitster@pobox.com>
>  wrote:
>
> > So that use case does not sound like a good rationale to require
> > addition of floating submodules.
>
>  Ok I will try another scenario :)
>
>  Imagine again products A, B and C and a common library. The products
>   are in a stable state of development and track a stable branch of
>  the common lib. Then imagine an important security fix gets made to
>  the common library. On the next pull of products A, B, and C they get
>  this fix for free because they were floating. They didn't need to
>  communicate with the maintainer of the common repo to know this. In
>  fact they don't really care. They just want the latest stable code
>  for that release branch.

So you don't want to have a stale submodule as Junio suggested, which is 
older than the gitlinked commit in the superproject, but you want to 
have the newest stable version, which is not yet gitlinked in the 
superproject, right?

Wouldn't  ( cd commonlib ; git pull stable ) instead of
git submodule update commonlib
work as you want?

To be able to configure this update behavior in .gitmodules for _some_ 
submodules, could be helpful in this case.

So you don't want to add a new commit to the products A, B and C repos 
whenever the stable branch of the submodule changes, but on the other 
hand when you commit changes to the products it would still make sense 
to update the gitlink to the current commonlib version together with 
your changes,  too, right?


>  This is how package management on many linux systems works.
>  Dependencies get updated and all products reap the benefit (or
>  catastrophe) automatically.
If I have e.g. the Debian testing distro, which is more floating than 
the most other Linux distro releases, then I still get only those 
versions of the packages that are referenced by this "Debian testing" 
superproject, unless I specify a different superproject (e.g. "Debian 
unstable") to get a newer version, but they are still tracked in some 
superproject. I'm not aware of a way to get the newest version of a 
package before it is in some "superproject", except downloading it 
explictily somewhere else. But I don't think this is what you want.
