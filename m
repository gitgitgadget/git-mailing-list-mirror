X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sat, 09 Dec 2006 08:26:15 -0800
Message-ID: <457AE3A7.4080802@zytor.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>	 <4578722E.9030402@zytor.com> <4579611F.5010303@dawes.za.net>	 <200612081438.25493.jnareb@gmail.com>	 <46a038f90612081728s65d65ccewe64fa1a496de76fa@mail.gmail.com>	 <457A1962.6000401@zytor.com>	 <46a038f90612081852u63e05da1qe57504636f3578fd@mail.gmail.com>	 <457A44ED.4080606@zytor.com> <46a038f90612082134x38be9c8dgca6fe60c087bf100@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 16:26:51 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <46a038f90612082134x38be9c8dgca6fe60c087bf100@mail.gmail.com>
X-Virus-Scanned: ClamAV 0.88.6/2311/Sat Dec  9 01:47:31 2006 on terminus.zytor.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33819>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt52H-0008Kq-E2 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 17:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937056AbWLIQ0l (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 11:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937057AbWLIQ0l
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 11:26:41 -0500
Received: from terminus.zytor.com ([192.83.249.54]:58048 "EHLO
 terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937056AbWLIQ0l (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006
 11:26:41 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net
 [67.180.238.27]) (authenticated bits=0) by terminus.zytor.com (8.13.8/8.13.7)
 with ESMTP id kB9GQF9J001527 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA
 bits=256 verify=NO); Sat, 9 Dec 2006 08:26:16 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

Martin Langhoff wrote:
> On 12/9/06, H. Peter Anvin <hpa@zytor.com> wrote:
>> Martin Langhoff wrote:
>> > I posted separately about those. And I've been mulling about whether
>> > the thundering herd is really such a big problem that we need to
>> > address it head-on.
>>
>> Uhm... yes it is.
> 
> Got some more info, discussion points or links to stuff I should read
> to appreciate why that is? I am trying to articulate why I consider it
> is not a high-payoff task, as well as describing how to tackle it.
> 
> To recap, the reasons it is not high payoff is that:
> 
> - the main benefit comes from being cacheable and able to revalidate
> the cache cheaply (with the ETags-based strategy discussed above)
> - highly distributed caches/proxies means we'll seldom see a true
> cold cache situation
> - we have a huge set of URLs which are seldom hit, and will never see
> a thundering anything
> - we have a tiny set of very popular URLs that are the key target for
> the thundering herd - (projects page, summary page, shortlog, fulllog)
> - but those are in the clear as soon as the caches are populated
> 
> Why do we have to take it head-on? :-)
> 

Because the primary failure scenario is timeout on the common queries 
due to excess parallel invocations under high I/O load resulting in 
catastrophic failure.

