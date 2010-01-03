From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 0/4 (resent)] Miscelanous gitweb improvements from J.H.
Date: Sun,  3 Jan 2010 17:07:26 +0100
Message-ID: <1262534850-24572-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 03 17:08:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRSzy-0008Jq-34
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 17:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab0ACQHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 11:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438Ab0ACQHl
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 11:07:41 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:63992 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab0ACQHk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 11:07:40 -0500
Received: by fxm25 with SMTP id 25so8133186fxm.21
        for <git@vger.kernel.org>; Sun, 03 Jan 2010 08:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=WFyFHWhchbt4EOfkqDorrPTiGPu9jgL90gy4fiA5rjs=;
        b=qrxGgm/iC/9qjBfVRZEJ4oQ9Tkc9LxkpBSqzMoqCu72yxol/2CCYJSVjsqmNvvuuKj
         aLagSqlcxa8bKoej1DEYa0VDZW++HqpeCD69vheh1b/ShDTLNU7JpWdRwJ8IJlAuBevB
         G5n0J8zNbzqqT/najRqGRZTFdwIgTGdMhbtos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=V/kx7UTb+vLtdhJgeDZAgmdvYecOTE3EOl6ZDa9keP/d9JylhLHyiOo05wOFFqz8/c
         mAyaAdM2io3K3wj4JCEdsnmVmZ55nhhP+O8/RPGzNTKOkc3dRyasiaws7xql7bMQwKS/
         Fhkkok18AkkLus91/5uS7naQrXquW2GCIh4DU=
Received: by 10.103.50.33 with SMTP id c33mr4753656muk.75.1262534858676;
        Sun, 03 Jan 2010 08:07:38 -0800 (PST)
Received: from localhost.localdomain (abvk210.neoplus.adsl.tpnet.pl [83.8.208.210])
        by mx.google.com with ESMTPS id g1sm1607328muf.14.2010.01.03.08.07.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Jan 2010 08:07:37 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136077>

This is resend of early part of "[PATCH 0/6] Gitweb caching changes v2"
thread by John 'Warthog9' Hawley (J.H.),
  Message-ID: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
  http://thread.gmane.org/gmane.comp.version-control.git/135052

or alternatively
  git://git.kernel.org/pub/scm/git/warthog9/gitweb.git gitweb-ml-v2

with a few modifications of my own.  Those patches were send originally as
responses in the mentioned thread, for further comments from original
author.  As the discussion didn't pick up (because of kernel.org upgrade, and
perhaps due to end-of-year stuff), I am resending those patches in a
separate thread for a better visibility; only comments are changed.

This series of patches is rebased on top of commit 37bae10
(Merge branch 'maint', 2009-12-31) in 'master' branch.


Change that apply to all patches in series: 
* moving from "GITWEB - " to "gitweb: " as subsystem prefix
* changing author to John 'Warthog9' Hawley <warthog9@kernel.org>
  (it was John 'Warthog9' Hawley <warthog9@eaglescrag.net>)
* add signoff or change it to John 'Warthog9' Hawley <warthog9@kernel.org>,
  and of course add my own signoff.


I have included reply to neither "GITWEB - File based caching layer"
nor "GITWEB - Separate defaults from main file" in this thread/series.

I haven't included the main point of the whole series, namely adding
response caching layer in the form that is used in git.kernel.org, because
I think this patch should be split into smaller parts, and unit-tested.
As it is now it is a bit of mess.  I have done patch which makes gitweb
always use explicit filehandle when printing (simplifying a bit it
replaces 'print <something>' by 'print {$out} <something>', with $out set
to \*STDOUT), as a patch that prepares for (optional) gitweb caching, while
not affecting throughput, latency and memory consumption when caching is
disabled, as opposed to original solution by J.H. of always storing whole
response in scalar and writing it at the end. 

I haven't included splitting of gitweb_defaults.perl off gitweb.perl, as it
was after large and invasive gitweb caching patch, it would require
substantial changes to gitweb tests upfront (by testing built gitweb.cgi and
not source gitweb.perl), and needs fixing of Makefile to actually work
reliably (we could have to process both gitweb.perl and
gitweb_defaults.perl, while provided Makefile process only the file which
triggered the rule... I think).


I am not sure if 'gitweb: Add option to force version match' is a good
solution to the problem it tires to address, i.e. if it is worth having, 
and I am not sure if I did 'gitweb: Makefile improvements' correctly.

John 'Warthog9' Hawley (4):
  gitweb: Load checking
  gitweb: Add option to force version match
  gitweb: Optionally add "git" links in project list page
  gitweb: Makefile improvements

 Makefile           |   65 +++++---------------------
 gitweb/Makefile    |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/README      |   14 +++++-
 gitweb/gitweb.perl |   80 ++++++++++++++++++++++++++++++--
 4 files changed, 230 insertions(+), 58 deletions(-)
 create mode 100644 gitweb/Makefile

John, any comments?

-- 
Jakub Narebski
ShadeHawk or jnareb on #git
Poland
