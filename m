From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: detect early of we are up to date and avoid costly rev-list
Date: Mon, 08 Jan 2007 21:44:36 -0800
Message-ID: <7vzm8ssqij.fsf@assigned-by-dhcp.cox.net>
References: <11683086324018-git-send-email-martin@catalyst.net.nz>
	<46a038f90701081839r5727c6a0qbcab1cb02dcef580@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jan 09 06:45:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H49nB-0003SX-29
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 06:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbXAIFo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 00:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbXAIFo6
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 00:44:58 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:46955 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbXAIFo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 00:44:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109054457.BJWD19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jan 2007 00:44:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8tlC1W00G1kojtg0000000; Tue, 09 Jan 2007 00:45:13 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90701081839r5727c6a0qbcab1cb02dcef580@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 9 Jan 2007 15:39:46 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36316>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> On 1/9/07, Martin Langhoff <martin@catalyst.net.nz> wrote:
>> @@ -2194,6 +2197,10 @@ sub update
>>      my $git_log;
>>      my $lastcommit = $self->_get_prop("last_commit");
>>
>> +    if ($lastcommit eq $commitsha1) { # up-to-date
>> +         return 1;
>> +    }
>> +
>>      # Start exclusive lock here...
>>      $self->{dbh}->begin_work() or die "Cannot lock database for BEGIN";
>
> Actually, that generates a warning on the initial checkout. The fix is
> to run the if as
>
>  if (defined $lastcommit && $lastcommit eq $commitsha1) { # up-to-date
>
> Junio -- is it easy for you to fixup  when you apply the patch?
> Otherwise, I'll be happy to repost it patch.

Thanks but no need.  "git commit --amend" is our friend ;-).
