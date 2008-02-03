From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: man pages are littered with .ft C and others
Date: Sun, 3 Feb 2008 11:39:47 +0100
Message-ID: <200802031139.48752.jnareb@gmail.com>
References: <alpine.DEB.1.00.0802021055180.21831@an.sumeria> <m34pcr6vnm.fsf@localhost.localdomain> <7vejbuxwpu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Adam Flott <adam@npjh.com>, git@vger.kernel.org,
	Jonas Fonseca <fonseca@diku.dk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 11:40:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLcH0-0001YK-UA
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 11:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642AbYBCKj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 05:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbYBCKj7
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 05:39:59 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:43286 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbYBCKj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 05:39:57 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1611948fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 02:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Vez7KmUAQb6t01Tcf2PFHOzJWJhPnsLBUMn7/BKohXg=;
        b=CYg+vbHP0Fals96c9asVmRJ5rxswpOV1RNF2zwXAb3G2mhk1AqMXr2Dv9qpzNIdXiVuf9AfHibnBBJnJbyNbG5SzfCptVpPFCoIXwxvzOy4IL0njUr5jP2VvN/dBqEsX2kqlPLHhrrIwIv+tLgWFoU3JGgg2w1CQvYh7yNjRXPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UD6HPizMenIRTXx8OmRPIvn8YmzK1IkJlIIwjVIIW/n6RDVTIFkclltfJrPEZqkm+RxV66Oq1q/toKnDITAFl4InpparhHK96W9FtG6Fin+vmmzCovqDQHyMxG/N4Bycwehry0dGXcEO7mfvj93cU9qNgHuha7M/klUjy2kIEBQ=
Received: by 10.78.156.6 with SMTP id d6mr9891926hue.22.1202035195576;
        Sun, 03 Feb 2008 02:39:55 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.194.189])
        by mx.google.com with ESMTPS id k10sm15848108nfh.17.2008.02.03.02.39.52
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 02:39:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vejbuxwpu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72348>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> I see the same error in manpages, for example in git-diff-tree(1)
> 
> http://thread.gmane.org/gmane.comp.version-control.git/53457/focus=53458
> 
> rings a bell?

You mean:

Julian Phillips:
> Are you using docbook xsl 1.72?  There are known problems building the 
> manpages with that version.  1.71 works, and 1.73 should work when it get 
> released.

No, I am using docbook-style-xsl-1.68.1-1, and compiling git from RPM.
Besids, I have different set of problems; only with literal blocks.
So while DOCBOOK_XSL_172 is not set... let me check...

Hmmm...

Before
$ man git-diff-tree

       Example:

       .ft C
       :100644 100644 5be4a4...... 000000...... M file.c
       .ft

$ make DOCBOOK_XSL_172=YesPlease doc
$ man Documentation/git-diff-tree.1

       Example:

              :100644 100644 5be4a4...... 000000...... M file.cWhen -z  option  is
              not  used, TAB, LF, and backslash characters in pathnames are repre-
              sented as \t, \n, and \\, respectively.

So setting DOCBOOK_XSL_172 while it fixes the bug (even if docbook-xsl
is version 1.68.1, not 1.72), but introduces another.

Unfortunately I don't know enough about AsciiDoc, DocBook and XML
toolchain to even *try* to fix this issue.


P.S. Alternate soution would be for SRPM to contain pre-compiled
manpages, and not require asciidoc and its toolchain to provide
manpages.
-- 
Jakub Narebski
Poland
