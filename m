From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/5] "git gc --auto" update
Date: Wed, 16 May 2012 19:29:32 +0700
Message-ID: <1337171377-26960-1-git-send-email-pclouds@gmail.com>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	Fernando Vezzosi <buccia@repnz.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 16 14:33:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUdQ7-00025e-Qa
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 14:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114Ab2EPMdb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 08:33:31 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39519 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757231Ab2EPMda (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2012 08:33:30 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1047153pbb.19
        for <git@vger.kernel.org>; Wed, 16 May 2012 05:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=In0zjMAYdbtvQEVJFu+3j5BpMGgjmCaqrMGzRKUVZvs=;
        b=Q8rfR3PTUrOWfDJrOY+e9UrqJKIJ5MbR4hoLSjYRzlfG8bg9pnIEv2tdkiEs+d4qR4
         9rGxbcqaiF9+gntUBaSt0XtJYuKXQwhhW4PSC0Xp7Rf9ehywew4if60mAhRVlAWjK8v+
         Qr+RFoxGd6/SvVwA0TVMn2ohAGqfcncxpAZvOqUwCl6+2U4yqQSb24slYKXEuhZ9vEN1
         oiOyF++7I39GfGP7otAnNpK39zLptKp3s0E9h6RiPIcpj1osfpVUp7bXK/s10g5I1c2O
         tT+JwnldEkXvaeVxsRVX0IMP4vkfsCsrlu58KJi20ZWc+iPQ9KsqlRIdkxo98wqSCRo1
         zYFA==
Received: by 10.68.219.162 with SMTP id pp2mr16124999pbc.85.1337171610098;
        Wed, 16 May 2012 05:33:30 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.61.104])
        by mx.google.com with ESMTPS id os7sm5325169pbb.67.2012.05.16.05.33.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 May 2012 05:33:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 16 May 2012 19:29:38 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197873>

Changes since the first patch:

 - wait time goes down to 1 hour, not too long, but also avoid flooding
 - avoid 1 fork for calling "gc --auto" if there's no actual housekeepi=
ng
 - commit learns commit.autogc config key. Scripts shoud make use of th=
is

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  Add convenient function to do automatic garbage collection
  index-pack: perform automatic gc, share receive.gc config with
    receive-pack
  commit: reinstate "gc --auto"
  gc: add --dry-run
  Update "gc" behavior in commit, merge, am and rebase

 Documentation/config.txt   |   11 +++++++--
 Documentation/git-gc.txt   |    7 +++++-
 builtin/commit.c           |    2 +
 builtin/gc.c               |   46 ++++++++++++++++++++++++++++++++++++=
+++++++-
 builtin/gc.h               |    9 ++++++++
 builtin/index-pack.c       |    6 +++-
 builtin/merge.c            |    8 +-----
 builtin/receive-pack.c     |   14 +-----------
 git-am.sh                  |    2 +-
 git-rebase--interactive.sh |    2 +-
 10 files changed, 80 insertions(+), 27 deletions(-)
 create mode 100644 builtin/gc.h

--=20
1.7.8.36.g69ee2
