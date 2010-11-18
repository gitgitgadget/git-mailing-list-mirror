From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7.2 1/4] gitweb: Prepare for splitting gitweb
Date: Thu, 18 Nov 2010 14:37:17 +0100
Message-ID: <201011181437.18499.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <201011130041.22918.jnareb@gmail.com> <7vd3q3eecm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 14:37:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ4gH-0001ZZ-8l
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 14:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757804Ab0KRNh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 08:37:28 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56462 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757692Ab0KRNh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 08:37:26 -0500
Received: by bwz15 with SMTP id 15so2764435bwz.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 05:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=IqzBYjQdpmUHPp/IIn+MZ9FLf8w1GKnGzwCQHmUUZxw=;
        b=SIR/Nb/MTpC1szms/SSToTpNb3vbuKnDWbAXFTLoTrjzCAfMyeI2gx5DlPtEmsnWCC
         l5aHwHt5OdSauJvFGMh1jAYpVQ62bCws5tdQtEroYU5inkncdb14fk9frXxYb6vTgGOc
         Nr1a0MBRKmXSVXEmSHguAsQ5ewEmi2QhKhs3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=lYbvGtaZK0Nm/MZs/xARkNcfPUCLFaoK+fIkJVcbuAcLfku8ZBZ+PG2Rz/weDGw17T
         BUXcQv9kHvJ48g+Q/TJoFwpqKaL3Sv7tIX17PwxcUj6up5QoBmAyvPQuEw56WcfUd17z
         m7hh7kuDQ1v+OHTOYgRitrwisA3UNfSUOMBx4=
Received: by 10.204.73.75 with SMTP id p11mr599378bkj.46.1290087444849;
        Thu, 18 Nov 2010 05:37:24 -0800 (PST)
Received: from [192.168.1.13] (abva111.neoplus.adsl.tpnet.pl [83.8.198.111])
        by mx.google.com with ESMTPS id r21sm228052bkj.22.2010.11.18.05.37.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 05:37:21 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vd3q3eecm.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161667>

On Thu, 18 Nov 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > That means adding GITWEBLIBDIR for future testing of individual
> > modules (it was not present in v7.1).
> 
> You confused me.  "git grep" after test-applying this 4-patch series on
> top of next shows only one GITWEBLIBDIR, which means that the symbol is
> defined but nobody pays attention to it.

That's why I wrote "for _future_ testing"... but perhaps it is not worth
introducing it now that it is not yet used by any test.

> > diff --git a/gitweb/Makefile b/gitweb/Makefile
> > index 0a6ac00..f9e32eb 100644
> > --- a/gitweb/Makefile
> > +++ b/gitweb/Makefile
> > @@ -57,6 +57,7 @@ PERL_PATH  ?= /usr/bin/perl
> > ...
> > -.PHONY: all clean install test test-installed .FORCE-GIT-VERSION-FILE FORCE
> > +.PHONY: all clean install install-modules test test-installed .FORCE-GIT-VERSION-FILE FORCE
> >  
> 
> In the earlier series, 478da52 (gitweb: Prepare for splitting gitweb,
> 2010-10-30) removed the trailing blank line from here but this does not do
> so anymore, which is a micronit regression.

I was not sure if such "while at it" style improvements are encouraged
or not.  Will remember it for v7.3.

-- 
Jakub Narebski
Poland
