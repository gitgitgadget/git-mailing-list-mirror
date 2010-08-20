From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/17] Documentation: unbreak regex in show-ref manual
Date: Fri, 20 Aug 2010 05:23:54 -0500
Message-ID: <20100820102354.GC10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOtT-0002jC-LW
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab0HTKcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 06:32:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58916 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab0HTKcH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 06:32:07 -0400
Received: by iwn5 with SMTP id 5so684461iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/0jH74iUsSH5uFLoZwCe5z9eD1qIuB4HmqDpBFVYRKc=;
        b=i9frL0B2EhERR5fcsXLg4chkDvPKFn9y9lkPu2ZxS0swEU+Q5dAc1WmS5Hkd6Swouk
         QQP7hWbHoxdNVor+lFmlEQZZTWsNFjBl5UH9YlK/KzJSshnsKgUK7vOGE/99WqOht8Ul
         0CUDaX9DlMImHpuuIoJ8aBcMLUaHTtkjol76k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kxJvA8CuOv5Pv6q/3RShDQXd+gYMgXwTGemm6ftLsHaVyZAI8mhje+SCxbKanEqVxh
         gt4tJ4OPwM+T5qYkL9ppT/BV9FCicSaT9+fMUyhGAm6041iR2BubHWD4fqortbd2EjpI
         Dq9p7i/pxJ4PeDr2hN9nYBLg9Ugav3eViKdDA=
Received: by 10.231.187.194 with SMTP id cx2mr1296946ibb.165.1282299935372;
        Fri, 20 Aug 2010 03:25:35 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm2492892ibh.4.2010.08.20.03.25.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:25:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154001>

I am not sure why, but the regular expression "(?:\^\{\})" gets
rendered by asciidoc as "(?:\{})".  The intent seems to be a regex
matching the literal string "^{}", so this rewrites the markup to
produce "(?:\^{})" as output.

Cc: Julian Phillips <julian@quantumfyre.co.uk>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/asciidoc.conf    |    1 +
 Documentation/git-show-ref.txt |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 6be8ba3..b5f0f29 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -16,6 +16,7 @@ plus=&#43;
 caret=&#94;
 startsb=&#91;
 endsb=&#93;
+backslash=&#92;
 tilde=&#126;
 apostrophe=&#39;
 backtick=&#96;
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 75780d7..4696af7 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -73,8 +73,8 @@ OPTIONS
 --exclude-existing[=<pattern>]::
 
 	Make 'git show-ref' act as a filter that reads refs from stdin of the
-	form "^(?:<anything>\s)?<refname>(?:\^\{\})?$" and performs the
-	following actions on each:
+	form "^(?:<anything>\s)?<refname>(?:{backslash}{caret}\{\})?$"
+	and performs the following actions on each:
 	(1) strip "^{}" at the end of line if any;
 	(2) ignore if pattern is provided and does not head-match refname;
 	(3) warn if refname is not a well-formed refname and skip;
-- 
1.7.2.2.536.g42dab.dirty
