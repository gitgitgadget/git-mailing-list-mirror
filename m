From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: safely output binary files for 'blob_plain' action
Date: Sat, 17 Jun 2006 15:30:59 -0700
Message-ID: <7vejxn76u4.fsf@assigned-by-dhcp.cox.net>
References: <200606171332.15591.jnareb@gmail.com>
	<20060617153540.GI2609@pasky.or.cz>
	<7v8xnv8ozp.fsf@assigned-by-dhcp.cox.net>
	<20060617220106.GJ2609@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Kay Sievers <kay.sievers@vrfy.org>
X-From: git-owner@vger.kernel.org Sun Jun 18 00:31:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrjJq-0000wm-7f
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 00:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWFQWbD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 18:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWFQWbB
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 18:31:01 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47103 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751006AbWFQWbA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 18:31:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060617223100.DPDK19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Jun 2006 18:31:00 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060617220106.GJ2609@pasky.or.cz> (Petr Baudis's message of
	"Sun, 18 Jun 2006 00:01:06 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22038>

Petr Baudis <pasky@suse.cz> writes:

>> In other words, something like this:
>> 
>>   (in torvalds/linux-2.6.git/config)
>> 
>> 	[gitweb]
>>         description = "Linus's kernel tree"
>>         ; defaultblobcharset = "latin1"
>>         blobmimemapfile = "mime-map"
>> 
>>   (in torvalds/linux-2.6.git/mime-map, first match decides)
>> 
>> 	fs/nls/nls_euc-jp.c	text/plain; charset=euc_jp
>>         *.c	text/plain; charset=utf-8
>>         *.h     text/plain; charset=utf-8
>
> You could as well just support the mime.types format and load
> /etc/mime.types for this kind of mapping (see below for a patch). The
> advantage is that this pretty much covers all the MIME types you will
> need, the disadvantage is that it's less flexible and the charset part
> wouldn't probably fit in nicely.

Ah, I thought Jakub's patch was already taking care of
mime.types but apparently that was not the case.  As you say,
using /etc/mime.types for this is obviously a good point to
start.

> We could obviously do both. :-)

The point of my example was about charset part; comparing the
suffix part only is not good enough for .po files, so we should
obviously do both.
