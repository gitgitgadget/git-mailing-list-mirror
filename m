From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to replace a single corrupt, packed object?
Date: Fri, 8 Aug 2008 09:36:28 -0700
Message-ID: <20080808163628.GF9152@spearce.org>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <0BF03F86-8E4E-46D2-9B04-4385CEBD6902@ai.rug.nl> <20080808161937.GC9152@spearce.org> <90E12BC7-1950-41DF-8BE5-C6B63CE060D9@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, nico@cam.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:37:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRUyC-0008My-6p
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 18:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757884AbYHHQgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 12:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758047AbYHHQga
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 12:36:30 -0400
Received: from george.spearce.org ([209.20.77.23]:33471 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757984AbYHHQg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 12:36:29 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 619F838420; Fri,  8 Aug 2008 16:36:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <90E12BC7-1950-41DF-8BE5-C6B63CE060D9@ai.rug.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91691>

Pieter de Bie <pdebie@ai.rug.nl> wrote:
> On 8 aug 2008, at 18:19, Shawn O. Pearce wrote:
>
>> The unpack-objects process will
>> fail when it finds this bad object, and everything after that in
>> the pack file will be dropped on the floor and not get unpacked.
>
> Even with the -r switch?
>
>        -r     When unpacking a corrupt packfile, the command dies at the 
> first corruption. This flag tells it to keep going and make
>               the best effort to recover as many objects as possible.

Oh, thanks for reminding me.  I had forgotten that Linus added -r
when someone else had corruption in a packed object.  Yea, if you
use -r it may be able to resume and pick up where it left off.

I haven't studied the -r code so I'm not sure how it knows where
its safe to restart unpacking from.  But if you have a .idx file
we probably could make a really good guess based on the offsets
it stores.  I doubt unpack-objects makes use of the .idx.

-- 
Shawn.
