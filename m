From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 2/6] Don't try to merge files that merge-recursive already merged
Date: Wed, 22 Aug 2007 11:21:52 +0200
Message-ID: <20070822092152.GB30748@diana.vm.bytemark.co.uk>
References: <11875975232619-git-send-email-davidk@lysator.liu.se> <1187597523433-git-send-email-davidk@lysator.liu.se> <11875975232734-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Aug 22 11:22:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INmPa-00055A-19
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 11:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbXHVJV5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 05:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbXHVJV5
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 05:21:57 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4508 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbXHVJV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 05:21:56 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1INmPQ-000864-00; Wed, 22 Aug 2007 10:21:52 +0100
Content-Disposition: inline
In-Reply-To: <11875975232734-git-send-email-davidk@lysator.liu.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56359>

On 2007-08-20 10:11:59 +0200, David K=E5gedal wrote:

> This avoid duplicating work, but also changes the resulting index
> state so that the conflicts are left in the index in the three
> stages.

After this patch, t1400-patch-history fails:

*   ok 1: Initialize the StGIT repository
*   ok 2: Create the first patch
*   ok 3: Create the second patch
*   ok 4: Check the "new" and "refresh" logs
*   ok 5: Check the log annotation
*   ok 6: Check the "push" log
*   ok 7: Check the "push(f)" log
*   ok 8: Check the "push(m)" log
* FAIL 9: Check the "push(c)" log

                echo bar > test && stg refresh &&
                stg pop &&
                echo foo > test && stg refresh &&
                ! stg push &&
                stg log --full | grep -q -e "^push(c) "

*   ok 10: Check the push "undo" log
*   ok 11: Check the refresh "undo" log
* failed 1 among 11 test(s)

I'll see if I can figure out what's wrong.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
