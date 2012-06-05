From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Tue, 5 Jun 2012 09:43:19 +0200
Message-ID: <CALbm-EZKBw_r6DXzqP7qcYe3tuAYLsy-7YF6tQFR9hJV5Q6mUQ@mail.gmail.com>
References: <CALbm-Ea5ZkAGFyB2OETqe7vK7LE+yO0zSaa_+kFMXOhO-nMwMQ@mail.gmail.com>
	<7vhauqsue3.fsf@alter.siamese.dyndns.org>
	<CALbm-EatNCPjFRO4NyGfZuSa72-FXwZcd_7cFe-f_iMOdGL4MQ@mail.gmail.com>
	<7vy5o2ra7w.fsf@alter.siamese.dyndns.org>
	<vpqpq9ejnxs.fsf@bauges.imag.fr>
	<CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 09:43:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SboQH-0001qZ-07
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 09:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612Ab2FEHnV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jun 2012 03:43:21 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59654 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab2FEHnU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2012 03:43:20 -0400
Received: by gglu4 with SMTP id u4so3729000ggl.19
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 00:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=AsR7n0ewPqLRHeOas5ZnLsD5b/y0JujoPhgpu7q+79k=;
        b=dWsW9IqcQNRYd7qQZXthiEsbdqftPA/SRFxNkYtoGnrpOb2OVztlUYoF5LbuOGB9pP
         w/RMBEwhrKY0fCHnV8lshtMhn/E2x6InjRwpvlExa11iob7giEXsSPVtcMDHlaOujPTA
         E3UmWWqJ9AC5rOyZNoXDkqI8B9cyXOlHXkxTThfGN2+yISbDsJmKSHZs6sEPGckCPRBp
         dD57ZrY2ghJ8vKPzJu/HmdxBshcIjZk2+pxhXSP5uyegt6/IlkzmB4OUMKdNjl1sB/Ab
         ACnS/aId8nYrOcBXkEfY2RtgBMlCXYyTvCg7fSN1nLZDAVxAj5pnpjWHzQI9P13lVTf0
         Sd7A==
Received: by 10.236.185.167 with SMTP id u27mr10457425yhm.32.1338882199562;
 Tue, 05 Jun 2012 00:43:19 -0700 (PDT)
Received: by 10.236.175.226 with HTTP; Tue, 5 Jun 2012 00:43:19 -0700 (PDT)
In-Reply-To: <CALbm-EZrKGaj1Q7gbmPmG0wQHxksnJqaS3bz3tMDsego7Zm2ZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199213>

Just did a short google search and found this:
http://serverfault.com/questions/294158/enable-acl-for-ecryptfs-mounted=
-home-directory

So I am convinced my filesystem is just broken as you said ;)

2012/6/5 Stefan Beller <stefanbeller@googlemail.com>:
> Hi,
>
> sb@sb:~/OSS/git/t$ ./t1304-default-acl.sh --verbose
> Initialized empty Git repository in /home/sb/OSS/git/t/trash
> directory.t1304-default-acl/.git/
> expecting success:
> =A0 =A0setfacl -m d:u::rwx,d:g::---,d:o:---,d:m:rwx $dirs_to_set &&
> =A0 =A0setfacl -m m:rwx =A0 =A0 =A0 =A0 =A0 =A0 =A0 $dirs_to_set &&
> =A0 =A0setfacl -m u:root:rwx =A0 =A0 =A0 =A0 =A0$dirs_to_set &&
> =A0 =A0setfacl -m d:u:"${LOGNAME}":rwx =A0$dirs_to_set &&
> =A0 =A0setfacl -m d:u:root:rwx =A0 =A0 =A0 =A0$dirs_to_set &&
>
> =A0 =A0touch file.txt &&
> =A0 =A0git add file.txt &&
> =A0 =A0git commit -m "init"
>
> [master (root-commit) 47f54f4] init
> =A0Author: A U Thor <author@example.com>
> =A00 files changed
> =A0create mode 100644 file.txt
> ok 1 - Setup test repo
>
> expecting success:
> =A0 =A0# SHA1 for empty blob
> =A0 =A0check_perms_and_acl .git/objects/e6/9de29bb2d1d6434b8b29ae775a=
d8c2e48c5391
>
> /home/sb/OSS/git/t/trash directory.t1304-default-acl
> not ok - 2 Objects creation does not break ACLs with restrictive umas=
k
> #
> # =A0 =A0 =A0 =A0 =A0 # SHA1 for empty blob
> # =A0 =A0 =A0 =A0 =A0 check_perms_and_acl .git/objects/e6/9de29bb2d1d=
6434b8b29ae775ad8c2e48c5391
> #
>
> expecting success:
> =A0 =A0git gc &&
> =A0 =A0check_perms_and_acl .git/objects/pack/*.pack
>
> Counting objects: 3, done.
> Writing objects: 100% (3/3), done.
> Total 3 (delta 0), reused 0 (delta 0)
> /home/sb/OSS/git/t/trash directory.t1304-default-acl
> not ok - 3 git gc does not break ACLs with restrictive umask
> #
> # =A0 =A0 =A0 =A0 =A0 git gc &&
> # =A0 =A0 =A0 =A0 =A0 check_perms_and_acl .git/objects/pack/*.pack
> #
>
> # failed 2 among 3 test(s)
> 1..3
> sb@sb:~/OSS/git/t$ cat trash\ directory.t1304-default-acl/actual
> # file: .git/objects/pack/pack-ee77696bcc9be7ef581005ee3706bc17fcba37=
6d.pack
> # owner: sb
> # group: sb
> user::r--
> user:root:rwx =A0 #effective:---
> user:sb:rwx =A0 =A0 #effective:---
> group::---
> mask::---
> other::---
>
> sb@sb:~/OSS/git/t$ mount
> /dev/sda3 on / type ext4 (rw,errors=3Dremount-ro)
> proc on /proc type proc (rw,noexec,nosuid,nodev)
> sysfs on /sys type sysfs (rw,noexec,nosuid,nodev)
> none on /sys/fs/fuse/connections type fusectl (rw)
> none on /sys/kernel/debug type debugfs (rw)
> none on /sys/kernel/security type securityfs (rw)
> udev on /dev type devtmpfs (rw,mode=3D0755)
> devpts on /dev/pts type devpts (rw,noexec,nosuid,gid=3D5,mode=3D0620)
> tmpfs on /run type tmpfs (rw,noexec,nosuid,size=3D10%,mode=3D0755)
> none on /run/lock type tmpfs (rw,noexec,nosuid,nodev,size=3D5242880)
> none on /run/shm type tmpfs (rw,nosuid,nodev)
> /dev/sda4 on /home type ext4 (rw)
> binfmt_misc on /proc/sys/fs/binfmt_misc type binfmt_misc
> (rw,noexec,nosuid,nodev)
> /home/sb/.Private on /home/sb type ecryptfs
> (ecryptfs_check_dev_ruid,ecryptfs_cipher=3Daes,ecryptfs_key_bytes=3D1=
6,ecryptfs_unlink_sigs,ecryptfs_sig=3D3b9d213e5c5d5780,ecryptfs_fnek_si=
g=3D77bec2da523c0338)
> gvfs-fuse-daemon on /home/sb/.gvfs type fuse.gvfs-fuse-daemon
> (rw,nosuid,nodev,user=3Dsb)
>
>
> So I am using /dev/sda4 on /home type ext4 (rw), but my user account
> has its home directory encrypted via ecryptfs.
> This is not run inside a virtual machine, it's a native computer.
>
>
>
> 2012/6/5 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Stefan Beller <stefanbeller@googlemail.com> writes:
>>>
>>>> I tried debugging into it:
>>>> In git/t/t1304-default-acl.sh there is:
>>>> check_perms_and_acl () {
>>>> =A0 =A0 test -r "$1" &&
>>>> =A0 =A0 getfacl "$1" > actual &&
>>>> =A0 =A0 grep -q "user:root:rwx" actual &&
>>>> =A0 =A0 grep -q "user:${LOGNAME}:rwx" actual &&
>>>> =A0 =A0 egrep "mask::?r--" actual > /dev/null 2>&1 &&
>>>> =A0 =A0 grep -q "group::---" actual || false
>>>> }
>>
>> Can you run it with --verbose and post the result?
>>
>>> Any ideas (other than "Your filesystem is broken",
>>> that is)?
>>
>> I'm very tempted to go for the "Your filesystem is broken" indeed.
>>
>>> As far as I can tell, with 'mask::---', these specific users who ar=
e
>>> given permissions to read from the objects wouldn't be able to read
>>> from them, so...
>>
>> That's my understanding too.
>>
>> Stefan, which filesystem are you using in the directory where you ru=
n
>> tests (type "mount" if you don't know)? Are you running on a virtual
>> machine?
>>
>> --
>> Matthieu Moy
>> http://www-verimag.imag.fr/~moy/
