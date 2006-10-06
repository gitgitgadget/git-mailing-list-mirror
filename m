From: Sean <seanlkml@sympatico.ca>
Subject: Re: Problem cloning packed-and-pruned http repository
Date: Fri, 6 Oct 2006 19:49:30 -0400
Message-ID: <BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE>
References: <20061006212616.GA5175@lumumba.uhasselt.be>
	<20061006220542.GA5890@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 01:49:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVzRf-0001Nc-Qm
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 01:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWJFXtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 19:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWJFXtd
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 19:49:33 -0400
Received: from bayc1-pasmtp08.bayc1.hotmail.com ([65.54.191.168]:51382 "EHLO
	BAYC1-PASMTP08.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1750705AbWJFXtc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 19:49:32 -0400
X-Originating-IP: [65.93.42.136]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.42.136]) by BAYC1-PASMTP08.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 6 Oct 2006 16:57:51 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GVzRa-00047m-PO; Fri, 06 Oct 2006 19:49:30 -0400
To: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Message-Id: <20061006194930.cf400ec4.seanlkml@sympatico.ca>
In-Reply-To: <20061006220542.GA5890@lumumba.uhasselt.be>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 06 Oct 2006 23:57:51.0843 (UTC) FILETIME=[3BC64B30:01C6E9A3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 7 Oct 2006 00:05:42 +0200
takis@lumumba.uhasselt.be (Panagiotis Issaris) wrote:

> Apparently, it does work :-/ After a _long_ time I noticed that the
> repository indeed got cloned... I am not sure if this is normal behavior
> or not, it seemed to take a _really_ long. I would have thought
> downloading 14MiB should not take a long time on my ADSL line.

It's not normal.  There's something odd going on.  I can clone your
repo with wget in about two minutes, while Git still hadn't downloaded
anything after 12 minutes when I killed it.

Poked around a bit, and found that if I comment out these lines from
http-fetch.c:

#ifndef NO_EXPAT
        if (remote_ls(repo, "objects/pack/", PROCESS_FILES,
                      process_ls_pack, NULL) == 0)
                return 0;
#endif

Then everything downloads nice and fast.  Does anyone have a guess
why that would be?

Sean
