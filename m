From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 0/3] Update compat/regex
Date: Tue, 17 Aug 2010 03:25:45 +0000
Message-ID: <1282015548-19074-1-git-send-email-avarab@gmail.com>
References: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 05:26:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlCol-0001my-JJ
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 05:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397Ab0HQD0W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 23:26:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57394 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab0HQD0V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 23:26:21 -0400
Received: by wyb32 with SMTP id 32so6487016wyb.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 20:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=UDQ+NGEaold+uIADuB4tpo4CRIV7WoRQdvu/XSeUaOM=;
        b=sQMS+ib7c9n/5TfesJ0+U3DVNHOVrRWPJReeA/zo1Ykq5I8nIyLB8nuvplZe0l7bIV
         uQiUDUi3zXnxZUTC1XKlkPG2Vw1DocDr/Y/lN1DdJOLCNOE1D6wst+kyvrKJg2Ni43BT
         dv10Jb8Lep88Dd7brpjHrH5rAGfwwaisYo71c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vmy3pTxBevfoUmb7gvyyDMoH2epTmRclK1md2+EBpVkmiPfoOcvYR9RwNL7pAQnI0k
         IunfFCjNE81GMoSuaknvK/MRKd+BDH78PbBuvBDIHBIoySoSB/urf14mez985i9m0Exp
         f48cUpyOdbI6ag4PETo7/PMkbGK474V0G6J+k=
Received: by 10.227.37.8 with SMTP id v8mr4922551wbd.180.1282015580355;
        Mon, 16 Aug 2010 20:26:20 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id r10sm6060786wbe.0.2010.08.16.20.26.18
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 20:26:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.389.gc3d0b
In-Reply-To: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153687>

On Mon, Aug 16, 2010 at 12:26, Paolo Bonzini <bonzini@gnu.org> wrote:

> Alternatively try out gawk, as it does not use gnulib but has the sam=
e set
> of sanitizations.

Why didn't you say that earlier? :)

Here's a RFC patch series that uses the gawk regex engine from the
gawk-devel branch of gawk CVS.

It compiles on Linux/FreeBSD and Solaris, with only a single warning
on FreeBSD due to an unused variable (upstream bug).

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
  compat/regex: use the regex engine from gawk for compat
  compat/regex: hacks to get the gawk regex engine to compile within
    git
  t/t7008-grep-binary.sh: un-TODO a test that needs REG_STARTEND

 Makefile                      |    4 +
 compat/regex/COPYING          |  674 ++++++
 compat/regex/mbsupport.h      |   59 +
 compat/regex/regcomp.c        | 3892 ++++++++++++++++++++++++++++++++
 compat/regex/regex.c          | 5003 +--------------------------------=
--------
 compat/regex/regex.h          |  462 +++--
 compat/regex/regex_internal.c | 1744 ++++++++++++++
 compat/regex/regex_internal.h |  810 +++++++
 compat/regex/regexec.c        | 4377 +++++++++++++++++++++++++++++++++=
++
 t/t7008-grep-binary.sh        |    2 +-
 10 files changed, 11921 insertions(+), 5106 deletions(-)
 create mode 100644 compat/regex/COPYING
 create mode 100644 compat/regex/mbsupport.h
 create mode 100644 compat/regex/regcomp.c
 create mode 100644 compat/regex/regex_internal.c
 create mode 100644 compat/regex/regex_internal.h
 create mode 100644 compat/regex/regexec.c

--=20
1.7.2.1.389.gc3d0b
