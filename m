From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: disable sub/superscript characters ^/~
Date: Tue, 16 Sep 2008 14:47:18 +0200
Message-ID: <1221569238-29263-1-git-send-email-trast@student.ethz.ch>
References: <7vy71s7b26.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <junio@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 14:49:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfZyq-0000DL-5K
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 14:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbYIPMrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 08:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbYIPMrX
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 08:47:23 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:12166 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbYIPMrW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 08:47:22 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Sep 2008 14:47:21 +0200
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 16 Sep 2008 14:47:20 +0200
X-Mailer: git-send-email 1.6.0.2.469.g5ab27
In-Reply-To: <7vy71s7b26.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 16 Sep 2008 12:47:20.0827 (UTC) FILETIME=[5BECACB0:01C917FA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95997>

Disables the special meaning of ^ and ~ as per the Asciidoc FAQ,

  http://www.methods.co.nz/asciidoc/faq.html#_how_can_i_disable_a_quoted_text_substitution

Signed-off-by: Thomas Rast <trast@student.ethz.ch>

---

Junio C Hamano wrote:
> Sorry, but this unfortunately does not seem to help asciidoc 8.2.5 on FC9
> at all, which is the combination used at k.org machine that feeds the
> html/man branches to everybody else.

This seems to do the trick on 8.2.5 here.

Unfortunately, the changelog for 8.0 says that setting the quote
character to an empty replacement is new in 8.0 (I can't test with
7.x), and I cannot find a way to make an 'if version >= 8' block.
(Why does it have ifdef but no if?)

So maybe if someone sees a way to do this version-dependent, then we
can combine the two approaches and work with both 7.x and 8.x.

- Thomas


 Documentation/asciidoc.conf |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 40d43b7..37bf195 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -15,6 +15,11 @@ startsb=&#91;
 endsb=&#93;
 tilde=&#126;
 
+# disable sub/superscripts -- they collide with our ref notation
+[quotes]
+^=
+~=
+
 ifdef::backend-docbook[]
 [linkgit-inlinemacro]
 {0%{target}}
-- 
tg: (5ab2757..) t/doc-disable-tilde (depends on: next)
