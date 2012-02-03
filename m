From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.9
Date: Fri, 3 Feb 2012 13:52:09 +0100
Message-ID: <201202031352.10279.jnareb@gmail.com>
References: <7vipjwzvc2.fsf@alter.siamese.dyndns.org> <m3y5slark1.fsf@localhost.localdomain> <CAPc5daVhXQ3-TCqZi8di=j5LdpwXZUt3bO8KkvA2UmL6axCRqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 13:51:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtIc3-0004MJ-Vf
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 13:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695Ab2BCMva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 07:51:30 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44299 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab2BCMv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 07:51:29 -0500
Received: by eaah12 with SMTP id h12so1428015eaa.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 04:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=+zLOr9hnOAv7nJsHHMZZ6rhEemjVazKqTk2TReZcPHk=;
        b=dH4GwkzyYyp/ZbOemvBapG2ED2yQ8CP8qVfCml8vtfrt4fjvgXTaqDv+KUr7DeOjP0
         eJvEK7xkuSRl2zjtfjRZK8ZeDL9wjqrL65ng3QCbn8DU6BTEzFsXT+hfsTG16aApcdhp
         CiCU87ESOpP5nbxoNnFChr/kRniVASAt9bPqM=
Received: by 10.213.108.145 with SMTP id f17mr1172114ebp.113.1328273488223;
        Fri, 03 Feb 2012 04:51:28 -0800 (PST)
Received: from [192.168.1.13] (abvn4.neoplus.adsl.tpnet.pl. [83.8.211.4])
        by mx.google.com with ESMTPS id e12sm21590573eea.5.2012.02.03.04.51.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 04:51:27 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CAPc5daVhXQ3-TCqZi8di=j5LdpwXZUt3bO8KkvA2UmL6axCRqQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189756>

On Fri, 3 Feb 2012, Junio C Hamano wrote:
> On Thu, Feb 2, 2012 at 12:50 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> 
> > When trying to rebuild RPM out of tarball with
> >
> >  $ rpmbuild -tb git-1.7.9.tar.gz
> >
> > I get the following error at the end of build phase:
> >
> >  RPM build errors:
> >     Installed (but unpackaged) file(s) found:
> >    /usr/share/locale/is/LC_MESSAGES/git.mo
> >
> 
> I think it should be simply ignored at least for now.  I stopped touching
> the rpm spec since August last year (the only reason I was running rpmbuild
> was to install them on k.org), so I didn't notice.

So for the time being something like that would be an acceptable fix?
 
diff --git a/git.spec b/git.spec
index 8ceb42b..5461b0b 100644
--- a/git.spec
+++ b/git.spec
@@ -134,6 +134,7 @@ find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
 %else
 rm -rf $RPM_BUILD_ROOT%{_mandir}
 %endif
+rm -rf $RPM_BUILD_ROOT%{_datadir}/locale
 
 mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d
 install -m 644 -T contrib/completion/git-completion.bash $RPM_BUILD_ROOT%{_sysconfdir}/bash_completion.d/git


-- 
Jakub Narebski
Poland
