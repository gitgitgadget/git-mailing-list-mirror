From: Junio C Hamano <junkio@cox.net>
Subject: Re: pack v4 status
Date: Tue, 27 Feb 2007 14:36:05 -0800
Message-ID: <7vwt23b54a.fsf@assigned-by-dhcp.cox.net>
References: <20070227155042.GB3230@spearce.org>
	<Pine.LNX.4.64.0702271348260.12485@woody.linux-foundation.org>
	<alpine.LRH.0.82.0702271717080.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 27 23:36:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMAvb-0000aX-2v
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 23:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbXB0WgI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 17:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbXB0WgI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 17:36:08 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:62967 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbXB0WgH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 17:36:07 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227223607.OSOJ2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 17:36:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Umc61W00A1kojtg0000000; Tue, 27 Feb 2007 17:36:06 -0500
In-Reply-To: <alpine.LRH.0.82.0702271717080.29426@xanadu.home> (Nicolas
	Pitre's message of "Tue, 27 Feb 2007 17:32:00 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40829>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 27 Feb 2007, Linus Torvalds wrote:
>
>> On Tue, 27 Feb 2007, Shawn O. Pearce wrote:
>> >  ...
>> > All trees are then converted to use a 22 byte record format:
>> > 
>> >   - 2 byte network byte order index into the string pool
>> >   - 20 byte SHA-1
>> 
>> Umm. Am I missing something, or is this totally braindamaged?
>> 
>> Are you really expecting there to never be more than 64k basenames? Trust 
>> me, that's a totally broken assumption. Anything that tracks generated 
>> stuff will _easily_ have several tens of thousands of random filenames 
>> even in a single tree, much less over the whole history of the repository.
>
> The idea is to deal with only tree objects containing the 64K most 
> frequently used base names and fall back to the current tree object 
> encoding for objects that couldn't be represented that way.

Ah, I was wondering the same thing as Linus after seeing shawn
talked about the 2-byte prefix on #git. Falling back to an
alternate encoding for rarer cases makes sense.
