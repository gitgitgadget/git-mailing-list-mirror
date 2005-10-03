From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Honor extractor's umask in git-tar-tree.
Date: Mon, 03 Oct 2005 11:05:49 -0700
Message-ID: <434172FD.7020302@zytor.com>
References: <20050930160353.F025C352B7B@atlas.denx.de> <Pine.LNX.4.64.0510010934290.3378@g5.osdl.org> <7vr7b53y0n.fsf@assigned-by-dhcp.cox.net> <7vk6gx3vkt.fsf_-_@assigned-by-dhcp.cox.net> <433F52DC.5090906@zytor.com> <pan.2005.10.02.09.55.52.564046@smurf.noris.de> <4340B73B.1090409@zytor.com> <7virwfuqwv.fsf@assigned-by-dhcp.cox.net> <43415C9A.1090502@zytor.com> <Pine.LNX.4.64.0510031028370.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 20:08:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMUhM-0001To-S2
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 20:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVJCSFw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 14:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVJCSFw
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 14:05:52 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:58511 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932486AbVJCSFv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2005 14:05:51 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j93I5hJv015368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Oct 2005 11:05:44 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510031028370.31407@g5.osdl.org>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9642>

Linus Torvalds wrote:
> 
> As to tar: I think the current
> 
>         if (S_ISDIR(mode) || S_ISREG(mode))
>                 mode |= (mode & 0100) ? 0777 : 0666;
> 
> is wrong. It makes things world-writable by default, and that's just 
> dangerous.

That's standard in the Unix world, though; of course, the user's umask 
shouldn't be set to zero unless things are in very special 
circumstances.  In the case of tar, the umask is applied on extraction 
unless the user explicitly specifies -p.

	-hpa
