From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 24/31] rebase: extract code for writing basic state
Date: Tue, 4 Jan 2011 20:19:24 +0100
Message-ID: <201101042019.24223.trast@student.ethz.ch>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-25-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 20:19:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaCPr-0003hh-L0
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 20:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864Ab1ADTT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 14:19:26 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:50746 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab1ADTT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 14:19:26 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 20:18:43 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 4 Jan
 2011 20:19:25 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <1293528648-21873-25-git-send-email-martin.von.zweigbergk@gmail.com>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164511>

Martin von Zweigbergk wrote:
> Note that non-interactive rebase stores the sha1 of the original head
> in a file called orig-head, while interactive rebase stores it in a
> file called head.
[...]
> +	if test "$type" = interactive
> +	then
> +		echo "$orig_head" > "$state_dir"/head
> +	else
> +		echo "$orig_head" > "$state_dir"/orig-head
> +	fi &&

Do we have to cater to the use-case where the user starts a rebase,
downgrades at a conflict, and then continues?

If not, you could read 'orig-head' first and fall back to 'head', only
writing 'orig-head' in the state saving independent of the mode.  That
would give us the chance of removing the redundancy at some point.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
