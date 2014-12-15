From: Benjamin Quorning <bquorning@zendesk.com>
Subject: But in `git checkout --patch`
Date: Mon, 15 Dec 2014 15:41:45 +0100
Message-ID: <CAN9HoQH5=z-d=J1HCA2UwGuFek21X6qCd_jFEkNpE6GiE50oNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 15:41:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0WqQ-0005SP-PP
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 15:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbaLOOlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 09:41:50 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:58960 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbaLOOlq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 09:41:46 -0500
Received: by mail-pd0-f181.google.com with SMTP id v10so11778588pde.12
        for <git@vger.kernel.org>; Mon, 15 Dec 2014 06:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zendesk.com; s=zencorpemail;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=XzH7EpSP7+SA8tfoXP6/8mV7odcKLMsqyOUJt9c/H94=;
        b=JeNPcSDvEB/0EUT0fz/oxq92UqwsZBevlOwYW/8Oefiupk3lX5DyzVFns1ErtRwny6
         sYSAMmtXov9/VTn0sReHdQ7iOym2reKSyO3F+yw3wIPLPF1O+jrgha+PkTm4Qe3pLSC1
         dqrtB9mhPvV82yG8NC5DV2CzHaHjhWpZmt/D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=XzH7EpSP7+SA8tfoXP6/8mV7odcKLMsqyOUJt9c/H94=;
        b=nNIvnVx3i1gE6mfs6thBpJO0t8TUH0okEhy28mDl5LpUwKceEBrAE2ZlFy4ogjFLxt
         85hfyu+rNob+yW3LFiu1BCAZbzIcnWlp+mR7S+xfDjSHLejt99X+dHFcetx494HEDvQB
         cf6NIxS/u3Z/QPdrnTg+vMu+IZ2cUddoZ/crTbyphiQ37K4yTyTRdHH1MH9BszRJf98P
         6QGXDwj5nzU4mYCyc+pkCHhJ9VzVMYxJeubv+R9t/5X61LEDgylZOVxWPGChweUMPzXE
         /YccoX5RShOhFX+Ud0UVnyR9Ym5iMLidBRKKGXqjuMn9g94sd6dGJQiJN0EBTBfD/za1
         vwjA==
X-Gm-Message-State: ALoCoQlpZ0Hd8EHL71to8I2sqj3K7RL+EKgiGZbDpQ+LYXHC4/V/CnXYOLWAj43U0VB3bbvD3vKe
X-Received: by 10.66.120.129 with SMTP id lc1mr52352051pab.86.1418654505611;
 Mon, 15 Dec 2014 06:41:45 -0800 (PST)
Received: by 10.66.150.196 with HTTP; Mon, 15 Dec 2014 06:41:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261406>

I'm not entirely sure how you like your bug reports, so I'll just the
best I can :-)

$ git --version
git version 2.2.0

$ uname -a
Darwin buzz.local 13.4.0 Darwin Kernel Version 13.4.0: Sun Aug 17
19:50:11 PDT 2014; root:xnu-2422.115.4~1/RELEASE_X86_64 x86_64

Reproduction steps:

1. A repository with a changed file, but no staged changes.
2. Execute `git checkout --patch`
3. When asked, press `e` to edit a chunk (opens an external editor in my case)
4. With the editor still open, click ctrl-C in the terminal.
5. The diff that was being edited, and the command prompt ("discard
this hunk from worktree" etc) is printed to the screen, over and over
again.
6. I have to grep and kill this process: /usr/bin/perl
/usr/local/Cellar/git/2.2.0/libexec/git-core/git-add--interactive
--patch=checkout --

--
Benjamin Quorning
