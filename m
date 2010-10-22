From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH en/and-cascade-tests 0/7]
Date: Fri, 22 Oct 2010 01:38:37 -0500
Message-ID: <20101022063837.GA6081@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 08:42:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9BKm-0002NJ-EE
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 08:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642Ab0JVGm1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 02:42:27 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52614 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab0JVGm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 02:42:26 -0400
Received: by yxn35 with SMTP id 35so355874yxn.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 23:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8TDBR+VXXC98qbjakyoFDo6N7sNd2CSllfxCsW/7/uU=;
        b=K6L5ilNKQKn3P08P0G71+gD07SVWToY82uhiFHz3FZhi4sO7V7fSgOZ5CkyIth7/Ey
         xk+p409Ll5G72VPlpsp6WeEiUASVHp70dQ9NsCcnq6BGvbtzUFXGKMvD8UJ2DqEkigAh
         3TKo1MslkoXqIEEiIMGanlCRyOg4ZVmVoRp/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=oEr7iVGfrEbsLnpZhoMSAbzzkrImfJlJg1mucVmktdJHSRRBhxh/GNuVvN7KT8vNT0
         v5LJzj8yNSazzI6VD/UeRLx6VzhEBmeU1FjTV35oFmc3KrvvpQSLPyfrXovFT9SVneBx
         2K6THr1zXLKfnB7aMlFF47pWfo+m30cYysHc0=
Received: by 10.100.208.12 with SMTP id f12mr1782847ang.94.1287729745668;
        Thu, 21 Oct 2010 23:42:25 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id g18sm3051418anh.38.2010.10.21.23.42.24
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 23:42:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287544320-8499-4-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159650>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>  builtin/branch.c         |    3 +++
>  builtin/checkout-index.c |    3 +++
>  builtin/commit.c         |    6 ++++++
>  builtin/gc.c             |    3 +++
>  builtin/ls-files.c       |    3 +++
>  builtin/merge.c          |    3 +++
>  builtin/update-index.c   |    3 +++
>  builtin/upload-archive.c |    7 ++++---

Okay, all of them survive a reroll except upload-archive.  As for
upload-archive:

 - it already doesn't support "-h"
 - it is such low-level plumbing, I don't really mind that.  Maybe
   someone is using a repository named "-h" (though I hope not, of
   course).

Maybe these patches should be squashed.  I separated them because they
were easier to write and it would be easier to cc the right people
this way.

The primary motivation for the series is that the repository checker
from the nd/setup series will not be happy without some change like
this.  In the git <foo> -h codepath, repository setup is not run so
repository access is forbidden.

The secondary motivation is to create better behavior in situations of
repository corruption.  When I type "git checkout -h", I am asking for
a usage message, not a repository self-check.  Especially when trying
to repair a repository, commands that do not do what they are asked to
are generally frustrating to use.

Patches apply on top of "test-lib: make test_expect_code a test
command" from the en/and-cascade-tests topic.

Enjoy,
Jonathan

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (7):
  branch -h: show usage even in an invalid repository
  checkout-index -h: show usage even in an invalid repository
  commit/status -h: show usage even with broken configuration
  gc -h: show usage even with broken configuration
  ls-files -h: show usage even with corrupt index
  merge -h: show usage even with corrupt index
  update-index -h: show usage even with corrupt index

 builtin/branch.c                |    3 +++
 builtin/checkout-index.c        |    3 +++
 builtin/commit.c                |    6 ++++++
 builtin/gc.c                    |    3 +++
 builtin/ls-files.c              |    3 +++
 builtin/merge.c                 |    2 ++
 builtin/update-index.c          |    3 +++
 t/t2006-checkout-index-basic.sh |   24 ++++++++++++++++++++++++
 t/t2107-update-index-basic.sh   |   32 +++++++++++++++++++++++++++++++=
+
 t/t3004-ls-files-basic.sh       |   39 +++++++++++++++++++++++++++++++=
++++++++
 t/t3200-branch.sh               |   11 +++++++++++
 t/t6500-gc.sh                   |   28 ++++++++++++++++++++++++++++
 t/t7508-status.sh               |   24 ++++++++++++++++++++++++
 t/t7600-merge.sh                |   11 +++++++++++
 14 files changed, 192 insertions(+), 0 deletions(-)
 create mode 100755 t/t2006-checkout-index-basic.sh
 create mode 100755 t/t2107-update-index-basic.sh
 create mode 100755 t/t3004-ls-files-basic.sh
 create mode 100755 t/t6500-gc.sh

--=20
1.7.2.3
