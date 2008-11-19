From: "rae l" <crquan@gmail.com>
Subject: [RFC] On how to manage tags fetched from remote?
Date: Wed, 19 Nov 2008 10:27:37 +0800
Message-ID: <91b13c310811181827y4e37815egaa34ba164d9f4269@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 19 03:29:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2cog-0008Bb-7H
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 03:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbYKSC1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 21:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbYKSC1l
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 21:27:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:50248 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbYKSC1j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 21:27:39 -0500
Received: by ug-out-1314.google.com with SMTP id 39so406787ugf.37
        for <git@vger.kernel.org>; Tue, 18 Nov 2008 18:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=q962fIljO5S7jWay3Vxy/wEvNePKMvEco45/3zO1+AU=;
        b=Jlw0QxEyUe9bKw/+9oVcpisS3zQZPzMABk+R3uYrwiUFTnRQ4RP1+wnkCGS/qf/6Jw
         QiGSDmSTrCffUGchCT2z5Q2svH9HuCnq+373uWEHsnbWKFc47PzYCVSxMSKELyK2/DSi
         xTo3KQsTRfSipktU611rtkb8XAXblcLAXsnck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=vrVLs1EVAZmpK+yvBa7W4t0k8ggkt5G+iu7zFeqp1rr+W3okxMMVrkx2EFiQYvSAvm
         ZwKCajvhZCmnY7AxGgpf3/kf03cZi/09FgaSBln8GrsyNjX4Pf1ZEn1Zwwt6C9FfSJzv
         C/ECCOx4EGnRbAdY0tWIxUq1rDUf4RFxR4Xww=
Received: by 10.103.52.7 with SMTP id e7mr184533muk.115.1227061657956;
        Tue, 18 Nov 2008 18:27:37 -0800 (PST)
Received: by 10.103.191.7 with HTTP; Tue, 18 Nov 2008 18:27:37 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101310>

The application field:

I use one git working tree to track many remote git repository:

 $ git remote -v
 227-archives	ssh://192.168.3.227/vmos/linux-with-dm-patches.git
 block	git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git
 btrfs	git://git.kernel.org/pub/scm/linux/kernel/git/mason/btrfs-unstable.git
 cryptodev	git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
 djbw-md	git://git.kernel.org/pub/scm/linux/kernel/git/djbw/md.git
 dk-block	git://git.kernel.dk/linux-2.6-block
 fastboot	git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git
 gfs2-2.6-nmw	git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-nmw.git
 linux-2.6-stable	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6-stable.git
 linux-2.6-target	git://git.kernel.org/pub/scm/linux/kernel/git/tomo/linux-2.6-target.git
 linux-iscsi	git://git.kernel.org/pub/scm/linux/kernel/git/mnc/linux-2.6-iscsi.git
 linux-mm-trees	git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git
 linux-nfs-server	git://git.linux-nfs.org/projects/bfields/linux.git
 lio-core-2.6	git://git.kernel.org/pub/scm/linux/kernel/git/nab/lio-core-2.6.git
 ocfs2	git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git
 origin	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
 rostedt-rt	git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-rt.git
 staging	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 tj-misc	git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git
 tytso-ext4	git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 utrace	git://git.kernel.org/pub/scm/linux/kernel/git/frob/utrace.git
 v16.y	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git
 v21.y	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.21.y.git
 v22.y	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.22.y.git
 v23.y	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.23.y.git
 v24.y	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.24.y.git
 v25.y	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.25.y.git
 v26.y	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.26.y.git
 v27.y	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.27.y.git
 xfs	git://oss.sgi.com:8090/xfs/xfs-2.6.git

Among them only 227-archives is where I will push to, others are all fetch only,

When I want to update, I just issue a "git remote -v update" command,

I'd like tags from origin, and from the stable kernel team, those tags
are all named well,
like v2.6.27, v2.6.27.1, v2.6.28-rc1, ...

But some tags from some other developeres are named bad, some tags named origin,
or named block, which will be ambigous when I want to refer a local remote name.

Asking every developer to delete their ambigous tag name is very troublesome!

The problem is because tags have no namespace, not similar to remote
branches have
namespaces which I named for the remote. Like this command: "git branch -a":

  master
  my-test
  block/bfq
  block/blktrace
  block/cmdfilter
  block/dynpipe
  block/fcache
  block/for-linus
  djbw-md/for-neil
  ...

The local branch have no namespace, while remote branches all have
their remote name first.

One solution to avoid the ambigous names is that give tags namespaces,
too; But then a tag
will not be a simple tag anymore;

Another approach is not fetching tags from remotes which have ambigous
tag names; the current
git implementation will need I run "git fetch -n <remote>" many times,
I cannot use just one
"git remote -v update";

To achieve one "git remote -v update", there are two approaches, too:
1. Bypassing any switches or other arguments after "git remote udpate"
directly to git fetch,
  then "git remote update -n" will call "git fetch -n";
  But this will disable all tags in all remotes;
2. Store a no-tags config item to the remote config, which like:
  [remote "linux-iscsi"]
	url = git://git.kernel.org/pub/scm/linux/kernel/git/mnc/linux-2.6-iscsi.git
	fetch = +refs/heads/*:refs/remotes/linux-iscsi/*
	fetch-tags = false
  when git fetch read the no-tags config, it will disable tags from this remote;

I think the last approach is the best, and most feasible;

However, please comment. Thanks.

-- 
Cheng Renquan, Shenzhen, China
Steven Wright  - "Cross country skiing is great if you live in a small country."
