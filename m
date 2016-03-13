From: =?UTF-8?B?0J3QuNC60LjRgtCwINCh0L7QsdC+0LvQtdCy?= 
	<n.a.sobolev@gmail.com>
Subject: git-secret - store your private data inside a repository
Date: Sun, 13 Mar 2016 17:11:30 +0300
Message-ID: <CAO_bL1xQ0C+HYdZQVvyHx3ByPaaJTgpQYhY7h9f76eQXHKZ_SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 13 15:15:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1af6nX-00057k-D9
	for gcvg-git-2@plane.gmane.org; Sun, 13 Mar 2016 15:15:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbcCMOLc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Mar 2016 10:11:32 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36481 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbcCMOLb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Mar 2016 10:11:31 -0400
Received: by mail-io0-f170.google.com with SMTP id z76so195804155iof.3
        for <git@vger.kernel.org>; Sun, 13 Mar 2016 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=FIIrMFdYMZkf0OcMnBHCdue92HjNZNOAEmqMvVJXx7o=;
        b=IbzBCQjkXnrld4vGNN8ULxVzZKz6ojUpU+JFPitxnVxfiypvw/uRd/0jsPIdNwktVt
         xlDud8rpYFoY2PQNVmFjQXigWZfYGm1bHTf9JRkV0jOvFfy8rtGJAWpsy6nztww6CQfu
         yrsf1bg+ZreXdgIz/d+0mIUpN8J3qmUUX4TMWGv3bOoTYwbUECB5KkofvvWCIIJ4OR/s
         hIv97sBB9V58U1fl5oTIfSa5REjEmvEPufU2mTp85SNDOy4PF5bUa2gG6cK7apLTl7Mk
         HoUN50+h67VkxmZjgwB/gggNUMtnRhI5nu9ixiZ79YvyJzbW/edeytom0/cItNVco1si
         vZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-transfer-encoding;
        bh=FIIrMFdYMZkf0OcMnBHCdue92HjNZNOAEmqMvVJXx7o=;
        b=CN+W3kjtN1K6ohiOatMgAzWkjORtv9niG7Lj7m/xdwYbPP2f58HNLgSkazz8r5w7bJ
         OWlZcwdkXpCuY8siR6cBitipBg23B4XglQuaD9eMsI1AWFbp7z1VIqY3xehzILJGSTom
         zhCpUN52xUMgmHMMNyeuTDLVtWWiDXBeHKPpdM0GucnshmPBNd+YPd1ww8lp6PQ5GmwM
         eiiy8cAXjYqoo5e1kAs21EkZb6p5In7Hz2QZjppujyhutSGB3azHKCAeBH/zuQ5MjNh5
         gmBc6Ywz31wLmUyQyggsNE5FaFg19O5WswLQEWvHqLx5Y83Ca8Lrs07VmCtfHHAGIXWU
         Rgug==
X-Gm-Message-State: AD7BkJKGYOotBybL4fOZ5Q2UuBcn76/wnNIJRKQs4yF33+49zYk390/LdLC1C2Dt2d8gnJMzdMz7n5kZBovp1Q==
X-Received: by 10.107.13.65 with SMTP id 62mr20014939ion.186.1457878290553;
 Sun, 13 Mar 2016 07:11:30 -0700 (PDT)
Received: by 10.36.15.74 with HTTP; Sun, 13 Mar 2016 07:11:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288752>

There=E2=80=99s a known problem in server configuration and deploying, =
when
you have to store your private data such as: database passwords,
application secret-keys, OAuth secret keys and so on, outside of the
git repository. Even if this repository is private, it is a security
risk to just publish them into the world wide web. What are the
drawbacks of storing them separately?

These files are not version controlled. Filenames change, locations
change, passwords change from time to time, some new information
appears, other is removed. And you can not tell for sure which version
of the configuration file was used with each commit.
When building the automated deployment system there will be one extra
step: download and place these secret-configuration files where they
need to be. So you have to maintain an extra secure server, where
everything is stored.
How does git-secret solve these problems?

git-secret encrypts files and stores them inside the git repository,
so you will have all the changes for every commit.
git-secret doesn=E2=80=99t require any other deploy operations rather t=
han git
secret reveal, so it will automatically decrypt all the required
files.
What is git-secret?

git-secret is a bash tool to store your private data inside a git
repo. How=E2=80=99s that? Basically, it just encrypts, using gpg, the t=
racked
files with the public keys of all the users that you trust. So
everyone of them can decrypt these files using only their personal
secret key. Why deal with all this private-public keys stuff? Well, to
make it easier for everyone to manage access rights. There are no
passwords that change. When someone is out - just delete his public
key, reencrypt the files, and he won=E2=80=99t be able to decrypt secre=
ts
anymore.

=46ind out more: https://sobolevn.github.io/git-secret/
