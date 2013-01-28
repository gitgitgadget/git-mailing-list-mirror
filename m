From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v3 00/11] unify appending of sob
Date: Sun, 27 Jan 2013 17:11:44 -0800
Message-ID: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jrnieder@gmail.com, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 02:12:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzdGy-0006JW-SI
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 02:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756973Ab3A1BMJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 20:12:09 -0500
Received: from mail-da0-f54.google.com ([209.85.210.54]:57820 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756900Ab3A1BMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 20:12:08 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so990966dad.41
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 17:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=PAEOgFFe7SsKzplQHwUQ/7AW9GSMvx8zMuQipF2MHBM=;
        b=ZQ50jP00q6VhqjHXPbUvCoECVzv4jGscpEmZdNxFCnvpkik4YYBB6gDkTpaTjGHHkK
         dvlp5xq5wDTl2iE6c+sjXkR9tefmIzjd3q2lIuHfRYQGgoXWlU6tc9X+KZfSBThw4F6K
         nmNJSbOGciNwCMIeB7TtDYfz1sObQsCqgekAM+QgnAM75n3bS1kMNKIU9nYqbNi0CyE/
         n2iz/LWeaSBJrIU/F8ZQWPIf2Ovt9tIkz3A7Zis53tzWeX0Szt4CbAVVbOcqhunC3V+T
         NrdXfcJEf/aL4QIFJo361dl/JPdJWX1t1NE7EgoxapZX+7BXJCB3cYjZd5924QvpH1aq
         DZlA==
X-Received: by 10.68.254.195 with SMTP id ak3mr33425414pbd.37.1359335527779;
        Sun, 27 Jan 2013 17:12:07 -0800 (PST)
Received: from charliebrown.sbx10663.mountca.wayport.net (ip-64-134-226-147.public.wayport.net. [64.134.226.147])
        by mx.google.com with ESMTPS id x2sm5619521paw.8.2013.01.27.17.12.05
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 17:12:06 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.252.gdb33759
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214764>

Round 3.

-Brandon

Brandon Casey (9):
  sequencer.c: rework search for start of footer to improve clarity
  commit, cherry-pick -s: remove broken support for multiline rfc2822
    fields
  t/test-lib-functions.sh: allow to specify the tag name to test_commit
  t/t3511: add some tests of 'cherry-pick -s' functionality
  sequencer.c: recognize "(cherry picked from ..." as part of s-o-b
    footer
  sequencer.c: always separate "(cherry picked from" from commit body
  sequencer.c: teach append_signoff how to detect duplicate s-o-b
  sequencer.c: teach append_signoff to avoid adding a duplicate newline
  Unify appending signoff in format-patch, commit and sequencer

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  t4014: more tests about appending s-o-b lines
  format-patch: update append_signoff prototype

 builtin/commit.c         |   2 +-
 builtin/log.c            |  13 +--
 log-tree.c               |  92 ++---------------
 revision.h               |   2 +-
 sequencer.c              | 150 ++++++++++++++++++---------
 sequencer.h              |   4 +-
 t/t3511-cherry-pick-x.sh | 219 +++++++++++++++++++++++++++++++++++++++
 t/t4014-format-patch.sh  | 263 +++++++++++++++++++++++++++++++++++++++=
++++++++
 t/test-lib-functions.sh  |   8 +-
 9 files changed, 600 insertions(+), 153 deletions(-)
 create mode 100755 t/t3511-cherry-pick-x.sh

--=20
1.8.1.1.450.g0327af3
