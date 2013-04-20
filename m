From: Simon Ruderich <simon@ruderich.org>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Sat, 20 Apr 2013 16:00:52 +0200
Message-ID: <20130420140051.GB29454@ruderich.org>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 16:01:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTYLn-0004Tf-Pe
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 16:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101Ab3DTOAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 10:00:55 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:43904 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244Ab3DTOAz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 10:00:55 -0400
Received: from localhost (pD9E968B7.dip0.t-ipconnect.de [::ffff:217.233.104.183])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Sat, 20 Apr 2013 16:00:52 +0200
  id 0000000000000022.0000000051729F94.00007F8D
Content-Disposition: inline
In-Reply-To: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221853>

On Thu, Apr 11, 2013 at 11:36:26AM +0100, John Tapsell wrote:
> Is there a way to make --cc default?

If you use aliases, something like this is easy:

    git config --global --add alias.lp 'log --patch --cc'

I use aliases heavily, so that's my fix for now.


But I think the current behaviour is unexpected for most (new?)
users (including me). I thought -p would display all changes in
all commits, including merges.

I guess changing -p's default behaviour to imply --cc is
problematic, so I think we should document that -p doesn't
generate patches for merges. Maybe something like this:

-- 8< --
Subject: [PATCH] Documentation/diff-options.txt: -p doesn't display merge changes

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 Documentation/diff-options.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 104579d..cd35ec7 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -24,6 +24,10 @@ ifndef::git-format-patch[]
 --patch::
 	Generate patch (see section on generating patches).
 	{git-diff? This is the default.}
+ifdef::git-log[]
+	Changes introduced in merge commits are not displayed. Use `-c`,
+	`--cc` or `-m` to include them.
+endif::git-log[]
 endif::git-format-patch[]
 
 -U<n>::
-- 
1.8.2.1.513.gdedbb69.dirty

-- 8< --

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
