From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for disconnected transfer
Date: Sat, 17 Feb 2007 10:41:13 -0800
Message-ID: <7vejootynq.fsf@assigned-by-dhcp.cox.net>
References: <28763990.2658921171630394111.JavaMail.root@vms064.mailsrvcs.net>
	<7vhctl50zc.fsf@assigned-by-dhcp.cox.net>
	<45D7161C.3050604@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Sat Feb 17 19:41:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIUV4-00023s-R7
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 19:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbXBQSlP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 13:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbXBQSlP
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 13:41:15 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55949 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932707AbXBQSlO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 13:41:14 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217184115.MNCX1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 13:41:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QihD1W0031kojtg0000000; Sat, 17 Feb 2007 13:41:13 -0500
In-Reply-To: <45D7161C.3050604@verizon.net> (Mark Levedahl's message of "Sat,
	17 Feb 2007 09:50:04 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40007>

Mark Levedahl <mdl123@verizon.net> writes:

> Junio C Hamano wrote:
>> I haven't thought things through, but I think something like this
>> would be sufficient:
>>
>> 	# create a bundle.
>> 	$ git bundle --create v1.5.0..maint master next >file.bdl
>>
>>
> In this vein, would it make sense to let git-push be the front end to
> create the bundle? I'm not sure git-push really contributes anything,
> but the interface would then be consistent across all transports. Just
> a thought.

I am not sure.  For the "fetch" case, the UI will be exactly the
same (URL and then refspecs), but we never say bottom commits
for git-push.  When you are creating a bundle, unless you are
including everything, you want a way to say which bottom commits
to be excluded from the resulting pack, so they are different.
I had an impression bundle creation is similar to archive.
