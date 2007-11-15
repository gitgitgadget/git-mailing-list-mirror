From: Junio C Hamano <gitster@pobox.com>
Subject: Re: New repo quickly corrupted
Date: Thu, 15 Nov 2007 13:55:40 -0800
Message-ID: <7vejer41ib.fsf@gitster.siamese.dyndns.org>
References: <31e9dd080711151350u6c2ae40foc7c05e59496260fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Jason Sewall" <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 22:56:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ismgv-0005Yu-QR
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 22:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762667AbXKOVzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 16:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757732AbXKOVzs
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 16:55:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53746 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756792AbXKOVzs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 16:55:48 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 53DE12EF;
	Thu, 15 Nov 2007 16:56:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D4E40961C2;
	Thu, 15 Nov 2007 16:56:03 -0500 (EST)
In-Reply-To: <31e9dd080711151350u6c2ae40foc7c05e59496260fa@mail.gmail.com>
	(Jason Sewall's message of "Thu, 15 Nov 2007 16:50:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65165>

"Jason Sewall" <jasonsewall@gmail.com> writes:

> find . -type f -exec dos2unix {} +
> git commit -a --amend
> [accept same message]
> git fsck
> [same error message as above]
>
> I just built my git today, unmodified:
> git version 1.5.3.5.721.g039b
>
> What's going on?

Carelessness is what is going on.

Notice how nicely your "find . -type f -exec dos2unix {}" goes
down to .git/objects and eats your loose objects

You probably wanted to do

	git ls-files | xargs dos2unix

instead.
