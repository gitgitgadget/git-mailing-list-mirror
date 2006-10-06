From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Convert Content-Disposition filenames into qtext
Date: Fri, 6 Oct 2006 12:30:59 -0700 (PDT)
Message-ID: <20061006193059.21334.qmail@web31807.mail.mud.yahoo.com>
References: <20061006192006.GW20017@pasky.or.cz>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 21:31:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVvPZ-0000AT-UP
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 21:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422901AbWJFTbG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 15:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422904AbWJFTbG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 15:31:06 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:9900 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422901AbWJFTbD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 15:31:03 -0400
Received: (qmail 21336 invoked by uid 60001); 6 Oct 2006 19:30:59 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=aPOvshyrSBWVZ35XEO7yYTKMEJsD7IS6IZ45aH8CUOaRw6tJUMRWz+p/1mx8nFHXzR1mv4S4xHDi6eBTMJhmTx+jmk2V7BCk+jT9neNcY5MiS7qs/kqTGl04jhtK0zYNyXs130SbbymYUIfXhoMJZ7nPb6Ka3lyMAKzxHp0w8o0=  ;
Received: from [64.215.88.90] by web31807.mail.mud.yahoo.com via HTTP; Fri, 06 Oct 2006 12:30:59 PDT
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061006192006.GW20017@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28440>

--- Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Fri, Oct 06, 2006 at 09:18:01PM CEST, I got a letter
> where Luben Tuikov <ltuikov@yahoo.com> said that...
> > Convert a string (e.g. a filename) into qtext as defined
> > in RFC 822, from RFC 2183.  To be used by Content-Disposition.
> > 
> > Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> > ---
> >  gitweb/gitweb.perl |   18 ++++++++++++++----
> >  1 files changed, 14 insertions(+), 4 deletions(-)
> 
> Content-Description: 1207600725-p1.txt
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index f848648..a35d02c 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -520,6 +520,16 @@ sub esc_html {
> >  	return $str;
> >  }
> >  
> > +# Convert a string (e.g. a filename) into qtext as defined
> > +# in RFC 822, from RFC 2183.  To be used by Content-Disposition.
> > +sub to_qtext {
> > +	my $str = shift;
> > +	$str =~ s/\\/\\\\/g;
> > +	$str =~ s/\"/\\\"/g;
> > +	$str =~ s/\r/\\r/g;
> 
> \r? Not \n?

Yes, \r, not \n.

\n is LF, \r is CR, from ASCII(7).

LF is legal in qtext as defined in RFC 822.
The illegals in qtext are CR, backslash and double quote.

   Luben

> 
> > +	return $str;
> > +}
> > +
> >  # git may return quoted and escaped filenames
> >  sub unquote {
> >  	my $str = shift;
> 
> Other than that,
> 
> Acked-by: Petr Baudis <pasky@suse.cz>
> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> #!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
> $/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
> lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
> 
