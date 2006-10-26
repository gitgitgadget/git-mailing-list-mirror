X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eran Tromer <git2eran@tromer.org>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 00:09:13 +0200
Message-ID: <45413209.2000905@tromer.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610261105200.12418@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 22:10:35 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060913 Fedora/1.5.0.7-1.fc5 Thunderbird/1.5.0.7 Mnenhy/0.7.4.0
In-Reply-To: <Pine.LNX.4.64.0610261105200.12418@xanadu.home>
X-Enigmail-Version: 0.94.1.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30264>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdDQX-0000XG-Ix for gcvg-git@gmane.org; Fri, 27 Oct
 2006 00:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1945960AbWJZWJn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 18:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945963AbWJZWJn
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 18:09:43 -0400
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:54488 "EHLO
 lucian.tromer.org") by vger.kernel.org with ESMTP id S1945960AbWJZWJm (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 18:09:42 -0400
Received: from [192.168.4.6] ([192.168.4.6]) by lucian.tromer.org
 (8.13.7/8.12.11) with ESMTP id k9QM9TNl027293; Fri, 27 Oct 2006 00:09:29
 +0200
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Hi,

On 2006-10-26 17:08, Nicolas Pitre wrote:
> On Thu, 26 Oct 2006, Eran Tromer wrote:
>> This creates a race condition w.r.t. "git repack -a -d", similar to the
>> existing race condition between "git fetch --keep" and
>> "git repack -a -d". There's a point in time where the new pack is stored
>> but not yet referenced, and if "git repack -a -d" runs at that point it
>> will eradicate the pack. When the heads are finally updated, you get a
>> corrupted repository.
> 
> And how is it different from receiving a pack through git-unpack-objects 
> where lots of loose objects are created, and git-repack -a -d removing 
> those unconnected loose objects before the heads are updated?

git-repack -a -d does not touch unconnected loose objects.
It removes only unconnected packed objects.

Only git-prune removes unconnected loose objects, and that's documented
as unsafe.

