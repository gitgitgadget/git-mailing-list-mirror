From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Move run_hook() from builtin-commit.c into
 run-command.c (libgit)
Date: Thu, 15 Jan 2009 14:59:39 -0800
Message-ID: <7v7i4wqioz.fsf@gitster.siamese.dyndns.org>
References: <1232031618-5243-1-git-send-email-s-beyer@gmx.net>
 <alpine.DEB.1.00.0901151637590.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 00:01:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNbDM-0000lG-ES
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 00:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936323AbZAOW77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 17:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761075AbZAOW75
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 17:59:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934914AbZAOW7z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 17:59:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AFB7B1C9FA;
	Thu, 15 Jan 2009 17:59:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F30331C9FB; Thu,
 15 Jan 2009 17:59:41 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 393039C4-E358-11DD-91AB-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105892>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 15 Jan 2009, Stephan Beyer wrote:
>
>> 	Stripping out a libified version seemed better to me than
>> 	copy and paste.
>
> Oh, definitely.
>
>> -	ret = start_command(&hook);
>> -	if (ret) {
>> -		warning("Could not spawn %s", argv[0]);
>> -		return ret;
>> -	}
>> -	ret = finish_command(&hook);
>> -	if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
>> -		warning("%s exited due to uncaught signal", argv[0]);
>
> What are the side effects of replacing this with "ret = 
> run_command(&hook);"?  This has to be discussed and defended in the commit 
> message.

I think the answer is "Lost warnings here and there".
