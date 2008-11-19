From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-remote: add verbose mode to git remote update
Date: Tue, 18 Nov 2008 17:53:23 -0800
Message-ID: <7vod0ctrak.fsf@gitster.siamese.dyndns.org>
References: <1227006242-21290-1-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: crquan@gmail.com
X-From: git-owner@vger.kernel.org Wed Nov 19 02:54:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2cHQ-0000Nz-AD
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 02:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbYKSBxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 20:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbYKSBxl
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 20:53:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbYKSBxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 20:53:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9578B17015;
	Tue, 18 Nov 2008 20:53:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BF3F11700C; Tue,
 18 Nov 2008 20:53:25 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E1294872-B5DC-11DD-AE41-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101305>

crquan@gmail.com writes:

> From: Cheng Renquan <crquan@gmail.com>
>
> Pass the verbose mode parameter to the underlying fetch command.
>
>   $ ./git remote -v update
>   Updating origin
>   From git://git.kernel.org/pub/scm/git/git
>   ...
> Signed-off-by: Cheng Renquan <crquan@gmail.com>
> ---
>   So now the patch looks very simple.

Indeed it does ;-), but there still is a minor nit.

> +	"git remote update [-v | --verbose] [group]",

Notice the difference between the example in your commit log message and
the help text?

I think "git remote [options] [cmd] [more options]" which is the current
option parser seems to try doing is very misguided, and a longer term
fix-up might be to redo the cmd_remote() option parser, but in the short
term, let's apply your patch with the following minor fixup:

diff --git c/builtin-remote.c w/builtin-remote.c
index 0af742b..abc8dd8 100644
--- c/builtin-remote.c
+++ w/builtin-remote.c
@@ -14,7 +14,7 @@ static const char * const builtin_remote_usage[] = {
 	"git remote rm <name>",
 	"git remote show [-n] <name>",
 	"git remote prune [-n | --dry-run] <name>",
-	"git remote update [-v | --verbose] [group]",
+	"git remote [-v | --verbose] update [group]",
 	NULL
 };
 
