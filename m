From: Sean <seanlkml@sympatico.ca>
Subject: Re: git and larger trees, not so fast?
Date: Thu, 9 Aug 2007 16:52:18 -0400
Message-ID: <20070809165218.9b76ebf7.seanlkml@sympatico.ca>
References: <20070809163026.GD568@mbox.bz>
	<alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
	<alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
	<7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net>
	<7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	moe <moe-git@mbox.bz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 22:52:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJEzu-0005kF-4q
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 22:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605AbXHIUwo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 16:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbXHIUwo
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 16:52:44 -0400
Received: from s1.bay2.hotmail.com ([65.54.246.99]:36696 "EHLO
	bay0-omc1-s27.bay0.hotmail.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754483AbXHIUwn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 16:52:43 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]) by bay0-omc1-s27.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Thu, 9 Aug 2007 13:52:42 -0700
X-Originating-IP: [64.231.205.174]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.174]) by bayc1-pasmtp08.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Thu, 9 Aug 2007 13:54:42 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IJEzo-0005s7-Q5; Thu, 09 Aug 2007 16:52:40 -0400
In-Reply-To: <7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.13; i686-pc-linux-gnu)
X-OriginalArrivalTime: 09 Aug 2007 20:54:42.0843 (UTC) FILETIME=[82A336B0:01C7DAC7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55473>

On Thu, 09 Aug 2007 13:42:50 -0700
Junio C Hamano <gitster@pobox.com> wrote:


> I do not know if this "fixes" the performance problem or not (I
> do not have that much time during the day), so I would not call
> this a "fix" yet, but at least the _change_ looks trivially
> correct, and passes all the existing tests.
> 
> Interested parties may want to try it and see if it shifts the
> bottleneck.

Junio,

This makes things _much_ better, however the final commit in the 
test script still shows a lot of user time:

## time git init
real    0m0.005s
user    0m0.001s
sys     0m0.004s

## time git add . 
real    0m3.501s
user    0m1.268s
sys     0m2.159s

## time git commit -q -m 'buurrrrn' -a
real    0m2.299s
user    0m1.065s
sys     0m1.317s

## time git status
real    0m1.107s
user    0m0.548s
sys     0m0.557s

## time git status
real    0m1.122s
user    0m0.545s
sys     0m0.557s

## time git status
real    0m1.142s
user    0m0.545s
sys     0m0.576s

## time git commit -q -m 'hurry' 50/500
real    0m16.944s
user    0m15.466s
sys     0m1.133s


Cheers,
Sean
