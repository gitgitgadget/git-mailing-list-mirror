From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] t9400: Add test cases for config file handling
Date: Mon, 21 May 2007 09:38:49 -0700
Message-ID: <7vtzu6dtd2.fsf@assigned-by-dhcp.cox.net>
References: <11797003182642-git-send-email-frank@lichtenheld.de>
	<7vlkfjhu2w.fsf@assigned-by-dhcp.cox.net>
	<20070521163145.GM4085@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon May 21 18:39:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqAuS-0005rw-Io
	for gcvg-git@gmane.org; Mon, 21 May 2007 18:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbXEUQiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 12:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755821AbXEUQiv
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 12:38:51 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:36756 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978AbXEUQiv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 12:38:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521163851.MNO22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 21 May 2007 12:38:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1sep1X00i1kojtg0000000; Mon, 21 May 2007 12:38:50 -0400
In-Reply-To: <20070521163145.GM4085@planck.djpig.de> (Frank Lichtenheld's
	message of "Mon, 21 May 2007 18:31:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48026>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> On Sun, May 20, 2007 at 05:57:27PM -0700, Junio C Hamano wrote:
>> This part seems to fail for me and gets an "unexpected cvs success".
>
> Note the note in the patch ;)
>
>> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
>> index fcfb99d..1de5177 100755
>> --- a/git-cvsserver.perl
>> +++ b/git-cvsserver.perl
>> @@ -192,11 +192,9 @@ sub req_Root
>>          }
>>      }
>>  
>> -    unless ( ($cfg->{gitcvs}{$state->{method}}{enabled}
>> -	      and $cfg->{gitcvs}{$state->{method}}{enabled} =~ /^\s*(1|true|yes)\s*$/i)
>> -	     or ($cfg->{gitcvs}{enabled}
>> -	      and $cfg->{gitcvs}{enabled} =~ /^\s*(1|true|yes)\s*$/i) )
>> -    {
>> +    my $enabled = ($cfg->{gitcvs}{$state->{method}}{enabled}
>> +		   || $cfg->{gitcvs}{enabled});
>> +    unless ($enabled && $enabled =~ /^\s*(1|true|yes)\s*$/i) {
>>          print "E GITCVS emulation needs to be enabled on this repo\n";
>>          print "E the repo config file needs a [gitcvs] section added, and the parameter 'enabled' set to 1\n";
>>          print "E \n";
>
> Yeah, should probably have fixed that myself before sending, but the
> other patches were already prepared ;)

Ok, so that's an Ack?
