From: Jakub Narebski <jnareb@gmail.com>
Subject: [gsoc2012 wiki PATCH] "`git instaweb --serve`" project
Date: Sat, 10 Mar 2012 01:46:56 +0100
Message-ID: <1331340416-13359-1-git-send-email-jnareb@gmail.com>
References: <20120302091114.GA3984@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 01:47:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6ASv-0006u3-HL
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 01:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758494Ab2CJArR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 19:47:17 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:53264 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756028Ab2CJArQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 19:47:16 -0500
Received: by wejx9 with SMTP id x9so1529580wej.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 16:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BnNvUcwM24/a4463Cp4pKTgmtXhtHdNQ685SgLNRA5E=;
        b=xe5rtcirNrafUehlpdLWF5tUV976Pc8THtqSrf0lTTjlpp+ROqRyJRL7ZA5ljOdch8
         k0tOkBX08Z4Xj/7s5zm4oPhmj9knxRvTEiz/bFekUwuXp3/sajqwbiR5e0yCWl8ZaqkZ
         Pq46Gd5wPXvOwer4L3rOj72jdKzAR0QUo+5nZbPSUMveWVnPDIn3sdYW4SlyxQ85z23z
         zNcgc23B2Z6EYXxzByTreOjgRlmDXtzoctO+AlfXUf9I8VRJV/hzVRyLJg0L0RPzYigy
         nXMjk7UCbGvreOyhHbBTJ5+K78KakB1nYUwgoFb/6AyCpscW0SoPHaol1TML+nJF8OM8
         MnIQ==
Received: by 10.216.131.24 with SMTP id l24mr2568362wei.76.1331340434475;
        Fri, 09 Mar 2012 16:47:14 -0800 (PST)
Received: from localhost.localdomain (abvu37.neoplus.adsl.tpnet.pl. [83.8.218.37])
        by mx.google.com with ESMTPS id k6sm9529127wiy.7.2012.03.09.16.47.12
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 16:47:13 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <20120302091114.GA3984@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192761>

---
I don't know if "git-serve" is something that would be realy useful,
or just checkmark in the comparison of Git and Mercurial.

 SoC-2012-Ideas.md |   54 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/SoC-2012-Ideas.md b/SoC-2012-Ideas.md
index 95411ec..884237e 100644
--- a/SoC-2012-Ideas.md
+++ b/SoC-2012-Ideas.md
@@ -318,6 +318,60 @@ Programming language: JavaScript
 Proposed by: Jakub Nar=C4=99bski =20
 Possible mentor(s): Jakub Nar=C4=99bski
=20
+`git instaweb --serve`
+----------------------
+
+[git-instaweb] is a tool for browsing a repository (in gitweb) with
+a web browser.  To use it, simply run `git instaweb` inside
+repository.  It would set up gitweb and a web server, and by default
+also run a web browser.  Web interface would be available at
+`http://localhost:1234`.
+
+For informal, ad-hoc sharing it would be nice if there was an option
+to `git instaweb` that would make it also allow remote machines
+to **pull** from you (via HTTP), similar to [hg serve] command in
+Mercurial version control system.
+
+git-instaweb supports many web servers.  Currently apache2, lighttpd,
+mongoose, plackup and webrick are supported.  It is not necessary to
+implement support for `--serve` in all of them.
+
+The project would consist of the following steps:
+
+ * Configure web server to run `git-http-backend` CGI program to serve
+   git repositories over HTTP.  It should probably allow by default
+   only read-only use.
+
+ * Configure gitweb to show fetch URL in 'summary' page.
+
+ * If possible for given web server (and with available modules),
+   configure it so that "smart" HTTP server and gitweb share common
+   URL (are available under the same URL).
+
+ * If possible use mechanism native for a web server used, for example=
=20
+   [Plack::App::GitSmartHttp] for 'plackup' web server, or [grack]
+   with WEBrick.
+
+ * Optionally: add support for pushing (disabled by default).
+
+ * Optionally: add documentation about using `git instaweb` to
+   "[Git User's Manual]" (or one of tutorials), similar to appropriate
+   chapter in [hgbook] ("Mercurial: The Definitive Guide").
+
+The minimum would be to implement pull support under different URL
+than web interface, and only for one web server.
+
+Programming language: shell script =20
+Proposed by: Jakub Nar=C4=99bski =20
+Possible mentor(s): Jakub Nar=C4=99bski, Eric Wong, ...
+
+[git-instaweb]: http://schacon.github.com/git/git-instaweb.html
+[hg serve]: http://mercurial.selenic.com/wiki/hgserve
+[Plack::App::GitSmartHttp]: http://search.cpan.org/perldoc?Plack::App:=
:GitSmartHttp
+[grack]: https://github.com/schacon/grack
+[Git User's Manual]: http://schacon.github.com/git/user-manual.html
+[hgbook]: http://hgbook.red-bean.com/read/collaborating-with-other-peo=
ple.html#sec:collab:serve
+
 Finishing network support for libgit2
 -------------------------------------
=20
--=20
1.7.9
