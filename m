From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 9/9] rerere forget path: forget recorded resolution
Date: Mon, 11 Jan 2010 22:05:54 +0100
Message-ID: <201001112205.54404.j6t@kdbg.org>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com> <201001112022.31257.j6t@kdbg.org> <7v3a2cif04.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 22:06:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NURTU-00024h-28
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 22:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029Ab0AKVGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 16:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992Ab0AKVGu
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 16:06:50 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:27985 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751459Ab0AKVGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 16:06:50 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 71586CDF8D;
	Mon, 11 Jan 2010 22:06:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7A3FA19F5C6;
	Mon, 11 Jan 2010 22:05:54 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7v3a2cif04.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136664>

On Montag, 11. Januar 2010, Junio C Hamano wrote:
> Actually it is _very_ easy to fool rerere to do something totally
> unexpected, and I have been thinking about using the similarity comparison
> algorithm on the region outside the conflicted area between preimage and
> thisimage and reject use of rerere.
>
> Try this in an empty directory.
>[snip]
> Now, immediately after this sequence, rerere will give you an disaster.

Indeed. The problem here is that two entirely different resolutions are 
recorded for the same conflict hash *in one run of rerere*. The damage can be 
avoided if conflict hashes are not reused in do_plain_rerere (in the first 
loop). (Though, I'm currently not in the mood to look into this in more 
depth.)

Of course, this does not mean that *both* conflicts can be resolved 
automatically when the merge is repeated. In my use-case this would have been 
desirable (and even your example would suggest it is, but that is not 
generally true).

-- Hannes
