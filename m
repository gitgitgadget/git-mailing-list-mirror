From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Having some problem with instaweb
Date: Thu, 23 Jun 2011 01:23:05 -0700 (PDT)
Message-ID: <m3iprx554t.fsf@localhost.localdomain>
References: <BANLkTim6gLg_-UdG36TXWS0Mfj3MOAQ_3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Gurjeet Singh <singh.gurjeet@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 10:23:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZfC0-0002tb-As
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 10:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166Ab1FWIXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 04:23:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63074 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab1FWIXH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 04:23:07 -0400
Received: by fxm17 with SMTP id 17so1123952fxm.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 01:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=eNOIJxaJ+BUFdojuVHKqQPtkhSoigLQdTFD0TRIoEYo=;
        b=kd584xdwcZfJeUztFNsii5PolERbiiUP1H5rAtGgA+yJC45H7UqESDVReVNzxAbWXD
         N0rqFvNfe5zYs6wKSKjq88oLOgcUCxJqchfy4mxB2Fow4/2S1H2EckCaBTq5Szu72Awp
         +y9HMrKNFvzoIsXD+l7FGFPfCN1XH1RkR4WPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=DvU8GGOFrfh0wZTjkZSg07Pa2s7a5RHAIk4Xg/T6mrny+BcN3cOW1+cymo20iI1Cvg
         wYTKMKGmuSXE1oAPhTRnVE0UrkDbnj3nHj9wBlCQJI2jzx+MIH9KwHM3dPmzOgyQLWlt
         yaXKkz/kc+ZupBP4CRqhK6/kv4FN9KsDuF6ts=
Received: by 10.223.37.153 with SMTP id x25mr2289818fad.117.1308817386549;
        Thu, 23 Jun 2011 01:23:06 -0700 (PDT)
Received: from localhost.localdomain (abva28.neoplus.adsl.tpnet.pl [83.8.198.28])
        by mx.google.com with ESMTPS id w15sm823578faj.23.2011.06.23.01.23.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 01:23:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5N8Mb3V007557;
	Thu, 23 Jun 2011 10:22:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p5N8MQa0007547;
	Thu, 23 Jun 2011 10:22:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTim6gLg_-UdG36TXWS0Mfj3MOAQ_3w@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176267>

CC-ing Eric Wong, author of git-instaweb.

Gurjeet Singh <singh.gurjeet@gmail.com> writes:

> I am on Linux Mint 10 and I tried the following command:
> 
> $ git instaweb -d apache2 -p 1234 --start
> Syntax error on line 1 of /mnt/storage/gurjeet/.git/gitweb/httpd.conf:
> Invalid command 'server.document-root', perhaps misspelled or defined
> by a module not included in the server configuration
> Could not execute http daemon apache2 -f.

Hmmm... it looks like starts apache2, but generates config file
(httpd.conf) for lighttpd instead.

Ahh... actually you started apache2, but didn't generate configuration
file for it, so git-instaweb re-uses previous config file... which by
default is lighttpd:

  start, --start
      Start the httpd instance and exit. This does not generate any of the
      configuration files for spawning a new instance.

Try using

  $ git instaweb -d apache2 -p 1234 -b lynx
 
then exiting web browser.


BTW. I think that git-instaweb should be more helpful here... will
investigate.

> /mnt/storage/gurjeet/ is my $HOME.

Nb. it doesn't mater where $HOME is, but where is git repository you
were in when calling git-instaweb.


BTW. in the future it would be good idea to tell what git version are
you using.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
