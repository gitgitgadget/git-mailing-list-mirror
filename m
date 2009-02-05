From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 026fa0d5ad Breaks installs with absolue $(gitexecdir) and 
 $(template_dir) variables using older GNU makes
Date: Thu, 05 Feb 2009 00:01:11 -0800
Message-ID: <7vprhxgvnc.fsf@gitster.siamese.dyndns.org>
References: <4985E8E1.90303@gmail.com>
 <7v63jpibe8.fsf@gitster.siamese.dyndns.org>
 <a2633edd0902042338n25dc7be4vbb202d011eb4ad78@mail.gmail.com>
 <7vvdrpgvzl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, Steffen Prohaska <prohaska@zib.de>,
	git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 09:02:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzCD-0000PG-Ci
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757547AbZBEIBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757528AbZBEIBU
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:01:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757507AbZBEIBU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:01:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D398996D54;
	Thu,  5 Feb 2009 03:01:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2AB5296D53; Thu,
  5 Feb 2009 03:01:12 -0500 (EST)
In-Reply-To: <7vvdrpgvzl.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 Feb 2009 23:53:50 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2B80EE6E-F35B-11DD-8801-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108520>

Junio C Hamano <gitster@pobox.com> writes:

> Regardless, I think your patch to config.mak is independently good,
> because the way Makefile defines these directories is without the trailing
> slash, and it would be better to be consistent.

In other words, I am thinking about applying your patch after amending the 
log message like this.

    [PATCH] config.mak.in: define paths without trailing slash

    The main Makefile defines gitexecdir and template_dir without trailing
    slash.  config.mak.in should do the same to be consistent.

    Signed-off-by: Pascal Obry <pascal@obry.net>

I think the misuse of abspath is a separate issue.

The main Makefile should be made robust not to misdetect the relative vs
absolute, especially because not everybody uses config.mak.autogen, and
because people should be able to override these variables from the command
line of make invocation and the name of the directory with or without
trailing slash ought to mean the same thing.
