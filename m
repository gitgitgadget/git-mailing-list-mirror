From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: ssh/login style password requests
Date: Fri, 01 Feb 2008 15:34:20 -0800
Message-ID: <7v4pcs8d4z.fsf@gitster.siamese.dyndns.org>
References: <1201841954-17949-1-git-send-email-mfwitten@mit.edu>
	<7vodb19edp.fsf@gitster.siamese.dyndns.org>
	<FE992810-2B2E-4C23-A7D3-AD4C39D925ED@MIT.EDU>
	<5F77BB5B-8D2B-42FD-A805-7195757B14EE@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Feb 02 00:35:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL5Pe-0003Fq-C5
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 00:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762219AbYBAXef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 18:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762159AbYBAXee
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 18:34:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35405 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762120AbYBAXed (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 18:34:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F4372E1D;
	Fri,  1 Feb 2008 18:34:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D8CD2E1A;
	Fri,  1 Feb 2008 18:34:28 -0500 (EST)
In-Reply-To: <5F77BB5B-8D2B-42FD-A805-7195757B14EE@mit.edu> (Michael Witten's
	message of "Fri, 1 Feb 2008 17:42:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72193>

Michael Witten <mfwitten@MIT.EDU> writes:

> It turns out that --compose will also leave some temporary files
> behind if git-send-email is terminated out of course.
>
> Should I establish a general handler for SIGTERM and SIGINT?

I was mostly worried about ^C leaving the terminal in a funny
state with your system(stty).

I do not think you should lose the message the user carefully
composed using an editor upon seeing ^C.  The user may start to
compose, edit the message, and then at some later time decide to
stop the mail-sending procedure by ^C-ing out.  The user would
thank you if you somehow left an escape hatch to allow salvaging
the message, instead of having it to be re-typed from scratch.
