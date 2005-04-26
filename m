From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Tue, 26 Apr 2005 16:43:07 -0700
Message-ID: <426ED20B.9070706@zytor.com>
References: <20050426004111.GI21897@waste.org>	<200504260713.26020.mason@suse.com>	<aec7e5c305042608095731d571@mail.gmail.com>	<200504261138.46339.mason@suse.com>	<aec7e5c305042609231a5d3f0@mail.gmail.com>	<20050426135606.7b21a2e2.akpm@osdl.org>	<Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org> <20050426155609.06e3ddcf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, magnus.damm@gmail.com,
	mason@suse.com, mike.taht@timesys.com, mpm@selenic.com,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 01:39:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQZdT-0002fd-KJ
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 01:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVDZXnq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 19:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVDZXnq
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 19:43:46 -0400
Received: from terminus.zytor.com ([209.128.68.124]:3472 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261848AbVDZXnm
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 19:43:42 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3QNhDRm020274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Apr 2005 16:43:13 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050426155609.06e3ddcf.akpm@osdl.org>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
>>
>>
>>On Tue, 26 Apr 2005, Andrew Morton wrote:
>>
>>>Mounting as ext2 is a useful technique for determining whether the fs is
>>>getting in the way.
>>
>>What's the preferred way to try to convert a root filesystem to a bigger
>>journal? Forcing "rootfstype=ext2" at boot and boot into single-user, and
>>then the appropriate magic tune2fs? Or what?
>>
> 
> 
> Gee, it's been ages.  umm,
> 
> - umount the fs
> - tune2fs -O ^has_journal /dev/whatever
> - fsck -fy                              (to clean up the now-orphaned journal inode)
> - tune2fs -j -J size=nblocks    (normally 4k blocks)
> - mount the fs
> 

I think this is overkill, but should of course be safe.

While you're doing this anyway, you might want to make sure you enable 
-O +dir_index and run fsck -D.

	-hpa
