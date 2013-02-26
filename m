From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: Re: [PATCH] Improve QNX support in GIT
Date: Tue, 26 Feb 2013 20:54:58 +0200
Message-ID: <CAHXAxrOnRkqFEtYa2DN4FEwzeXpKhLsUx0yvoi59dtOSyEGOQw@mail.gmail.com>
References: <20130226172504.GA2271@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 19:55:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAPgT-0006rW-VL
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 19:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984Ab3BZSy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 13:54:59 -0500
Received: from mail-qe0-f47.google.com ([209.85.128.47]:36664 "EHLO
	mail-qe0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab3BZSy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 13:54:59 -0500
Received: by mail-qe0-f47.google.com with SMTP id q19so635622qeb.34
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 10:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=hWPx+BrXuKPmb5ZcT+U2+HxkO/beAOVUXIcelHlh6GY=;
        b=kU0wcoppxUdr5R54mlpkE8It6BSfkzqhaldsg1RGJ0YDEs4xaKlIzAKi6OPrbqj5eM
         kkkFzen/2YykkeSYjRHI7NyR85SH4I7epqmC9r1BKk9q+o3Hb2uQx5K0JkodzBzvIN/B
         sGdh5fiujRnZ24Pfkz52sBvIo0Ct81Clnw1Zka2NCeOglyWLw6sz7Wo94H8bHCE7eLIg
         YDIedVIb6qmQ2VTM+jlYxXFDxkmoYeXXKX0PR90nb7Ldg13sFlsKrB8tvvghTnnokjTT
         8pwbiVdFxXiBEy0gQsq6XeTVw4s2H7paoA2I2ZzoBjy+TRRoXhI6+wceB/1QPP00dTRj
         R+Og==
X-Received: by 10.49.108.9 with SMTP id hg9mr21689759qeb.34.1361904898449;
 Tue, 26 Feb 2013 10:54:58 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Tue, 26 Feb 2013 10:54:58 -0800 (PST)
In-Reply-To: <20130226172504.GA2271@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217158>

> I don't think it's a good idea to just enable thread support.  On QNX,
> once a process creates a thread, fork stops working.  This breaks
> commands that create threads and then try to run other programs, such
> as "git fetch" with an https remote.  If threads are enabled, I think
> that the uses of fork need to be audited and, if they can be called
> after a thread is created, fixed.

I did a quick look into the run-command.c and transport-helper.c
modules, they use pthread OR fork for external command spawning
depending on NO_PTHREAD declaration. Another fork() occurence in the
module daemon.c for daemonization and I know that it works.
