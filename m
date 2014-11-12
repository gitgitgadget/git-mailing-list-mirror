From: Michael Blume <blume.mike@gmail.com>
Subject: Re: mac test failure -- 2gb clone
Date: Wed, 12 Nov 2014 14:09:03 -0800
Message-ID: <CAO2U3Qjk+9QZXVrh+1qG_ozRstrcMSyiZjXFJY-YZcvcVBUp=g@mail.gmail.com>
References: <CAO2U3QjFCBqJ+_E-nyxGnm3GdwB1zJgK6d8SJ4QULQHY1D6bUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 23:09:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xog6Z-0001EQ-Ni
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 23:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490AbaKLWJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 17:09:28 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:34843 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbaKLWJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 17:09:25 -0500
Received: by mail-lb0-f178.google.com with SMTP id f15so11349772lbj.9
        for <git@vger.kernel.org>; Wed, 12 Nov 2014 14:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=s25bV/UHh2Os03O7y61jPDU5mVx8HGFqmuCjsYcQejg=;
        b=yUu90dCoZyWrbMEKLtolvU0MRjw7lpdfHH9dIAiQKRT4PWzkD8Oy96wS9jzn817QQj
         sXtvFpUjbddvyOXN+fkz3cL77mcFlPcndyKR3J4FpAKOPbHFJeTP5RDrexuAGt0YNJ7c
         v/Ibo8/ZAkaIvRIS2A8z+rsgapC68BVy3WdEwF253Psq2Z4MUOH0rwvqIq2W7nJGVgG2
         sHIh8cGn5jeCuMWoSa/nqrL3le09az9kRkT157VCFPSjBtMQuaoP8N3uSldzElBxhX9y
         0Wih3/IG6YZX8FQW60mrAhvMZusaAAfUJV08rbNOj7TrAGdQdw253F5xfMa2y0RbQ+i0
         T+uQ==
X-Received: by 10.152.27.133 with SMTP id t5mr4607369lag.88.1415830164018;
 Wed, 12 Nov 2014 14:09:24 -0800 (PST)
Received: by 10.25.160.20 with HTTP; Wed, 12 Nov 2014 14:09:03 -0800 (PST)
In-Reply-To: <CAO2U3QjFCBqJ+_E-nyxGnm3GdwB1zJgK6d8SJ4QULQHY1D6bUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Confirmed exists on master

On Wed, Nov 12, 2014 at 1:57 PM, Michael Blume <blume.mike@gmail.com> wrote:
> This is in pu, haven't checked if it's also in master, this is the
> first time I've run this test
>
> $ GIT_TEST_CLONE_2GB=t ./t5705-clone-2gb.sh -v
> Initialized empty Git repository in
> /Users/michael.blume/workspace/git/t/trash
> directory.t5705-clone-2gb/.git/
> expecting success:
>
> git config pack.compression 0 &&
> git config pack.depth 0 &&
> blobsize=$((100*1024*1024)) &&
> blobcount=$((2*1024*1024*1024/$blobsize+1)) &&
> i=1 &&
> (while test $i -le $blobcount
> do
> printf "Generating blob $i/$blobcount\r" >&2 &&
> printf "blob\nmark :$i\ndata $blobsize\n" &&
> #test-genrandom $i $blobsize &&
> printf "%-${blobsize}s" $i &&
> echo "M 100644 :$i $i" >> commit
> i=$(($i+1)) ||
> echo $? > exit-status
> done &&
> echo "commit refs/heads/master" &&
> echo "author A U Thor <author@email.com> 123456789 +0000" &&
> echo "committer C O Mitter <committer@email.com> 123456789 +0000" &&
> echo "data 5" &&
> echo ">2gb" &&
> cat commit) |
> git fast-import --big-file-threshold=2 &&
> test ! -f exit-status
>
>
> git-fast-import statistics:
> ---------------------------------------------------------------------
> Alloc'd objects:       5000
> Total objects:           23 (         0 duplicates                  )
>       blobs  :           21 (         0 duplicates          0 deltas
> of          0 attempts)
>       trees  :            1 (         0 duplicates          0 deltas
> of          0 attempts)
>       commits:            1 (         0 duplicates          0 deltas
> of          0 attempts)
>       tags   :            0 (         0 duplicates          0 deltas
> of          0 attempts)
> Total branches:           1 (         1 loads     )
>       marks:           1024 (        21 unique    )
>       atoms:             21
> Memory total:          2344 KiB
>        pools:          2110 KiB
>      objects:           234 KiB
> ---------------------------------------------------------------------
> pack_report: getpagesize()            =       4096
> pack_report: core.packedGitWindowSize = 1073741824
> pack_report: core.packedGitLimit      = 8589934592
> pack_report: pack_used_ctr            =          2
> pack_report: pack_mmap_calls          =          1
> pack_report: pack_open_windows        =          1 /          1
> pack_report: pack_mapped              =   54863024 /   54863024
> ---------------------------------------------------------------------
>
> ok 1 - setup
>
> expecting success:
>
> git clone --bare --no-hardlinks . clone-bare
>
>
> Cloning into bare repository 'clone-bare'...
> done.
> ok 2 - clone - bare
>
> expecting success:
>
> git clone file://. clone-wt
>
>
> Cloning into 'clone-wt'...
> fatal: No path specified. See 'man git-pull' for valid url syntax
> not ok 3 - clone - with worktree, file:// protocol
> #
> #
> # git clone file://. clone-wt
> #
> #
>
> # failed 1 among 3 test(s)
> 1..3
