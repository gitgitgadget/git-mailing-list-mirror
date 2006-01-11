From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git binary size...
Date: Wed, 11 Jan 2006 11:56:39 -0800
Message-ID: <43C562F7.1090000@zytor.com>
References: <Pine.LNX.4.64.0601111021450.5073@g5.osdl.org> <43C558FB.3030102@op5.se> <43C55EE4.9010103@zytor.com> <43C56278.6090105@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 20:57:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewm5j-0000zy-Ta
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 20:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWAKT5E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 14:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWAKT5E
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 14:57:04 -0500
Received: from terminus.zytor.com ([192.83.249.54]:42203 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932481AbWAKT5D
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 14:57:03 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k0BJujtq003848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jan 2006 11:56:45 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C56278.6090105@op5.se>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14507>

Andreas Ericsson wrote:
> H. Peter Anvin wrote:
> 
>>
>> I disagree with both of these.  Most users will not install via "make 
>> install", but rather via a package manager.  Package managers have 
>> long since dealt with this problem; in the case of rpm, the debug 
>> information is stripped off into a separate package.  Having "make 
>> install" strip would break that -- although defining $(STRIP) makes it 
>> a bit easier to deal with (STRIP=: make install).
>>
> 
> Fair point. So how about a strip: target for just stripping the binaries 
> in the directory? That way one can do "make strip install", but 
> everything else will work as always. Better yet, make it
> 
> strip:
>     strip $(STRIP_OPTS) $(PROGRAMS)
> 
> so Linus can set STRIP_OPTS=--strip-debug and everybody's happy.
> 

The proper way to do this is:

strip:
	$(STRIP) $(STRIP_OPTS) $(PROGRAMS)

For "strip", this is frequently omitted, though.  Since "strip" is 
architecture-dependent, though, this is necessary for cross-compilation.

	-hpa
