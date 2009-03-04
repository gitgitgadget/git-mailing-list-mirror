From: Tim Visher <tim.visher@gmail.com>
Subject: Strange push/clone errors
Date: Wed, 4 Mar 2009 09:01:51 -0500
Message-ID: <c115fd3c0903040601xbfce200q78c53aeee0b44f2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 15:03:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lergw-000369-MK
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 15:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbZCDOBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 09:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbZCDOBy
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 09:01:54 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:33739 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZCDOBx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 09:01:53 -0500
Received: by an-out-0708.google.com with SMTP id c2so2390957anc.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 06:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Gw4Pi1m46Ec6xj2jZxvTuNpI+vCUZGzrCEzDxhyBdVM=;
        b=qU74Cz/vLZu4ethPyI/LNQQ9lOUMK0kqJj9W2xhwsy/m1gnWu5ezxncMGQ6RPWsDhr
         BkgaiAGx0Xsiydn96pg4Cw6uoJ16UidIp64WAUrPxavQWrsCTRR5H/81RUJOrANJ2Y8K
         9ltTkgx9sMDxP6+FCIi8JNvd/2Plsv29Mwsn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=X6hhe+eEkE7mUxIBZz1DiVjYsYBYk/4BD5igXNGenQkWNq2jnIjhICBNgj18KsgmcP
         YYo3O5Y54d4TTyIcT+Vq0xjlDGi/+//4gfMqsfPX4e56vTvHD0sDwCLGyo5FPLzNyqcy
         pKH/AR4dG5znbd7X5cC9ebCjEoFxSjR+MA+LE=
Received: by 10.100.13.6 with SMTP id 6mr6637937anm.9.1236175311277; Wed, 04 
	Mar 2009 06:01:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112213>

Hello Everyone,

I'm trying to maintain an offline copy of the Git repo for our Sandbox
environment at work and I just came across and oddity in the behavior
I'd expect.

I have a repo on an Internet enabled machine that is a direct clone of
the kernel.org version.

    $ git show remote origin
    * remote origin
      URL: http://www.kernel.org/pub/scm/git/git.git
      Remote branch merged with 'git pull' while on branch master
        master
      Tracked remote branches
        html
        maint
        man
        master
        next
        pu
        todo

I then have a repo on a thumb drive that's initially a `clone --bare`
of the repo on the Internet enabled machine.  I added that as a remote
on the previously mentioned repo.

    $ git remote show sandbox
    * remote sandbox
      URL: /cygdrive/f/Documents/git.git/
      Tracked remote branch
        master

When I do a `git push sandbox master` I get the following

    $ git push sandbox master
    Everything up-to-date

The problem is here.  Now that I have a supposedly up to date copy on
my thumb drive, I'd like to be able to push it out to a central server
on our Sandbox network.  However, when I do a git clone, tags are
missing.

    $ git clone /cygdrive/f/Documents/git.git/
    Initialized empty Git repository in /home/tvishe01/Desktop/git/.git/
    Checking out files: 100% (1589/1589), done.

    $ cd git/

    $ git tag

    ...
    v1.6.1.3
    v1.6.2-rc0
    v1.6.2-rc1

Doing the same thing in the repo connected to kernel.org I get:

    $ git tag
    v1.6.1.3
    v1.6.2
    v1.6.2-rc0
    v1.6.2-rc1
    v1.6.2-rc2

As you can see, v1.6.2 and v1.6.2-rc2 are missing from the repo that
I'm pushing to on my thumb drive, despite it claiming it's up to date.

What am I doing wrong?

Thanks in advance!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
