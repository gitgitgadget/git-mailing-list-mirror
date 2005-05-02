From: Tom Lord <lord@emf.net>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 14:06:29 -0700 (PDT)
Message-ID: <200505022106.OAA28850@emf.net>
References: <200504292145.j3TLjoTC014157@laptop11.inf.utfsm.cl>
Cc: seanlkml@sympatico.ca, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 23:02:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSi2V-0000bN-JL
	for gcvg-git@gmane.org; Mon, 02 May 2005 23:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVEBVHO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 17:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVEBVHO
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 17:07:14 -0400
Received: from emf.emf.net ([205.149.0.19]:8198 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S261745AbVEBVGf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 17:06:35 -0400
Received: (from lord@localhost) by emf.net (K/K) id OAA28850; Mon, 2 May 2005 14:06:29 -0700 (PDT)
To: vonbrand@inf.utfsm.cl
In-reply-to: <200504292145.j3TLjoTC014157@laptop11.inf.utfsm.cl> (message from Horst von Brand on Fri, 29 Apr 2005 17:45:50 -0400)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


   From: Horst von Brand <vonbrand@inf.utfsm.cl>

   Now pray tell how Joe signing one, two, three, or none of the things he is
   juggling makes any difference here.

We are talking about these signable things:

	1) Joe's assertions about the ancestry of his 
	   change.

	2) A full tree that Joe believes contains exactly
	   his change, compared to the ancestry, in some
	   well-defined way.

	3) A "patch" -- a statement of the well-defined 
	   change Joe is making.


Signing (1) is mandatory if history-sensitive merges are to be
possible.

If everything works perfectly, then signing (1) and (2) is
mathematically equivalent to signing (1) and (3) and both are
equivalent to signing (1), (2), and (3).

Things don't work perfectly.

A document containing (1) and (2) is, almost by definition, a "human
scale" document.   It reprepresents a real-world unit of human labor.
It summarizes the product of that labor in a human-readable, compact
form.   In most cases, a person could study a (1),(2) document in
great detail, byte for byte, relying on very few software tools.

By contrast, a document containing (1) and (3), for a project as large
as the kernel, can not be described as a "human scale" document: it
represents the product of vast amounts of human labor -- exceeding a 
single human's capacity to fully comprehend.   There are just too many
bits there for a full tree to specifically represent a single human's 
detailed *intensions* except indirectly.

You are countering, essentially, that programmers are afforded plenty
of tools for comparing two trees.  Therefore, as I understand you, any
programmer with working tree-comparison tools can robustly commit a
(1),(3) pair accurately.  Similarly, any programmer can robustly
receive a (1),(3) pair and study it as if it were a (1),(2) pair -- so
where's the problem?

The problem is in lot's of places but perhaps the clearest summary can
be presented as a communications problem.  Supposing that work is done
entirely with (1),(3) pairs:


	Alice and Bob both have a copy of the tree ORIG.

	Alice makes changes and now also has tree MOD_alice.

        Alice examines her changes locally.  Her
	version of the changes, summarized as a patch (aka changeset)
        is: CHANGES_alice.

	Alice signs the pair <ORIG, MOD_alice> (a (1),(3) pair) and
	sends it to Bob.

	Bob faithfully retrieves MOD_alice.

	Bob compares Mod_alice to ORIG, using robust tools 
	he has at hand.  The patch (aka changeset) which 
	summarizes the differences in his view is: CHANGES_bob.


Nothing in this scenario gives Bob a way to prove that CHANGES_bob ==
CHANGES_alice.  Bob can be as certain as we are content with that he
wound up with the same _tree_ that Alice did, but he and Alice will
have to go out of their way if they want to check their communication
in such a way that Bob can be confident Alice has checked that she
said what she meant to say.

More bluntly, given just a (1),(3) pair, Bob is extending his vulnerability
to include a reliance on Alice's patch-computing tools.   If Alice were
known to be signing a (1),(2) pair which she had reviewed in detail,
then Bob's vulnerability stays at just his local patch-handling tools
and his general trust of Alice.

In general, it's the potential specificity of a (1),(2) signature, rather
than a (1),(3), that makes (1),(2) signing the more robust idea (from
the robustness perspective).


-t

