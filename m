From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb: Scan dir for repos & show these other specified repos
Date: Mon, 1 Mar 2010 23:18:28 +0100
Message-ID: <201003012318.29548.jnareb@gmail.com>
References: <4B8C1267.2050301@gmail.com> <m33a0jn7ft.fsf@localhost.localdomain> <1267478419.4400.2.camel@kheops>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Mike.lifeguard" <mike.lifeguard@gmail.com>, git@vger.kernel.org
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Mon Mar 01 23:18:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmDws-0003Ju-3x
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 23:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630Ab0CAWSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 17:18:40 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:41850 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab0CAWSj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 17:18:39 -0500
Received: by bwz4 with SMTP id 4so2267960bwz.28
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 14:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+ix9UvIcJd/5bqrzRr2gnpTQ8pm7N0dcSq12Tj9dXJI=;
        b=a4JgOXVsnt88/6GRPZpchRao/Nt1L2UNU+wxOJ23SdTYFNDMx7jFpFs/qVyHKGrerQ
         xwqQ7DVQDuO07+0udazKt4TF3el7+RZvEX2NlrCIbAhCaMyfZ3E3ZrQbQjzMflefezBD
         7mDTOFo66WZ0hjvZWDT/8f2dJ0cgmqPL5RN20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ORm/+X7/J39dYmXTwXkO+PBZ9KdyfroGcoAQsDIuGbImNuAnm2UeSvvkN4lZa1aebT
         KZ2Dpu4AN3CYlWkrp4s/+g4ZNvX05dBZRiZhhjO89oTV5ure3mOL3R2Al/ZMppKGiVpl
         EE83BNJ3i4P9HigB0TVYCv5RhBedb/B+J+T+Y=
Received: by 10.204.145.23 with SMTP id b23mr459426bkv.17.1267481917448;
        Mon, 01 Mar 2010 14:18:37 -0800 (PST)
Received: from ?192.168.1.13? (abwj97.neoplus.adsl.tpnet.pl [83.8.233.97])
        by mx.google.com with ESMTPS id 15sm2420073bwz.0.2010.03.01.14.18.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 14:18:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1267478419.4400.2.camel@kheops>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141363>

On Mon, 1 Mar 2010, Sylvain Rabot wrote:
> On Mon, 2010-03-01 at 11:55 -0800, Jakub Narebski wrote:
> > "Mike.lifeguard" <mike.lifeguard@gmail.com> writes:
> > 
> > > Is it possible to have gitweb show all repositories in /path/to/wherever
> > > and also show some other repositories at particular locations like
> > > /home/user/git/repo1 and /home/user2/git/repo2 ? Or better yet, scan
> > > multiple dirs? Currently I can only see how to do one or the other
> > > within a single gitweb installation. I suppose I could run two of them...

> > P.S. It probably be a good idea to have something like mod_userdir,
> > but gitweb currently doesn't support something like that.
> 
> I had the same problematic some times ago. I wanted to have several
> project's roots folder for gitweb (one for each unix user of the
> server).
> 
> You can find the discussion here :
> 
> http://thread.gmane.org/gmane.comp.version-control.git/132926/
> http://marc.info/?t=125827961600002&r=1&w=2
> 
> Here the configuration I used :
> 
> /etc/gitweb.conf :
> 
> $projectroot = $ENV{'GITWEB_PROJECTROOT'} || "/var/gitweb";
> 
> /etc/apache2/sites-available/yourvirtualhost :
> 
> RewriteEngine on
> RewriteRule ^/$ /cgi-bin/gitweb.cgi [QSA,L,PT]
> RewriteRule ^/\~([^\/]+)/?$ /cgi-bin/gitweb.cgi
> [QSA,E=GITWEB_PROJECTROOT:/home/$1/gitweb/,L,PT]
> 
> I.E. :
> 
> http://yourvirtualhost/ will have /var/gitweb as proeject root
> http://yourvirtualhost/~<user>/ will have /home/<users>/gitweb as
> proeject root
> 
> You can modify the rewrite rule to match what you want to do.

Would you mind writing it up and adding it as an example in gitweb/README?
If you don't have time, I can try to do this myself in my free time.

-- 
Jakub Narebski
Poland
