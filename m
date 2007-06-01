From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/3] Include documentation sources for rpmbuild with '--without docs'
Date: Fri, 1 Jun 2007 18:27:30 +0200
Message-ID: <200706011827.31337.jnareb@gmail.com>
References: <200705281054.05376.jnareb@gmail.com> <200705300131.17137.jnareb@gmail.com> <20070531131615.GA27044@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Jun 02 00:26:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuFZa-00024O-96
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 00:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758353AbXFAW0G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 18:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757020AbXFAW0G
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 18:26:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:53670 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758293AbXFAW0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 18:26:03 -0400
Received: by ug-out-1314.google.com with SMTP id j3so325507ugf
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 15:26:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=I7DQK8kuOlEqcGHANH7bTT0kF7TvZz4DQKcegnmYKKbfiDQhm47kXWT6LE1KtuHICwMBt0RY14kF8Shmwsx+b6BMr6qTk9yOdvewdKGiF4fqz7OBby68d0LodKfW54AllNDBRH/2LFMQM0bgjuiaf5g25uoFPJWXxnzd3KqDy34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TxG8IJW9zggnWsXjsrFPXM9t5uqQttDcmqvzBni9O2olObgufTBwJ0Y9k3LzSw7nry3n1NfcHB+A9n68bSz8GdJPcwSnyzShjxQ/t1HJxAtfv3nefMWcvgb4E2pzVSPX+BxI+u5GFbjHaIFu8NdCNliV2CaD8i5ut1KGVSH2rB4=
Received: by 10.67.116.3 with SMTP id t3mr1070842ugm.1180736762450;
        Fri, 01 Jun 2007 15:26:02 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id g1sm1047910muf.2007.06.01.15.25.52;
        Fri, 01 Jun 2007 15:25:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070531131615.GA27044@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48893>

This includes _all_ documentation sources (and not only manual.txt) in
the rpm file build with '--without docs' option.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Jakub Narebski <jnareb@gmail.com> wrote Wed, May 30, 2007:
> On Tue, 29 May 2007, Jonas Fonseca wrote:
>> Jakub Narebski <jnareb@gmail.com> wrote Mon, May 28, 2007:

>> I don't know if manual.txt should perhaps be included if
>> HTML and PDF files will not be generated.
>> 
>>> +%{!?_without_docs: %{_mandir}/man1/*.1*}
>>> +%{!?_without_docs: %{_mandir}/man5/*.5*}
>>> +%{!?_without_docs: %doc *.html *.pdf}
> 
> O.K. It would be as easy as %{?_without_docs: %doc *.txt}

Actually it does add more than manual.txt, it adds sources for
all tig documentation (including manpages).

This patch textually depends on earlier patch, but in fact
thic change is independent on previous one.

 tig.spec.in |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/tig.spec.in b/tig.spec.in
index b7753fd..2385fb8 100644
--- a/tig.spec.in
+++ b/tig.spec.in
@@ -1,5 +1,5 @@
 # -*- mode: rpm-spec-mode; encoding: utf-8; -*-
-# Pass '--without docs' to rpmbuild if you don't want the documentation
+# Pass '--without docs' to rpmbuild if you don't want the documentation to be build
 
 Summary: 	Tig: text-mode interface for git
 Name: 		tig
@@ -50,9 +50,11 @@ CFLAGS="$RPM_OPT_FLAGS -DVERSION=tig-%{version}-%{release}"
 %{!?_without_docs: %{_mandir}/man1/*.1*}
 %{!?_without_docs: %{_mandir}/man5/*.5*}
 %{!?_without_docs: %doc *.html}
+%{?_without_docs:  %doc *.txt}
 
 %changelog
 * Fri Jun  1 2007 Jakub Narebski <jnareb@gmail.com>
+- Include documentation sources for --without docs
 - Remove PDF version of manual from being build and installed
 
 * Mon May 28 2007 Jakub Narebski <jnareb@gmail.com>
-- 
1.5.2
