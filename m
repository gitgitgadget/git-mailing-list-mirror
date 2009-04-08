From: Sam Vilain <samv@catalyst.net.nz>
Subject: Re: [PATCH] perl: add new module Git::Config for cached 'git config'
 access
Date: Wed, 08 Apr 2009 21:50:39 +1200
Message-ID: <49DC736F.1030007@catalyst.net.nz>
References: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz> <20090406092942.GW17706@mail-vs.djpig.de> <1239058276.31863.19.camel@maia.lan> <m3prfo1xh6.fsf@localhost.localdomain> <7vbpr7r72w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 11:53:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrUTH-0000dm-TG
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 11:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759268AbZDHJuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 05:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758824AbZDHJuy
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 05:50:54 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:48809 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748AbZDHJux (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 05:50:53 -0400
Received: from 203-97-235-49.cable.telstraclear.net ([203.97.235.49] helo=[192.168.69.179])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <samv@catalyst.net.nz>)
	id 1LrUQb-0001vZ-DZ; Wed, 08 Apr 2009 21:50:41 +1200
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <7vbpr7r72w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116064>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>   
>> Errr... wouldn't it be better to simply use 
>>
>> +		my ($item, $value) = split("\n", $_, 2)
>>
>> here? Have you tested Git::Config with a "null" value, i.e. something
>> like
>>
>>     [section]
>>         noval
>>
>> in the config file (which evaluates to 'true' with '--bool' option)?
>> Because from what I remember from the discussion on the 
>> "git config --null --list" format the lack of "\n" is used to
>> distinguish between noval (which is equivalent to 'true'), and empty
>> value (which is equivalent to 'false')
>>
>>     [boolean
>>         noval        # equivalent to 'true'
>>         empty1 =     # equivalent to 'false'
>>         empty2 = ""  # equivalent to 'false'
>>     
>
> I do not mind if the _write method always wrote out
>
> 	[core]
>         	autocrlf = true
>
> for a variable that is true, but it should be able to read existing
>
> 	[core]
>         	autocrlf
>
> correctly.
>   

Yep - that's what I thought was reasonable behaviour as well and what my 
submission does.

> Sam, I think you meant to make me squash the "Oops, for no good reason,
> here is a fix-up" into the previous one, but for this case, I'd appreciate
> a re-roll of the series, that includes a test to read from an existing
> configuration file that contains such "presense of the name alone means
> boolean true" variables.
>   

Sure, I rebased the series to have the fix-ups at the right places, but 
didn't think it was an interesting enough change to rate a full 
re-submission. The series at git://github.com/samv/git branch 
perl-Config has the minor change put into the place it was introduced. I 
put a little note to this effect after the --- line.

I'm not quite sure what you want squashed where, maybe just edit the 
below list to be how you'd like it,

pick d43238e perl: add new module Git::Config for cached 'git config' access
pick 5ea135d perl: make Git.pm use new Git::Config module
pick b2865bc perl: make Git::Config use --null
pick 28eecdc perl: fix no value items in Git::Config

:-)

Sam
