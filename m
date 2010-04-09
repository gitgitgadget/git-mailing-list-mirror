From: Eugene Sajine <euguess@gmail.com>
Subject: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Fri, 9 Apr 2010 15:35:42 -0400
Message-ID: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 09 21:35:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Jza-0005f1-FL
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 21:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595Ab0DITfq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Apr 2010 15:35:46 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:65496 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab0DITfp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Apr 2010 15:35:45 -0400
Received: by bwz1 with SMTP id 1so2779068bwz.21
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 12:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=kF/s+uQXqy937QQvFmOraNEA4Kbw9N6jGFiGnkT5JnM=;
        b=Lsw21DNlYfVW1jvG2saxNqwoih0g+wggKATByG18UNLCdgZ3XYHK+euJ6Tgm4C738g
         np43OnDVQnAb27P/4t6L+GOiMdSLtiL3rz4rqllX1aDVB4TUGQZpj9nfQK75l7oBqvFO
         W1GkzefxW+nQC+064Mpt4imkd4+ZftCJjLEmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=AYs/lficiKwHo2Zyj/L/njOA4UmGtB7Q9eO/noKWdJqj0SYj2Wk2ZFs8yNoeNGoXx/
         8qjq9xIdK8a60NtGGu0jEg0XpDpy4BXAGLwybRx5wKj328Mu1oCizYUWHMp3yCxyjqaH
         0fK2ztXHRB2JJWXxtoz2/RgBLDZ/WCE00HHu8=
Received: by 10.204.120.202 with HTTP; Fri, 9 Apr 2010 12:35:42 -0700 (PDT)
Received: by 10.204.134.84 with SMTP id i20mr506210bkt.192.1270841742834; Fri, 
	09 Apr 2010 12:35:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144464>

Hi,


In case of this situation

=C2=A0 =C2=A0 =C2=A0 =C2=A0A =C2=A0master
=C2=A0 =C2=A0 =C2=A0 =C2=A0 \
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0B =C2=A0next
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0C =C2=A0topic


$ git rebase --onto master topic
=46irst, rewinding head to replay your work on top of it...
fatal: Not a range.
Nothing to do.

Which is OK.

When I fired up interactive rebase, it printed me =E2=80=9Cnoop=E2=80=9D=
, so I was
expecting it to do nothing and exited the vi, without deleting this
"noop". But it did performed some operation and I actually have commit
C lost, with topic pointing to the same commit as master.

$ git rebase -i --onto master topic
Successfully rebased and updated refs/heads/topic.

I believe this is wrong.


Thanks,
Eugene
