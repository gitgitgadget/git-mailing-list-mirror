From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack operation is thrashing my server
Date: Mon, 11 Aug 2008 08:59:59 -0700
Message-ID: <20080811155959.GG26363@spearce.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <20080811150150.GC26363@spearce.org> <32541b130808110840p1287426fpeef967a9ff4fb094@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ken Pratt <ken@kenpratt.net>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 18:01:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSZpS-0002Fr-Uf
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 18:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbYHKQAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 12:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbYHKQAB
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 12:00:01 -0400
Received: from george.spearce.org ([209.20.77.23]:47745 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbYHKQAA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 12:00:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8E5A338375; Mon, 11 Aug 2008 15:59:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <32541b130808110840p1287426fpeef967a9ff4fb094@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91955>

Avery Pennarun <apenwarr@gmail.com> wrote:
> On Mon, Aug 11, 2008 at 11:01 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > On the up side, packing should only be consuming huge memory like
> > this when it needs to move loose objects into a pack file.  I think
> > Martin Langhoff suggested packing this on your laptop then using
> > rsync over SSH to copy the pack file and .idx file to the server, so
> > the server didn't have to spend time figuring out the deltas itself.
> 
> Do you need to also introduce a ".keep" file to get the benefit from
> this?  I had a repo with some very large objects, and it was killing
> my low-memory server *every* time I did "git gc", until I repacked on
> another system, created the .keep file, and rsynced it back.  Does
> that make sense?

No, the ".keep" file wouldn't have an impact.  Delta reuse (the
feature I was alluding to) works whether or not there is a .keep
file present.

I wonder if your "git gc" was using --aggressive?

-- 
Shawn.
