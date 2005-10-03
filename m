From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Honor extractor's umask in git-tar-tree.
Date: Mon, 03 Oct 2005 10:28:07 -0700
Message-ID: <43416A27.7070302@zytor.com>
References: <20050930160353.F025C352B7B@atlas.denx.de>	<Pine.LNX.4.64.0510010934290.3378@g5.osdl.org>	<7vr7b53y0n.fsf@assigned-by-dhcp.cox.net>	<7vk6gx3vkt.fsf_-_@assigned-by-dhcp.cox.net>	<433F52DC.5090906@zytor.com>	<pan.2005.10.02.09.55.52.564046@smurf.noris.de>	<4340B73B.1090409@zytor.com> <7virwfuqwv.fsf@assigned-by-dhcp.cox.net>	<43415C9A.1090502@zytor.com> <7v8xxasenp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 19:31:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMU6m-0006qn-2I
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 19:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVJCR2I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 13:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVJCR2I
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 13:28:08 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:32399 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932462AbVJCR2H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2005 13:28:07 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j93HS0Jv013901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Oct 2005 10:28:01 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xxasenp.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9640>

Junio C Hamano wrote:
> 
> For in-cache permission mode bits, we would probably need
> something like this:
> 
>   * git-update-index will pick up the filesystem bits with the
>     current semantics (i.e. look only at (mode & 0100) and
>     force 0644 or 0755) by default; --full-perm-bits option
>     would bypass this bits munging.
> 
>     Once a file is added with --full-perm-bits, it might be
>     nice if index file remembers to pick up the full bits next
>     time git-update-index is run on the path.  This could be
>     achieved by saying that anything stored in the cache with
>     non 100644, 100755 nor 120000 bits are such paths without
>     having to change the index file format.
> 

One could also say that since oddball permissions are an exception, not 
the rule, that one should use a "git-chmod" command to enter the 
permissions in the cache.  The correct answer is probably *both* that 
and --full-permissions (or whatever) since they both probably apply to 
different workflows.

	-hpa
