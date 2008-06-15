From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH (WIP)] gitweb: Use Test::WWW::Mechanize::CGI to test gitweb output
Date: Sun, 15 Jun 2008 10:36:21 +0200
Message-ID: <200806151036.22205.jnareb@gmail.com>
References: <200806141447.28052.jnareb@gmail.com> <200806142059.52373.jnareb@gmail.com> <4854343B.40707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 10:37:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7nkB-00075C-JF
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 10:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756278AbYFOIgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 04:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756161AbYFOIgg
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 04:36:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:10237 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533AbYFOIge (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 04:36:34 -0400
Received: by ug-out-1314.google.com with SMTP id h2so255917ugf.16
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 01:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=wZFcolXcpqy9D+EmPOM4Z7y58UMuL88QoSEV0RaaMMo=;
        b=ePcvEnREBef2rAtmwgMUgELEPawqWZ9t5pl1LYJ8jKEU2aUsmldJUcR3LXT1zMa4R3
         ezoC+UfDvjHHuTgIXj3E4Ghefty/p+BMEE7bNHN98Qa3FMxQ6P3ZAj+TrjcHM1qwpZuk
         OLwzEFPCQg6rVX2PyEuhX0fHqVRJ7KGc+V4BM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mTV/ncAt49WRb+tYzh6lgU/Mz9KCdXd3qCauprfvys1cgXSuezw00BhAmWL+Utbb/b
         lKOGc3wSxT78fDErK0IfHPBn6hW1TWRkSfwUFQaLCd/sj1MxlyubihzaMIDn+IpDmX5f
         mUybo3sJGDalqqMujwrHm50H7rj9ghKPKBm/Q=
Received: by 10.67.16.13 with SMTP id t13mr4234208ugi.64.1213518992816;
        Sun, 15 Jun 2008 01:36:32 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.239.84])
        by mx.google.com with ESMTPS id m1sm5854851uge.36.2008.06.15.01.36.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 01:36:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4854343B.40707@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85070>

Lea Wiemann wrote:
> Jakub Narebski wrote:
>>
>> [*1*] it would be nice to have perl_application in WWW::Mechanize::CGI,
>> which would simply setup %ENV and use do() instead of system() on
>> provided application.
> 
> Gitweb and probably CGI::Carp qw(fatalsToBrowser) use 'exit', so we'd 
> have to use Test::Trap (or so) to catch those.  I think we should defer 
> this until performance actually becomes an issue.

The idea was more to avoid bug in cgi_application() method of WM::CGI,
which fails on pathname containing embedded spaces (that is why
workaround in setting $gitweb path, to avoid 'trash directory' in it),
than for performance reasons.

Nevertheless naive $mech->cgi( sub { do "$gitweb"; } ); doesn't work;
and after thinking about it a little it simply couldn't work...

-- 
Jakub Narebski
Poland
