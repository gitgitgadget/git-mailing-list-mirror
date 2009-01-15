From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: how to apply patch in the middle
Date: Wed, 14 Jan 2009 17:39:13 -0800
Message-ID: <20090115013913.GC10179@spearce.org>
References: <20090115013535.GB6937@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 02:40:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNHDp-0005dd-4H
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 02:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbZAOBjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 20:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbZAOBjO
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 20:39:14 -0500
Received: from george.spearce.org ([209.20.77.23]:34471 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbZAOBjN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 20:39:13 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 37C4838210; Thu, 15 Jan 2009 01:39:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090115013535.GB6937@b2j>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105755>

bill lam <cbill.lam@gmail.com> wrote:
> I want to change history to rewrite
> 
>   - A - B - C - D - E - ..
>  
> as
> 
>  - A - C' - D - E - ..

Uh, "git rebase -i A", change "pick" on line "C" to "squash".
This should have the same impact as what you are trying.

> because rebase/squash cannot automatically resolve conflicts, I
> generate a patch file from A to C
> 
>   git diff A C >pat
> 
> However I don't know how apply this patch and cancel the old B and C.

One way you can insert this is:

  git rebase -i A^
  change "pick" on line "A" to "edit"
  delete lines "B" and "C".

  when it stops for amend, don't amend.
  git apply --index pat
  git commit -m "my new B and C"
  git rebase --continue

-- 
Shawn.
