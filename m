From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] Fix documentation syntax of optional arguments in short options.
Date: Wed, 09 Apr 2008 06:24:48 +0200
Message-ID: <47FC4510.6080904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Apr 09 06:25:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjRsX-0001Zy-I4
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 06:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbYDIEZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 00:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbYDIEZA
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 00:25:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:63668 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbYDIEZA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 00:25:00 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2172131fgb.17
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 21:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=Rd2L1EkPsnzOv/N5q2X52afA+qa78ydQBLJSFhhjSQw=;
        b=xu5M3Rl5zcdu3B2KWD5U2zPX0gb3ul43kHLR/VejobK/QXsw6XnL1nJ6PA9klSooFlO4hbZokBKYfNFt7DHAYRYYmguAU8jeKgf5HCI3P+wus3h9HCQXsAywetUEiQq1mtbNbXqiCuZaYUJtfDKQAXHshtTkoZAexsTV9rm4b7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=cAgc3b2MPqgsLT/kq/vTDMfi2pBq6jZMd4An+QPt6kKlWC8sU+4bP4LD//g8QphBvrxxWWoWEQqePsbYbLdFNfu8Gvu5F0VNGsEazW0E54ffHFGI7/wUu3FU8dCg5m/1kQzHqBBFmk5//rM90NlhJ6qUSPKXGpqL7UG+95aLV0k=
Received: by 10.82.151.9 with SMTP id y9mr1139840bud.52.1207715097938;
        Tue, 08 Apr 2008 21:24:57 -0700 (PDT)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id 31sm5901864nfu.24.2008.04.08.21.24.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Apr 2008 21:24:55 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79070>

When an argument for an option is optional, like in -n from git-tag,
putting a space between the option and the argument is interpreted
as a missing argument for the option plus an isolated argument.
Documentation now reflects the need to write the parameter following
the option -n, as in "git tag -nARG", for instance.

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
 Documentation/git-tag.txt |    4 ++--
 parse-options.c           |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index c22fb71..4b6fd90 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]  <name> [<head>]
 'git-tag' -d <name>...
-'git-tag' [-n [<num>]] -l [<pattern>]
+'git-tag' [-n[<num>]] -l [<pattern>]
 'git-tag' -v <name>...

 DESCRIPTION
@@ -57,7 +57,7 @@ OPTIONS
 -v::
 	Verify the gpg signature of the given tag names.

--n <num>::
+-n<num>::
 	<num> specifies how many lines from the annotation, if any,
 	are printed when using -l.
 	The default is not to print any annotation lines.
diff --git a/parse-options.c b/parse-options.c
index e87cafb..acf3fe3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -344,7 +344,7 @@ void usage_with_options_internal(const char * const *usagestr,
 			break;
 		case OPTION_INTEGER:
 			if (opts->flags & PARSE_OPT_OPTARG)
-				pos += fprintf(stderr, " [<n>]");
+				pos += fprintf(stderr, "[<n>]");
 			else
 				pos += fprintf(stderr, " <n>");
 			break;
-- 
1.5.3.4
