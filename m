From: John Szakmeister <john@szakmeister.net>
Subject: 'git checkout -p' is a bit confusing...
Date: Mon, 9 May 2011 06:05:49 -0400
Message-ID: <BANLkTik+VbJZKc1Xwb-3p3HPW-zxanc7HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 12:06:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJNLi-0007nu-O1
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 12:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963Ab1EIKFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 06:05:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45688 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab1EIKFv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 06:05:51 -0400
Received: by wya21 with SMTP id 21so3739890wya.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 03:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=+Px/bJSrHKUf5CcDgsA03inKc+/ovIXSzM6HTfRK7hw=;
        b=G2YkAX0Fz4irTPdjK9ErlUc4nbkIPDKwQXBCZO1MaCwIapWENOuAgTPpQOC/aXoYkS
         /OGSO2E6Zr1BpM7aIRvqLrNbJddQBz6W5xUTI+zI8+l3JNHxKakLEw9vIDrBENfGQ8dE
         I6llUZbOq5BVcpPng3MCe8A7F/Pgj23Nbx8Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=maXaNTcKxramujvlwciq7PnuoJhL5EP2DQ1hDPhyaVHFGnR23+z5AfwJb7aznJNnKF
         qZW1SduHO/NUIXlISKif+aKHY4S9eGYSy2mT3b8QVw/Uyyl281dP83LwtEQtfnGvwxgv
         2MV0/UH5ruNnQKox7qxNb2B2PVXdq18xk39+E=
Received: by 10.216.68.7 with SMTP id k7mr919707wed.54.1304935549671; Mon, 09
 May 2011 03:05:49 -0700 (PDT)
Received: by 10.216.86.204 with HTTP; Mon, 9 May 2011 03:05:49 -0700 (PDT)
X-Google-Sender-Auth: QLZ_rRUxL3GCw9Ifq52HoARlTdU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173214>

I noticed this a little while back, but thought it may have been my
own misunderstanding.  I wanted to selectively revert part of a file,
so I used 'git checkout -p filename'.  Then I needed to edit the hunk,
and got something like this:

    # Manual hunk edit mode -- see bottom for a quick guide
    @@ -236,6 +236,12 @@ int run_add_interactive(const char *revision,
const char *patch_mode,
            }
            args[ac] = NULL;

    +        for (i=0; i < ac; i++)
    +          {
    +            fprintf(stderr, "%s ", args[i]);
    +          }
    +        fprintf(stderr, "\n");
    +
    # ---
    # To remove '+' lines, make them ' ' lines (context).
    # To remove '-' lines, delete them.
    # Lines starting with # will be removed.
    #
    # If the patch applies cleanly, the edited hunk will immediately be
    # marked for discarding. If it does not apply cleanly, you will be given
    # an opportunity to edit again. If all lines of the hunk are removed,
    # then the edit is aborted and the hunk is left unchanged.

Since the diff was showing me the forward direction (from the base to
modified working tree), I expected that when I left the +'s in there,
that it was going to leave my hunk.  Unfortunately, it discarded my
hunk.  I can see the text at the bottom, and now it makes sense, but I
wonder if there's a way to make it so that you can edit the patch to
look the way you want, and keep those bits (in much the same way as
'git add -p' works)?

I hope that makes sense. :-)

Thank you!

-John
