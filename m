From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/2] Re: 'git grep needle rev' attempts to access 'rev:.../.gitattributes' in the worktree
Date: Wed, 10 Oct 2012 20:59:02 +0700
Message-ID: <1349877544-17648-1-git-send-email-pclouds@gmail.com>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 15:59:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLwp6-0007gp-2J
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 15:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568Ab2JJN70 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 09:59:26 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34656 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564Ab2JJN7W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 09:59:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so734362pbb.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 06:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cfcMFSQ5Chuv4ZtPAMc5htSWwvAq8Vd1pDnvDrP9lDA=;
        b=Kh99Xrhb7hAUnRSgXUVhIkYq37eWWkArGvgFhZttTCUnSjcc5X/Nhcv3ykTEgbii64
         5eISFfkp9JZ3qSr3iBYbi86HE3rytALQ94p9h4bohAa8JQKxFZPSP+r9+/1vjHbvPlMV
         CpoEskrAGRjB3mr4fdzt5qBtk9VUp4jwRC8UVTTmSvOB1Bj4qQV2Id1TcNh7dyx9SCxU
         bGrchaEDKE3MqMLIMU9Zbdqg5GUEPBkyQ/d8CDYvJRN6hbohNQuaCtokv/iCR7LcVEQl
         ruZIYZg/QUqa4ki+AbVbEkQCruUlDGc4/cEXvG3lWBatITUx3eNaJrXB8E4au65YGhSE
         eyjg==
Received: by 10.68.234.36 with SMTP id ub4mr74645433pbc.68.1349877562192;
        Wed, 10 Oct 2012 06:59:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id nd6sm1065154pbc.68.2012.10.10.06.59.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 06:59:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 20:59:12 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1349868894-3579-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207412>

Round too. .gitattributes should be respected in all cases except blob
grepping. As Johannes pointed elsewhere in this thread, if "git
diff <rev1> <rev2>" looks up worktree's .gitattributes (and none in
rev1/rev2), there's no reason "git grep" should behave differently.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  quote: let caller reset buffer for quote_path_relative()
  grep: stop looking at random places for .gitattributes

 builtin/clean.c        |  2 ++
 builtin/grep.c         | 24 +++++++++++++-----------
 builtin/ls-files.c     |  1 +
 grep.c                 | 11 ++++++++---
 grep.h                 |  4 +++-
 quote.c                |  1 -
 t/t7008-grep-binary.sh | 22 ++++++++++++++++++++++
 wt-status.c            |  1 +
 8 files changed, 50 insertions(+), 16 deletions(-)

--=20
1.7.12.1.406.g6ab07c4
