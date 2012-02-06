From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/4] Deprecate "not allow as-is commit with i-t-a entries"
Date: Mon,  6 Feb 2012 17:57:31 +0700
Message-ID: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 11:52:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuMBl-0004ug-BA
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 11:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422Ab2BFKwm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 05:52:42 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40579 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906Ab2BFKwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 05:52:41 -0500
Received: by pbdu11 with SMTP id u11so4870137pbd.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 02:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=FlSe8eyddjBXz4svXozdE6WmBclCnfGEhv0oO2/4Neg=;
        b=aZ7m+HoBhvahovxkDzpSBsgiLHLekprjNYhZ8tmjdiv2+RbzVXRkDXHaIlNeetWhQl
         odj1qyZoTVtfyPYxUXwHzzsWyXqr5rWdmLZ7ZyyfpKVPdzTOJpirjn9IJPwPoCV4Jk0k
         iMMthfUKBoTyO9zsoe9d5Uo2Ip6PrbzwWL3hg=
Received: by 10.68.225.39 with SMTP id rh7mr4125513pbc.104.1328525561429;
        Mon, 06 Feb 2012 02:52:41 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id b7sm38338833pba.2.2012.02.06.02.52.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Feb 2012 02:52:39 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 06 Feb 2012 17:57:35 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190062>

By the end of this series "git commit -m foo" will proceed regardless
intent-to-add (aka "git add -N") entries. commit.ignoreIntentToAdd is
used as transitiono config key.

The plan is in 2/4. I set 1.8.0 as the first deprecation date, but of
course it's just a suggestion. The second deprecation date might be
1.8.5, long enough for users to adapt to the new behavior.

=2E.or we switch back half way because we find current behavior does
make more sense.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  cache-tree: update API to take abitrary flags
  commit: introduce a config key to allow as-is commit with i-t-a
    entries
  commit: turn commit.ignoreIntentToAdd to true by default
  commit: remove commit.ignoreIntentToAdd, assume it's always true

 Documentation/git-add.txt |   12 ++++++++++--
 builtin/commit.c          |    9 ++++++---
 cache-tree.c              |   35 +++++++++++++++++------------------
 cache-tree.h              |    5 ++++-
 merge-recursive.c         |    2 +-
 t/t2203-add-intent.sh     |   21 ++++++++++++++++++++-
 test-dump-cache-tree.c    |    2 +-
 7 files changed, 59 insertions(+), 27 deletions(-)

--=20
1.7.8.36.g69ee2
