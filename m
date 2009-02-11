From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Tue, 10 Feb 2009 16:31:07 -0800
Message-ID: <7vwsbxizlg.fsf@gitster.siamese.dyndns.org>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com>
 <200902110051.20975.robin.rosenberg.lists@dewire.com>
 <7vd4dpkfr2.fsf@gitster.siamese.dyndns.org>
 <200902110127.18149.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 01:32:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX323-00009B-Jn
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 01:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757613AbZBKAbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 19:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758060AbZBKAbT
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 19:31:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758121AbZBKAbR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 19:31:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DB46698E41;
	Tue, 10 Feb 2009 19:31:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3611A98E40; Tue,
 10 Feb 2009 19:31:09 -0500 (EST)
In-Reply-To: <200902110127.18149.robin.rosenberg.lists@dewire.com> (Robin
 Rosenberg's message of "Wed, 11 Feb 2009 01:27:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4AF56D34-F7D3-11DD-849A-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109362>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> onsdag 11 februari 2009 00:56:49 skrev Junio C Hamano:
>> We failed to honor what the end user wanted: to repack.  Why should we
>> exit 0 here?
>
> A repack may or may not yield a better packed repo. In this case, not,
> but for a different reason than failing to find better deltas. Given the
> circumstances that is most likely to cause the "failure (repacking on
> windows), this is "normal" behaviour and no reason to scare the user
> with an error code.

Up to this point, I felt my earlier misconception corrected, but then ...

> The unlink error might be enough.

... I think we should not even show unlink errors, if "this is not an
error, nothing to worry about" is the official stance about such failure;
otherwise the errors will scare people, *and* others then doubly complain
that even the command detects errors, the whole thing does *not* error
out.
