From: Dmitry Marakasov <amdmi3@amdmi3.ru>
Subject: Re: [PATCH] configure.ac: link with -liconv for locale_charset()
Date: Wed, 12 Mar 2014 02:39:42 +0400
Message-ID: <20140311223942.GD11801@hades.panopticon>
References: <20140311183529.GA73693@hades.panopticon>
 <xmqqsiqoo4ma.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>, git@vger.kernel.org, wxs@FreeBSD.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 23:39:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNVKy-0001AF-BE
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 23:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755762AbaCKWjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 18:39:48 -0400
Received: from smtpout3.timeweb.ru ([92.53.117.25]:44333 "EHLO
	smtpout3.timeweb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbaCKWjr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 18:39:47 -0400
Received: from [213.148.20.85] (helo=hive.panopticon)
	by smtp.timeweb.ru with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.76)
	(envelope-from <amdmi3@amdmi3.ru>)
	id 1WNVKp-0007e4-4U; Wed, 12 Mar 2014 02:39:43 +0400
Received: from hades.panopticon (hades.panopticon [192.168.0.32])
	by hive.panopticon (Postfix) with ESMTP id C0D699A3;
	Wed, 12 Mar 2014 02:39:42 +0400 (MSK)
Received: by hades.panopticon (Postfix, from userid 1000)
	id B686610669; Wed, 12 Mar 2014 02:39:42 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <xmqqsiqoo4ma.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243908>

* Junio C Hamano (gitster@pobox.com) wrote:

> > On e.g. FreeBSD 10.x, the following situation is common:
> > - there's iconv implementation in libc, which has no locale_charset()
> >   function
> > - there's GNU libiconv installed from Ports Collection
> >
> > Git build process
> > - detects that iconv is in libc and thus -liconv is not needed for it
> > - detects locale_charset in -liconv, but for some reason doesn't add it
> >   to CHARSET_LIB (as it would do with -lcharset if locale_charset() was
> >   found there instead of -liconv)
> > - git doesn't build due to unresolved external locale_charset()
> >
> > Fix this by adding -liconv to CHARSET_LIB if locale_charset() is
> > detected in this library.
> >
> > Signed-off-by: Dmitry Marakasov <amdmi3@amdmi3.ru>
> > ---
> 
> Looks sensible; Dilyan, any comments?

Addendum: build logs before and after the fix:

http://people.freebsd.org/~amdmi3/git-iconv-fail.log
http://people.freebsd.org/~amdmi3/git-iconv-fixed.log

-- 
Dmitry Marakasov   .   55B5 0596 FF1E 8D84 5F56  9510 D35A 80DD F9D2 F77D
amdmi3@amdmi3.ru  ..:  jabber: amdmi3@jabber.ru    http://www.amdmi3.ru
