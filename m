From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/4] start_command: detect execvp failures early
Date: Thu, 14 Jan 2010 22:53:19 +0100
Message-ID: <201001142253.19595.j6t@kdbg.org>
References: <1263044757-12560-1-git-send-email-ilari.liusvaara@elisanet.fi> <201001101411.22418.j6t@kdbg.org> <7viqb49xwb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 22:54:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVXeN-00048V-OM
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 22:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756641Ab0ANVyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 16:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756594Ab0ANVyV
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 16:54:21 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:51143 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932310Ab0ANVyR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 16:54:17 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 120E310020;
	Thu, 14 Jan 2010 22:54:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id ADD5619F60C;
	Thu, 14 Jan 2010 22:53:19 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7viqb49xwb.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137030>

On Donnerstag, 14. Januar 2010, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> > Previously, failures during execvp could be detected only by
> > finish_command. However, in some situations it is beneficial for the
> > parent process to know earlier that the child process will not run.
> >
> > The idea to use a pipe to signal failures to the parent process and
> > the test case were lifted from patches by Ilari Liusvaara.
>
> I wonder if we can do this without pipe, perhaps using "vfork, exec, then
> update a variable"....

Except that some systems implement vfork(2) in terms of fork(2), I heard. 
Moreover, I think that we do way too many things before the exec; isn't that 
dangerous?

-- Hannes
