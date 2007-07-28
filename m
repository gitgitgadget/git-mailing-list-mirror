From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: [PATCH 1/2] gitk: Import msgcat for translation support
Date: Sat, 28 Jul 2007 00:28:10 -0700 (PDT)
Message-ID: <157938.79347.qm@web38908.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sat Jul 28 09:28:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEgil-0001Ea-Rg
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 09:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759927AbXG1H2M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 03:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbXG1H2M
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 03:28:12 -0400
Received: from web38908.mail.mud.yahoo.com ([209.191.125.114]:40971 "HELO
	web38908.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760609AbXG1H2L convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 03:28:11 -0400
Received: (qmail 79617 invoked by uid 60001); 28 Jul 2007 07:28:11 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=irM112jtUk6XBmkDD/QaIClvtFy7K/mDxr0BUMwjVd9UnhUOaxoLuzT5KYfHE5OmSmTkCN9BkQX1QQ/9N3446BPrtVi3luzW5QU2MMT5rOQSxllDPPTbD63B0OXVNpQ33+wrOB8rclebMkbQMuvuwStancX7OaOoS3HxhHYkjTg=;
X-YMail-OSG: Txe8m_YVM1mbgNr1QODXKKyzGJdbgp.Gy35WDdMZJhgsHA1AVYd5FNeNgtLP.LBqeA--
Received: from [128.251.88.135] by web38908.mail.mud.yahoo.com via HTTP; Sat, 28 Jul 2007 00:28:10 PDT
X-Mailer: YahooMailRC/651.41 YahooMailWebService/0.7.119
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54002>

> 
> ----- Original Message ----
> From: Paul Mackerras <paulus@samba.org>
> To: Christian Stimming <stimming@tuhh.de>
> Cc: git@vger.kernel.org
> Sent: Friday, July 27, 2007 4:53:28 PM
> Subject: Re: [PATCH 1/2] gitk: Import msgcat for translation support
> 
> Christian Stimming writes:
> 
> > Import tcl's msgcat package to have the [mc...] procedure for  
> > translation available.
> 
> I would prefer
> 
> if {[catch {
>     package require msgcat
>     # rest of your new stuff
> }]} {
>     proc mc {str} {
>     return $str
>     }
> }
> 
> so that everything still works if msgcat isn't available.  In other
> words I don't want to introduce a possible regression by increasing
> gitk's requirements.

Junio already replied to this, and he was correct. However, this made me think
of something (that probably should be in git-gui as well) to make it a little
more robust. We should check that the msg directory is where we think it is,
and either give a warning, or exit the app (I would vote for the former).

So, something like:

set msgdir [file join . msgs]      ;# or whatever this turns out to be
if {[file exists $msgdir]} {
    ::msgcat::mcload $msgdir
} else {
    puts stderr "WTF: can't find message catalog directory"
}

Or you could just use [catch] around the ::msgcat::mcload too.


Regards,
    --brett




       
____________________________________________________________________________________
Moody friends. Drama queens. Your life? Nope! - their life, your story. Play Sims Stories at Yahoo! Games.
http://sims.yahoo.com/  
