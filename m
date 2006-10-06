From: Petr Baudis <pasky@suse.cz>
Subject: Re: gitweb: using quotemeta
Date: Fri, 6 Oct 2006 15:50:19 +0200
Message-ID: <20061006135019.GN20017@pasky.or.cz>
References: <efpme9$o13$1@sea.gmane.org> <20061002201256.89409.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 15:50:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVq5t-0000V5-S3
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 15:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWJFNuW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 09:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbWJFNuW
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 09:50:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63695 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422668AbWJFNuV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 09:50:21 -0400
Received: (qmail 5489 invoked by uid 2001); 6 Oct 2006 15:50:19 +0200
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20061002201256.89409.qmail@web31809.mail.mud.yahoo.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28402>

Dear diary, on Mon, Oct 02, 2006 at 10:12:56PM CEST, I got a letter
where Luben Tuikov <ltuikov@yahoo.com> said that...
> Escaping for the purposes of HTML _view_ and URL generation is ok,
> but it is not ok when _saving_ the file with a file name.
> 
> A file name is just a string of chars, and I want to _save_ the file
> name as its name is. No changes or interpretations please.  I don't
> care what the string is, what chars it is made of, etc.
> 
> Please don't interpret file names and their characters when the files
> are _saved_ by the user's browser.
> 
> The file name in my filesystem should be the exact same file name
> as it appears on any other filesystem hosting the same git repo.
> 
> I don't want this translation:
> Server FS: linux-2.6.git-5c2d97cb31fb77981797fec46230ca005b865799.tar.gz
> Quotemeta: linux\-2\.6\.git\-5c2d97cb31fb77981797fec46230ca005b865799\.tar\.gz
> User FS: linux\-2\.6\.git\-5c2d97cb31fb77981797fec46230ca005b865799\.tar\.gz

Then the user agent is buggy - which browser exhibits this behaviour?

According to RFC2183, the filename is a value. According to RFC2045, a
value is either a token (uninteresting) or a quoted-string. According to
RFC822:

     quoted-string = <"> *(qtext/quoted-pair) <">; Regular qtext or
                                                 ;   quoted chars.

     qtext       =  <any CHAR excepting <">,     ; => may be folded
                     "\" & CR, and including
                     linear-white-space>

     quoted-pair =  "\" CHAR                     ; may quote any char

So what we emit is completely correct.

Of course I have nothing against escaping just ", \ and CR. I don't mind
just substituting CR with some other string, but please just quote " and
\ correctly.

As of now, gitweb will not handle any filenames containing those three
characters properly because of now.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
