From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: gitk "find commit adding/removing string"/possible pickaxe bug?
Date: Tue, 18 Jan 2011 22:16:01 +0100
Message-ID: <201101182216.01772.trast@student.ethz.ch>
References: <514EB3AA-CD31-4BDB-B777-B7AAEEDF5663@sebastianhahn.net> <20110118185027.GA10562@sigill.intra.peff.net> <201101182139.28808.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Sebastian Hahn <mail@sebastianhahn.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 18 22:16:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfIuQ-0001u2-E9
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 22:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445Ab1ARVQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 16:16:05 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:26901 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab1ARVQE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 16:16:04 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 18 Jan
 2011 22:15:44 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 18 Jan
 2011 22:16:02 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <201101182139.28808.trast@student.ethz.ch>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165218>

Thomas Rast wrote:
> So indeed
> 
>   git log -Squux -c -p
> 
> gives a combined diff.  But OTOH
> 
>   git log -Sbar -c -p
> 
> doesn't; it only gives a diff for the commit that introduced 'bar'.

It's actually even stranger.  -S does not seem to filter merges at
all.  For example, in git.git

  $ git log | grep -c ^Merge
  4677
  $ git log -Sthis_string_never_existed_anywhere -c | grep -c ^Merge
  4677

I think it should just filter all history, shouldn't it?  After all

  $ git log -- this_file_never_existed

also comes up empty.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
