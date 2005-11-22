From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Diffs "from" working directory
Date: Tue, 22 Nov 2005 10:32:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511221025580.13959@g5.osdl.org>
References: <200511201817.15780.blaisorblade@yahoo.it>  <20051120174359.GA24177@fieldses.org>
  <Pine.LNX.4.64.0511201010490.13959@g5.osdl.org>  <20051120205855.GA30346@fieldses.org>
  <4381287F.5080402@citi.umich.edu> <b0943d9e0511211328j7c062c07s@mail.gmail.com>
 <4382A972.1010801@citi.umich.edu> <Pine.LNX.4.64.0511212124160.13959@g5.osdl.org>
 <43835D8E.60109@citi.umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 19:34:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EecxD-00053M-Tx
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 19:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965094AbVKVSdB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 13:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbVKVSdB
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 13:33:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33759 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965094AbVKVSc7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 13:32:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAMIWtnO001957
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 22 Nov 2005 10:32:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAMIWs95020579;
	Tue, 22 Nov 2005 10:32:55 -0800
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <43835D8E.60109@citi.umich.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12565>



On Tue, 22 Nov 2005, Chuck Lever wrote:
> 
> then perhaps the problem is that the "stg mail" tool should place the author
> in the From: field automatically?  (ie change the tool, or permanently modify
> the default template that comes with StGIT to do this, as Catalin suggested
> earlier).
> 
> that seems a little twisty to me; you're overloading the SMTP header field
> instead of explicitly specifying patch authorship.  seems like a layering
> violation.

No, I only use the actual SMTP header field if the _body_ of the email 
doesn't contain the "From:".

So there's really two different "From:" lines: there's the SMTP header 
one, which is just a default fallback one, and there's the first non-empty 
line of the email body itself, which is the preferred one. No layering 
violation, just two different layers that have the same format for the 
line.

See "The Perfect Patch" by Andrew, and bullet (4): Attribution:

	http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

To quote:

   'If someone else wrote the patch, they should be credited (and blamed) 
    for it. To communicate this, add a line:

    From: John Doe <jdoe@wherever.com>

    as the very first line of the email.  Downstream tools will pick this 
    up and jdoe will get the git "Author" line.'

and I'd be even more anal about it: I would seriously suggest to people 
that they just _always_ add the "From:" line at the head of the email, 
even if it just is exactly the same as what will be in the SMTP header.

Why? Simple. It makes is less likely that somebody who just forwards the 
patch will forget to add that line for you. So you are really helping 
people out - and making sure the attribution stays correct - by adding 
that extra "From:" line at the top of your email body, even if it is 
"unnecessary" in the sense that it's also in your SMTP header.

		Linus
