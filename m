From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] log: Show reflog date with --date=normal
Date: Tue, 28 Jul 2009 10:05:34 -0700
Message-ID: <7vr5w07n6p.fsf@alter.siamese.dyndns.org>
References: <1e2f7d731286d99b74cc9af37beb5fe187e9d460.1248770042.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 28 19:05:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVq7b-0005w0-U3
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 19:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbZG1RFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 13:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbZG1RFn
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 13:05:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbZG1RFn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 13:05:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DD617178D7;
	Tue, 28 Jul 2009 13:05:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 04C68178CF; Tue,
 28 Jul 2009 13:05:36 -0400 (EDT)
In-Reply-To: <1e2f7d731286d99b74cc9af37beb5fe187e9d460.1248770042.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue\, 28 Jul 2009 10\:40\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E1A9A5B2-7B98-11DE-B1A4-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124262>

Thomas Rast <trast@student.ethz.ch> writes:

> The reflog case special-cases --date=default (internally DATE_NORMAL)
> to show the entry number instead of a date.  This means it is
> impossible to show the default date format for the reflog entries.

Isn't it the other way around?  Traditionally you wrote

    $ git show -g @{0}
    $ git show -g @{now}

to explicitly ask for either time or number, but without @{which}, the
presense of --date=<foo> for some unknown reason declares that you want
time for reflogs, too.  I personally think that is an insane behaviour,
but that is probably already stuck in people's fingers.

    $ git show -g --date=short master
    $ git show -g --date=short master@{0}
    $ git show -g --date=short master@{now}
    
I think what is broken, if anything, is the second case (i.e. with --date,
you cannot even ask for entry numbers).

You can get times in default date formats just fine.
