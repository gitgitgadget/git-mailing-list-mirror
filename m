From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Wed, 27 Apr 2005 11:54:05 -0700
Message-ID: <426FDFCD.6000309@zytor.com>
References: <20050426004111.GI21897@waste.org> <200504260713.26020.mason@suse.com> <aec7e5c305042608095731d571@mail.gmail.com> <200504261138.46339.mason@suse.com> <aec7e5c305042609231a5d3f0@mail.gmail.com> <20050426135606.7b21a2e2.akpm@osdl.org> <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org> <20050426155609.06e3ddcf.akpm@osdl.org> <426ED20B.9070706@zytor.com> <871x8wb6w4.fsf@deneb.enyo.de> <20050427151357.GH1087@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Florian Weimer <fw@DENEB.ENYO.DE>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, magnus.damm@gmail.com,
	mason@suse.com, mike.taht@timesys.com, mpm@selenic.com,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 20:53:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQrda-0006fl-JC
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 20:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVD0S40 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 14:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVD0SzC
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 14:55:02 -0400
Received: from terminus.zytor.com ([209.128.68.124]:45242 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261958AbVD0Syw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 14:54:52 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3RIsA2w010150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Apr 2005 11:54:11 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050427151357.GH1087@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Thomas Glanzmann wrote:
> 
> For tar I have no idea why it should slow down the operation, but maybe
> you can enlighten us.
> 

Directory hashing slows down operations that do linear sweeps through 
the filesystem reading every single file, simply because without 
dir_index, there is likely to be a correlation between inode order and 
directory order, whereas with dir_index, readdir() returns entries in 
hash order.

	-hpa
