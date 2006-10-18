From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Use diff3 instead of merge in merge-recursive.
Date: Wed, 18 Oct 2006 08:53:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610180835000.3962@g5.osdl.org>
References: <20061018085949.GA26501@cepheus.pub> <eh4sfr$3ej$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 17:55:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaDkv-00061Z-GU
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 17:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWJRPx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 11:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161210AbWJRPx6
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 11:53:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161103AbWJRPx4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 11:53:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9IFrsaX028939
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 08:53:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9IFrrUN007066;
	Wed, 18 Oct 2006 08:53:53 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eh4sfr$3ej$1@sea.gmane.org>
X-Spam-Status: No, hits=-2.469 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29241>



On Wed, 18 Oct 2006, Jakub Narebski wrote:
> 
> Doesn't xdiff library git uses have diff3/merge equivalent?

Nope. It has something it calls "merge", but it's really just "apply the 
diff from the common base to the other end".

IOW, if "a" is your common ancestor, and "b1" and "b2" are the branches, 
it's literally

	diff a b1 | patch b2

and not actually a real 3-way merge.

As to why git uses "merge" - I have this strong memory of having seen 
machines that had one but not the other, and that, along with the fact 
that I've used "merge" personally, is why we call "merge" rather than 
diff3.

In Linux systems, "merge" usually comes with the RCS package, and "diff3" 
is usually from "diffutils". It may be that "diff3" is more common. I'm 
not sure what the history is, and what the situation would tend to be like 
on other systems..

		Linus
