From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: git-config: aliases with parameter expansion ($1 and such)
Date: Mon, 24 Mar 2008 14:15:21 +0100
Message-ID: <47E7A969.8010405@dirk.my1.cc>
References: <47E65AF5.4060708@dirk.my1.cc> <76718490803230645k13471472sc99932563b0239da@mail.gmail.com> <47E66382.5030800@dirk.my1.cc> <20080323193842.GA23227@coredump.intra.peff.net> <20080323194514.GA23492@coredump.intra.peff.net> <76718490803231854u6ee76437h5acf37b0b602f3b1@mail.gmail.com> <7vzlso3kjc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 24 14:16:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdmX1-000719-2f
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 14:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757899AbYCXNP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 09:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757858AbYCXNP0
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 09:15:26 -0400
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:41813 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757430AbYCXNPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 09:15:25 -0400
Received: from [84.176.80.166] (helo=[192.168.2.100])
	by smtprelay11.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JdmWJ-0002Hm-TT
	for git@vger.kernel.org; Mon, 24 Mar 2008 14:15:24 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <7vzlso3kjc.fsf@gitster.siamese.dyndns.org>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78031>

Thanks for the help. Both
    (1) atag = !sh -c 'git tag -a -m "$0" "$0"'
and
    (2) atag = !sh -c 'git tag -a -m "$1" "$1"' -
work, but in the latter case the '-' is indeed crucial.
If not given, $1 is not set and git tag complains badly.
When called without any args, (1) sets a tag called "sh"
whereas (2) complains about the missing value for the -m option.
So I decided to use the second form. Shells are funny things. ;-)

BTW: Is it true that "-a" is implicitely added to "git tag"
when the "-m" switch is present, i.e. are
    $ git tag -m foo foo
and
    $ git tag -a -m foo foo
equivalent? Thought so, but it's not in the docs.

Junio C Hamano schrieb:
> "Jay Soffian" <jaysoffian@gmail.com> writes:
>
>   
>> All my shell aliases therefor look like:
>>
>> h          = "!sh -c 'git alias \"$1\" || git help \"$1\"' -"
>>
>> (Notice the trailing '-'.)
>>     
>
> Just for my curiosity, why aren't they
>
>   
>> h          = "!sh -c 'git alias \"$0\" || git help \"$0\"'"
>>     
>
> without trailing '-'?
>   
