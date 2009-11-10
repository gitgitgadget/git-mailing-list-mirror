From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 20/24] http-fetch: add missing initialization of argv0_path
Date: Tue, 10 Nov 2009 22:56:08 +0100
Message-ID: <200911102256.08627.j6t@kdbg.org>
References: <20091109150235.GA23871@progeny.tock> <1257779104-23884-20-git-send-email-jrnieder@gmail.com> <7vpr7q6sw8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 22:56:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7yhQ-0007Ko-VY
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 22:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758449AbZKJV4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 16:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758440AbZKJV4I
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 16:56:08 -0500
Received: from [93.83.142.38] ([93.83.142.38]:61183 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758426AbZKJV4H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 16:56:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B32D419F5EA;
	Tue, 10 Nov 2009 22:56:08 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7vpr7q6sw8.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132600>

On Dienstag, 10. November 2009, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> > Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> > ---
>
> Why do you have inclusion of "exec_cmd.h" in [19/24]?  As far as I can
> tell, nothing you do in that patch depends on it.
>
> According to c6dfb39 (remote-curl: add missing initialization of
> argv0_path, 2009-10-13), this patch is necessary (and you must include
> "exec_cmd.h") on MinGW, regardless of the "give help upon -h" topic.
>
> I think this should be ejected from your series go directly to 'maint', or
> am I mistaken?

You are right.

This command (in bash):

comm <(git grepc -l main\( *.c) <(git grepc -l extract_argv0 *.c)

shows programs in the 1st column that have main(), but do not call 
git_extract_argv0_path. One remaining candidate is show-index.c, but its only 
call-out is sha1_to_hex(), which doesn't use any other services.

http-fetch.c is the only file that needs this patch.

-- Hannes
