From: sean <seanlkml@sympatico.ca>
Subject: Re: Recursive remove
Date: Fri, 13 Jan 2006 09:03:01 -0500
Message-ID: <BAYC1-PASMTP095A70114DD0A50FA6CAFAAE260@CEZ.ICE>
References: <20060113132119.GB23655@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 15:07:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExPaS-0004xG-VI
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 15:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422682AbWAMOH0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 09:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbWAMOH0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 09:07:26 -0500
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:2536 "EHLO
	BAYC1-PASMTP09.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1422682AbWAMOHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 09:07:25 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP09.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 13 Jan 2006 06:08:00 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 6B33F644C23;
	Fri, 13 Jan 2006 09:07:23 -0500 (EST)
To: "Peter Eriksen" <s022018@student.dtu.dk>
Message-Id: <20060113090301.10e08670.seanlkml@sympatico.ca>
In-Reply-To: <20060113132119.GB23655@ebar091.ebar.dtu.dk>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 13 Jan 2006 14:08:01.0171 (UTC) FILETIME=[C368CE30:01C6184A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 13 Jan 2006 14:21:19 +0100
"Peter Eriksen" <s022018@student.dtu.dk> wrote:

> Hello,
> 
> A way to recursively remove a directory /Some/Dir/ is a follows:
> 
>    git ls-files -z Some/Dir >rmfiles
>    git update-index -z --force-remove --stdin <rmfiles
>    git commit -a -m "Remove directory Some/Dir"
>    rm -rf Some/Dir
> 
> What is a better way to do it?
> 

Hi Peter,

The following is a bit more concise but not better than your version:

rm -rf Some/Dir
git ls-files -z -d Some/Dir | git-update-index -z --remove --stdin
git commit -m "Remove directory Some/Dir"


Git could stand to have an "rm" command to make this easier.


Sean
