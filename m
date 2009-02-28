From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] autoconf: Add support for --infodir
Date: Sat, 28 Feb 2009 01:33:29 +0100
Message-ID: <20090228002550.22597.53878.stgit@localhost.localdomain>
References: <Tim Visher <tim.visher@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Tim Visher <tim.visher@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 01:35:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdDAw-0005W3-6b
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 01:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242AbZB1AeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 19:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754036AbZB1AeA
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 19:34:00 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:59668 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998AbZB1Ad7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 19:33:59 -0500
Received: by fxm24 with SMTP id 24so1292568fxm.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 16:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=qauprEGK9bYH8ffjNE7mKw4ndscEE04qnycBAbPUKhI=;
        b=uUWFXyA3lsey+LaA2ZYzPwZy2nqiOmNFJT0Y1biU6NQf/lAXB5A3gZJy7TsXn2OSlJ
         E+ho0XllgDtp1lXcH8ZIjWf5ybF/xydIjLbBV3DOffi97nCUnQK048syIDc5L4AT+tDi
         4c4haBA6pZwgIP6jGLRsGqPoARasqosvjRgmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=GaGMldecQBUEDHZTXPN+ddrpAE7KhxE9dreRnUB6bhagfmMk2oIAB21phhtoRUNZKh
         GPt0VGvDJT/U5atqQOpkTAG+pAB2Kam8imZUQSQRoBYFCIowRxGKsTw3AzLFYVX63hED
         bbLmqwVGGEc5xACulNVaTyMoMXOPIQ8sLzitI=
Received: by 10.103.131.18 with SMTP id i18mr1587806mun.120.1235781236658;
        Fri, 27 Feb 2009 16:33:56 -0800 (PST)
Received: from localhost.localdomain (abwe96.neoplus.adsl.tpnet.pl [83.8.228.96])
        by mx.google.com with ESMTPS id y37sm404721mug.53.2009.02.27.16.33.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Feb 2009 16:33:56 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1S0XUsF022672;
	Sat, 28 Feb 2009 01:33:35 +0100
In-Reply-To: <Tim Visher <tim.visher@gmail.com>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111727>

On Thu, 26 Feb 2009, Jeff King wrote:
> On Thu, Feb 26, 2009 at 09:48:29AM -0500, Tim Visher wrote:
> 
>> I'm working on getting git 1.6.2-rc2 built.  I have a bin, man, info,
>> and html directory in my home folder that I'd like to use as the
>> defaults for git.  I attempted to do this through
>> 
>>     make configure
>>     ./configure --XXdir=/full/path/to/dir
>>     make all man info html
>>     make install install-man install-info install-html
>> 
>> But other than the binaries (and I'm not even totally convinced they
>> got in correctly) and the man pages, everything else seems to be
>> attempting to go to the typical places in /usr/local.
>> 
>> What am I doing wrong?

Why don't you use simply --prefix=DIR?

> 
> The configure support is notoriously incomplete (AFAIK, very few of the
> active developers use it regularly). Probably you need something like
> this (but I didn't test it):
> 
> diff --git a/config.mak.in b/config.mak.in
> index 7cce0c1..505d5c7 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -18,6 +18,8 @@ datarootdir = @datarootdir@
>  template_dir = @datadir@/git-core/templates
>  
>  mandir=@mandir@
> +htmldir=@htmldir@
> +infodir=@infodir@
>  
>  srcdir = @srcdir@
>  VPATH = @srcdir@

Well, the infodir part works trivially, because autoconf (and
therefore ./configure script) has support for --infodir=DIR.
Below there is patch that adds that, with the commit message.

But it is more difficult with respect to --htmldir. I am not autoconf
hacker, so I don't know how to add support for having --htmldir=DIR in
./configure (in configure.ac).  What can be done is to derive htmldir
in config.mak.in from other sources, for example:

  htmldir=@datadir@/doc/git

or something like that.

-- >8 --
Now that we actually (can) install some info files, and that $infodir
is set and used in Makefile(s), let add support for --infodir=DIR
[PREFIX/info] ./configure option in config.mak.in.

Half of patch by Jeff King <peff@peff.net>m adding --XXdir support 
(the easy part: autoconf has --infodir, but not --htmldir).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 config.mak.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 7cce0c1..acff9ed 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -18,6 +18,7 @@ datarootdir = @datarootdir@
 template_dir = @datadir@/git-core/templates
 
 mandir=@mandir@
+infodir=@infodir@
 
 srcdir = @srcdir@
 VPATH = @srcdir@
