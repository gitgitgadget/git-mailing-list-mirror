From: Nicolas Pitre <nico@cam.org>
Subject: Re: "failed to read delta base object at..."
Date: Mon, 25 Aug 2008 14:58:05 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808251445090.1624@xanadu.home>
References: <20080825164602.GA2213@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 21:01:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXhIQ-0007bd-0x
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 21:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbYHYS6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 14:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753957AbYHYS6n
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 14:58:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32468 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbYHYS6n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 14:58:43 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K66006267CTQY52@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 25 Aug 2008 14:58:06 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080825164602.GA2213@fieldses.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93655>

On Mon, 25 Aug 2008, J. Bruce Fields wrote:

> Today I got this:
> 
> fatal: failed to read delta base object at 3025976 from
> /home/bfields/local/linux-2.6/.git/objects/pack/pack-f7261d96cf1161b1b0a1593f673a67d0f2469e9b.pack
> 
> This has happened once before recently, I believe with a pack that had
> just been created on a recent fetch.  (If I remember correctly, this was
> soon after a failed suspend/resume cycle that might have interrupted an
> in-progress fetch; could that possible explain the error?)  In that case
> I reset origin/master, deleted a tag or two, and fetched, and the
> problem seemed to be fixed.

The above error is indicative of a corrupted pack on disk.  To confirm 
it you could use 'git verify-pack' with the given pack file.

With a sufficiently recent git, you only need to copy over another pack 
containing the corrupted object, or the object itself in loose form, 
into your object store to "fix" it.

As to the source of disk corruptions... that's up to you to find the 
cause amongst many (including a failed suspend).


Nicolas
