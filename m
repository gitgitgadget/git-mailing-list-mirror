From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 0/7] Detailed test coverage reports for Git
Date: Sun, 25 Jul 2010 14:40:54 +0000
Message-ID: <1280068861-17701-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 16:41:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od2OE-00016w-9E
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 16:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992Ab0GYOlN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 10:41:13 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49376 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab0GYOlM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 10:41:12 -0400
Received: by ewy23 with SMTP id 23so602412ewy.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 07:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=4KAyWh3nB1101F2yq6Av9L4qSQQUdufYW6w/hQQKjAU=;
        b=bAWPmpmEu+PZLxixmVaIEmQi/oYtSWBr4HzE5D872TOygMnRipKmHANJt2FMgfguTM
         TFTJaCNcRQg+Aqom3laO5kZz4obUcwoDL/ZCqpvWcrwPyr73TcN+Eqc61dF9oHVG01TI
         3C8fsd3dHp6olvgQR5C3IUxyuLrn9j0coQI0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=tB/swmqdFRUSP1v2zdvxKhl4kHLnHOTSX+mB16UFFfMlwuyKgRqLAnXlcnVsOxon3E
         VqnBI/mm50Jw7Yyppfpuob0AoW3NMvT+3dGHDRUujQL+g/GbXj/9LA+AXnXqrjDL+r4k
         uPQwNPoF7344Gvwfnw7G9SjIYynmdOrS/i/7U=
Received: by 10.213.76.16 with SMTP id a16mr533456ebk.90.1280068870878;
        Sun, 25 Jul 2010 07:41:10 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id x54sm3977142eeh.23.2010.07.25.07.41.09
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 07:41:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151745>

This is v2 of the test coverage series. It addresses all the points
that were raised for v1. Here's the diffstat against v1:
   =20
     .gitignore |   15 +++------------
     Makefile   |   19 +++++++++----------
     t/README   |   21 ++++++++++++++++-----
     3 files changed, 28 insertions(+), 27 deletions(-)

And the diff since v2:
   =20
    diff --git a/.gitignore b/.gitignore
    index e02f1f9..baed247 100644
    --- a/.gitignore
    +++ b/.gitignore
    @@ -207,12 +207,3 @@
    -/*.gcda
    -/*.gcno
    -/*.gcov
    -/builtin/*.gcda
    -/builtin/*.gcno
    -/builtin/*.gcov
    -/xdiff/*.gcda
    -/xdiff/*.gcno
    -/xdiff/*.gcov
    -/compat/*.gcda
    -/compat/*.gcno
    -/compat/*.gcov
    +*.gcda
    +*.gcno
    +*.gcov
    diff --git a/Makefile b/Makefile
    index c35c348..b6975aa 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -2282,0 +2283 @@ coverage:
    +object_dirs :=3D $(sort $(dir $(OBJECTS)))
    @@ -2284,4 +2285,3 @@ coverage-clean:
    -	$(RM) *.gcov *.gcda *.gcno
    -	$(RM) builtin/*.gcov
    -	$(RM) builtin/*.gcda
    -	$(RM) builtin/*.gcno
    +	$(RM) $(addsuffix *.gcov,$(object_dirs))
    +	$(RM) $(addsuffix *.gcda,$(object_dirs))
    +	$(RM) $(addsuffix *.gcno,$(object_dirs))
    @@ -2298,4 +2298,3 @@ coverage-report:
    -	gcov -b *.c
    -	gcov -b -o builtin builtin/*.c
    -	gcov -b -o xdiff xdiff/*.c
    -	gcov -b -o compat compat/*.c
    +	for dir in $(object_dirs); do \
    +		gcov --preserve-paths --branch-probabilities --all-blocks --obje=
ct-directory=3D$$dir $$dir*.c; \
    +	done
    @@ -2303 +2302 @@ coverage-report:
    -coverage-report-untested-functions:
    +coverage-untested-functions: coverage-report
    @@ -2308 +2307 @@ coverage-report-untested-functions:
    -coverage-report-cover-db:
    +coverage-report-cover-db: coverage-report
    diff --git a/t/README b/t/README
    index 718f35d..400e2da 100644
    --- a/t/README
    +++ b/t/README
    @@ -273,0 +274,9 @@ Do:
    +   Don't blindly follow test coverage metrics, they're a good way =
to
    +   spot if you've missed something. If a new function you added
    +   doesn't have any coverage you're probably doing something wrong=
,
    +   but having 100% coverage doesn't necessarily mean that you test=
ed
    +   everything.
    +
    +   Tests that are likely to smoke out future regressions are bette=
r
    +   than tests that just inflate the coverage metrics.
    +
    @@ -518,3 +527,5 @@ Test coverage
    -You can use the coverage tests to find out if your tests are reall=
y
    -testing your code code. To do that, run the coverage target at the
    -top-level (not in the t/ directory):
    +You can use the coverage tests to find code paths that are not bei=
ng
    +used or properly exercised yet.
    +
    +To do that, run the coverage target at the top-level (not in the t=
/
    +directory):
    @@ -532 +543 @@ functions:
    -    make coverage-report-untested-functions
    +    make coverage-untested-functions
    @@ -537 +548 @@ Devel::Cover module. To install it do:
    -   # On Debian:
    +   # On Debian or Ubuntu:
   =20
I also rewrote some of the commit messages.
   =20
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (7):
  gitignore: Ignore files generated by "make coverage"
  Makefile: Include subdirectories in "make cover" reports
  Makefile: Split out the untested functions target
  Makefile: Add coverage-report-cover-db target
  Makefile: Add coverage-report-cover-db-html target
  t/README: A new section about test coverage
  t/README: Add a note about the dangers of coverage chasing

 .gitignore |    6 ++++++
 Makefile   |   17 +++++++++++++++--
 t/README   |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 2 deletions(-)
