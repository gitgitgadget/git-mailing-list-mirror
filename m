From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 06/12] MSVC: config.mak.uname: drop -D__USE_MINGW_ACCESS
 from compile definitions
Date: Mon, 28 Apr 2014 17:32:45 +0200
Message-ID: <CABPQNSZhMCPyyKVX0AhpttJbEJ3uF4gUPR9gpN=DUcLLxviwPA@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org> <1398693097-24651-7-git-send-email-marat@slonopotamus.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 17:33:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WenYk-0006Vh-8v
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 17:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243AbaD1Pd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 11:33:29 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:51842 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbaD1Pd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 11:33:26 -0400
Received: by mail-ig0-f180.google.com with SMTP id c1so4911916igq.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=VajLhRqwjBmblClcQqA2pozYYiFGCaHK+GfId8UvYtI=;
        b=AfZgxQXaDm9x/XtmrtxrSaZw2+clY/5SDP5mDJ1hayPDL+CZmgLqAY+n5bZDt5RGjR
         llidq71vZJKDxivE4NcuTNbaU76BQziC46W/TQ72Vhunir0vrYQ6ggf96TXalGA6DSc1
         5WYY5L+xuJfESNlWC2nwZj8SYvHp9AWwoyi57Hcunieuik37ziEhSQBUWC8EdKpcU7lh
         w8mUCHKKbvOihDfS0Xtw7s+SIoIaaPRFkqFVRXsgMvojWulhKxFyJOAIOagfh7SKlD73
         JcolK6gQPQniScDo3OK0LnpArgZMESssnnG9ZJx6tnCceKT7GUXluJgQ67/zgeaNj8QR
         9vqQ==
X-Received: by 10.50.50.146 with SMTP id c18mr24108477igo.42.1398699205794;
 Mon, 28 Apr 2014 08:33:25 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 08:32:45 -0700 (PDT)
In-Reply-To: <1398693097-24651-7-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247365>

On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> -D__USE_MINGW_ACCESS only affects MinGW and does nothing when
> MSVC is used.

Seems reasonable in itself.

But, doesn't this mean that our access are currently broken on MSVC?
The comment about __USE_MINGW_ACCESS is:

/*  Old versions of MSVCRT access() just ignored X_OK, while the version
    shipped with Vista, returns an error code.  This will restore the
    old behaviour  */

This sounds like we should lift the access-fix up one abstraction, into Git.

But wait a minute. In Git for Windows, we already wrapped up access
for unicode-support (03a102ff - "Win32: Unicode file name support
(except dirent)"), doing the exact same thing already. This patch
isn't upstreamed yet, though.

Sounds like there's some cleaning up left to do on our behalf :)

This clean-up makes sense regardless, though.
