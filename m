From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7.3 1/4 (bugfix)] gitweb: Prepare for splitting gitweb
Date: Thu, 2 Dec 2010 20:36:46 +0100
Message-ID: <201012022036.46664.jnareb@gmail.com>
References: <201010311021.55917.jnareb@gmail.com> <201012022001.31739.jnareb@gmail.com> <7vmxooq8uf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 20:37:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POExg-0000Mx-HY
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 20:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757599Ab0LBTgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 14:36:55 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42305 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab0LBTgy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 14:36:54 -0500
Received: by fxm20 with SMTP id 20so1479996fxm.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 11:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1vEhDW/iKgGiJvAwbm0nZLTkFLZcHCyLJNe02cxBlds=;
        b=r2B5g0TjAC7iKrNv0AhOCzmWsViVqzz0+FSAMjeofGJou4n78wo51wie2dRCeVbM3n
         qgqQHWmN6ksKhfuXQXFPeqiykwy22EBc+2CCgASw/lM+XEwPlR2KSqmtQoRvRzAPKObm
         EdohG4FSF+U20sHWBSI/m10zeNBfW1s5Y56PE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IgMEWEnKrGNA1EGBi2AvmqANSD2+BrjxcdqwbuxMoDmd2hx9isOByC9vONit16/MZP
         OaDYIK+BqaAEKm7TvOJXatty0k/rSDf3MtMPCxj1+8l+6VRY0tDwlkwGbLvkzwqj5S2j
         fSWNG29XgFUD0s0xZyW7b2lBxUASO7j1fy/9M=
Received: by 10.223.81.67 with SMTP id w3mr1026763fak.110.1291318613393;
        Thu, 02 Dec 2010 11:36:53 -0800 (PST)
Received: from [192.168.1.13] (abwq166.neoplus.adsl.tpnet.pl [83.8.240.166])
        by mx.google.com with ESMTPS id c11sm348072fav.2.2010.12.02.11.36.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 11:36:51 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vmxooq8uf.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162741>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > > Ah, I don't run the install step for a revision that does not pass its
> > > selftest, so I haven't run "make install" on 'pu' for some time.  That may
> > > explain it.
> >
> > Hmmm... I thought that "make install" doesn't install gitweb, but it does
> > with "$(MAKE) -C gitweb install"... though I am not sure if "make all"
> > builds gitweb (runs "make gitweb").
> 
> I think it does, and it should if it doesn't.

Anyway "install" target in gitweb/Makefile runs "all" target in
gitweb/Makefile, so 
   "make install" -> "make -C gitweb install" -> "make -C gitweb all"
   -> gitweb/gitweb.cgi is generated

gitweb/gitweb.cgi is in $(OTHER_PROGRAMS), and we have

  all:: [...] $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS


Hmmm... shouldn't it be 'gitweb', not 'gitweb/gitweb.cgi'?  Just wondering
(we have gitweb/gitweb.cgi target in main Makefile, which just proxies
to gitweb/Makefile).

-- 
Jakub Narebski
Poland
