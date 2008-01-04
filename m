From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libgit: git_setup_directory() is not reentrant
Date: Fri, 04 Jan 2008 12:40:41 -0800
Message-ID: <7vd4shjpdi.fsf@gitster.siamese.dyndns.org>
References: <477E67C5.5020301@pipapo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Thaeter <ct@pipapo.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 21:41:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAtLz-0003xd-FH
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 21:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbYADUkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 15:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbYADUkx
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 15:40:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640AbYADUkw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 15:40:52 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 723044C5C;
	Fri,  4 Jan 2008 15:40:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F5264C5B;
	Fri,  4 Jan 2008 15:40:48 -0500 (EST)
In-Reply-To: <477E67C5.5020301@pipapo.org> (Christian Thaeter's message of
	"Fri, 04 Jan 2008 18:07:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69603>

Christian Thaeter <ct@pipapo.org> writes:

> While working on a git-browser, I noticed that git_setup_directory() is
> not reentrant.

Yup, that comes from a longstanding design of git that "a
command runs once and exits".  Do not call that twice, or help
the libification effort.
