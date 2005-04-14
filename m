From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Yet another base64 patch
Date: Thu, 14 Apr 2005 10:02:55 -0700
Message-ID: <425EA23F.6010900@zytor.com>
References: <425DEF64.60108@zytor.com> <Pine.LNX.4.58.0504140114260.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 19:02:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM7he-0000Ll-BZ
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 19:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVDNRDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 13:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVDNRDo
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 13:03:44 -0400
Received: from terminus.zytor.com ([209.128.68.124]:24970 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261555AbVDNRD0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 13:03:26 -0400
Received: from [172.27.3.248] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3EH2uxo008507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Apr 2005 10:03:03 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504140114260.7211@ppc970.osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> So why is "base64" worse than the stock one?
> 
> As mentioned, the "flat" version may be faster, but it really isn't an
> option. 32000 objects is peanuts. Any respectable source tree may hit that
> in a short time, and will break in horrible ways on many Linux
> filesystems.
> 

If it does, it's not because of n_link; see previous email.

I have used ext2 filesystems with hundreds of thousands of files per 
directory back in 1996.  It was slow but didn't break anything.

The only filesystem I know of which has a 2^16 entry limit is FAT.

> So you need at least a single level of subdirectory. 
> 
> What I don't get is why the stock hex version would be better than base64.
> 
> I like the result, I just don't _understand_ it.

The base64 version has 2^12 subdirectories instead of 2^8 (I just used 2 
characters as the hash key just like the hex version.)  So it ascerbates 
the performance penalty of subdirectory hashing.

	-hpa
