From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: What to expect after 0.99.8
Date: Tue, 04 Oct 2005 19:48:51 -0700
Message-ID: <43433F13.1080306@zytor.com>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0510031522590.23242@iabervon.org>	<7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0510031709360.23242@iabervon.org>	<7v1x32l0gz.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0510031606550.31407@g5.osdl.org>	<20051004071210.GA18716@localdomain>	<Pine.LNX.4.63.0510040321170.23242@iabervon.org>	<pan.2005.10.04.14.18.59.102722@smurf.noris.de>	<434296F1.5030006@zytor.com>	<20051004154640.GC4682@kiste.smurf.noris.de>	<4342AF4B.7020806@zytor.com> <7vu0fx9c1c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 04:49:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMzLr-00065M-2C
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 04:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVJECtI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 22:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVJECtI
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 22:49:08 -0400
Received: from terminus.zytor.com ([192.83.249.54]:9697 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751209AbVJECtG
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 22:49:06 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j952mt77020039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Oct 2005 19:48:56 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0fx9c1c.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9696>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>>If you have an ssh connection, you're writing over a pipe to the ssh 
>>process, and your local buffer is that pipe, which is PIPE_BUF size.
> 
> I vaguely recall there was an interesting regression in recent
> kernel history when the implementation of the pipe buffer was
> changed, with which, writing the same amount of data with
> different number of writes made things behave differently and
> making the worst case buffer size less than traditional 4K.
> 
> I wonder if we are going to be bitten by that one...
> 

The definition of PIPE_BUF is that a write to a pipe of no more than 
PIPE_BUF bytes will either succeed immediately or block; it will not be 
broken up into multiple writes (with potential interlace problems.)  It 
says *nothing* about what happens with multiple writes.

	-hpa
