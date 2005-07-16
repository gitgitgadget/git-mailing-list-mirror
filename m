From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Darcs-Git: upgrading to Git 0.99
Date: Sat, 16 Jul 2005 22:45:47 +0200
Message-ID: <7islyev5s4.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: darcs-devel-bounces@darcs.net Sat Jul 16 22:46:10 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DttXy-000501-E9
	for gcvdd-darcs-devel@m.gmane.org; Sat, 16 Jul 2005 22:46:06 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DttXo-00074k-95; Sat, 16 Jul 2005 16:45:56 -0400
Received: from shiva.jussieu.fr ([134.157.0.129])
	by abridgegame.org with esmtp (Exim 4.50) id 1DttXl-00070a-HO
	for darcs-devel@darcs.net; Sat, 16 Jul 2005 16:45:53 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr
	[134.157.168.1])
	by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j6GKjqrL091440
	; Sat, 16 Jul 2005 22:45:52 +0200 (CEST)
X-Ids: 168
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr
	[134.157.168.57])
	by hydrogene.pps.jussieu.fr (8.13.4/jtpda-5.4) with ESMTP id
	j6GKjlIx011778 ; Sat, 16 Jul 2005 22:45:48 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.50)
	id 1DttXf-00018V-Mg; Sat, 16 Jul 2005 22:45:47 +0200
To: darcs-devel@darcs.net
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2
	(shiva.jussieu.fr [134.157.0.168]);
	Sat, 16 Jul 2005 22:45:52 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 42D97200.001 by Joe's j-chkmail
	(http://j-chkmail.ensmp.fr)!
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

[CC'd to the Git mailling list; please CC any replies to Darcs-Devel]

David, Ian,

I'd like to upgrade the Git code used in Darcs to 0.99 (we're
currently using 0.6).  There are two good reasons for that, the first
of which is actually a showstopper:

 - the format of Git repositories has changed incompatibly, with a new
   kind of thing called the ``pack'' (a very neat performance hack, by
   the way); hence, Darcs-Git is unable to read recent Git repos,
   unless you use the Git tools to unpack them;

 - 0.99 actually exports usable interfaces, which will allow us to use
   pristine Git sources in Darcs.

Now I'm wondering how to do that.  Currently, I'm using a nasty hack
using the C preprocessor to include just the sources we need in
Darcs.  As 0.99 builds a ``libgit.a'', I'd like to use that instead.

There are three ways to do that:

  (1) require that the users put a suitable libgit.a in /usr/local/lib
      before building Darcs, and distribute a tarball of Git from
      darcs.net;

  (2) include just the sources needed for libgit.a in Darcs, and have
      the Darcs build build a local libgit

  (3) as (2), but include all of Git, including their
      ``user-friendly'' scripts.

Solution (2) will include 33 files totalling 167KB, while (3) is about
a megabyte of source.

My personal favourite is solution (2), as it is simple for both the
users and us.  I'm not very keen on (1), as it will cause problems
when the friendly Git folks change their interfaces, but have no
strong dislike towards it if it's what you think is right.  (3) is
definitely overkill.

                                        Juliusz
