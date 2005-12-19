From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: EAGAIN?
Date: Mon, 19 Dec 2005 14:23:05 -0800
Message-ID: <43A732C9.2060509@zytor.com>
References: <7vhd95h02o.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512191142410.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 23:25:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoTQ2-0007Nf-LJ
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 23:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVLSWXh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 17:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVLSWXg
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 17:23:36 -0500
Received: from terminus.zytor.com ([192.83.249.54]:22932 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964861AbVLSWXg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2005 17:23:36 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBJMNFax012451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Dec 2005 14:23:16 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512191142410.4827@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13838>

Linus Torvalds wrote:
> 
> On Mon, 19 Dec 2005, Junio C Hamano wrote:
> 
>>I was looking at "git grep -n EAGAIN" output and found that many
>>places check "errno == EAGAIN" without checking "errno ==
>>EINTR", both for read(2) and write(2).
> 
> 
> I suspect it's mostly in my code. It's a stupid quirk of mine.
> 
> You might as well delete those thing, but yes, if you want to replace them 
> with testing both EAGAIN and EINTR, go right ahead.
> 

It might be that some of those should either be replaced by fwrite/fread 
or there should be a generic wrapper (usually called xwrite/xread).

	-hpa
