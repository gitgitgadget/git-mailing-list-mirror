From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Technical details about the index file format.
Date: Mon, 11 Feb 2008 11:27:35 -0800
Message-ID: <7vr6fj8fa0.fsf@gitster.siamese.dyndns.org>
References: <1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 20:28:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOeKd-0001Ud-Ty
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 20:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759092AbYBKT1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 14:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758990AbYBKT1q
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 14:27:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758364AbYBKT1o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 14:27:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 91D474A17;
	Mon, 11 Feb 2008 14:27:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 03ECD4A16;
	Mon, 11 Feb 2008 14:27:38 -0500 (EST)
In-Reply-To: <1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com>
	(Robin Rosenberg's message of "Mon, 11 Feb 2008 07:28:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73569>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  Documentation/technical/index-format.txt |   91 ++++++++++++++++++++++++++++++
>  1 files changed, 91 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/technical/index-format.txt
>
> I believe the main index details are accurate. Anything else to explain.

You missed the most important feature.  The entries are sorted
in a particular order.

Also I do not think we store CE_UPDATE.  The tip of 'master'
will soon clarify about this.

Also when a name is longer than 12-bit can express, we will have
a constant there and the name length could be longer (you need
to strlen() it).  The tip of 'master' will soon have this fix
(we used to just overrun).

Other than these, I think the description is fairly accurate.
