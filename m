From: Baz <brian.ewins@gmail.com>
Subject: [PATCH 0/2] Add --dry-run option to git-push
Date: Thu, 11 Oct 2007 00:34:27 +0100
Message-ID: <2faad3050710101634s5ed39bcbn723184810bc265d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 01:34:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifl4Y-0007BX-Qj
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 01:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903AbXJJXea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 19:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756901AbXJJXea
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 19:34:30 -0400
Received: from nz-out-0506.google.com ([64.233.162.234]:50212 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882AbXJJXe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 19:34:29 -0400
Received: by nz-out-0506.google.com with SMTP id s18so295583nze
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 16:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=+Ra6O0mo1+aaQu/0cYzzTVdkdgfcgfDS/G9SB2xMpoA=;
        b=KxNS4XS8I8SeORzLO/ydJXcLhZegH07CLvMVv2xwyM2R5lSAa5e9FV2uF9z1XVnu4B/Fu9+AhUf9dp9R0PqLYKohLOuIR2Ix466DAoCZdK3kfnF343uSdXPGckALJDQO57h8Tdp768x6kkGzwWh9ZkRmA6U04bW2wznRKbVozcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=j0c1RTmRHoqidAnkKqsA0VcNW/jhExhXsSZHxXoWbP3e3DT+xGiv5GtNXorn3mdMM7KYn1KpKwq3lDcOQY4NElvM1QRotCOuAtdK1Uw6aloi3y8WfIiAi2I0Yx4DzkfKM/PhRwhmQcaOpLn/fomS1f6hXhUIsbCTA0Kt9zuosV0=
Received: by 10.142.163.14 with SMTP id l14mr426995wfe.1192059267533;
        Wed, 10 Oct 2007 16:34:27 -0700 (PDT)
Received: by 10.142.157.1 with HTTP; Wed, 10 Oct 2007 16:34:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60566>

Hi,
there was discussion recently about the default behaviour of git-push
having the potential to confuse, making it easy to push commits that
are still cooking in other branches.

Its also possible for newbies to make mistakes with refspecs, but
there's no way to know if you've got the syntax right without actually
pushing. Steffan suggested a dry-run flag, which I've always wanted
too, so here's an attempt. Patches git-send-pack, git-push, their
docs, and adds a test for git-push.

Treat me gentle... first patch to the list and the mailer will
probably mangle it (sigh)

Cheers,
Baz

Diffstat:

 Documentation/git-push.txt      |    6 +++++-
 Documentation/git-send-pack.txt |    5 ++++-
 builtin-push.c                  |   10 ++++++++--
 send-pack.c                     |   31 +++++++++++++++++++------------
 t/t5516-fetch-push.sh           |   10 ++++++++++
 5 files changed, 46 insertions(+), 16 deletions(-)
