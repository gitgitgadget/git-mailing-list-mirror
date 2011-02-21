From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 00/15] Mark "init", "clone", and "add" output for
 translation
Date: Mon, 21 Feb 2011 04:12:29 -0600
Message-ID: <20110221101229.GA32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:12:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSl2-00087o-Lp
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:12:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab1BUKMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:12:40 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39889 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab1BUKMj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:12:39 -0500
Received: by iwn8 with SMTP id 8so1724514iwn.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=X3bO9kobLxFT/bTBXAKKvY/Qins0oqTMh3Jo+ldVI48=;
        b=CnCY4UY3TI1C/qHDCXpyRqppQUeKIkRIhMRAwEG1vSohcJO8gPFuQUy6ZWVmAtOGuV
         dLNEYSZVwmOt4QntLowK9ejWpMmsubTDCNRU6FM9tzc0lvtmqpchCwCTKgnT7cQFD57m
         DRcdqSb2GNZgCColwwyAetJ5yZ1ublSlcIKEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xOkjv3jwgM3+nUS7tXpVcjEDQNJjy8RV7EpMGJefoYbzfr1mUbvyYryBTD1d3l28B5
         6I9GlwqucaF/GH24j2V8qFnEhMTDI8ErI+A5EC9wNE8oy1Of62iovve8yCBEgjKLiTkW
         N0Z7lZu1qXn03dyUXurB8fXbK3yAU6pDFzw5Y=
Received: by 10.42.241.74 with SMTP id ld10mr1765614icb.20.1298283158525;
        Mon, 21 Feb 2011 02:12:38 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id 8sm2425075iba.4.2011.02.21.02.12.35
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:12:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221040012.GB26968@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167455>

Hi again,

To make the primitives introduced by v2 more concrete, here's a series
including a few gettextization patches.  I don't plan to send more of
these unless there is some agreement that the basic structure is
right.  Maybe by next time I'll hunker down and write myself a tool to
check that a commit only inserts "_("-")" pairs (maybe using diff
--word-diff?)

This series still includes the skeleton gettext.h wrapper.

Changes from v1:

 - clearer commit messages, hopefully
 - clearer documentation for GETTEXT_POISON in the makefile

Please feel free to try it out, complain, ack, send patches, and so
on.

Jonathan Nieder (2):
  i18n: do not poison translations unless GIT_GETTEXT_POISON envvar is
    set
  update-index --refresh --porcelain: add missing const

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (13):
  i18n: add no-op _() and N_() wrappers
  tests: add GETTEXT_POISON to simulate unfriendly translator
  Makefile: "pot" target to extract messages marked for translation
  init: mark basic messages for translation
  init: mark "Initialized [...] repository" for translation
  clone: mark basic messages for translation
  clone: split "Cloning into" message into two
  clone: mark "Cloning into" message for translation
  add: mark basic messages for translation
  add: mark "The following paths are ignored" for translation
  add: mark "did not match any files" for translation
  add -u --verbose: mark "remove '%s'" for translation
  add --refresh --verbose: mark "Unstaged changes" heading for
    translation

 Makefile               |   27 ++++++++++++++++++++
 builtin/add.c          |   50 +++++++++++++++++++-------------------
 builtin/clone.c        |   63 +++++++++++++++++++++++++---------------=
-------
 builtin/init-db.c      |   58 ++++++++++++++++++++++++----------------=
---
 cache.h                |    3 +-
 gettext.c              |   14 ++++++++++
 gettext.h              |   32 ++++++++++++++++++++++++
 po/.gitignore          |    1 +
 read-cache.c           |    4 +-
 t/t0001-init.sh        |    2 +-
 t/t2200-add-update.sh  |    2 +-
 t/t2204-add-ignored.sh |   37 +++++++++++++++++++---------
 t/t3700-add.sh         |   13 +++++++--
 t/t5601-clone.sh       |    2 +-
 t/test-lib.sh          |    9 +++++++
 15 files changed, 215 insertions(+), 102 deletions(-)
 create mode 100644 gettext.c
 create mode 100644 gettext.h
 create mode 100644 po/.gitignore
