From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/5] jn/shortlog
Date: Mon, 3 May 2010 21:52:17 -0500
Message-ID: <20100504025217.GA7322@progeny.tock>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
 <1272912875.3537.6.camel@dreddbeard>
 <20100504002526.GA7061@progeny.tock>
 <20100504015635.GA7258@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 04:52:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O98FB-0001IC-MO
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 04:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927Ab0EDCwK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 May 2010 22:52:10 -0400
Received: from mail-iw0-f202.google.com ([209.85.223.202]:57369 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755626Ab0EDCwI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 22:52:08 -0400
Received: by iwn40 with SMTP id 40so4250448iwn.1
        for <git@vger.kernel.org>; Mon, 03 May 2010 19:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Jaa7ZPRKA1iPXmqEtn3+zUa97BUYKRqjjuda0xcvCk4=;
        b=Td1ajDC3nPFfXZojR5FKzJLdEc6hcRym982IztA3w8GxQWknu7kZkEwL6xavcQkcs1
         05AhDr7/p8qB51GaQ+mWye5mYH31XPoALyHdr6tPjBXmgBGMQfZhDd4IAuEUalFR1GXm
         98SKgKxjvZOXAYxOOJXe3L4RCmGEz5Q3TBYOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lzVbE8DrWcnz72oST9AVTjfI0EmBCEbwKU2Ju4VRoxXf9w3ljema77JZcX00l4H+Lx
         Ay9LrbChTsFpH/eEy6jJRP0iDz6jwlTsqalH3GMdZwiva1q3C/dqxVEthxfWKoLpr4Iy
         iIje/kfOZfW6noB8RFtMs1WneZeJ+0lTvd14k=
Received: by 10.231.151.211 with SMTP id d19mr1129744ibw.53.1272941525454;
        Mon, 03 May 2010 19:52:05 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4858481iwn.0.2010.05.03.19.52.03
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 19:52:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100504015635.GA7258@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146282>

Jonathan Nieder wrote:

> apparently shortlog does not default to HEAD when stdin is not a
> tty.
>=20
> Possible fixes:
>=20
>  - document the current unfriendly behavior
>  - default to HEAD when input is empty

Here=E2=80=99s the uncontroversial half.

Patch 1 is new: it explains why scripts that mean HEAD need to explicit=
ly
say so.  The remaining patches are just like before, except tests pass =
a
HEAD arg now.  Sorry about the breakage, and thanks for catching it.

Jonathan Nieder (4):
  Documentation/shortlog: scripted users should not rely on implicit
    HEAD
  t4201 (shortlog): guard setup with test_expect_success
  t4201 (shortlog): Test output format with multiple authors
  shortlog: Document and test --format option

Will Palmer (1):
  pretty: Respect --abbrev option

 Documentation/git-shortlog.txt |   15 +++++-
 builtin/shortlog.c             |    3 +-
 pretty.c                       |    7 ++-
 shortlog.h                     |    1 +
 t/t4201-shortlog.sh            |  116 +++++++++++++++++++++++++++++++-=
-------
 t/t6006-rev-list-format.sh     |   19 +++++++
 6 files changed, 132 insertions(+), 29 deletions(-)
