From: =?ISO-8859-1?Q?St=E9phane_Corlosquet?= <scorlosquet@gmail.com>
Subject: Tracked files become untracked in some obscure scenario
Date: Tue, 9 Aug 2011 15:59:08 -0400
Message-ID: <CAGR+nnFM+Pr29h4POarx5rQdrTuMvtwwZLwVPZuChSDKQjLg4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 21:59:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqsSK-00024e-UV
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 21:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab1HIT7K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Aug 2011 15:59:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48831 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248Ab1HIT7J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2011 15:59:09 -0400
Received: by fxh19 with SMTP id 19so350261fxh.19
        for <git@vger.kernel.org>; Tue, 09 Aug 2011 12:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=keOAPkxl1CUBWzehIHeCfKoS/SGfFjSEbw8n+OOvaxU=;
        b=O1QoMNSLTbdx3AIFHl1VntOoL1NX9li/MWaVQ5yj8CkcvGj+MWTDMJpJ3bPWA+ivaM
         2jfVXtgVOH7XS8fdcJ58YKo2YCctmDQZcpVjW2D0jNKZhRMvOsZJgBC039cUF1K5Ymuq
         WPwl76r/hzZ8FGv456s0CwnG3Yxa5TWPrgsko=
Received: by 10.223.56.79 with SMTP id x15mr9897732fag.130.1312919948196; Tue,
 09 Aug 2011 12:59:08 -0700 (PDT)
Received: by 10.223.112.16 with HTTP; Tue, 9 Aug 2011 12:59:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179045>

Hi,

I'm encountering a very strange bug where some directory containing
one file becomes untracked when it should be tracked. I originally
found this bug in a bigger repository, but I isolated the culprit
files into a small tarball which you can download from
http://files.openspring.net/tmp/gitbug-20110809.tgz

This bug occurs on the following three configs:
Mac OS X Snow Leopard with git=A01.7.4.1
Mac OS X Snow Leopard with git=A01.7.5
Mac OS X Lion with git=A01.7.4.4
I could not reproduce on Ubuntu.

To reproduce, extract the tarball and try to add its content into a fre=
sh repo:
$ git init
Initialized empty Git repository in /private/tmp/stemtest/.git/
$ git add .
$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
# =A0 (use "git rm --cached <file>..." to unstage)
#
# new file: =A0 drupal/sites/all/modules/scf/pubnode_docbook4/xsl/docbo=
ok-xsl-1.73.2/common/olink.xsl
# new file: =A0 files/pubnode/ab4d8c648ef8e26312beaba802a503d1f8081bb6/=
README
#
# Untracked files:
# =A0 (use "git add <file>..." to include in what will be committed)
#
# files/pubnode/ab4d8c648ef8e26312beaba802a503d1f8081bb6/

=46rom there onwards, if I commit and do other operations, this
directory will remain in the untracked files list.=A0I'm terribly
confused by this bug. It seems it has to do with the paths of both
files, since if I rename them, the bug does not happen. But I can't
explain what's going on.

regards,
Steph.
