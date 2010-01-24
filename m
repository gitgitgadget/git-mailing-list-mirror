From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Sun, 24 Jan 2010 17:44:56 +0100
Message-ID: <201001241744.57139.j6t@kdbg.org>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <7viqasbmtc.fsf@alter.siamese.dyndns.org> <201001232141.49556.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 17:46:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ5bL-0001KP-Rd
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 17:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab0AXQqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 11:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754151Ab0AXQqK
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 11:46:10 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:27133 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754003Ab0AXQqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 11:46:08 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id F2F65CDF90;
	Sun, 24 Jan 2010 17:46:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 4600919F5EC;
	Sun, 24 Jan 2010 17:44:57 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <201001232141.49556.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137903>

On Samstag, 23. Januar 2010, Johannes Sixt wrote:
> On Samstag, 23. Januar 2010, Junio C Hamano wrote:
> > What happens if you did this?
> >
> > 	git --git-dir=//git/repo/repo.git --work-tree=/git/repo
> >
> > where "//git/repo" is on the "git server" and you are working in local
> > hierarchy "/git/repo"?
>
> Ah, right, this would not do the right thing. (But I can't verify this
> claim right now.)

I tested it, and it does the right thing. The reason is that before 
setup_work_tree() calls make_relative_path(), the --work-tree argument has 
been processed by make_absolute_path(), which adds the drive prefix.

As long as setup_work_tree() remains the only caller of make_relative_path(), 
we are safe.

-- Hannes
