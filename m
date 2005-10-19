From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb.cgi
Date: Tue, 18 Oct 2005 17:38:13 -0700
Message-ID: <43559575.1060902@zytor.com>
References: <43546492.3020401@zytor.com> <20051018110725.GB6929@vrfy.org> <43552FC2.3000000@zytor.com> <Pine.LNX.4.64.0510181645200.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 02:39:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES1yQ-0006EG-D7
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 02:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbVJSAi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 20:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbVJSAi1
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 20:38:27 -0400
Received: from terminus.zytor.com ([192.83.249.54]:26839 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751513AbVJSAi1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 20:38:27 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9J0cISI012174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Oct 2005 17:38:18 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510181645200.3369@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10246>

Linus Torvalds wrote:
> 
> It really doesn't work very well with the "front page" though..
> 
> Doing a "Save page as.." shows that it's not a huge page: it's roughly 700 
> lines long and 57kB in size, but pressing the reload button (or just going 
> somewhere else and coming back immediately) takes 45 seconds to reload for 
> me.
> 
> Trying again shows that it _is_ cached if you press the reload button 
> immediately again, but I haven't quite figured out how long the cache 
> timeout is. It seems to be around one minute (from some very preliminary 
> tests it's more than 25 seconds, but less than a minute and a half).
> 

It turns out that the default CacheSize is only 256K.  D'oh!  Fixed.

I also changed the CacheDefaultExpire to 600 seconds.

> That said, I tried to figure out how the front page is generated, but 
> haven't quite. Can somebody (Kay?) please say what it does most, and I can 
> try to make sure git does that efficiently.. 

The only thing the front page really should need is to know when the 
last change to the tree was, which presumably means looking at each head 
of each tree and follow the chain until there is a datable object.

	-hpa
