From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Thu, 25 Sep 2008 14:23:56 +0200
Message-ID: <200809251423.56983.jnareb@gmail.com>
References: <200809251230.11342.jnareb@gmail.com> <CCF9B7B7-4D85-4704-9363-2CE41B048828@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Sep 25 14:25:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kipul-0008Mt-K4
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 14:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbYIYMYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 08:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754796AbYIYMYL
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 08:24:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:59020 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbYIYMYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 08:24:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so286205fgg.17
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=QY2+phJCs2A6RLmSB9oP0xxrfE3gn0LRsoSgPFagoRs=;
        b=qD3UPPsP6uR3PlWfDz6MIMcG6qoTD1yYdbGgWHh3DNIbZ+N3E6qpgqeAmMlKKxUc5n
         mBh/ULGvNdNeR4amUPxdscqQv6qakgH9Ew2kzeWEcWFoNx1CQp69+w92FYOxxjDFayrc
         PVSnBAHTTMrmkxQ17411tWzxu0QG9zowTD0dk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=q0EQCEL5EYlB3xi0V9IAlz+xy9xS+idy7tfHQA5pKuAwqpNlnPUwa+Bleo+G9MUYxM
         fv1c6JM1HFF75i++orYPLvZYT1e8fiyEsQAGGMPhd90EriEjAtb3uebDyn0e8UqtLkS2
         IO5ubbzYtgDLJ8RJokjYJsl1H93nANmxApxNU=
Received: by 10.86.52.1 with SMTP id z1mr8649293fgz.63.1222345446762;
        Thu, 25 Sep 2008 05:24:06 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.235.56])
        by mx.google.com with ESMTPS id l12sm681184fgb.6.2008.09.25.05.24.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Sep 2008 05:24:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CCF9B7B7-4D85-4704-9363-2CE41B048828@simplicidade.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96756>

Pedro Melo wrote:
> On Sep 25, 2008, at 11:30 AM, Jakub Narebski wrote:
> 
> > * Support for FastCGI (via CGI::Fast or FCGI).
> >
> >  Unfortunately I don't use FastCGI.  This has to be done in a very
> >  un-intruisive way, and without performance penalties for "ordinary"
> >  CGI and mod_perl.
> >
> >  Suggested: input reading and validation refactoring.
> 
> Is it ok to require CPAN modules? If yes, then using HTTP::Engine as a  
> base could be helpful here.

No, it is not.  Some gitweb installations (kernel.org, IIRC) are on
tightly managed machines, where installation is severely restricted.
If it is distributed together with Perl package it is best, if it can
be found in distribution packages it is good, if it can be found in
distribution extras it is quite good, if it can be found in trusted
package repository, it is manageable.  Installing untested packages
from CPAN is usually out of the question.

That said...
 
> It supports standalone deployments as well as FastCGI, CGI, mod_perl,  
> POE and others.
> 
> And it acts as a very simple HTTP-layer, without any "framework"
> logic. 

...if we could make it conditional on HTTP::Engine being installed,
and fallback on current code easily, it could be done, I think, without
problems.

Thanks for the pointer. 

> > * Committags support
> >
> >   Support expansion of "tags" in commit messages, like gitweb now
> >   does for (shortened) SHA-1, converting them to 'object' view link.
> >   It should be done in a way to make it easy configurable,
> >   preferebly having to configure only variable part, and not having
> >   to write whole replacement rule.
> >
> >   Possible committags include: _BUG(n)_, bug _#n_, _FEATURE(n),
> >   Message-Id, plain text URL e.g. _http://repo.or.cz_, spam  
> >   protecting of  email addresses, "rich text formatting" like *bold*
> >   and _underline_, syntax highlighting of signoff lines.
> 
> If this part is modular, we can even use a full blown text markup  
> tool, like Markdown or Textile, to generate the HTML version of the  
> commits.

I don't think it is a good idea.  The main target of git commit
messages is command line, so fixed width format is expected.  Commit
mesages are also shown in commit tools and history viewers (git-gui,
gitk, QGit) and in intergration with IDE/editors (KDevelop, Eclipse,
Emacs, Vim).  Unless unprocessed code doesn't loose anything, I think
that advanced markup is a bad, bad idea.

-- 
Jakub Narebski
Poland
