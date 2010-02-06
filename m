From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: notes TODOs (was: Re: [PATCH 1/4] gitweb: notes feature)
Date: Sat, 06 Feb 2010 03:30:45 -0800 (PST)
Message-ID: <m3aavma9gg.fsf@localhost.localdomain>
References: <cb7bb73a1002050444y55f57696gb1b3bd06ab9261ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 12:30:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdisI-0000lL-K2
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 12:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755472Ab0BFLau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 06:30:50 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:52749 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311Ab0BFLas (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 06:30:48 -0500
Received: by bwz19 with SMTP id 19so540872bwz.28
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 03:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=BJe/0n+JlpzAT4wxFE3vFBa19SylVho0C00kWz8l1z8=;
        b=VY7Z2G/OVTtgFak5pA0fMjsfRl0meIr5bK7txxvQuWUlNlNg1Q0jz0P7noprjR8KkY
         L/QNFaa8lU41inNQuWSZGWOUd7sWoTYlf7Kxf7TkzEGYKy+u1U7dsn+df+kzD6ANdhHu
         umap5OZxrVpae1SfmWKmU6F78Oy5F6C4SR1ew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=fAXcAXFkPw4pOBchtO1p3nRw94wnf/TdRAjCKoreB57kllevI1zhI4+mzwx9u4Dj6v
         q6XhFi2j8pgNKMKWzStI0MyAMoZiqLIEzOJME97LnlMzqfve+bp2VKdS8dgjHdaRuDO9
         QhThEyexh2Gd9eZVx+y66HVHZYvRRHOWE1GRU=
Received: by 10.204.140.18 with SMTP id g18mr2695348bku.47.1265455847407;
        Sat, 06 Feb 2010 03:30:47 -0800 (PST)
Received: from localhost.localdomain (abvb35.neoplus.adsl.tpnet.pl [83.8.199.35])
        by mx.google.com with ESMTPS id 14sm1084502bwz.1.2010.02.06.03.30.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 03:30:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o16BU2El008693;
	Sat, 6 Feb 2010 12:30:13 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o16BTZgh008685;
	Sat, 6 Feb 2010 12:29:35 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <cb7bb73a1002050444y55f57696gb1b3bd06ab9261ac@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139157>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> If I may be allowed to add a suggestion to put in the list, [...]

What I would like to see (besides --notes-ref or --notes option,
either as an option to git wrapper, or as an option to git-show,
git-format-patch, git-log and git-rev-list (I think that's all)),
is for git-notes to have a subcommand to move notes from one object
to the other:

  'git notes' move [-f] <oldobject> <newobject>

Both source and target should be required, as I am not sure if more
common would be moving note from some object to HEAD, or from HEAD to
some object.  The '-f'/'--force' option is in the case when note for
<newobject> exists (although it might be better to concatenate notes
in the future), and when <oldobject> and <newobject> are of different
types (unless we want som DWIM type coercion).

It could be used to make notes move to amended commit, for example:

  $ git commit --amend
  $ git notes move ORIG_HEAD HEAD # or HEAD@{1} HEAD

-- 
Jakub Narebski
Poland
ShadeHawk on #git
