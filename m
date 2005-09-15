From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Shell quoting
Date: Thu, 15 Sep 2005 11:44:42 -0700
Message-ID: <4329C11A.1040302@zytor.com>
References: <43290BB8.90501@zytor.com> <7vy85yahjk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 20:45:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFyjF-00017T-7S
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 20:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030572AbVIOSo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 14:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbVIOSo6
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 14:44:58 -0400
Received: from terminus.zytor.com ([209.128.68.124]:28594 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030572AbVIOSo5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 14:44:57 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8FIikjk012059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Sep 2005 11:44:46 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy85yahjk.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8623>

Okay, I'm trying to put together some rules that should work across shells.

For byte values:

0		Hopeless - not representable in C strings
1-31,127	Prefix with ^V if (and only if!) entered at a prompt,
		as opposed to passed in the ssh command field
32-126		\-escape all characters except -+_@=:.,/ and
  		ASCII alphanumerics
128-		Don't escape (would have to be done differently
  		depending on locale, and shouldn't be needed)

Anyone know of a system for which that breaks horribly?  The 1-31,127 
stuff is iffy, but I just don't know of anything that's more reliable. 
Unfortunately \010-style quoting doesn't work in any of the common shells.

	-hpa
