From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] fast-import: Document the core.bigFileThreshold
	configuration setting
Date: Mon, 1 Feb 2010 07:41:33 -0800
Message-ID: <20100201154133.GF8916@spearce.org>
References: <20100129012350.GD20488@spearce.org> <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com> <20100129183705.GB22101@spearce.org> <7vockc45ut.fsf@alter.siamese.dyndns.org> <7vmxzw15dt.fsf@alter.siamese.dyndns.org> <7v3a1oyrkp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 16:41:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbyPI-00012V-FW
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 16:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab0BAPli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 10:41:38 -0500
Received: from mail-yw0-f173.google.com ([209.85.211.173]:52615 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768Ab0BAPlh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 10:41:37 -0500
Received: by ywh3 with SMTP id 3so1667922ywh.22
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 07:41:36 -0800 (PST)
Received: by 10.151.3.11 with SMTP id f11mr6454868ybi.108.1265038895864;
        Mon, 01 Feb 2010 07:41:35 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 8sm1728715yxg.24.2010.02.01.07.41.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 07:41:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v3a1oyrkp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138616>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Junio C Hamano <gitster@pobox.com> wrote:
 > You may want to add the new option to the output from "cmd -h" and
 > probably description of the configuration in the doc before any of this
 > gets official.

 Doc patch.  :-)

 Feel free to squash, or to apply as its own change, I don't care
 either way.

 Documentation/config.txt |   14 ++++++++++++++
 fast-import.c            |    2 +-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f7728ec..b16a20b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -409,6 +409,20 @@ You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
+core.bigFileThreshold::
+	Files larger than this size are stored deflated, without
+	attempting delta compression.  Storing large files without
+	delta compression avoids excessive memory usage, at the
+	slight expense of increased disk usage.
++
+Default is 512 MiB on all platforms.  This should be reasonable
+for most projects as source code and other text files can still
+be delta compressed, but larger binary media files won't be.
++
+Common unit suffixes of 'k', 'm', or 'g' are supported.
++
+Currently only linkgit:git-fast-import[1] honors this setting.
+
 core.excludesfile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', git looks into this file for patterns
diff --git a/fast-import.c b/fast-import.c
index 8055f73..1bcf3bb 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2613,7 +2613,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 }
 
 static const char fast_import_usage[] =
-"git fast-import [--date-format=f] [--max-pack-size=n] [--depth=n] [--active-branches=n] [--export-marks=marks.file]";
+"git fast-import [--date-format=f] [--max-pack-size=n] [--big-file-threshold=n] [--depth=n] [--active-branches=n] [--export-marks=marks.file]";
 
 int main(int argc, const char **argv)
 {
-- 
1.7.0.rc0.170.g7207c

-- 
Shawn.
