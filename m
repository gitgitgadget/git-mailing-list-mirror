From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-bisect doesnt record bad commits
Date: Mon, 6 Feb 2006 14:21:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602061417510.3854@g5.osdl.org>
References: <20060206215442.GA12209@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 23:22:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6Ejp-00008t-LO
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 23:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWBFWVX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 17:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWBFWVX
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 17:21:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4996 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932389AbWBFWVW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 17:21:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k16MLIDZ007094
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 6 Feb 2006 14:21:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k16MLD3P032065;
	Mon, 6 Feb 2006 14:21:16 -0800
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060206215442.GA12209@suse.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15665>



On Mon, 6 Feb 2006, Olaf Hering wrote:
> 
> Is there a reason why git-bisect does only record good ones? I would
> really like to know which commits did crash for me. :(

It does. Look in the bisection log (".git/BISECT_LOG").

Now, the reason it doesn't actually save them away as _tags_ is because 
technically, it doesn't need to. The algorithm itself only really cares 
about the most recently marked-bad commit, and the others are totally 
uninteresting from an algorithmic standpoint.

That said, if you want the visualization tools (for example) to show them, 
you could certainly _create_ the tags, if you want to. The fact that they 
wouldn't be used by the bisection algorithm doesn't mean that you can't 
create the ".git/refs/bisect/bad-<sha1>" file in _addition_ to the one 
that marks the latest one.

		Linus
