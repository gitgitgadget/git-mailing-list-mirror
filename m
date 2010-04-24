From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] request-pull: protect against OPTIONS_KEEPDASHDASH
 from environment
Date: Sat, 24 Apr 2010 07:10:10 -0500
Message-ID: <20100424120437.GA12237@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 14:09:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5eBF-0004Gj-6z
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 14:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477Ab0DXMJk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 08:09:40 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33145 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332Ab0DXMJj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 08:09:39 -0400
Received: by gyg13 with SMTP id 13so5551725gyg.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 05:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=5CcNhCZLZKUkKQA52STD0OL3ONyosxR7W9k4SXTsGms=;
        b=nI/GOHpnTvsc0IqA1hxZ83tqac7ImnmRQ3VK78uT8/3sOIHLLU7/17pQ7bPM1eD9x3
         xzuwzpTHkEbl5HBSYJLVMydfLfrSaEcXrOShf81t6nzuwrVkS6qx9DpjRLWIcvOV1W3Q
         bkQINVY3eb0iMGRGd5YUXeXtIqwMVBhhrjjrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=kxmAD+EzhfIACC0UZ05fGn9yl1zeTWEFOFOXvUvKCPeXjSTKQXrmHJFABa0ByJf4nO
         GEsQ6cbkYQ+zrcFzF4VWT26QRELdqaBzL/PI+eX/8bgv8l9H0BWiXBzM5n5tINETUwYE
         udvqR5zgSsbefK55szpXUqr2o4XIvDrjxJh64=
Received: by 10.150.251.10 with SMTP id y10mr1438206ybh.123.1272110977940;
        Sat, 24 Apr 2010 05:09:37 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1458002iwn.3.2010.04.24.05.09.36
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 05:09:37 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145668>

Hi,

At last, the mysterious t7400 test failure has been solved, thanks to
Gerrit Pape.  It was caused by an assumption in git that a certain
variable not in its namespace would not be set.

Here=E2=80=99s a problem of the same kind, though harder to trip.  I ca=
n=E2=80=99t
imagine why anyone would be exporting the OPTIONS_KEEPDASHDASH
variable, but it is not in git=E2=80=99s namespace so it seems better n=
ot
to make any assumptions.

Jonathan Nieder (2):
  tests for request-pull
  request-pull: protect against OPTIONS_KEEPDASHDASH from environment

 contrib/git-resurrect.sh |    1 +
 git-request-pull.sh      |    1 +
 t/t5150-request-pull.sh  |  228 ++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 230 insertions(+), 0 deletions(-)
 create mode 100644 t/t5150-request-pull.sh
