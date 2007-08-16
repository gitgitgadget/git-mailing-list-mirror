From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix an unitialized pointer in merge-recursive.c
Date: Thu, 16 Aug 2007 01:08:01 -0700
Message-ID: <7vsl6jkila.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550708160100t5aa93430x6cbe83e6e7a61d73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 10:08:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILaOv-00074S-M0
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 10:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbXHPIIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 04:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753448AbXHPIIK
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 04:08:10 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:52784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757039AbXHPIIH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 04:08:07 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 37496122381;
	Thu, 16 Aug 2007 04:08:25 -0400 (EDT)
In-Reply-To: <e5bfff550708160100t5aa93430x6cbe83e6e7a61d73@mail.gmail.com>
	(Marco Costalba's message of "Thu, 16 Aug 2007 10:00:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55986>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Indeed &mrtree is passed to merge_trees() that not always
> seems to set the value, so on some paths mrtree could
> return uninitialized.
>
> Spotted by a gcc 4.2.1 warning

Are you sure that gcc is correctly seeing the codeflow?

In merge(), mrtree is used only under index_only, and
merge_trees() always sets *result under index_only.
