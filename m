From: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 22:29:43 +0100
Message-ID: <20110427212943.GA2646@jakstys.lt>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 23:29:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFCIz-0006XV-Hj
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 23:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759Ab1D0V3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 17:29:49 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34425 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929Ab1D0V3s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 17:29:48 -0400
Received: by wwa36 with SMTP id 36so2374430wwa.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JyhDZt4DDqr4sA9feaQHA1o8DP1tyr6hrnunB+sGlSU=;
        b=s6ikQyOZ9RiSZVF4zSOQPxohHB/Gua1nyPSRkfy/DQ27YxUUR9SG091PeAHMskTxIY
         uiLRArpDXlESQeo1TXgUJ0qPj4XTcFkzozXIgdKkjkpkPfOtuJL9qiRKgndGNkIni4vF
         e7FF/+kTPaKY1KDCGG9PGGRnLRxQGYTKUQ8eA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HajYJHJ1bl7iFvKNo85mfdWojOWtKPrhYm9+04/lfe+LCzJydQYnlaEpANKGUJtTZD
         gDxwfrqQx9oSvOR6ANVUbqpKLv7Th4A6c5O+hysIIGpWMnMl1QWTOLRX4i44UIVDf25z
         Bv3riGlJAd4Z0X4UP0PetCX5LnhLVg+qQHDjA=
Received: by 10.227.39.89 with SMTP id f25mr2699581wbe.154.1303939786921;
        Wed, 27 Apr 2011 14:29:46 -0700 (PDT)
Received: from localhost ([109.246.247.245])
        by mx.google.com with ESMTPS id b20sm707979wbb.16.2011.04.27.14.29.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 14:29:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172276>

On Wed, Apr 27, 2011 at 01:36:44PM +1000, Jon Seymour wrote:
> Has anyone ever given consideration to git supporting a plugin
> architecture for git extensions?
> 

How about this proposition? From the user perspective:
$ cd /somewhere/might/be/home/or/project/.git/ext/
$ git clone git://github.com/jonseymour/gitwork.git

What user finds in gitwork/ is totally up to maintainer. git cares about
two files:
    .git/ext/git-work(.exe)
    .git/ext/git-work.1.gz

$ cd gitwork;
$ (c)make|./waf|scons|what_the_hell_just_produce_git-work
$ git config ext.work.enabled true

What git does when git <command> is invoked:
-------------------------------------------
* config.ext.<command>.enabled is true. If not, do nothing new.
* if above is true, search for git-work in:
  ** project directory
  ** user home directory
* if found, execute it
* if not found, fallback to default mechanism (check in
    cmd_struct_commands, etc)

Similar with man pages.

Think about how Vim plugins are distributed. Vim developers assumed that
users are educated enough to download the plugin and extract it to the
right place. Are git users less intelligent to download & install it,
especially in a case when they need an *extension*?

Are you trying to kill a bird with a rock?

Motiejus
