From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] Remove PDF version of manual from being build and installed
Date: Fri, 1 Jun 2007 18:24:07 +0200
Message-ID: <200706011824.08148.jnareb@gmail.com>
References: <200705281054.05376.jnareb@gmail.com> <200705300131.17137.jnareb@gmail.com> <20070531131615.GA27044@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Jun 02 00:26:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuFZZ-00024O-P0
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 00:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758069AbXFAWZz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 18:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758063AbXFAWZz
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 18:25:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:53670 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757995AbXFAWZy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 18:25:54 -0400
Received: by ug-out-1314.google.com with SMTP id j3so325507ugf
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 15:25:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OQEVx6w+77zZ6QX19klrxl6oo93obWXgdUfLWxdhVIqjLhEXoh0iU9CnQmpz0lddJpqS9+9J2BbRsLbXQTR/bhDIhxctFMWYmUKY5eeFECDiqntjWIaZIgy3WEL4VvoowMAY3ujgAyhCT3yIgidY2wnZKJ1FqKT8K63g7zvYqAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=d268kihqobPGW06d/MqSv9wAMLmHIBviWjP9l3oKnY0KNQr5ZkFf6/6ppoPy3v/hT/YYH1Poyj3tAApJLfiFThQHJzyFkSkUiaIhXzCeiWCBbn8pRshoPN088q5pDrsgkHMpp9nh+NpfyLMRpKh0GrkMiZx2BrGLHzbFIIXIzw4=
Received: by 10.66.254.2 with SMTP id b2mr1101484ugi.1180736751594;
        Fri, 01 Jun 2007 15:25:51 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id g1sm1047910muf.2007.06.01.15.25.48;
        Fri, 01 Jun 2007 15:25:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070531131615.GA27044@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48894>

Because PDF version of "The tig Manual" doesn't offer anything new
that is not present in HTML version, and building PDF requires
additional tools (docbook2pdf) and their dependencies present, remove
it from tig rpm.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Jakub Narebski <jnareb@gmail.com> wrote Wed, May 30, 2007:
> On Tue, 29 May 2007, Jonas Fonseca wrote:
>> Jakub Narebski <jnareb@gmail.com> wrote Mon, May 28, 2007:
>>
>>> I think we can skip generation of manual.pdf, and generate it only on
>>> request (e.g. "make doc-pdf"), or using doc-man and doc-html in place
>>> of doc in the spec file... but this is better left for the next
>>> commit.
>> 
>> Good idea, PDF is not essential and probably suboptimal to either of the
>> HTML versions of the manual.
>
> And it is very easy to implement: just replace 'doc' in make invocation
> in tig.spec.in by the 'doc-man doc-html'.

This patch (commit) does just that.


On Thu, 31 May 2007, Jonas Fonseca wrote:

> I will try to correct this together with the no-PDF doc-building.

I hope we didn't end up duplicating our efforts.

 tig.spec.in |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tig.spec.in b/tig.spec.in
index 2ce6cdb..b7753fd 100644
--- a/tig.spec.in
+++ b/tig.spec.in
@@ -10,7 +10,7 @@ Group: 		Development/Tools
 Vendor: 	Jonas Fonseca <fonseca@diku.dk>
 URL: 		http://jonas.nitro.dk/tig/
 Source: 	http://jonas.nitro.dk/tig/releases/%{name}-%{version}.tar.gz
-BuildRequires: 	ncurses-devel%{!?_without_docs:, xmlto, asciidoc > 6.0.3, /usr/bin/docbook2pdf}
+BuildRequires: 	ncurses-devel%{!?_without_docs:, xmlto, asciidoc > 6.0.3}
 BuildRoot: 	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
 Requires: 	git-core, ncurses
 
@@ -31,7 +31,7 @@ Using it as a pager, it will display input from stdin and colorize it.
 CFLAGS="$RPM_OPT_FLAGS -DVERSION=tig-%{version}-%{release}"
 %{__make} %{_smp_mflags} \
 	prefix=%{_prefix} \
-	all %{!?_without_docs: doc}
+	all %{!?_without_docs: doc-man doc-html}
 
 %install
 [ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT
@@ -49,8 +49,11 @@ CFLAGS="$RPM_OPT_FLAGS -DVERSION=tig-%{version}-%{release}"
 %doc README COPYING INSTALL SITES BUGS TODO tigrc
 %{!?_without_docs: %{_mandir}/man1/*.1*}
 %{!?_without_docs: %{_mandir}/man5/*.5*}
-%{!?_without_docs: %doc *.html *.pdf}
+%{!?_without_docs: %doc *.html}
 
 %changelog
+* Fri Jun  1 2007 Jakub Narebski <jnareb@gmail.com>
+- Remove PDF version of manual from being build and installed
+
 * Mon May 28 2007 Jakub Narebski <jnareb@gmail.com>
 - Initial tig spec file
-- 
1.5.2
