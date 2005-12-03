From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git pull aborts in 50% of cases
Date: Sat, 03 Dec 2005 11:21:50 -0800
Message-ID: <4391F04E.1050002@zytor.com>
References: <20051202190412.GA10757@mipter.zuzino.mipt.ru>	<43909963.60901@zytor.com>	<20051202211250.GA11384@mipter.zuzino.mipt.ru>	<4390B64E.20601@zytor.com>	<Pine.LNX.4.63.0512030316520.19086@wbgn013.biozentrum.uni-wuerzburg.de>	<7vu0dq29wg.fsf@assigned-by-dhcp.cox.net> <43911D9E.5030803@zytor.com> <7vpsoezf6y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 20:23:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EicxW-0005v9-50
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 20:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVLCTWA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 14:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVLCTWA
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 14:22:00 -0500
Received: from terminus.zytor.com ([192.83.249.54]:57498 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751251AbVLCTV7
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 3 Dec 2005 14:21:59 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB3JLpXK013440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Dec 2005 11:21:52 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsoezf6y.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13161>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> 
>>/pub is a symbolic link.  We shouldn't rely on getcwd() for this kind of 
>>stuff; it's bad for a whole bunch of reasons.
> 
> 
> Well, if I recall correctly it was done this way because
> DWIMmery needs to be done before the validation.
> 
> Anyway, here is a rewrite of tonight (I resurrected your "belts
> and suspenders paranoia patch" for this).  Would appreciate it
> if people can try this out (in the proposed updates branch).
> 
> The rules (in 0.99.9k and "master" so far) have been that if you
> have symlinked public, whitelist should say what the canonical
> names of them are (and the way canonical names are obtained were
> getcwd()).  The rule of this patch is different: whitelist says
> what the remote requestor can ask for.  So if your /pub is a
> symlink to /mnt/mnt1/pub, you do not have to say /mnt/mnt1/pub
> to export it.  Instead you whitelist /pub (or /pub/scm).  Also
> if your ~bob is /home1/bob and ~alice is /home2/alice, you do
> not say "/home1 /home2" -- instead, you say "~alice ~bob".
> 

Yup, this is the way to do it.  Forcing people to use canonical names is 
quite a nonstarter.

	-hpa
