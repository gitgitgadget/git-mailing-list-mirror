From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git and symlinks as tracked content
Date: Tue, 03 May 2005 15:56:05 -0700
Message-ID: <42780185.7010204@zytor.com>
References: <1115145234.21105.111.camel@localhost.localdomain>	<Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>	<Pine.LNX.4.58.0505031255000.30768@sam.ics.uci.edu>	<Pine.LNX.4.58.0505031304140.26698@ppc970.osdl.org> <7vr7got2tz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Gal <gal@uci.edu>,
	Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 00:50:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT6De-0007Zo-BY
	for gcvg-git@gmane.org; Wed, 04 May 2005 00:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVECW4k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 18:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVECW4k
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 18:56:40 -0400
Received: from terminus.zytor.com ([209.128.68.124]:34279 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261895AbVECW4i
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 18:56:38 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j43MuA25008966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 May 2005 15:56:11 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7got2tz.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> 
> Introducing "dev" type, as Andreas suggests, is wrong.  This
> this should be done in the same way as you suggested for the
> symlink case.  Store a blob object with those chrdev or blkdev
> modes whose contents are of form:
> 
>     major=14
>     minor=4
>     owner=root
>     group=audio
>     perm=0660
> 
> This would impact the diff side least, and for the cache side it
> does not matter in storing and merging.  checkout-cache still
> needs to know about this.
> 

Owner and permissions are part of the tree object, and apply to all file 
types.  The only thing equivalent to file data is the major,minor; 
storing it as a comma-separated decimal ASCII string is probably the 
cleanest, i.e. for your exaple:

14,4

	-hpa
