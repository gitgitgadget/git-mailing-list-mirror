From: Junio C Hamano <gitster@pobox.com>
Subject: Re: About git pretty
Date: Sat, 30 Aug 2008 09:30:15 -0700
Message-ID: <7vfxom1n54.fsf@gitster.siamese.dyndns.org>
References: <94a0d4530808221624m26034923pbc1f97cb4c4203d8@mail.gmail.com>
 <20080823000336.GB14684@leksak.fem-net>
 <94a0d4530808231157y3d36fc23q4617787214a02ea1@mail.gmail.com>
 <alpine.DEB.1.00.0808241948390.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 30 18:31:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZTMG-0007AI-Ti
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 18:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbYH3QaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 12:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbYH3QaX
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 12:30:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbYH3QaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 12:30:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F1B35A80B;
	Sat, 30 Aug 2008 12:30:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E584D5A7FF; Sat, 30 Aug 2008 12:30:16 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808241948390.24820@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Sun, 24 Aug 2008 19:49:58 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F0BF8226-76B0-11DD-8218-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94384>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> On Sat, Aug 23, 2008 at 3:03 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
>>
>> > Felipe Contreras wrote:
>> >> Hi,
>> >>
>> >> Please read aloud the following commands:
>> >> git log --pretty=short
>> >> git log --pretty=full
>> >> git log --pretty=format:%s
>> >>
>> >> It is just me or 'pretty full' doesn't exactly convey the meaning of 
>> >> the action to execute?
>> >
>> > But "pretty short" and "pretty format" is. :)
>> >
>> >> How about:
>> >> git log --format=short
>> >> git log --format=full
>> >> git log --format=custom:%s
>> >>
>> >> If you like the idea I can work on a patch.
>> >
>> > Because --pretty=<format> is an option taken by many git commands 
>> > including git plumbing (e.g. rev-list), many scripts will rely on 
>> > "--pretty" and they all would have to be changed. And --pretty exists 
>> > since Jan 2005 (see 9d97aa64).
>> 
>> Well, it might be difficult, but that doesn't mean it should not be 
>> done. Just like the 'git-*' removal, there could be a period for 
>> transition.
>
> Of course it could be done.  But I do not deem it necessary.  In the 
> balance gain/pain it comes out as not worth the hassle on this guy's 
> calculator.

On the other hand, as an undocumented synonym without deprecating nor
conflicting with existing set of options in any way, I do not think it is
wrong per-se to support something like:

	git log --format=short
        git log --format=':%h %s'

in addition to existing --pretty.  It should be fairly obvious and trivial
to make handle_revision_opt() pretend as if the user said --pretty, and
for the latter one silently prefix "tformat" while doing so.

I won't be doing such a patch myself, though.
