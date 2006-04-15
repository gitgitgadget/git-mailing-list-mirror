From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] diff-options: add --patch-with-stat
Date: Sat, 15 Apr 2006 15:01:43 +0200
Message-ID: <e5bfff550604150601n335205actb0e1955884e76582@mail.gmail.com>
References: <Pine.LNX.4.63.0604151340210.24303@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7v64lbggrd.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0604151436280.6147@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 15:01:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUkPN-0005wN-Dk
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 15:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWDONBq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 09:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWDONBq
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 09:01:46 -0400
Received: from wproxy.gmail.com ([64.233.184.235]:4497 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030227AbWDONBq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 09:01:46 -0400
Received: by wproxy.gmail.com with SMTP id i6so382348wra
        for <git@vger.kernel.org>; Sat, 15 Apr 2006 06:01:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KprkIG+RBaYoX4y6DwI5yCrR2Sd9cztCcq+ydB3+gKvLMEqHwQ5ZHHPpuFBCMCZlTKqN02PO8zHkXbxS3BFy2PbwkGn8Yo0hNK0DV/6kZbDQhXAa7/Mr5eohnMkZhNpIEP4wJnvbkpt7xzB5/GtlEPPsmMvCCqSL3xrwpV7pzOY=
Received: by 10.65.43.9 with SMTP id v9mr1305587qbj;
        Sat, 15 Apr 2006 06:01:43 -0700 (PDT)
Received: by 10.64.131.14 with HTTP; Sat, 15 Apr 2006 06:01:43 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604151436280.6147@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18748>

On 4/15/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 15 Apr 2006, Junio C Hamano wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > >     BTW I really would like to have a diffstat for combined diffs.
> > >     Any ideas?
> >
 Just another idea, from current git:

$ git-diff-tree -r -m --stat 4da8cbc23
4da8cbc234177d6a8cf749d4ef60bd05ec843898
---
 blame.c     |   20 ++++++++++++++------
 diff-tree.c |    2 +-
 diff.h      |    6 +++++-
 git.c       |   15 +++++++++++++--
 http-push.c |    1 +
 rev-list.c  |    1 +
 revision.c  |   26 ++++++++++++--------------
 revision.h  |    7 +++++--
 tree-diff.c |   46 +++++++++++++++++++++++++---------------------
 9 files changed, 77 insertions(+), 47 deletions(-)
4da8cbc234177d6a8cf749d4ef60bd05ec843898
---
 Documentation/diff-options.txt |    3 +
 Documentation/git-apply.txt    |    8 ++-
 Makefile                       |   14 ++++-
 apply.c                        |  123 ++++++++++++++++++++++++++++++++++------
 combine-diff.c                 |   12 ++++
 diff.c                         |   83 ++++++++++++++++-----------
 diff.h                         |    3 +
 http-fetch.c                   |    8 +--
 http-push.c                    |    6 +-
 9 files changed, 199 insertions(+), 61 deletions(-)

$ git-diff-tree -r -c  4da8cbc23
4da8cbc234177d6a8cf749d4ef60bd05ec843898
::100644 100644 100644 c5372b984a457d0e5bddcf0b334a1a3cdc149cec
cc7cc627c88d135c3f8d814449813e73c1ea3430
236095fc9a1a6ffc056be8616c0f83e4e8c7ec2f MM        diff.h
::100644 100644 100644 994ee90035c4ae5e055df79cea8621d294190a3f
aa0bc1f6f6a51fb39d54dc81b93805f86d19aa46
19a0f772e7bf729755c66ab38f5dfb64ae784f00 MM        http-push.c


PROPOSED OUTPUT:

$ git-diff-tree -r -c --stat 4da8cbc23

4da8cbc234177d6a8cf749d4ef60bd05ec843898
---
 diff.h      |    6 +++++-
 http-push.c |    1 +
 2 files changed, 6 insertions(+), 1 deletions(-)
4da8cbc234177d6a8cf749d4ef60bd05ec843898
---
 diff.h      |    3 +++
 http-push.c |    6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)


I agree Junio ouput is nicer, this one is perhaps more consistent with
git-diff-tree -m --stat output.

Marco
