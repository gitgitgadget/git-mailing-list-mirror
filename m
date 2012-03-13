From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/7] tests: diffstat summary line varies by locale (Re:
 [PATCH v2] Use correct grammar in diffstat summary line)
Date: Mon, 12 Mar 2012 23:51:01 -0500
Message-ID: <20120313045100.GA12474@burratino>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 05:51:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Jhk-00086w-L5
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 05:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512Ab2CMEvT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 00:51:19 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60458 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756067Ab2CMEvR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 00:51:17 -0400
Received: by yenl12 with SMTP id l12so141647yen.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 21:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f/iKUSmBf2nmg4rC0j+Vu8zR2T/qkZIN9MMU7hBs3d4=;
        b=gkaXdE6EwPVhu5if+6Bmx6Jr675Moutx6J+sRXQ+do4Uhh/n/acG84RArTCkpsXI2J
         hJ5BiKlwP88d8NR2hImiPuYgCtURJpmV+skKqJfCWTAJqF5DdYtBSHcx5VIDtHBrB7Lk
         bleCRanrI1JC43J8aFTLxVlckTNRpMzPDa3Ji0EwODLPvuNavQfl495dKhz1eUvunR19
         aBgmt39XSbquaKzCURGXZjvc4NDPapYAVujN21yDMw3LHJ7E74hFsD2do99ByS5purlL
         rEXWT6JZA7HYTvWLGagg/WTrusbU1I3SMHFBIXLrlDnCV0Fn0lCH2h9/ZRfGZs9BoVez
         48vA==
Received: by 10.60.9.168 with SMTP id a8mr7871298oeb.58.1331614276899;
        Mon, 12 Mar 2012 21:51:16 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id j9sm23169310obl.21.2012.03.12.21.51.15
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 21:51:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1328100907-20397-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192971>

(-cc: Thomas)
Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>  In Vietnamese, the summary line is "thay =C4=91=E1=BB=95i 68 t=E1=BA=
=ADp tin, th=C3=AAm(+) 163,
>  xo=C3=A1(-) 116". Lovely. Perhaps I'll translate git into Vietnamese=
 after
>  all :)

Though I wouldn't be able to read it, that would make me happy.

>  And this patch's diffstat looks just scary due to test suite's updat=
es.

Here's a series on top that does two things:

 1. make the current testsuite run again with GETTEXT_POISON enabled
 2. try to ensure that next time someone wants to tweak --stat output,
    fewer test updates will be needed.

Patch 1 consists only of good changes that seem maint-worthy to me,
but it is incomplete (see patch 7).

The rest seem to work but I haven't re-checked them carefully.

Patch 7 is a "miscellany" patch that even includes a few changes that
should be part of patch 1.  I am sending it this way just to get early
feedback on the approach; a final series would move all the
s/test_cmp/test_i18ncmp/ changes to patch 1 and have the rest of the
changes split up by topic.

The series is based against 7f814632 (Use correct grammar in diffstat
summary line).

Thoughts welcome, of course.

Jonathan Nieder (7):
  test: use test_i18ncmp to check --stat output
  test: use numstat instead of diffstat in funny-names test
  test: modernize funny-names test style
  test: test cherry-pick functionality and output separately
  test: use numstat instead of stat in "git stash show" tests
  test: use numstat instead of diffstat in binary-diff test
  remainder

 t/t3300-funny-names.sh              |  354 ++++++++++++++++++---------=
--------
 t/t3508-cherry-pick-many-commits.sh |   32 +++-
 t/t3903-stash.sh                    |   32 +++-
 t/t4012-diff-binary.sh              |   29 ++-
 t/t4013-diff-various.sh             |    7 +-
 t/t4014-format-patch.sh             |    9 +-
 t/t4016-diff-quote.sh               |   35 ++--
 t/t4030-diff-textconv.sh            |    6 +-
 t/t4031-diff-rewrite-binary.sh      |   10 +-
 t/t4043-diff-rename-binary.sh       |    8 +-
 t/t4045-diff-relative.sh            |   16 +-
 t/t4047-diff-dirstat.sh             |   65 +++----
 t/t4049-diff-stat-count.sh          |    2 +-
 t/t4100-apply-stat.sh               |    4 +-
 t/t5150-request-pull.sh             |    2 +-
 t/t7602-merge-octopus-many.sh       |    6 +-
 16 files changed, 356 insertions(+), 261 deletions(-)
