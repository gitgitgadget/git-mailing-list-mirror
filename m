From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: seg fault in "git format-patch"
Date: Sun, 31 May 2015 13:45:11 -0700
Message-ID: <CAKRnqNJnaLioQPWYDmSiBfLCSMGdFR21bAEXRzdpkChDBf2wgw@mail.gmail.com>
References: <556B5D4C.4030406@gmail.com> <CAP8UFD0Pi3_hF0+S3AXktD5NkBL_Q1mU_oN4fULyZemDEUr8Jg@mail.gmail.com>
 <CAKRnqNKVfzt_qMqoxsjMpunUYDNYd8C0jACM69HxGhJHEeVY-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Development <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 22:45:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzA70-0001uO-Sp
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 22:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758438AbbEaUpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 16:45:35 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:35107 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbbEaUpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 16:45:33 -0400
Received: by wgme6 with SMTP id e6so99483470wgm.2
        for <git@vger.kernel.org>; Sun, 31 May 2015 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A7+Y4sM0iGLHbNRag12WbDPuePekXr98ttYSoIJ/F3w=;
        b=O5Wn8ymtN1uEj/JDSgnrlS05xFOKIZ3c+bY0HGZcykrHNK1kv+ZZLKYThREDi8nRc8
         XDViAkKCTTu3uH8c7wSG4zlhWgrlnk3cwd8FqQLfAH74G1ApP0ufCcAUcae4E83p/g3F
         tEeH15VaUG/YRAwc8Scx9xgB2V0IWlmeCh5TJzdF+XzVt/ben3DuqR+mk5PfcqxbPPkt
         fmKAYmD6lR98cdS3xmEuCN+poSm7nKvPsuuXza5DfW2SLoIlCmV67aXxO9XDbLGYFJUi
         VoQdQJ79uldKGOeSpCCvNUCRwPfy70zPPYp44BQkPR0C1nOBxEXpIM7Fx8zl6wyGY6qR
         Vo3A==
X-Received: by 10.194.248.227 with SMTP id yp3mr34273909wjc.32.1433105132276;
 Sun, 31 May 2015 13:45:32 -0700 (PDT)
Received: by 10.194.208.234 with HTTP; Sun, 31 May 2015 13:45:11 -0700 (PDT)
In-Reply-To: <CAKRnqNKVfzt_qMqoxsjMpunUYDNYd8C0jACM69HxGhJHEeVY-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270352>

Oh, you can also clone the gnu-pw-mgr and likely get the same result:

$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        fetch = +refs/heads/*:refs/remotes/origin/*
        url = ssh://git.sv.gnu.org/srv/git/gnu-pw-mgr.git
[branch "master"]
        remote = origin
        merge = refs/heads/master

On Sun, May 31, 2015 at 1:41 PM, Bruce Korb <bruce.korb@gmail.com> wrote:
> bt won't help much:
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x000000000047e62f in ?? ()
> (gdb) bt
> #0  0x000000000047e62f in ?? ()
> #1  0x000000000047e6ba in ?? ()
> #2  0x000000000043cb9a in ?? ()
> #3  0x000000000043e9cc in ?? ()
> #4  0x000000000040647d in ?? ()
> #5  0x0000000000405863 in ?? ()
> #6  0x00007ffff6fc3be5 in __libc_start_main () from /lib64/libc.so.6
> #7  0x0000000000405cd5 in ?? ()
>
> $ git --version
> git version 1.8.4.5
> $ rpm -q -a|grep  '^git'
> git-email-1.8.4.5-3.8.4.x86_64
> gitg-0.2.7-3.1.4.x86_64
> git-cvs-1.8.4.5-3.8.4.x86_64
> git-svn-1.8.4.5-3.8.4.x86_64
> git-web-1.8.4.5-3.8.4.x86_64
> git-gui-1.8.4.5-3.8.4.x86_64
> gitg-lang-0.2.7-3.1.4.noarch
> git-1.8.4.5-3.8.4.x86_64
> git-core-1.8.4.5-3.8.4.x86_64
> gitk-1.8.4.5-3.8.4.x86_64
>
> $ head -n 300 /etc/*eleas*
> ==> /etc/SuSE-release <==
> openSUSE 13.1 (x86_64)
> VERSION = 13.1
> CODENAME = Bottle
> # /etc/SuSE-release is deprecated and will be removed in the future,
> use /etc/os-release instead
>
> ==> /etc/lsb-release <==
> LSB_VERSION="core-2.0-noarch:core-3.2-noarch:core-4.0-noarch:core-2.0-x86_64:core-3.2-x86_64:core-4.0-x86_64"
>
> ==> /etc/lsb-release.d <==
> head: error reading '/etc/lsb-release.d': Is a directory
>
> ==> /etc/os-release <==
> NAME=openSUSE
> VERSION="13.1 (Bottle)"
> VERSION_ID="13.1"
> PRETTY_NAME="openSUSE 13.1 (Bottle) (x86_64)"
> ID=opensuse
> ANSI_COLOR="0;32"
> CPE_NAME="cpe:/o:opensuse:opensuse:13.1"
> BUG_REPORT_URL="https://bugs.opensuse.org"
> HOME_URL="https://opensuse.org/"
> ID_LIKE="suse"
>
>
> On Sun, May 31, 2015 at 1:26 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Sun, May 31, 2015 at 9:13 PM, Bruce Korb <bruce.korb@gmail.com> wrote:
>>> $ git format-patch -o patches --ignore-if-in-upstream
>>> 14949fa8f39d29e44b43f4332ffaf35f11546502..2de9eef391259dfc8748dbaf76a5d55427f37b0d
>>> Segmentation fault
>>> /u/gnu/proj/gnu-pw-mgr
>>> $ git format-patch -o patches
>>> 14949fa8f39d29e44b43f4332ffaf35f11546502..2de9eef391259dfc8748dbaf76a5d55427f37b0d
>>> patches/0001-remove-dead-code.patch
>>> patches/0002-dead-code-removal.patch
>>> patches/0003-add-sort-pw-cfg-program.patch
>>> patches/0004-add-doc-for-sort-pw-cfg.patch
>>> patches/0005-clean-up-doc-makefile.patch
>>> patches/0006-clean-up-doc-makefile.patch
>>> patches/0007-happy-2015-and-add-delete-option.patch
>>> patches/0008-fix-doc-Makefile.am.patch
>>> patches/0009-re-fix-copyright.patch
>>> patches/0010-finish-debugging-remove_pwid.patch
>>> patches/0011-only-update-file-if-something-was-removed.patch
>>> patches/0012-update-NEWS.patch
>>> patches/0013-bootstrap-cleanup.patch
>>
>> Could you tell us which git version you are using? You can use "git --version".
>> The operating system you are using could also be useful.
>> And maybe you could also run git under gdb and give us the output of
>> the "bt" (backtrace) gdb command when it crashes?
>>
>> Thanks,
>> Christian.
