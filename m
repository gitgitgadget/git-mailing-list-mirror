From: "George Spelvin" <linux@horizon.com>
Subject: Re: git auto-repack is broken...
Date: 3 Dec 2011 01:55:19 -0500
Message-ID: <20111203065519.22213.qmail@science.horizon.com>
Cc: linux@horizon.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 08:02:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWjbs-0001Sh-RE
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 08:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab1LCHCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Dec 2011 02:02:03 -0500
Received: from science.horizon.com ([71.41.210.146]:58735 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751734Ab1LCHCB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2011 02:02:01 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Dec 2011 02:02:01 EST
Received: (qmail 22214 invoked by uid 1000); 3 Dec 2011 01:55:19 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186251>

Thanks, Jeff, for the life-cycle chart.

A couple of ideas come to mind:
- When unpacking objects from a pack, it should be fine to set their
  date to that of the pack.  After all, they're at least that old.
- We could put unreferenced objects into packs whose date is the most
  recent of any of the contained objects.
- We could then group unreferenced objects into packs based on age,
  so their ages sould not be affected too much by the preceding
  operations.

That still produces a noticeable number of packs, which isn't
good, but maybe it's better that keeping thousands of loose
objects for a month...
