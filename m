From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/5] Add 'df_name_compare()' helper function
Date: Thu, 06 Mar 2008 22:50:22 +0100
Message-ID: <85bq5r34kh.fsf@lola.goethe.zz>
References: <cover.1204777699.git.torvalds@linux-foundation.org>
	<b1cd18fa986c63bea6d0a20ac580b993e5fffaa2.1204777699.git.torvalds@linux-foundation.org>
	<8563w03sxv.fsf@lola.goethe.zz>
	<alpine.LFD.1.00.0803060743180.12253@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 00:06:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXPA8-0001cl-6Z
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 00:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756954AbYCFXFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 18:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756285AbYCFXF3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 18:05:29 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:36452 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756219AbYCFXF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 18:05:29 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.67)
	(envelope-from <dak@gnu.org>)
	id 1JXP9R-0007MC-1U; Thu, 06 Mar 2008 18:05:25 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 58CF71C40B5F; Thu,  6 Mar 2008 22:50:21 +0100 (CET)
In-Reply-To: <alpine.LFD.1.00.0803060743180.12253@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 6 Mar 2008 07:58:48 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76430>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 6 Mar 2008, David Kastrup wrote:
>
>> Consider the case of a merge of
>> 
>> A:
>> blubb
>> blubb.hi
>> 
>> B:
>> blubb.hi
>> blubb/
>> 
>> Any traversal that is done reasonably efficiently will never compare
>> blubb to blubb/ and I don't see how to get around this.
>
> Correct. There _is_ no sort order that will find the conflict in a
> single pass,

[...]

>> Basically, I think you need a special traversal routine.
>
> Yes, we need to handle it in two passes. Which is actually hopefully
> not all that hard, but it is totally impossible (at least for me) with
> the old code that was so hard to follow.

Well, as I said: a single pass is ok when additionally supported by a
FIFO keeping x around until x/ (or its place in the order of things)
passes by.  This will be O(1) with regards to comparisons, and typically
cheap with regard to memory requirements (things get unfriendly if there
are billions of files or even directories obeying the pattern x.*, but
only with regard to memory, not speed).

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
