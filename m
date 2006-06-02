From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] A Perforce importer for git.
Date: Fri, 2 Jun 2006 09:43:57 -0400
Message-ID: <BAYC1-PASMTP04855AA99A546A74A7F07BAE910@CEZ.ICE>
References: <BAYC1-PASMTP117796558F3B42B2C18DBCAE980@CEZ.ICE>
	<81b0412b0606020609o24ee34b4p7b1bcd013136d49a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 15:44:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm9xD-0005Ud-NQ
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 15:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWFBNoe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 09:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWFBNoe
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 09:44:34 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:63774 "EHLO
	BAYC1-PASMTP04.CEZ.ICE") by vger.kernel.org with ESMTP
	id S932097AbWFBNod (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 09:44:33 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP04.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 2 Jun 2006 06:44:32 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id C803A644C28;
	Fri,  2 Jun 2006 09:44:31 -0400 (EDT)
To: "Alex Riesen" <raa.lkml@gmail.com>
Message-Id: <20060602094357.ee3d8407.seanlkml@sympatico.ca>
In-Reply-To: <81b0412b0606020609o24ee34b4p7b1bcd013136d49a@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 02 Jun 2006 13:44:33.0065 (UTC) FILETIME=[ADF1E190:01C6864A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2 Jun 2006 15:09:45 +0200
"Alex Riesen" <raa.lkml@gmail.com> wrote:

> BTW, can I suggest to import the _currently_ synced state?
> 
> The reason is that because of the way how Perforce is done
> its working directories (views, aka clients) are often a
> horrible mix of occasionally synced files to some random
> versions. No one actually uses "p4 sync" for whole project here
> where I work, because it is absolutely useless at this level
> (updated files have abolutely no relevance at head revision,
> which is what you get by syncing without strictly specifying
> a revision). So a working state is stitched together from
> a lot of "mappings": perforce path to local path -> revision.
> That state can be actually worked on (up until you have
> to commit something, that is not possible except on head). 

Hey Alex,

I'd happily change the script to accommodate your needs if it's at all
reasonable.  As you've no doubt gathered, the script is currently very
branch centric.  It needs a mapping view from each p4 branch into the
local git directory.  Then it does a sync //p4/mapping@{revision} for
each revision along each mapped branch and commits it into git.

Note that it never syncs specifically to head, it explicitly asks for
each revision along the branch and tt doesn't know anything about your
working state, it can only import commits.

Are you looking for the ability to create a single git branch which has
the history of the combined view of your stitched together client mappings
rather than the independent branches held by the server?

Sean
