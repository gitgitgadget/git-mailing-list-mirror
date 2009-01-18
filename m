From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http-push: remove MOVE step after PUT when sending
 objects to server
Date: Sun, 18 Jan 2009 12:05:21 -0800
Message-ID: <7vocy4wfb2.fsf@gitster.siamese.dyndns.org>
References: <be6fef0d0901171224y35c3d95cn2d38639ac03c3b8f@mail.gmail.com>
 <7viqod5thi.fsf@gitster.siamese.dyndns.org>
 <be6fef0d0901171919ub28dda7ref6443abec3627aa@mail.gmail.com>
 <alpine.DEB.1.00.0901181425420.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 21:06:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOdv6-0000kE-8j
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 21:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbZARUFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 15:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754120AbZARUFa
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 15:05:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbZARUFa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 15:05:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E4E01CCD9;
	Sun, 18 Jan 2009 15:05:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0F38C1CCDD; Sun,
 18 Jan 2009 15:05:23 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901181425420.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun, 18 Jan 2009 14:32:30 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A15B142-E59B-11DD-BFBF-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106274>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The point is: the repository inside the document root of the web server is 
> still a valid repository.
>
> And the assumption is that whenever you have a file that looks like a 
> valid object/pack inside a valid repository, that it does not need 
> replacing.
>
> So even when optimizing the uncommon (HTTP push is 2nd class citizen), we 
> have to keep the common workflow intact (1st class citizens _are_ push by 
> file system, ssh or git://).

The first class citizens are "local use", not "copying out of the area
that looks like a repository only to http:// transport users".

> Which unfortunately means that put && move must stay.

I still do not understand why it is unfortunate.

As far as I understand, Ray's issue was that his filesystem did not like
the temporary file name that is used for the initial "put" phase because
it contained a character it did not like (colon, perhaps).  Why isn't the
patch about changing _that_ single issue?
