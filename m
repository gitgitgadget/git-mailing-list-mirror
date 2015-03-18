From: Jimmy Zelinskie <jimmy.zelinskie@coreos.com>
Subject: Submodule not working with specified work-tree
Date: Wed, 18 Mar 2015 11:31:20 -0400
Message-ID: <CACPE2UYkPc3nHM7g1MJt8u57P4TukuBo7Qbjn=f+axH81nvdWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 16:31:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYFwP-00033h-L8
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 16:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbbCRPbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 11:31:24 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:33058 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbbCRPbW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 11:31:22 -0400
Received: by ladw1 with SMTP id w1so39152864lad.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 08:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coreos.com; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=1jDLpAc2Oqq2AuUxSz7oA8q/3/xhGOfrPIwpyyUp99k=;
        b=EmOdOLafMT3uznWu8sWfMWkNfgD80LxR8QDAC/3sBMUZCH2149bhtUPkfIHSNFOyD4
         8G6PWTjy3Lq9qNSlrsirrWSGwl0+Tfieh7TU0MT5KaViBsm6YoJ1rw1yT8iMYQ7QVMV7
         YJNvKsyn6oGMZC2NsGYASCnsIFi3kvWCxxPvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=1jDLpAc2Oqq2AuUxSz7oA8q/3/xhGOfrPIwpyyUp99k=;
        b=bxL+vwjz/XsYTKhGPnaHCOuT3T/2dHonaAAdMbwsN7hb//D1K4+UX9YdtPeL0diwI0
         t8NH9bMXC3tCmMgNOhXFoOWlNbM+yH/N+nTcDw9wqgZ0tn73K6Ha4/brCIdmQceOsUon
         8VT/P/G7Irtrnvt9xUh+QQ92gMzpv4N6oPt1z5le/kH9RTOsQRlBLz5Zq72S1T+Ktb9u
         QgluJwH1kzORvwsfX2wszWAQYhpq6ml8rCMqqjatehkWCCmpFk/fOKEGZdBXhgRcjpr0
         BnygXy3q72ZFCredeaX4ZVStVjYm01hcqbz3SDImCBrZC4dhabuUArrEdGzezarzqlrt
         ke9g==
X-Gm-Message-State: ALoCoQmYn9bKgv/2/rIXTvUHC9MtIqyynf5W8VZLdldIzT+qaIwaoFIPyElD+gXyOcyS11abGYae
X-Received: by 10.152.26.136 with SMTP id l8mr65211718lag.109.1426692680858;
 Wed, 18 Mar 2015 08:31:20 -0700 (PDT)
Received: by 10.25.212.212 with HTTP; Wed, 18 Mar 2015 08:31:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265738>

It seems like submodule isn't picking up on the work tree that I'm
specifying. In the scenario that I'm working with, I'd prefer to not
have to "cd" into a directory to update the submodules. All the other
git subcommands that I'm executing work fine with specifying the git
dir and work tree via envvars or parameters. I'm not sure if this is a
bug or not.

$ git --git-dir $HOME/testrepo/.git --work-tree $HOME/testrepo
submodule update --init --recursive
fatal: /usr/local/Cellar/git/2.3.0/libexec/git-core/git-submodule
cannot be used without a working tree.

$ GIT_WORK_TREE=$HOME/testrepo GIT_DIR=$HOME/testrepo/.git git
submodule update --init --recursive
fatal: /usr/local/Cellar/git/2.3.0/libexec/git-core/git-submodule
cannot be used without a working tree.

$ git version
git version 2.3.0

$ uname -a
Darwin hanazawa.local 14.1.0 Darwin Kernel Version 14.1.0: Mon Dec 22
23:10:38 PST 2014; root:xnu-2782.10.72~2/RELEASE_X86_64 x86_64
