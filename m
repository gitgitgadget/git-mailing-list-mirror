From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFH] rpm packaging failure
Date: Sun, 31 Jan 2010 15:46:08 -0800
Message-ID: <20100131234607.GB10914@gmail.com>
References: <7v8wbgueqz.fsf@alter.siamese.dyndns.org> <20100130151921.GM29188@inocybe.localdomain> <7vsk9nsemh.fsf@alter.siamese.dyndns.org> <20100130194746.GN29188@inocybe.localdomain> <7vd40rjks4.fsf@alter.siamese.dyndns.org> <20100131231430.GA10914@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 00:52:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbjae-0001xx-A2
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 00:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441Ab0AaXwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 18:52:25 -0500
Received: from mail-yw0-f179.google.com ([209.85.211.179]:57955 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421Ab0AaXwW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 18:52:22 -0500
Received: by ywh9 with SMTP id 9so3904722ywh.19
        for <git@vger.kernel.org>; Sun, 31 Jan 2010 15:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EK8OQB9b1KczqXZjMRqi1jm10HQBDisVhZ5xr/bjBIw=;
        b=LvhMFNmACBgnmZJ2R0WFn2/HSwZ95EnqCgYttv6to13SSTxka+qVWI0VSjlqSUHiq2
         2htuBE64FU84xZ+DAR9gcfkgMumKLOMQMbE/98Zb5P7sg1K9tPZL95ZhjXJ2aJ1kFAoE
         Qrl6ja/e1gbqhYz9xBhKkz4dpmr07jWCVzPWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KphUdAT+OAj3xtg0T2yYUvu53IPguTKmI/f8oXeS0Qz/NnzCaBzeZmOhsgn9XqWTu9
         Vwoawtyl4BLl16DyZ6X2Culfdgs7ruF1LovjijN6soidPmOQ7AqWd3c7+MDwdUP0TazB
         2OanaDInPKqSmlRapfH6lPesgOitSSF5Mvw2w=
Received: by 10.101.25.8 with SMTP id c8mr4264342anj.83.1264981571974;
        Sun, 31 Jan 2010 15:46:11 -0800 (PST)
Received: from gmail.com ([12.183.88.10])
        by mx.google.com with ESMTPS id 13sm2801000gxk.9.2010.01.31.15.46.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 15:46:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100131231430.GA10914@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138567>

On Sun, Jan 31, 2010 at 03:14:32PM -0800, David Aguilar wrote:
> On Sat, Jan 30, 2010 at 02:22:03PM -0800, Junio C Hamano wrote:
> > Todd Zullinger <tmz@pobox.com> writes:
> > 
> > > Not shipping them if they aren't yet used/needed for anything other
> > > than folks working on remote helpers seems reasonable and the rm in
> > > the spec file should do the trick nicely.
> > 
> > Thanks.
> > 
> > To allow us to go forward a bit easier, I am planning to use the attached,
> > as we would need some parts of it when we do start generating a separate
> > package, I think.
> > 
> > -- >8 --
> > Subject: [PATCH] RPM packaging: don't include foreign-scm-helper bits yet
> > 
> > The files in /usr/lib/python* are only the support infrastructure for
> > foreign scm interface yet to be written and/or shipped with git.  Don't
> > include them in the binary package (this will also free us from Python
> > dependency).
> > 
> > When we ship with foreign scm interface, we will need to package these
> > files with it in a separate subpackage, but we are not there yet.
> > 
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  git.spec.in |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> 
> Apologies for the late response to this thread.
> 
> Would it be simpler to define NO_PYTHON when running make?
> We can always resurrect %python_sitelib when it is needed.
> 
> Here's what that looks like relative to master.


I see you just pushed out a new master with the %define changes.
Here's a rebased patch just in case.

-- >8 --
From ac09b94c332564cc7dde3c2f8961990098b5d4a0 Mon Sep 17 00:00:00 2001
From: David Aguilar <davvid@gmail.com>
Date: Sun, 31 Jan 2010 14:52:13 -0800
Subject: [PATCH] RPM packaging: Define NO_PYTHON to avoid Python dependency

We don't use the Python bits yet so we shouldn't require python
to build.  The %define used python to calculate %python_sitelib
and thus incurred a build-time python dependency without
specifying python in BuildRequires.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git.spec.in |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index ee74a5e..320829a 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -98,7 +98,6 @@ BuildRequires:  perl(Error)
 Perl interface to Git
 
 %define path_settings ETC_GITCONFIG=/etc/gitconfig prefix=%{_prefix} mandir=%{_mandir} htmldir=%{_docdir}/%{name}-%{version}
-%{!?python_sitelib: %global python_sitelib %(%{__python} -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")}
 
 %prep
 %setup -q
@@ -106,14 +105,15 @@ Perl interface to Git
 %build
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" \
      %{path_settings} \
+     NO_PYTHON=NotYet \
      all %{!?_without_docs: doc}
 
 %install
 rm -rf $RPM_BUILD_ROOT
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" DESTDIR=$RPM_BUILD_ROOT \
      %{path_settings} \
+     NO_PYTHON=NotYet \
      INSTALLDIRS=vendor install %{!?_without_docs: install-doc}
-test ! -d $RPM_BUILD_ROOT%{python_sitelib} || rm -fr $RPM_BUILD_ROOT%{python_sitelib}
 find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name '*.bs' -empty -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
@@ -192,6 +192,9 @@ rm -rf $RPM_BUILD_ROOT
 # No files for you!
 
 %changelog
+* Sun Jan 31 2010 David Aguilar <davvid@gmail.com>
+- Define NO_PYTHON until we actually need the Python bits.
+
 * Sun Jan 31 2010 Junio C Hamano <gitster@pobox.com>
 - Do not use %define inside %{!?...} construct.
 
-- 
1.7.0.rc1.7.gc0da5
