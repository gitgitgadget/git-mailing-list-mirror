From: Adam Roben <aroben@apple.com>
Subject: Re: [PATCH 0/9] Make git-svn fetch ~1.7x faster
Date: Mon, 22 Oct 2007 23:13:48 -0700
Message-ID: <471D911C.6070704@apple.com>
References: <1193118397-4696-1-git-send-email-aroben@apple.com>
 <20071023060812.GA30978@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 08:14:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkD1g-0004u2-IU
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 08:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbXJWGNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 02:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbXJWGNt
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 02:13:49 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:61565 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbXJWGNt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 02:13:49 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out4.apple.com (Postfix) with ESMTP id 01FF41687E37
	for <git@vger.kernel.org>; Mon, 22 Oct 2007 23:13:49 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id DDCCB2804D
	for <git@vger.kernel.org>; Mon, 22 Oct 2007 23:13:48 -0700 (PDT)
X-AuditID: 11807134-a865fbb000000c52-71-471d911c42c8
Received: from elliott.apple.com (elliott.apple.com [17.151.62.13])
	by relay14.apple.com (Apple SCV relay) with ESMTP id C1ED228086
	for <git@vger.kernel.org>; Mon, 22 Oct 2007 23:13:48 -0700 (PDT)
Received: from [17.151.66.27] by elliott.apple.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0JQC00GGQPB0LS70@elliott.apple.com> for git@vger.kernel.org;
 Mon, 22 Oct 2007 23:13:48 -0700 (PDT)
In-reply-to: <20071023060812.GA30978@glandium.org>
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62110>

Mike Hommey wrote:
> On Mon, Oct 22, 2007 at 10:46:28PM -0700, Adam Roben wrote:
>   
>> This patch series makes git-svn fetch about 1.7x faster by reducing the number
>> of forks/execs that occur for each file retrieved from Subversion. To do so, a
>> few new options are added to git-cat-file and git-hash-object to allow
>> continuous input on stdin and continuous output on stdout, so that one instance
>> of each of these commands can be kept running for the duration of the fetch.
>>     
>
> You don't need to do this to avoid forks. Just use git-fast-import
> instead.
>   


I agree that fast-import is probably ultimately a better solution for 
this, but given that git-svn currently uses the output of every command 
it forks off and that fast-import doesn't seem to give the same output, 
changing git-svn to use fast-import would be a fairly sweeping change 
that I didn't feel comfortable making without a better understanding of 
git-svn.

-Adam
