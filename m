From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/2] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Fri, 4 Jun 2010 19:51:16 -0500
Message-ID: <20100605005116.GA8774@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 05 02:51:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKhbh-0003RK-EH
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 02:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541Ab0FEAvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 20:51:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45366 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932500Ab0FEAvT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jun 2010 20:51:19 -0400
Received: by iwn37 with SMTP id 37so1623665iwn.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 17:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Gv/d9HoZ6GHvFBPhk9LX7wGbYbpobjuVkC6jq5vGPOo=;
        b=rBWCMDdy99mLiZxVCV4IzugisOXnBgmrD4aOhnn8Q5whRlQoOAD3ITFfNFmvCUYubm
         pF09NnJX2bsVMO6JEUPXv3dHTBNafQ2X04EPIvGkidHAJ8bOK+K1EKCNhWZviLpEZpCi
         vdUytQBySIpZlvFhy/baPJG29aDJWIDzUljfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=x/cjVqIvWnq9l70FPdkgy9z/AzybCeFuvk9oCoebXVxfjoY1z04mHBT/jmi1ELCbxd
         czJoSWhXKC8f1bzNsxuialicNZnU2QGx2q5ozuSLfICyu/Q0gXxLvBrTLq5Ebds2j1P8
         iu06533j4Iemkvh/ZJSEofdEt5L2ey7ylp4j8=
Received: by 10.231.176.74 with SMTP id bd10mr14408631ibb.38.1275699078573;
        Fri, 04 Jun 2010 17:51:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm7781814ibf.7.2010.06.04.17.51.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 17:51:17 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148442>

This series teaches =E2=80=98git grep=E2=80=99 to accept

	git grep -Ovi some_function_name

to find all the call sites for some_function_name so they can be
adjusted.  Dscho=E2=80=99s cover letter[1] explains it better.

And in fact, Dscho did all the work here; this iteration just rebases i=
t
on master and adds some tests.

Happy hacking,
Jonathan

Johannes Schindelin (2):
  grep: Add the option '--open-files-in-pager'
  grep -O: allow optional argument specifying the pager (or editor)

 Documentation/git-grep.txt |    8 +
 builtin/grep.c             |   81 +++++++-
 git.c                      |    2 +-
 t/lib-pager.sh             |   15 ++
 t/t7002-grep.sh            |  530 ------------------------------------=
--------
 t/t7006-pager.sh           |   16 +-
 t/t7810-grep.sh            |  530 ++++++++++++++++++++++++++++++++++++=
++++++++
 t/t7811-grep-open.sh       |  157 +++++++++++++
 8 files changed, 792 insertions(+), 547 deletions(-)
 create mode 100644 t/lib-pager.sh
 delete mode 100755 t/t7002-grep.sh
 create mode 100755 t/t7810-grep.sh
 create mode 100644 t/t7811-grep-open.sh

[1] http://thread.gmane.org/gmane.comp.version-control.git/143219
