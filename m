From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 09/18] gitweb: Revert reset_output() back to original
 code
Date: Thu, 09 Dec 2010 18:43:08 -0800
Message-ID: <4D0193BC.7010203@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>	<1291931844-28454-10-git-send-email-warthog9@eaglescrag.net> <m3pqta1ou3.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 03:41:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQsvI-0007cj-8S
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 03:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754472Ab0LJClY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 21:41:24 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:42851 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225Ab0LJClX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 21:41:23 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBA2fLuX020911
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 9 Dec 2010 18:41:21 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <m3pqta1ou3.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 18:41:21 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163383>

>> Reverted change to reset_output as
>>
>> 	open STDOUT, ">&", \*STDOUT_REAL;
> 
> For somebody not following our discussion the above would be very,
> very cryptic... though I suppose this would be squashed in final
> (ready to be merged in) version of the code.
>  
>> causes assertion failures:
>>
>> 	Assertion !((((s->var)->sv_flags & (0x00004000|0x00008000)) == 0x00008000) && (((svtype)((s->var)->sv_flags & 0xff)) == SVt_PVGV || ((svtype)((s->var)->sv_flags & 0xff)) == SVt_PVLV)) failed: file "scalar.xs", line 49 at gitweb.cgi line 1221.
> 
> It looks like bug in Perl, because it should give some kind of Perl
> error, not failed assertion from within guts of Perl C code.
> 
> Which Perl version are you using?

This is perl, v5.10.0 built for x86_64-linux-thread-multi

>> if we encounter an error *BEFORE* we've ever changed the output.
> 
> And how to reproduce this error (i.e. how did you found it)?

Cause an error to occur before the caching engine switches output, for
instance fail on creating the cache dir, or disable caching all together
and generate an error.  I think the former is where I noticed it, it was
consistent though.

- John 'Warthog9' Hawley
