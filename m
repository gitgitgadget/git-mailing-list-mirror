From: John McIntyre <joh98.mac@gmail.com>
Subject: Re: Git Server Repository Security?
Date: Mon, 18 May 2015 13:32:07 +0100
Message-ID: <CABQ4iYjwa-KmZAQV=p5efQYBZu3ymQRNwTC4TGXdpo4groArCA@mail.gmail.com>
References: <CABQ4iYiWu17H1XhPYebmP27x=R11SKW0P91AW2y9S=r-2c0B1A@mail.gmail.com>
	<20150518102633.GA15186@book.hvoigt.net>
	<CABQ4iYgjtdw46Psow_e7uGLqx0ZiFt+TQOgXvCmP1-W10LGEmg@mail.gmail.com>
	<20150518115749.GA16841@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 18 14:32:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuKDW-0004pp-CV
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 14:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333AbbERMcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 08:32:11 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:35076 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbbERMcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 08:32:09 -0400
Received: by labbd9 with SMTP id bd9so217555411lab.2
        for <git@vger.kernel.org>; Mon, 18 May 2015 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nr/PMt2P2n/C25KV5p27FjAcU+9jaAkNOTkg6bc9Dks=;
        b=SY1EZOp65bCoWklnLyHiBt/hItmlMcsP9XTWba3rCxmsaxLXEmeO7/pqocWWtajHRA
         HJRtvyGeGs4TRXs6jp1Wqbp6T1gU2sDjCDjGNY21s83YHzhFDmSvsk9sX+QJOzYwIiuv
         omuixdJ9OQ2gvPonyapy0NYOeL9G6doD4EnI9mJOe0N0bVXSXF/Oi0lf14Xbwg67VbS6
         DzHZDHdIrAyjkNMKyh8/o5T0a42UqFLtN6hFE+fxqijJxy58xP1XCzESAGbJYt6iWZWF
         z6rAclblmNm1AIUlJEor2XTnKCuzav0ybD0emhtlbxe23mIvwlHqBCUG7E06b4y77xHv
         3e1A==
X-Received: by 10.152.27.162 with SMTP id u2mr16796629lag.22.1431952327679;
 Mon, 18 May 2015 05:32:07 -0700 (PDT)
Received: by 10.152.129.228 with HTTP; Mon, 18 May 2015 05:32:07 -0700 (PDT)
In-Reply-To: <20150518115749.GA16841@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269230>

2015-05-18 12:57 GMT+01:00 Heiko Voigt <hvoigt@hvoigt.net>:
> On Mon, May 18, 2015 at 11:58:03AM +0100, John McIntyre wrote:
>> 2015-05-18 11:26 GMT+01:00 Heiko Voigt <hvoigt@hvoigt.net>:
>> > Hi,
>> >
>> > On Mon, May 18, 2015 at 11:07:02AM +0100, John McIntyre wrote:
>> >> Hi,
>> >> I've been asked to set up a git repository for a few projects.  So I
>> >> have a Linux CentOS server running git.   I place the repositories
>> >> under /opt and I use the .ssh/authorized_keys of the git user, to
>> >> grant access. The user sends me his private key, and I paste it into
>> >> the end of the file.
>> >>
>> >> And now, I realise that there's a problem.  If I have /opt/repo1.git
>> >> and /opt/repo2.git, then all users can access both repositories.
>> >>
>> >> Is there a way to prevent this?
>> >
>> > If you want a simple tool using ssh-keys have a look at gitolite[1].
>> > It quite simple to setup and with it you can specify all kinds of access
>> > rights.
>>
>> That's adding a separate level of complexity.
>
> Yes its a little more complex but not much.
>
>> I looked into filesystem-level permissions.  I don't see any means of
>> doing so, because everyone accesses the repositories using the 'git'
>> user.  So even if I add a group like 'devClient1' and then change the
>> group ownership of a repo to that user, they'll still be able to
>> access all repos..?
>
> No the repositories are only accessible by the defined groups/users.
>
> The access control is done by the gitolite layer. It uses the command
> option in the authorized_keys file to restrict access. The access rights
> and groups and so on are configured in its own gitolite.conf file which
> is itself stored in a git repository in which you commit and push to
> change them (or add more ssh-keys).
>
> It only uses ssh to authenticate the authorisation is then handled by
> the gitolite tool.
>
> In my experience this is a setup simpler to handle then groups and users
> directly on the server. It also allows to give a unique url for
> accessing one repository. With multiple system users you would have one
> url per user per repository which is not nice when sharing these and
> breaks (or needs extra complexity) when using submodules.

All right, so I'm a bit confused.  I followed the instructions to get
gitolite, and put a public key, placing it on the server.  I then
run..

***
gitolite setup -pk server-git01_rsa.pub
Initialized empty Git repository in /home/git/repositories/gitolite-admin.git/
Initialized empty Git repository in /home/git/repositories/testing.git/
***

Our repositories are under /opt/git/n where n is the name of the repo.

Is there a config file where this is defined?
