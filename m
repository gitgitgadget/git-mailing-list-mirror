From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: RFC: Adding an option to log-like commands to call an external
 command for each revision
Date: Sun, 29 Aug 2010 20:30:15 +0000
Message-ID: <AANLkTikh-KoWuPYE12pVszwduGTBOssKDxqk=4iF6QZT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 29 22:30:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpoWF-0003AX-1Y
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 22:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357Ab0H2UaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 16:30:18 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53926 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab0H2UaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 16:30:16 -0400
Received: by gxk23 with SMTP id 23so1735341gxk.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 13:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=TdXw8hUW97EVZvdsgtEiwQtcnlZ2dqEoDXCOJ6l75TU=;
        b=KykwqXyi6OawmrmIsM+3kgZnt2t+on88XgPPdoTZIjyakNl+8nhkFmuDbgXPBEMado
         FFPF7OEbcN8rXNuEVtrWjcuUYiEBzfVjk698suEk+/Vpid95ON5/WrJLvUPdTEfuBmQ+
         7JbzVUEzpPgxElq9yRXMfkyPuXqO9Gt6nwhnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=vFMXEfLmnC/SprG7772/QjPoQ+ch5Dx2eIU87tHyEUpwiR/XCPTYRdVFRtzESo1hCQ
         X8tsD9QYdSSDpRyvt/XSJQaMGYAR7kX9YkhvqHrIA1s0rFJ/OBwIvRUD2nf8NEqpH00o
         vMQqubOrjNWTUG9AHB1/WX+fqC9RgFBoKCubw=
Received: by 10.101.144.8 with SMTP id w8mr3504059ann.231.1283113816089; Sun,
 29 Aug 2010 13:30:16 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 29 Aug 2010 13:30:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154714>

I have this alias in my .gitconfig:

    review = "!f() { for rev in $(git rev-list --reverse \"$@\"); do
git show $rev; done; }; f"

I use it after I "git pull" to see what changed, e.g.:

    git review 49ea7b8..e1ef3c1

But sometimes I find that I want to do that for other things too, so I
have these hacks:

    review-grep = "!f() { for rev in $(git log --reverse
--pretty=format:%H --grep=\"$@\"); do git show $rev; done; }; f"
    review-file = "!f() { for rev in $(git log --reverse
--pretty=format:%H \"$@\"); do git show $rev; done; }; f"

But just now I wanted to use -S instead of grep, but adding aliases
like this is a bit silly.

Maybe we should have something like:

    git log --for-each=less a..b

To call "less" for each commit, what do you think?
