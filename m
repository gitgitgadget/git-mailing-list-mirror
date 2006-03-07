From: Francis Daly <francis@daoine.org>
Subject: Re: What's in git.git
Date: Tue, 7 Mar 2006 22:23:53 +0000
Message-ID: <20060307222353.GA1171@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 23:31:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGki7-0001Ma-7d
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 23:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWCGWbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 17:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWCGWbQ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 17:31:16 -0500
Received: from craic.sysops.org ([217.75.2.2]:31382 "EHLO craic.sysops.org")
	by vger.kernel.org with ESMTP id S964792AbWCGWbP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Mar 2006 17:31:15 -0500
Received: from craic.sysops.org (craic.sysops.org [127.0.0.1])
	by craic.sysops.org (8.12.11/8.12.11) with SMTP id k27MNr0Y001193;
	Tue, 7 Mar 2006 22:23:53 GMT
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: ClamAV 0.87.1/1316/Mon Mar  6 18:53:13 2006 on craic.sysops.org
X-Virus-Status: Clean
X-Spam-Status: No, hits=-3.0 required=2.0
	tests=QUOTED_EMAIL_TEXT,USER_AGENT_MUTT
	version=2.55
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17353>


> I'd like asciidoc tweaks in "next" by Francis Daly tested by
> people who have access to different vintages of docbook-xsl by
> trying to build manpages.  Look for displayed examples, such as
> the one in git-branch documentation.  I've tried it with v1.68
> and getting far better results than before, and Francis says
> v1.69 works fine with or without the change. IOW this is a
> workaround for a problem in v1.68.

For completeness / comparison:

I have docbook-xsl v1.68 (strictly, 1.68.1-0.1 as packaged in debian
stable) and docbook-xsl v1.69 (1.69.1 freshly downloaded with the
manpages/ChangeLog listing the last change on 2005-08-11).

I have asciidoc 7.1.1 (local install) and xmlto version 0.0.18 as packaged
in debian stable.

Also:

$ xsltproc -V
Using libxml 20616, libxslt 10112 and libexslt 810
xsltproc was compiled against libxml 20616, libxslt 10112 and libexslt 810
libxslt 10112 was compiled against libxml 20616
libexslt 810 was compiled against libxml 20616

Of that lot, I believe only the docbook-xsl version actually matters
for this test, but I'm happy to learn otherwise.

I run

asciidoc -b docbook -d manpage -f asciidoc.conf git-branch.txt 
xmlto man git-branch.xml 
asciidoc -b xhtml11 -d manpage -f asciidoc.conf git-branch.txt 

I vary the docbook-xsl version being used and I vary the asciidoc.conf
file to include or exclude the "literallayout" change.

The four html files produced differ only in the "Last updated" time.

The two man pages produced with v1.69 are identical.

The two man pages produced with v1.68 differ in the expected and intended
ways, replacing ".IP" with a ".nf/.fi" pair in two places.

And the differences between 1.68 and 1.69 with the old configuration, and
1.68 and 1.69 with the new configuration, are also confined to that area.

Repeating the tests on git-clone.txt (which also has a multiline example)
gets the same result.

And doing the test on git-mv.txt (with no multiline example) shows
that the asciidoc.conf change has no effect on pages like that. No real
surprise there.

So I'm happy that the (fixed) change improves something and breaks
nothing, at least for those versions of the tools.

	f
-- 
Francis Daly        francis@daoine.org
