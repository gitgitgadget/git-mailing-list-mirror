From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH] speedup allocation in pack-redundant.c
Date: Tue, 22 Nov 2005 23:48:51 +0100
Message-ID: <4383A053.8020100@etek.chalmers.se>
References: <81b0412b0511220656l528436b1xea80ee18965e4dda@mail.gmail.com> <7vek58ct4b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	=?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
X-From: git-owner@vger.kernel.org Tue Nov 22 23:51:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eegw3-00071l-HC
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 23:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbVKVWsU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 17:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbVKVWsU
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 17:48:20 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:10164 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1030211AbVKVWsU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 17:48:20 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn1.fre.skanova.net (7.2.060.1)
        id 437DDFC20011A139; Tue, 22 Nov 2005 23:48:16 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vek58ct4b.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12579>

Junio C Hamano wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> 
>>Subject: [PATCH] speedup allocation in pack-redundant.c
>>
>>Reuse discarded nodes of llists
>>
>>Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>
> 
> 
> I think making allocation/deallocation to the central place is a
> good cleanup, but I am not sure about the free-nodes reusing.
> Does this make difference in real life?  If so, it might be
> worth doing the slab-like allocation, since free-nodes are very
> small structure and malloc overhead is not ignorable there.
> 
> 
I have done some tests, and unfortunatley I saw approx. zero
improvement with Alex's patch. (less than 10ms difference when
total runtime is 1.850s, tested on http://home.arcor.de/fork0/download/idx.tar.gz)

Did someone else notice an improvement?

It's a nice idea though. I'll look into doing slab-allocation
for the fun of it, but I'm not really sure that malloc is the
bottleneck.

/Lukas
