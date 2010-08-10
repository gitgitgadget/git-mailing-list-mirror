From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Git server eats all memory
Date: Tue, 10 Aug 2010 00:46:36 +0000
Message-ID: <robbat2-20100810T004153-279468425Z@orbis-terrarum.net>
References: <wesfwyupgrg.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 10 02:53:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oid5o-00075I-S0
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 02:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab0HJAxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 20:53:21 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:48065 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751845Ab0HJAxT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 20:53:19 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Aug 2010 20:53:19 EDT
Received: (qmail 9368 invoked from network); 10 Aug 2010 00:46:38 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (CAMELLIA256-SHA encrypted) ESMTPS; Tue, 10 Aug 2010 00:46:38 +0000
Received: (qmail 2894 invoked by uid 10000); 10 Aug 2010 00:46:36 -0000
Content-Disposition: inline
In-Reply-To: <wesfwyupgrg.fsf@kanis.fr>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153069>

On Wed, Aug 04, 2010 at 04:57:39PM +0200,  Ivan Kanis wrote:
> I am wondering if anyone has seen this behavior? I'll do whatever I can
> to troubleshoot the problem. I know C but I just don't know where to
> look at. Any help would be very much appreciated.
We've seen a similar problem in experimental planning for migrating the
core Gentoo repository to Git. That's a 900MiB packfile ('git repack
-adf --window=250 --depth=250' taking 2 hours).

Multiple concurrent full clones push the server into swap. We had 16GiB
of RAM, and this was still occurring.

Our temporary solution plan is via hooks, if you're asking for a item
before a certain point, throw an error telling you to download a
git-bundle from a given URL instead (as a bonus you can resume that
trivially).

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
