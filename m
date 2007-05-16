From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add an option to git-ls-tree to display also the size of object
Date: Tue, 15 May 2007 17:37:35 -0700
Message-ID: <7vps51hacw.fsf@assigned-by-dhcp.cox.net>
References: <11792246701367-git-send-email-jnareb@gmail.com>
	<7vy7jpj4lr.fsf@assigned-by-dhcp.cox.net>
	<200705160119.10802.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 02:37:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho7WP-0004wv-U9
	for gcvg-git@gmane.org; Wed, 16 May 2007 02:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759135AbXEPAhh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 20:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759010AbXEPAhh
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 20:37:37 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57378 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbXEPAhg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 20:37:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516003736.BVFR22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 15 May 2007 20:37:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zcdb1W00F1kojtg0000000; Tue, 15 May 2007 20:37:35 -0400
In-Reply-To: <200705160119.10802.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 16 May 2007 01:19:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47397>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> > Add -l/--long/--size option to git-ls-tree command, which displays
>> > object size of an entry after object id (left-justified with minimum
>> > width of 7 characters).
>> 
>> Not a NAK at all (but not an ACK either yet), but just asking
>> questions on some design considerations.
>
> I guess I should use [PATCH/RFC] for this patch...

I do not see any need for that.  As far as I am concerned, all
the [PATCH] are RFCs ;-)

>> * Do these options do different things?  If not, why have more
>>   than one (or two, --long and its shorthand -l)?
>
> The idea was to have output similar (if possible by git-ls-tree
> machinery) to 'ls -l' output, hence -l/--long, but actually it is
> about --size.

"ls -l" is about long (it is not "long to show everything the
system knows", but "longer than usual), so I think it is Ok to
say "ls-tree -l" and people would understand.

>> * Why pad to 7 places?  Do we have a similar padding elsewhere?
>>   Will this ever used by non-scripts?  How does this padding
>>   affect parsers other than Perl that read this information?
>
> Padding is added here to make output more human-readable. And I guess
> padding of 7 places is default for 'ls -l'.

Ok, "it is to make the output also consumable more easily by
humans" is a very reasonable answer.

>>   Also I suspect that having to show the size of a tree object,
>>   expressed in terms of the canonical representation, might
>>   force packv4 aware ls-tree to convert its traversal efficient
>>   representation to the canonical one only to get its size.
>
> It still will be accessible, but perhaps it would be less efficient
> with v4 pack. It is I think acceptable that -l needs more CPU (and I/O) 
> time...

Shawn answered this better than I could.  I am moderately
negative on the size of tree objects part.

But modulo these details, I agree that being able to get the
size of each blob would be useful.
