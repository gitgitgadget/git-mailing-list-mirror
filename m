X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 09:21:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610260912250.3962@g5.osdl.org>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net>
 <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com>
 <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
 <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <87k62n5ahp.fsf@alplog.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 26 Oct 2006 16:22:51 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87k62n5ahp.fsf@alplog.fr>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30233>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd7zX-0008Kj-Ri for gcvg-git@gmane.org; Thu, 26 Oct
 2006 18:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423600AbWJZQWA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 12:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423601AbWJZQWA
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 12:22:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42386 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1423600AbWJZQV7 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 12:21:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9QGLZPo029065
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 26
 Oct 2006 09:21:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9QGLYZh019975; Thu, 26 Oct
 2006 09:21:34 -0700
To: Vincent Ladeuil <v.ladeuil+lp@free.fr>
Sender: git-owner@vger.kernel.org



On Thu, 26 Oct 2006, Vincent Ladeuil wrote:

> >>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:
> 
>     Linus> Commits are defined by a _combination_ of:
> 
>     Linus>  - the tree they commit (which is recursive, so the
>     Linus>  commit name indirectly includes information EVERY
>     Linus>  SINGLE BIT in the whole tree, in every single file)
> 
> And here you keep that separate from any SCM related info,
> right ?

I don't understand that question.

The commits contain the tree information. A raw commit in git (this is the 
true contents of the current top commit in my kernel tree, just added 
indentation and an empty line between the command I used to generate it 
and the output, to make it stand out better in the email) looks something 
like this:

   [torvalds@g5 linux]$ git-cat-file commit HEAD

   tree ba1ed8c744654ca91ee2b71b7cdee149c8edbef1
   parent 2a4f739dfc59edd52eaa37d63af1bd830ea42318
   parent 012d64ff68f304df1c35ce5902f5023dc14b643f
   author Linus Torvalds <torvalds@g5.osdl.org> 1161873881 -0700
   committer Linus Torvalds <torvalds@g5.osdl.org> 1161873881 -0700
   
   Merge master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6
   
   * master.kernel.org:/pub/scm/linux/kernel/git/davem/sparc-2.6:
     [SPARC64]: Fix memory corruption in pci_4u_free_consistent().
     [SPARC64]: Fix central/FHC bus handling on Ex000 systems.

where the _name_ of the commit is 

   [torvalds@g5 linux]$ git-rev-parse HEAD

   e80391500078b524083ba51c3df01bbaaecc94bb

ie the commit itself contains the exact tree name (and the name of the 
parents), and the name of the commit is literally the SHA1 of the contents 
of the commit (plus a git-specific header).

>     >> Trees are defined by their content only ?
> 
>     Linus> Where "contents" does include names and
>     Linus> permissions/types (eg execute bit and symlink etc).
> 
> Which can also be expressed as: "Everything the user can
> manipulate outside the SCM context", right ?

Again, I'm not sure what you mean by that. The SCM does not track 
_everything_. It does not track user names and inode numbers, so in a 
sense a developer can change things that the SCM simply doesn't _care_ 
about and never tracks. But yes, the tree contents uniquely identify the 
exact contents that the user cares about.

>     Linus> If you compare the commit name, and they are equal,
>     Linus> you automatically know
> 
>     Linus>  - the trees are 100% identical
>     Linus>  - the histories are 100% identical
> 
> And that's the only info you can get, no ordering here.

No, there is ordering there too. But yes, the ordering is not in the name 
itself, you have to go look at the actual commit history to see it.

The name is just an identifier.

>     Linus> If you only care about the actual tree, you compare
>     Linus> the tree name for equality, ie you can do
> 
>     Linus> 	git-rev-parse commit1^{tree} commit2^{tree}
> 
>     Linus> and compare the two: if and only if they are equal are
>     Linus> the actual contents 100% equal.
> 
> Actually, that's backwards:
> 
> "their actual contents are equal" implies "their signatures are
> equal".

No. 

If the signatures are equal, the contents are equal, and vice versa. It 
really is a two-way thing.

> But, two totally different trees can have the same signature.

No. Don't even think that way. That just confuses you. The hash is 
cryptographic, and large enough, that you really can equate the contents 
with the hash. Anything else is just not even interesting.

