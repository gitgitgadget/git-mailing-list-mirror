X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: lamikr <lamikr@cc.jyu.fi>
Subject: gitweb install
Date: Mon, 20 Nov 2006 03:15:05 +0200
Message-ID: <45610199.4030502@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 01:15:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Virus-Scanned: amavisd-new at cc.jyu.fi
User-Agent: Thunderbird 1.5.0.8 (X11/20061109)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31874>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glxki-0004t1-9p for gcvg-git@gmane.org; Mon, 20 Nov
 2006 02:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933835AbWKTBPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 20:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933836AbWKTBPJ
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 20:15:09 -0500
Received: from posti5.jyu.fi ([130.234.4.34]:29598 "EHLO posti5.jyu.fi") by
 vger.kernel.org with ESMTP id S933835AbWKTBPF (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 20:15:05 -0500
Received: from localhost (localhost.localdomain [127.0.0.1]) by posti5.jyu.fi
 (8.13.6/8.13.6) with ESMTP id kAK1F4Yu029474 for <git@vger.kernel.org>; Mon,
 20 Nov 2006 03:15:04 +0200
Received: from posti5.jyu.fi ([127.0.0.1]) by localhost (posti5.jyu.fi
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id dSf+AmOBhSvT for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 03:15:04 +0200 (EET)
Received: from aragorn.kortex.jyu.fi (aragorn.kortex.jyu.fi
 [130.234.182.120]) by posti5.jyu.fi (8.13.6/8.13.6) with ESMTP id
 kAK1F2Ic029469 for <git@vger.kernel.org>; Mon, 20 Nov 2006 03:15:03 +0200
Received: from [127.0.0.1] (aragorn2.kortex.jyu.fi [127.0.0.1]) by
 aragorn.kortex.jyu.fi (Postfix) with ESMTP id 994D24683C8 for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 03:15:05 +0200 (EET)
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Hi

Following dummyuser test case (me :-) might be usefull for improving docs.
I have read the gitweb/README but in addition of that I find out that
there is really little documentation about installing gitweb
except the Makefile & git-instaweb.sh itself.

I would like to install gitweb to /var/run/html/gitweb directory and
after reading the git/INSTALL & gitweb/README
I came to conclusion that something like following could work

1) build git by changing some of the default gitweb configs as a user
    make prefix=/usr all doc GITWEB_SITENAME='gitweb test'
GITWEB_PROJECTROOT=/var/www/html/gitweb 
2) install git as a root after build
    make prefix=/usr install install-doc
3) add following to apache config
    <VirtualHost www:80>
        ServerName my-web-page
        DocumentRoot /gitweb
        RewriteEngine on
        RewriteRule ^/(.*\.git/(?!/?(info|objects|refs)).*)?$
/cgi-bin/gitweb.cgi%{REQUEST_URI}  [L,PT]
        SetEnv    GITWEB_CONFIG    /etc/gitweb.conf
    </VirtualHost>
4) move git repository (kernel for example) to /var/www/html/gitweb
5) restart apache
6) open browser to http://my-web-page/gitweb

Obviously something failed, as after step 2, I do not have either the
/etc/gitweb.conf or gitweb scripts under directory /var/www/html/gitweb

regards
    Mika
   

   
