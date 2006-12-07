X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Thu, 07 Dec 2006 11:16:58 -0800
Message-ID: <457868AA.2030605@zytor.com>
References: <45708A56.3040508@drzeus.cx> <Pine.LNX.4.64.0612011639240.3695@woody.osdl.org> <457151A0.8090203@drzeus.cx> <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <45744FA3.7020908@zytor.com> <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org> <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org> <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org> <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 19:17:37 +0000 (UTC)
Cc: Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
X-Virus-Scanned: ClamAV 0.88.6/2301/Thu Dec  7 07:20:18 2006 on terminus.zytor.com
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33606>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsOkQ-0004UJ-JF for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163224AbWLGTRS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163223AbWLGTRS
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:17:18 -0500
Received: from terminus.zytor.com ([192.83.249.54]:58623 "EHLO
 terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1163222AbWLGTRR (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:17:17 -0500
Received: from [10.0.6.0] (yardgnome.c2micro.com [69.104.58.50])
 (authenticated bits=0) by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id
 kB7JH17p022302 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Thu, 7 Dec 2006 11:17:01 -0800
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 7 Dec 2006, H. Peter Anvin wrote:
>> That all being said, the lack of intrinsic caching in gitweb continues to be a
>> major problem for us.  Under high load, it makes all the problems worse.
> 
> I really don't see what gitweb could do that would be somehow better than 
> apache doing the caching in front of it.. Is there some apache reason why 
> that isn't sufficient (ie limitations on its cache size or timeouts?)
> 

What it could do better is it could prevent multiple identical queries 
from being launched in parallel.  That's the real problem we see; under 
high load, Apache times out so the git query never gets into the cache; 
but in the meantime, the common queries might easily have been launched 
20 times in parallel.  Unfortunately, the most common queries are also 
extremely expensive.

