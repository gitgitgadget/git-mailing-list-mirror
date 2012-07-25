From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH] Add a svnrdump-simulator replaying a dump file for testing.
Date: Wed, 25 Jul 2012 08:20:10 +0200
Message-ID: <4800743.K7ssi2Nkyl@flomedio>
References: <7v4noyo6tc.fsf@alter.siamese.dyndns.org> <7v8veakyar.fsf@alter.siamese.dyndns.org> <20120724195049.GD5210@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	davidbarr@google.com, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 08:20:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StuxK-0002Ap-Oj
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 08:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932786Ab2GYGUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 02:20:17 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56617 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932736Ab2GYGUP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 02:20:15 -0400
Received: by bkwj10 with SMTP id j10so234614bkw.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 23:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=goSkF6KxJRsndEa3igQjrE7Ywo1ecWpB0hYXH0M+LkY=;
        b=S3LpAK00sSZfvRrX4MmXzzAcTt9shKnWIMeaFRz2bARZqkyZ59P+xSZg93mOsE7OgY
         Tf0H5FAKlYBAAkU27UX8ZD71/3iN5y7jWe6JPI3+aIFAg3MIHmDnvlSlAjD5QyzSHMxR
         RWgESOiZ8CvzctauEkcOX7xIj+pi0PjSFjO1wl7K2WAADi0S3CgJHWnG4Wy1mQi1dQj6
         PPiIByLuPG/yqg3Alt3CJoLq3bjQVxua2WNBBsuedUhFTI3RyIcIjByUgczILQJKVCSl
         FENCSVNRDgg8RiioRontMgvSqZNPTl3NBqmYSPwtvTjGFJQn2bbX0hJ7+tCRmCq9VTiq
         +PMg==
Received: by 10.204.145.90 with SMTP id c26mr11589354bkv.34.1343197214416;
        Tue, 24 Jul 2012 23:20:14 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id gq2sm11902958bkc.13.2012.07.24.23.20.12
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 23:20:13 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120724195049.GD5210@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202129>

On Tuesday 24 July 2012 14:50:49 Jonathan Nieder wrote:
> > It is unclear how this is different from giving the ceiling by
> > specifying it as the "END" in -rSTART:END command line.  Is this
> > feature really needed?
> 
> I think the idea is that you put this script (or a symlink to it) on
> your $PATH with higher precedence than svnrdump and run a command
> that expected to be able to use svnrdump.  Then instead of going to
> the network, the command you run magically uses your test data
> instead.
> 
> If the command you are testing wanted to run "svnrdump" without the
> upper endpoint set, we need to handle that request, either by emitting
> all the revs we have, or by stopping somewhere.  The revlimit feature
> provides the "stopping somewhere" behavior which is not strictly
> needed but is presumably very useful when testing incremental fetch.

Exactly, the purpose is to transparently replace svnrdump.
Callers of svnrdump usually will specify -rSTART:HEAD, because they want to 
fetch everything they don't yet have.
This feature allows to limit HEAD and to simulate incremental fetches using 
the same dump file.
For me it proved very useful.

> Florian, do you mind if I make the revlimit feature a separate patch
> when applying this?

No problem.

> 
> Anyway, it looks good and reasonable to me, so will apply.
> 
> Thanks.
> Jonathan

--
Florian
