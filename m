From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How do I undo a fast-forward merge safely?
Date: Sun, 22 Feb 2009 11:54:47 -0800 (PST)
Message-ID: <m3fxi6s0vu.fsf@localhost.localdomain>
References: <e38bce640902221115o2dd1c63dv6f7acc374b48d418@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 20:56:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbKR1-00038x-Oc
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 20:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbZBVTyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 14:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbZBVTyu
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 14:54:50 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:60464 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbZBVTyt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 14:54:49 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2568667fgg.17
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 11:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=3c/isyaRgFShssANenPPxTMTnVdgSdXdoj+ximHffM4=;
        b=Y+ZXcuxHxaxtCgZMwvwlO/8WRwIFF3V4xBSciOSOJoIIQvW3dM5rNMs0IgCFMeM9PN
         WddmKcVTTx6wjorExEsFR5dfaCiyZyyNlu4S1wlxP3gaRKztxKd8YyowuV3c72g1yVh4
         11GFU8riTN0kUcvOaQWmVyC4cM1aGxqVNA0Mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=OXHdZBZvRF3253f9pElLwEhifQgYIXRTS9Os9xyCX5JUvY9MhRROZ7uYKTPOdIuvC3
         Kz9R0ji4TiTiWbJQofd+mkc/bp85prkFuvLtlPhVyu7Iv4P4lhBpXYxvQ0SEn5Xe0CQr
         O/Vg8rcGLBoQRcuA95tv5CetyU1ygWckqj5Dw=
Received: by 10.86.83.1 with SMTP id g1mr938000fgb.20.1235332487729;
        Sun, 22 Feb 2009 11:54:47 -0800 (PST)
Received: from localhost.localdomain (abvl123.neoplus.adsl.tpnet.pl [83.8.209.123])
        by mx.google.com with ESMTPS id 12sm10551270fgg.53.2009.02.22.11.54.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 11:54:47 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n1MJsk5U031051;
	Sun, 22 Feb 2009 20:54:47 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n1MJsjHM031047;
	Sun, 22 Feb 2009 20:54:45 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <e38bce640902221115o2dd1c63dv6f7acc374b48d418@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111054>

Brent Goodrick <bgoodr@gmail.com> writes:

> I had done a git merge --no-commit <source_branch> operation, but that
> bit me because I mistakingly concluded that --no-commit would prevent
> any type of automatic operation, but apparently a fast-forward
> occurred.  I should have used the --no-ff option? How do I get my
> target branch back to where it was before the bad merge?

[...]
> So, what operations, rebase, reset, etc, do I need to do to get this
> repo back to where it was right before the fast-forward?

Each 'large' operation sets ORIG_HEAD

  $ git reset --hard ORIG_HEAD

If you want to be more careful, examine reflog for HEAD, using either
"git reflog" or "git log -g", and you can reset to previous version of
HEAD (i.e. where current branch pointed to before 'git fetch') with

  $ git reset --hard HEAD@{1}

-- 
Jakub Narebski
Poland
ShadeHawk on #git
