From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Mon, 15 Apr 2013 13:49:43 +0530
Message-ID: <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com> <7vy5ck4m6b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 10:20:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UReeM-0007YM-FS
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 10:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934797Ab3DOIU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 04:20:26 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:59842 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124Ab3DOIUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 04:20:25 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so5434711iec.41
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=UEW9OrHYrOt52PaGHbW6lb8sERFG/i2gzqw9wmQtTd4=;
        b=0b7dcUEp8Ze/zdtmoCgGkE82iORgACqF8Ji4doF0k4XmeF74CbZQ1CBiZTCwjbsznO
         q3vcDzeeywGY1bqxdsu5Hvz5wJAo1PqDblEKHtPEFPUL8pm0CR4BVTCMS+CYLbvBEWp2
         zKyJaiC1OfRK2LQCOTalTExqfiXxIMFH0sgxhvlqun2CfXBlGWna/kmjKuICTvUtZ4KM
         zQ0gUGJoYsrFc+edbS8NOJQP3Q0hpfO4EgnottJmKfJMmvfQA1RoA5jsLo3YNsJbhYnk
         fADJJtslRSMlJDoDvwBGlcmy4Kh06rmen8g7Tu2ZpeeWPlHAKgeig+E49lb5Ds7+LkvJ
         33/Q==
X-Received: by 10.50.50.71 with SMTP id a7mr4585571igo.14.1366014023277; Mon,
 15 Apr 2013 01:20:23 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 01:19:43 -0700 (PDT)
In-Reply-To: <7vy5ck4m6b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221202>

Junio C Hamano wrote:
> Any new configuration variable brings its own problem by forcing
> existing users to countermand it explicitly from the command line.
> If the --separate-git-dir would not work for your application, you
> need a new feature and you can achieve the same by adding a new
> command line option (say, --submodule-git-dir), that would be more
> preferrable.

I'm getting a little tired of your first instinct to oppose every new
addition to git. (Ofcourse I understand your attitude as the
maintainer, but still)

It doesn't make sense as a command-line option, because it is "magic"
that kicks in only when git clone is executed inside an existing git
worktree.  The point is that the user doesn't have to remember
anything special: a normal git clone already does the right thing
outside a git worktree; my proposal is to make it do the right thing
inside a git worktree as well.  Although I'm not against allowing a
user to create a "full clone" inside a git repository by overriding
clone.submoduleGitDir via a command-line option, I really cannot see
why this would be anything but rare.  Why would a user *want* a full
clone inside a git worktree?

Also, naming it --submodule-git-dir can cause a lot of confusion:
--separate-git-dir names a specific directory to put the GITDIR in,
while --submodule-git-dir names a directory inside which to create
other named directories to put GITDIRs in.  Ofcourse
clone.submoduleGitDir is a bad name too: any suggestions?
