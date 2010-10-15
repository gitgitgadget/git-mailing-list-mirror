From: Chris Packham <judge.packham@gmail.com>
Subject: [RGC/PATCHv2] grep: submodule support
Date: Fri, 15 Oct 2010 16:26:39 -0700
Message-ID: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens.Lehmann@web.de, pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 16 01:27:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6tg2-0000z5-SU
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 01:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321Ab0JOX0y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 19:26:54 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63588 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab0JOX0x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 19:26:53 -0400
Received: by pwj4 with SMTP id 4so245540pwj.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 16:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=jZ6bUWNGBU46GXTWkLTwBWYWXis0YYs1Do8fqkAAnCo=;
        b=HVj+de0vT5IwdVf61sEcELxkfI4CHUXa9OpRYMeeNXiUphL8BvRw9s1l9hzZ2FPu6A
         pw1Mgg82PWUuQU42/wLBcCQe8WgviW1YvDjrW++KzUkfeH+efg/y+V2p4ZDuHRdwaP7W
         cCe9KshuSRcTe/dmExp8gcXzx4AsEd9LA2UEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=yEqcvrukVDHQisBl7vCrsvT/scEF2qkVyE0E/BBjHc9/0Cx2QN1VWnE3QkxoqSIyX5
         gbEhZV/1FT/62Stayc7ajxqtMWpAnv7KHda4dYC0mytD4OCENEiNHznP03i/5ZogdxCH
         JInY9bmQhu3TmvGODX/H/byK3RxMywMAMAdbw=
Received: by 10.142.136.12 with SMTP id j12mr1176584wfd.148.1287185209681;
        Fri, 15 Oct 2010 16:26:49 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id y42sm10506678wfd.10.2010.10.15.16.26.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 16:26:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159143>

Here is my updated grep support for submodules series. The old series
can be seen here [1].

[1] http://article.gmane.org/gmane.comp.version-control.git/157599

This the actual implementation is far from complete but the first 3
patches should be OK on their own. Since the last series I've rebased t=
o
master on git.git so hopefully more people can try it out if they want
to. I'll be travelling/moving for the next week or so I may be a little=
=20
unresponsive.

The changes since last time are:

* use environment variables to pass some information to the sub-process
* a lot more options supported by create_sub_grep_argv, including
  rebuilding the pattern list.
* figure out the correct prefix based on the cwd & worktree (thanks Duy=
).


Chris Packham (4):
      grep: output the path from cwd to worktree
      grep_cache: check pathspec first
      add test for git grep --recursive
      grep: add support for grepping in submodules

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      worktree: provide better prefix to go back to original cwd
