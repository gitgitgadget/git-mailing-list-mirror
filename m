Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C763502B9
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476306; cv=none; b=VZNMRz3kdB6/VWLDW1yyd0NwjNcgX8zLyNvGSww5khHPWQ/gDQNxi3A5j3tReUbfelnmoO4gpr2XcXDKhFGoDqPkK4Sp2XkbmBAFjDkLpCdm2EX3N2rZ4X8dDq221qTp4/oVEHFJSAj0oW2dQrIMxdfyeGCBw6tkdyPLyfkoNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476306; c=relaxed/simple;
	bh=QQKzUigW243GS9Z3k2q/oWo3ALMgTqq4vkSeWUG6hWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVqyi4LNqLYMVd73b8NLmNN6yYQ6Jny+CE62zZMwTsZYvrO7MgmLRvmLSl4UvKTFWxuIEMw1bivvupfsO3JaA36jl2LCzGp7sH3H1RYam9WMEouEGvdwCd8JtPFanf7dchBcjCAVYL1jbcrImTf+0z0iIgTYxUdmoy3nvsQoYGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjNtU5hj; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjNtU5hj"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so28469665e9.3
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 06:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770476304; x=1771081104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KyH650XLR9tDBR5m0Q7HeYZt3Clv40gRe90Y0hhESBg=;
        b=IjNtU5hja7qX2mT6g5b19cgUitPGPzN+AFOWRkqn4jpRq697PjfDOU1DiKChz9P0tG
         2jVKN9dS/v4uq5RMYmWYwMGCMrJsdjXy6w4kQzK2XR5Lf7Gt295jDOixz5ehCJbzs+z1
         IRdRzDVXsW1OyJ0THaou/YBT8pcn3p6eFKmbGd1c/Fc/Zj6oNiEDzDgoN/MyvKeCVoeT
         +b7GTE8NshVHr2KWcVnmCLNH5lMBc+0xt0LB90ic9R+ETDOfreg805eY+jOPnurmSZmB
         gBWG+JpMlcuBRCtcwAW6EGNWteYn6JzS8PZwFcF7LVOY1xaxF+//MMY7D8vickK9N4ie
         BsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770476304; x=1771081104;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyH650XLR9tDBR5m0Q7HeYZt3Clv40gRe90Y0hhESBg=;
        b=bhfMQYKbj7euK+vc05WLKN63RWY+qDVRNsBiC7IFU4Spi7FOQ2LlGvNkky+51CqdeQ
         GVHbVvJkwFuTncYBl8zBebLN58xalVLZzSgJvWnV6h81J4XC7sIrHOEHQYPlDe2oTj4W
         iDGivncQG0/Hua9BFYajpCvzPIl7GnsNToB4gO9x3P9K00iVoQzqYJO4RPF8ZvI9snKT
         ePF1bvwmOvthDp21AIGe+M5s5tr5jWYVVGbrdMOjUvkmPeJaRLXD/YVxDKA5OWixmy5/
         vdSReHyUznyBpgwMkjM/37M+4S/XAyLkAYR23J/D4ifhI47oj+7FNChupoJ3aI60qQAr
         lfTA==
X-Gm-Message-State: AOJu0YzEw+oynIFly4KL8mNC64vG5PcSst2vSqirFhkuRG73OaAmHMr0
	yk2uz3tJdsv8+kvfEx9hESOBuny8csxTD1my7MulWsgJ3rsBoW7rJmOdpmy7kJIM
X-Gm-Gg: AZuq6aL3k6pGhrFVX+/uOSl93RU5Xm3hAuIoOyKIh5c6TvHkhRWICe/4FulAOOlkGWc
	Ixhczy4IjbJLDUuQ+s4/frivDk533l17BETr9IYfgMzTaCsI5p7VB3WgW17azX5FXRddX1DF3HM
	wOYcsVSrxm6cNWVoKMKwheJX839wVixxQSFgWEvePrA/jFn+/CPLC9MTXsqWsddyC/8Mas0QW8Z
	iw+wQoUN5depwBXSSddvOmOCXq6jlLreIlaBs6ez4XDe3/rM6ISxMIPcvMxs2Nf73jO8MWVDY+A
	jXEhkUphRC8Xm8dZgQyIRk85mtYJt4veX6s5ZZHiJK4aR2BLn/UWRzJJFUfdvi1otzgAlaK1LMg
	6qyp9SzY5Ak/n/pyyhFJo5pVX/UhKr15Da22E9dK0ZpwBwkpA7pFKT1R5Vr9lUXDXN1L7GzCH7J
	+i1RJBJr1HFyYjTHQ=
X-Received: by 2002:a05:600c:c84:b0:480:6941:d38c with SMTP id 5b1f17b1804b1-48320221064mr78898975e9.29.1770476303957;
        Sat, 07 Feb 2026 06:58:23 -0800 (PST)
Received: from berwick ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd3b8sm13780317f8f.11.2026.02.07.06.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 06:58:23 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Matthias Beyer <mail@beyermatthias.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	pyokagan@gmail.com,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/3] templates: detect commit messages containing diffs
Date: Sat,  7 Feb 2026 14:58:01 +0000
Message-ID: <e75978b959157ddc235465b3cf5cf95aaf3d75ff.1770476279.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1770476279.git.phillip.wood@dunelm.org.uk>
References: <20260206090358.GA2761602@coredump.intra.peff.net> <cover.1770476279.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If a commit message contains a diff that is not indented then "git
am" will treat that diff as part of the patch rather than as part
of the commit message. This allows it to apply email messages that
were created by adding a commit message in front of a regular diff
without adding the "---" separator used by "git format-patch". This
often surprises users [1-4] so add a check to the sample "commit-msg"
hook to reject messages that would confuse "git am".

Detecting if the message contains a diff is complicated by the hook
being passed the message before it is cleaned up so we need to ignore
any diffs below the scissors line. There are also two possible
config keys to check to find the comment character at the start
of the scissors line.

[1] https://lore.kernel.org/git/bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm
[2] https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org/
[3] https://lore.kernel.org/git/d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br/
[4] https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJDxAs9u=FGpHQTkjE-guhwkya0DRVA6g@mail.gmail.com/

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 templates/hooks/commit-msg.sample | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/templates/hooks/commit-msg.sample b/templates/hooks/commit-msg.sample
index b58d1184a9d..099cc58c303 100755
--- a/templates/hooks/commit-msg.sample
+++ b/templates/hooks/commit-msg.sample
@@ -15,10 +15,37 @@
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
 # grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
 
-# This example catches duplicate Signed-off-by lines.
+# This example catches duplicate Signed-off-by lines and messages that
+# would confuse 'git am'.
+
+ret=0
 
 test "" = "$(grep '^Signed-off-by: ' "$1" |
 	 sort | uniq -c | sed -e '/^[ 	]*1[ 	]/d')" || {
 	echo >&2 Duplicate Signed-off-by lines.
-	exit 1
+	ret=1
 }
+
+comment_re="$(
+	{
+		git config --get-regexp "^core\.comment(char|string)\$" ||
+			echo '#'
+	} | sed -n -e '
+		${
+			s/^[^ ]* //
+			s|[][*./\]|\\&|g
+			s/^auto$/[#;@!$%^&|:]/
+			p
+		}'
+)"
+line="$(sed -n -e "/^${comment_re} -\{8,\} >8 -\{8,\}\$/q
+		   /^diff -/{p;q;}
+		   /^Index: /{p;q;}" "$1")"
+if test -n "$line"
+then
+	echo >&2 "Message contains a diff that will confuse 'git am'."
+	echo >&2 "To fix this indent the diff."
+	ret=1
+fi
+
+exit $ret
-- 
2.52.0.362.g884e03848a9

