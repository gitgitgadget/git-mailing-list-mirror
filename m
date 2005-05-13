From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit [its a workspace
	id, isn't it?]
Date: Fri, 13 May 2005 10:36:48 +0200
Organization: linutronix
Message-ID: <1115973408.11872.125.camel@tglx>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	 <2cfc4032050512183788e01fc@mail.gmail.com>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 10:31:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWVZ9-0001vQ-T4
	for gcvg-git@gmane.org; Fri, 13 May 2005 10:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVEMIhO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 04:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVEMIgy
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 04:36:54 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:49296
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262286AbVEMIfv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 04:35:51 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id 5CD3165C003;
	Fri, 13 May 2005 10:35:45 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id 00D3E282C9;
	Fri, 13 May 2005 10:35:50 +0200 (CEST)
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc4032050512183788e01fc@mail.gmail.com>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-13 at 11:37 +1000, Jon Seymour wrote:

> I think I understand what Thomas is trying to achieve, but I think
> there is a naming problem here. The marker really isn't a repoid - it
> is a workspace id.

I did not think about the naming convention here. I was just looking at
the repositories of Dave Miller - net-2.6 and sparc-2.6 - which are not
seperable by any automated mechanism due to the fact that Dave uses the
same committer name for both, which is reasonable. 

You are right, those are workspaces which happen to have a seperate
public repository.


> From the point of view of a given change epoch, M always wants to see
> "local changes occur first". To know what changes were local to M you
> need to mark the changes that workspace M made with an identifier
> saying that M did this in this workspace, hence the need for the
> marker that Thomas is proposing.


My main concern here is to be able to see a change in the context in
which it was made.
 
In distributed development a change made in workspace A is correct in
the context of A and a change made in the workspace B is correct in the
context of B. By merging these maybe unrelated changes produce a
problem. Add a random number of changes to increase the complexitiy.

It is helpful from my experience to have a possibility to see the
seperate changes in the context where they were made to understand why
the change was made.

If your history is cluttered by the head forward cloning you have more
work to deduce the information you want to have instead of having it
available on demand by a tool.


> Assuming that there is value in being able to reconstruct the merge
> order from the perspective of workspaces that have contributed to the
> global history it would seem that Thomas's suggestion of marking each
> commit with an identifier is reasonable, however, I think the name of
> the identifier should change - what's being tracked is a workspace,
> not a repository.


Ack.

The question is how to automate those workspace identifiers in a
senseful way. A shared object repository makes it necessary to keep the
identifier in workspace itself. A first idea might be
a .git_workspace_id file in the toplevel directory of the workspace,
which can automatically be ignored by all git tools. Maybe a ignore rule
for all .git* files is also reasonable to make future extensions simpler


tglx


