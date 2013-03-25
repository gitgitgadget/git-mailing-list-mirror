From: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH 0/5] Verify GPG signatures when merging and extend %G? pretty
 string
Date: Tue, 26 Mar 2013 00:46:11 +0100
Message-ID: <5150E1C3.9020609@physik.tu-berlin.de>
References: <7v8v5b1nlp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 00:46:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKH6G-0005W8-Kk
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 00:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758635Ab3CYXqT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 19:46:19 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:12816 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab3CYXqS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 19:46:18 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-4) with esmtp 
	id 1UKH5l-0006or-CR; Tue, 26 Mar 2013 00:46:18 +0100
Received: from [192.168.0.103] (cable-124-189.zeelandnet.nl [82.176.124.189])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 4607D11402;
	Tue, 26 Mar 2013 00:46:13 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <7v8v5b1nlp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219119>

Rebased it onto the current 'master'. The second patch fixes that the G=
PG
status parser ignores the first line of GPG status output (that would b=
e caught
by the new merge signature verification test case).

Sebastian G=F6tte (5):
  Move commit GPG signature verification to commit.c
  commit.c/GPG signature verification: Also look at the first GPG statu=
s
    line
  merge/pull: verify GPG signatures of commits being merged
  merge/pull Check for untrusted good GPG signatures
  pretty printing: extend %G? to include 'N' and 'U'

 Documentation/merge-options.txt    |   4 ++
 Documentation/pretty-formats.txt   |   3 +-
 builtin/merge.c                    |  35 ++++++++++++++++-
 commit.c                           |  61 +++++++++++++++++++++++++++++
 commit.h                           |  10 +++++
 git-pull.sh                        |  10 ++++-
 gpg-interface.h                    |   8 ++++
 pretty.c                           |  77 ++++-------------------------=
--------
 t/lib-gpg/pubring.gpg              | Bin 1164 -> 2359 bytes
 t/lib-gpg/random_seed              | Bin 600 -> 600 bytes
 t/lib-gpg/secring.gpg              | Bin 1237 -> 3734 bytes
 t/lib-gpg/trustdb.gpg              | Bin 1280 -> 1360 bytes
 t/t7612-merge-verify-signatures.sh |  61 +++++++++++++++++++++++++++++
 13 files changed, 195 insertions(+), 74 deletions(-)
 create mode 100755 t/t7612-merge-verify-signatures.sh

--=20
1.8.1.5
