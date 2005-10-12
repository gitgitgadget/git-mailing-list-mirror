From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] Cleaning up die() error messages
Date: Tue, 11 Oct 2005 21:40:37 -0700
Message-ID: <434C93C5.9040505@zytor.com>
References: <20051010105008.GB30202@gentoo.org>	<7vzmph42j2.fsf@assigned-by-dhcp.cox.net>	<pan.2005.10.11.19.48.04.675482@smurf.noris.de>	<434C2590.3040107@zytor.com>	<pan.2005.10.12.01.20.17.917829@smurf.noris.de>	<434C8095.4080201@zytor.com> <7vd5mbqs2x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 06:41:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPYQ4-0002II-Iq
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 06:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVJLEkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 00:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVJLEkp
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 00:40:45 -0400
Received: from terminus.zytor.com ([192.83.249.54]:45441 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932438AbVJLEko
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 00:40:44 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9C4ebOU010943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Oct 2005 21:40:38 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5mbqs2x.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10005>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>>I thought about this, and probably the sanest way is to wrap malloc() 
>>with something that creates a linked list of allocations.  If we abort, 
>>we can unwind the linked list and free all allocations.
> 
> You can free() the allocated memory with something like that,
> but it is likely that the aborted function would have already
> created some linked structure out of those memory blocks, and
> cleaning up that you would need the real exception handling
> wouldn't you?
> 

Not unless any of those linked structures can be reached from outside 
the git library.

	-hpa
