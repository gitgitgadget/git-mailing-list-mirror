From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/3] diff: add "fasttextconv" config option
Date: Sun, 28 Mar 2010 20:23:00 +0200
Message-ID: <201003282023.00913.j6t@kdbg.org>
References: <20100328145301.GA26213@coredump.intra.peff.net> <20100328145421.GC27970@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 28 20:25:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvxAk-0008Dm-3v
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 20:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968Ab0C1SZL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Mar 2010 14:25:11 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:44273 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754952Ab0C1SZK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 14:25:10 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A80A91001B;
	Sun, 28 Mar 2010 20:25:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3532A19F5F1;
	Sun, 28 Mar 2010 20:23:01 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20100328145421.GC27970@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143417>

On Sonntag, 28. M=C3=A4rz 2010, Jeff King wrote:
> +	if (start_command(&child) !=3D 0 ||
> +	    strbuf_read(&buf, child.out, 0) < 0 ||
> +	    finish_command(&child) !=3D 0) {

This conditional is somewhat dubious. If strbuf_read fails, you do not =
wait=20
for the child, and a zombie remains.

The have this sequence already in run_textconv().

-- Hannes
