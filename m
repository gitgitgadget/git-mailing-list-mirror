From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff: release blobs after generating textual diff.
Date: Tue, 08 May 2007 13:58:48 -0700
Message-ID: <7v7irj2fsn.fsf@assigned-by-dhcp.cox.net>
References: <7vr6pucp9e.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.99.0705061301190.24220@xanadu.home>
	<200705062336.28201.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue May 08 23:00:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlWmu-0002oO-Rp
	for gcvg-git@gmane.org; Tue, 08 May 2007 23:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032135AbXEHU6w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 16:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032137AbXEHU6w
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 16:58:52 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52642 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032134AbXEHU6u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2007 16:58:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508205849.LQQ22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 8 May 2007 16:58:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id wkyo1W00e1kojtg0000000; Tue, 08 May 2007 16:58:49 -0400
In-Reply-To: <200705062336.28201.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Sun, 6 May 2007 23:36:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46623>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> s=C3=B6ndag 06 maj 2007 skrev Nicolas Pitre:
>> On Sun, 6 May 2007, Junio C Hamano wrote:
>>=20
>> > This reduces the memory pressure when dealing with many paths.
>> >=20
>> > An unscientific test of running "diff-tree --stat --summary -M"
>> > between v2.6.19 and v2.6.20-rc1 in the linux kernel repository
>> > indicates that the number of minor faults are reduced by 2/3
>> > (153k vs 49k).
>> >=20
>> > Signed-off-by: Junio C Hamano <junkio@cox.net>
>> > ---
>> >=20
>> >  * This is still a WIP, not in the sense that it breaks anything
>> >    (it doesn't seem to), but in the sense that it is not known
>> >    if it is useful in general and would make that much of a
>> >    difference with a project much larger than the kernel.
>>=20
>> This can only be good.  People are really starting to use Git with=20
>> gigantic repos on limited memory hardware.
>
> This did wonders on the usually unreasonable diffs on huge
> repos. The openoffice diff mentioned in the openoffice thread
> went from 6 to ~3 minutes, and most importantly the computer
> was perfectly usable meanwhile. Git memory usage dropped from
> 1,7GB to 400MB.

I've parked a cleaned-up version in 'next'.  Hopefully we can
merge it to 'master' before 1.5.2, as it is not about a new
feature but about fixing a performance 'bug'.
