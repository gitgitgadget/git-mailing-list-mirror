X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Documentation: Update information about <format> in git-for-each-ref
Date: Sat, 28 Oct 2006 19:30:05 +0200
Message-ID: <200610281930.05889.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 28 Oct 2006 17:29:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=D2vyzIKAR6qA7T5SyLRIswbpqLLgKo0fSkARzLySdz9lyxls56om6a8k/KT7QoCakpQbFEIi3tcwQ1vdfOfT558SPV+2tNQ7kWxImuytc0vV1THyLaHbsgwXS5wtr+xLwlF5jVKl7Dc7mOxx/bIJkM1hz/hft2wLYoQsgZp5YFQ=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30382>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gds04-0001EN-HC for gcvg-git@gmane.org; Sat, 28 Oct
 2006 19:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751175AbWJ1R3U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 13:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWJ1R3U
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 13:29:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:19193 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1751175AbWJ1R3T
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 13:29:19 -0400
Received: by ug-out-1314.google.com with SMTP id 32so897043ugm for
 <git@vger.kernel.org>; Sat, 28 Oct 2006 10:29:18 -0700 (PDT)
Received: by 10.67.97.18 with SMTP id z18mr1457207ugl; Sat, 28 Oct 2006
 10:29:18 -0700 (PDT)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id z40sm847961ugc.2006.10.28.10.29.17; Sat, 28 Oct
 2006 10:29:17 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Update information about value of <format> used when it is left
unspecified.  Add information about `%%` and `%xx` interpolation
(URL encoding).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Could any of you review this, fix wording (if needed)?


By the way one thing missing from git-for-each-ref to use it
in gitweb without changing its output is ablility to sort on
"epoch", i.e. taggerdate for tags and committerdate for commits.
This is needed to sort heavyweight and lightweight tags together
on epoch in "summary" and "tags" views in gitweb. (It is not
needed for heads/branches, but it is the tags sorting that
cripples gitweb "summary" view performance.)

We could either add "fake" field `date` which will be `taggerdate`
for tags and `committerdate` for commits, and empty for trees
and blobs, or allow in <key> for more than one field to be
specified.


I also wish for change of %(field) to %{field}, adding %nn{field}
and %-nn{field} field width specifiers, committerepoch and
committertz fields (and equivalent for tagger and author) or
%{committer:date} like field-format specifiers. And for peace
on Earth while at it... ;-)

 Documentation/git-for-each-ref.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index d5fdcef..4af1ebf 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -38,7 +38,11 @@ OPTIONS
 	is prefixed with an asterisk (`*`) and the ref points
 	at a tag object, the value for the field in the object
 	tag refers is used.  When unspecified, defaults to
-	`%(refname)`.
+	`%(objectname) SPC %(objecttype) TAB %(refname)`.
+	It also interpolates `%%` to `%`, and `%xx` where `xx`
+	are hex digits interpolates to character with hex code
+	`xx`; for example `%00` interpolates to `\0` (NUL),
+	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
 
 <pattern>::
 	If given, the name of the ref is matched against this
-- 
1.4.3.3
