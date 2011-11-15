From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/3] upload-archive: use start_command instead of fork
Date: Tue, 15 Nov 2011 05:28:08 -0500
Message-ID: <20111115102807.GA18649@sigill.intra.peff.net>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
 <1319472131-3968-4-git-send-email-kusmabite@gmail.com>
 <201111151122.48378.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, rene.scharfe@lsrfire.ath.cx
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Nov 15 11:28:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQGFV-0006T6-DY
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 11:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586Ab1KOK2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 05:28:13 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42579
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754293Ab1KOK2M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 05:28:12 -0500
Received: (qmail 6094 invoked by uid 107); 15 Nov 2011 10:28:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Nov 2011 05:28:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Nov 2011 05:28:08 -0500
Content-Disposition: inline
In-Reply-To: <201111151122.48378.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185453>

On Tue, Nov 15, 2011 at 11:22:48AM +0100, Thomas Rast wrote:

> > Remove the NOT_MINGW-prereq for t5000, as git-archive --remote
> > now works.
> 
> I see valgrind failures bisecting to this commit, like so:
> 
> ==19125== Syscall param execve(argv[i]) points to unaddressable byte(s)
> ==19125==    at 0x5303CB7: execve (in /lib64/libc-2.11.3.so)
> ==19125==    by 0x53045A5: execvpe (in /lib64/libc-2.11.3.so)
> ==19125==    by 0x4B183C: execv_git_cmd (exec_cmd.c:137)
> ==19125==    by 0x4F305E: start_command (run-command.c:277)
> ==19125==    by 0x47F5C9: cmd_upload_archive (upload-archive.c:98)
> ==19125==    by 0x4051F4: run_builtin (git.c:308)
> ==19125==    by 0x40538F: handle_internal_command (git.c:466)
> ==19125==    by 0x405556: main (git.c:553)
> ==19125==  Address 0x7feffe7d0 is not stack'd, malloc'd or (recently) free'd
> 
> when running 'make valgrind' in current master.  Let me know if you
> need more information.

With which test, and on what OS? I couldn't replicate running
t5000 on Linux.

-Peff
