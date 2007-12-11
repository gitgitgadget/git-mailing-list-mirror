From: David Kastrup <dak@gnu.org>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 12:08:47 +0100
Message-ID: <85bq8xlc8w.fsf@lola.goethe.zz>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	<9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
	<7vlk82hrdt.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.99999.0712102225240.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 12:08:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J22yd-0000nv-Pv
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 12:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbXLKLIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 06:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbXLKLIS
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 06:08:18 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:51022 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbXLKLIR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 06:08:17 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1J22yG-0002bJ-Cp; Tue, 11 Dec 2007 06:08:16 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E88D61C4CE33; Tue, 11 Dec 2007 12:08:47 +0100 (CET)
In-Reply-To: <alpine.LFD.0.99999.0712102225240.555@xanadu.home> (Nicolas
	Pitre's message of "Mon, 10 Dec 2007 22:27:03 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67838>

Nicolas Pitre <nico@cam.org> writes:

> On Mon, 10 Dec 2007, Junio C Hamano wrote:
>
>> "Jon Smirl" <jonsmirl@gmail.com> writes:
>> 
>> > 95%   530  2.8G - 1,420 total to here, previous was 1,983
>> > 100% 1390 2.85G
>> > During the writing phase RAM fell to 1.6G
>> > What is being freed in the writing phase??
>> 
>> entry->delta_data is the only thing I can think of that are freed
>> in the function that have been allocated much earlier before entering
>> the function.
>
> Yet all ->delta-data instances are limited to 256MB according to Jon's 
> config.

Maybe address space fragmentation is involved here?  malloc/free for
large areas works using mmap in glibc.  There must be enough
_contiguous_ space for a new allocation to succeed.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
