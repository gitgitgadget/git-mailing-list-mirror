From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status in clean working dir
Date: Mon, 21 Jul 2008 19:48:02 -0700
Message-ID: <7vljzur5wd.fsf@gitster.siamese.dyndns.org>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca>
 <7vy73ur6pz.fsf@gitster.siamese.dyndns.org>
 <7vtzeir68z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Bremner <bremner@unb.ca>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 04:49:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL7w6-0006d1-BU
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 04:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646AbYGVCsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 22:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754524AbYGVCsK
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 22:48:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169AbYGVCsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 22:48:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ACEB236085;
	Mon, 21 Jul 2008 22:48:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 67FAC3607B; Mon, 21 Jul 2008 22:48:04 -0400 (EDT)
In-Reply-To: <7vtzeir68z.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 21 Jul 2008 19:40:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9DEA08F0-5798-11DD-B370-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89429>

Junio C Hamano <gitster@pobox.com> writes:

> Actually, the situation is now even worse than I originally thought
> especially with Jeff's pager.<cmd> patch on 'master' recently.  For
> example, you can screw yourself quite badly by forcing diff-files used in
> the scripts you run to page, defeating --exit-code option.  Which means
>
>  (1) It hurts?  Don't do it then; but
>
>  (2) Then why are we even allowing to configure the plumbing to page?
>
> Should we maintain a table of commands that we allow paging to be
> customized, and ignore pager.<cmd> for commands that are not in the list?
>
> Which codepath should issue error messages when the user tries to break
> the system by saying "pager.diff-files = true"?

Another possibility is to set up an extra process whose sole purpose is to
wait for the main process that feeds the pager pipe and relay its exit
status to the outside world.  But I do not think we would want to go
there...
