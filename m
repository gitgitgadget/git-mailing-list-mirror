From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: use new Git::Repo API, and add optional caching
Date: Tue, 15 Jul 2008 01:14:43 +0200
Message-ID: <200807150114.44402.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com> <200807142323.22761.jnareb@gmail.com> <487BDB34.7010002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 01:16:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIXGp-0001E8-Si
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 01:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759247AbYGNXOw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 19:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759246AbYGNXOw
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 19:14:52 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:19484 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759245AbYGNXOv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 19:14:51 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2182804fgg.17
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 16:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=eGbMb8sjbPkDrUXVs33IAgNlMQaeZJXp6fgAFVaZtUo=;
        b=qBNL4pJ2S1TG8Ve4l4mNxCZ9gLiy1Dfg+4EVZOjLTq+foJSic2svX3GRnQaKmopTTz
         JmGej3+wxEUWET4D52jcepcE0wxy9j5iKBxC3NnuTKY7CoQiqYQBzcH6iY6WkCPpsg3S
         5eOAPbDnqqt2k9cPy+O2s3zLXFHsxPtntlRb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FGwRPkczpwq601qbHs7rn2ush4nwII+c31fJiehfRrSUm/I2HshEsvNZwzDYrIFrJD
         0lglJ1E3dEUsExvl4IXiVwroB9ph2IxdvawdVurJBD/rEuk1+/mek/8L+I/voFt/jSdM
         pkyNAKjkqIqjvMHtlbQWjeEP5eO+VFhKictEo=
Received: by 10.86.90.2 with SMTP id n2mr15084405fgb.51.1216077289823;
        Mon, 14 Jul 2008 16:14:49 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.250.43])
        by mx.google.com with ESMTPS id 4sm1829028fgg.9.2008.07.14.16.14.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 16:14:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <487BDB34.7010002@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88477>

Lea Wiemann wrote:
> Jakub Narebski wrote:

> > Note that if caching is enabled, you can set expires to either
> > time-to-expire of cache entries (simpler), or time left to live to
> > invalidation of item in cache (better, but more complicated)
>=20
> Gitweb's cache is actually never out-of-date, and cache invalidation
> happens automatically. =C2=A0It uses some (long) expiry times to guar=
d
> against non-standard modification of the repository, but it's nothing
> the HTTP client should be concerned with.

Could you explain then how gitweb cache is invalidated?

The _reasoning_ behind setting Expires:/Cache-Control: max-age=3D heade=
r
for gitweb with caching is that browser doesn't need to even try to
cache-validate or access page for the time we *know* that output would
not change[*1*] because it is from the cache.


[*1*] In significant way: changing relative dates/time doesn't count.

--=20
Jakub Narebski
Poland
