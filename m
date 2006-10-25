X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Gerrit Pape <pape@smarden.org>
Subject: Re: git-*arch* in git-arch rpm
Date: Wed, 25 Oct 2006 11:23:27 +0000
Message-ID: <20061025112327.16220.qmail@e5d824cd35b8a9.315fe32.mid.smarden.org>
References: <20061024200211.17221.qmail@9f622d681978b5.315fe32.mid.smarden.org> <7viri9dkk5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 11:23:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7viri9dkk5.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30051>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcgr8-00085C-B6 for gcvg-git@gmane.org; Wed, 25 Oct
 2006 13:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423276AbWJYLXH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 07:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423275AbWJYLXH
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 07:23:07 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:31144 "HELO
 a.mx.smarden.org") by vger.kernel.org with SMTP id S1423277AbWJYLXG (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 07:23:06 -0400
Received: (qmail 16221 invoked by uid 1000); 25 Oct 2006 11:23:27 -0000
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, Oct 24, 2006 at 10:35:38PM -0700, Junio C Hamano wrote:
> Gerrit Pape <pape@smarden.org> writes:
> > Hi, there're two programs in the git-arch rpm that shouldn't be there:

> So we need at least this?

And this I think, but can't test it.

diff --git a/git.spec.in b/git.spec.in
index 9b1217a..0dbee39 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -96,10 +96,10 @@ find $RPM_BUILD_ROOT -type f -name .pack
 find $RPM_BUILD_ROOT -type f -name '*.bs' -empty -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
 
-(find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "arch|svn|cvs|email|gitk" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-doc-files
+(find $RPM_BUILD_ROOT%{_bindir} -type f | grep -vE "git-archimport|svn|cvs|email|gitk" | sed -e s@^$RPM_BUILD_ROOT@@)               > bin-man-doc-files
 (find $RPM_BUILD_ROOT%{perl_vendorlib} -type f | sed -e s@^$RPM_BUILD_ROOT@@) >> perl-files
 %if %{!?_without_docs:1}0
-(find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f | grep -vE "arch|svn|git-cvs|email|gitk" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
+(find $RPM_BUILD_ROOT%{_mandir} $RPM_BUILD_ROOT/Documentation -type f | grep -vE "git-archimport|svn|git-cvs|email|gitk" | sed -e s@^$RPM_BUILD_ROOT@@ -e 's/$/*/' ) >> bin-man-doc-files
 %else
 rm -rf $RPM_BUILD_ROOT%{_mandir}
 %endif

> diff --git a/git.spec.in b/git.spec.in
> index 9b1217a..b61a338 100644
> --- a/git.spec.in
> +++ b/git.spec.in
> @@ -126,10 +126,10 @@ # These are no files in the root package
>  
>  %files arch
>  %defattr(-,root,root)
> -%doc Documentation/*arch*.txt
> -%{_bindir}/*arch*
> -%{!?_without_docs: %{_mandir}/man1/*arch*.1*}
> -%{!?_without_docs: %doc Documentation/*arch*.html }
> +%doc Documentation/git-archimport.txt
> +%{_bindir}/git-archimport
> +%{!?_without_docs: %{_mandir}/man1/git-archimport.1*}
> +%{!?_without_docs: %doc Documentation/git-archimport.html }
>  
>  %files email
