X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [RFC] Two conceptually distinct commit commands
Date: Mon, 04 Dec 2006 21:52:38 -0300
Message-ID: <200612050052.kB50qcn2026534@laptop13.inf.utfsm.cl>
References: <cworth@cworth.org>
NNTP-Posting-Date: Tue, 5 Dec 2006 00:53:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Carl Worth <cworth@cworth.org> 
   of "Mon, 04 Dec 2006 11:08:22 -0800." <87d56z32e1.wl%cworth@cworth.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Delayed for 51:53:35 by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 04 Dec 2006 21:52:44 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33272>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrOYN-0003YE-3q for gcvg-git@gmane.org; Tue, 05 Dec
 2006 01:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937264AbWLEAw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 19:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937276AbWLEAwz
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 19:52:55 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:37694 "EHLO
 inti.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937264AbWLEAwz (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 19:52:55 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net
 [200.83.245.173]) by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id
 kB50qe3C002825 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Mon, 4 Dec 2006 21:52:43 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kB50qcn2026534; Mon, 4
 Dec 2006 21:52:39 -0300
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> wrote:

[...]

> Proposal
> -------
> Here are the two commit commands I would like to see in git:
> 
>   commit-index-content [paths...]
> 
>     Commits the content of the index for the given paths, (or all
>     paths in the index). The index content can be manipulated with
>     "git add", "git rm", "git mv", and "git update-index".
> 
>   commit-working-tree-content [paths...]
> 
>     Commits the content of the working tree for the given paths, (or
>     all tracked paths). Untracked files can be committed for the first
>     time by specifying their names on the command-line or by using
>     "git add" to add them just prior to the commit. Any rename or
>     removal of a tracked file will be detected and committed
>     automatically.

Edit somefile with, e.g, emacs: Get backup called somefile~
Realize that somefile is nonsense, delete it(s edited version)
commit-working-tree-contents: Now you have the undesirable somefile~ saved

Edit somefile, utterly changing it: Get backup called somefile~
mv somefile newfile
commit-working-tree-contents: somefile~ saved, newfile lost

Edit somefile a bit, move it to newfile. Make sure no backups left over.
commit-working-tree-contents: somefile deleted, newfile lost

This is /not/ easy to get right, as it depends on what the user wants, and
the random programs run in between git commands.

You need to tell git somehow what files you want saved, and which ones are
junk. I.e., just the first command (unfortunately).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
