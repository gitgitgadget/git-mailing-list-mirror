From: Simon Strandgaard <neoneye@gmail.com>
Subject: git gc - out of memory
Date: Sat, 14 Nov 2009 20:26:00 +0100
Message-ID: <df1390cc0911141126w1a0c5691p83885053a73f829@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 20:26:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9OG8-0007IE-HY
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 20:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbZKNTZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 14:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbZKNTZ5
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 14:25:57 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:48835 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbZKNTZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 14:25:57 -0500
Received: by fxm21 with SMTP id 21so1541535fxm.21
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 11:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=yIAwjU80SMl3B7uZ8t457/oZIXnt+Y9/mEX08Ggp4Jo=;
        b=hfrjqrl5i5xohSf5TfS1RS0TydSD/TPf0anZ0nTcFhnW5OU3eqN9RHd31sQwYQ917P
         oupupA8+JWVfR/Kje1pNhDHHh1Jt71qbAinTlXNUvs949gnQszKE4Q+watBQKN/Micon
         ulRtaMeXGBKqJfGOb4f8xbKoQp8hWjpYuWDAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=iRiG7bQjsVn0xqnGlwnUE3SXN55GClRsvX+ldRIgRuCMyxmXAjuX3Y4lilpr/avgh7
         fEzsoF8ZTMtoTJRma/merleCprNRfSZFnO/aCCcD5s9H/V46qGHmNta6XLTFEREZmvad
         oH+wyeK4oiEW3kq66mF6PkdKhEpGNKWU9V42M=
Received: by 10.216.87.81 with SMTP id x59mr1959057wee.147.1258226760026; Sat, 
	14 Nov 2009 11:26:00 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132881>

My bare repository is on an OpenBSD machine.
I was unaware of the importance of git gc until today
after investigating a problem with "git pull".
So there hasn't been run git gc on the repository ever.

The biggest file in the repository is a 45 mb file.
The repository size is near 2 gb.

What can I do?

$ git gc
Counting objects: 5934, done.
warning: suboptimal pack - out of memory
fatal: Out of memory, malloc failed8)
error: failed to run repack
$ git --version
git version 1.6.5.2
$ uname -a
OpenBSD amiga.opcoders.com 4.3 GENERIC#698 i386
$ ulimit -a
time(cpu-seconds)    unlimited
file(blocks)         unlimited
coredump(blocks)     unlimited
data(kbytes)         524288
stack(kbytes)        4096
lockedmem(kbytes)    662576
memory(kbytes)       1985524
nofiles(descriptors) 128
processes            64
$ du -ks myrepository.git
1859538 myrepository.git
$



Below is the "git pull" problem I'm having. I think its caused
by the former problem. When pulling it dies because of malloc failure.

prompt> git pull
remote: Counting objects: 280, done.
remote: fatal: Out of memory, malloc failed
error: git upload-pack: git-pack-objects died with error.
fatal: git upload-pack: aborting due to possible repository corruption
on the remote side.
remote: aborting due to possible repository corruption on the remote side.
fatal: protocol error: bad pack header
prompt> git --version
git version 1.6.5.2
prompt> uname -a
Darwin pidgin.local 9.8.0 Darwin Kernel Version 9.8.0: Wed Jul 15
16:55:01 PDT 2009; root:xnu-1228.15.4~1/RELEASE_I386 i386 i386
prompt> sw_vers
ProductName:    Mac OS X
ProductVersion: 10.5.8
BuildVersion:   9L31a
prompt>


Kind regards
Simon Strandgaard - http://gdtoolbox.com/
