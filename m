From: Charles Bailey <charles@hashpling.org>
Subject: Re: Random failure after "git config core.autocrlf false" then
	"git reset --hard"
Date: Thu, 14 May 2009 08:49:25 +0100
Message-ID: <20090514074925.GB8713@hashpling.org>
References: <4A0A34E3.9050801@SierraAtlantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Slutz <Don.Slutz@SierraAtlantic.com>
X-From: git-owner@vger.kernel.org Thu May 14 09:49:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Vh6-0003su-Js
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 09:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760152AbZENHt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 03:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758749AbZENHt0
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 03:49:26 -0400
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:51360 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760454AbZENHtZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 03:49:25 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAFNpC0rUnw4U/2dsb2JhbADOKoQCBQ
Received: from pih-relay08.plus.net ([212.159.14.20])
  by relay.ptn-ipout02.plus.net with ESMTP; 14 May 2009 08:49:26 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1M4Vgz-0008MR-Ip; Thu, 14 May 2009 08:49:25 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n4E7nPOi009984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 May 2009 08:49:25 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n4E7nPEE009983;
	Thu, 14 May 2009 08:49:25 +0100
Content-Disposition: inline
In-Reply-To: <4A0A34E3.9050801@SierraAtlantic.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: e079a8880e93530db547677c8b4e1479
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119167>

On Tue, May 12, 2009 at 10:48:03PM -0400, Don Slutz wrote:
> This both works and fails with either file2 & subdir/file3 "modified" or  
> just subdir/file3.  I have found that "git reset --hard" looks to be the  
> issue.  If you have autocrlf=true, and a clean work tree and then set  
> autocrlf=false; then
> "git reset --hard" does not change the work tree files.  However  
> sometimes (which so far I have only been able to reproduce with this  
> test) git diff will report the difference.

It shouldn't be random. git reset --hard should only reset those
working tree files for which the appropriate index entry has been
change or which have been change on disk since checkout from the
index. Changing the core.autocrlf setting doesn't count as in index
change (although perhaps it should??).

The point of git reset --hard in these tests was to throw away any
uncommitted merge resolutions and/or conflicts, not about rechecking
out everything. Admittedly the tests are probably a bit fast and loose
and they should probably force a complete refresh from the index when
the core.autocrlf setting is changed.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
