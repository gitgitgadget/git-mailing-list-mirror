From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/5] Add --remote option to send-pack
Date: Wed, 02 May 2007 22:35:30 -0700
Message-ID: <7virba31wd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704281304360.28708@iabervon.org>
	<7vtzuzg26l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704290152410.28708@iabervon.org>
	<7vejm3g0dg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705022330460.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 03 07:35:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjTyZ-0002XL-Ot
	for gcvg-git@gmane.org; Thu, 03 May 2007 07:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767394AbXECFfc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 01:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767395AbXECFfc
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 01:35:32 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60749 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767394AbXECFfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 01:35:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070503053530.XTPI24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 3 May 2007 01:35:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id uVbW1W0091kojtg0000000; Thu, 03 May 2007 01:35:30 -0400
In-Reply-To: <Pine.LNX.4.64.0705022330460.28708@iabervon.org> (Daniel
	Barkalow's message of "Thu, 3 May 2007 00:04:41 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46065>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sat, 28 Apr 2007, Junio C Hamano wrote:
>
>> We are indeed pretending.  Consider:
>> 
>>  (1) You push, and push succeeds.
>> 
>>  (2) Somebody fetches your result, works on it and pushes back;
>>      this might happen in post-receive hook.
>> 
>>  (3) You fetch.  You should see somebody else's commit at the
>>      tip, not what you pushed in (1).
>> 
>> By not fetching but instead of storing what you pushed, you are
>> pretending that you re-fetched so fast that you gave no chance
>> to anybody to perform (2) quickly enough.
>
> But you did effectively re-fetch instantaneously by doing an operation 
> that atomicly updates the ref and reports success.

I do not think there is much point arguing over this; I am not
fundamentally opposed to keeping a copy of what we just pushed
to the other side.

But I think it needs to be documented that hooks on the remote
side could do funny things, and probably we should strongly
discourage people from doing such.

You do need to take care of the case where we are _not_ tracking
the remote side, though (i.e. lack of colon in the fetch
refspecs).
