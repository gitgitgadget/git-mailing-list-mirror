From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] Use 'printf %s $x' notation in t5401
Date: Wed, 30 Jan 2008 17:16:59 -0800
Message-ID: <7vbq72hjzo.fsf@gitster.siamese.dyndns.org>
References: <20080130062156.GA15838@spearce.org>
	<7vlk67izoa.fsf@gitster.siamese.dyndns.org>
	<20080130064845.GR24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 02:18:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKO3z-0006Ee-HL
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 02:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335AbYAaBR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 20:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755227AbYAaBR0
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 20:17:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871AbYAaBRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 20:17:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 06EC43FF7;
	Wed, 30 Jan 2008 20:17:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6451B3FF4;
	Wed, 30 Jan 2008 20:17:16 -0500 (EST)
In-Reply-To: <20080130064845.GR24004@spearce.org> (Shawn O. Pearce's message
	of "Wed, 30 Jan 2008 01:48:45 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72084>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> Do you really mean this? "printf %s 1 2 3" writes "123" without
>> terminating LF.  You seem to check only for size but to be
>> reusable you might want to use something like:
> 
> The only thing we care about is was there args or not to the hook.
> I probably could do that test differently, like say:
>
> 	echo $# >$GIT_DIR/pre-receive.args
>
> and then test that the file contains "0" instead of looking for it to
> be empty.  Not sure why I didn't write it that way in the beginning.
>
>> 	printf '%s\n' "$@"
>
> Eh.  Since all we care is that the argument count is 0 we probably
> should be looking at $# and calling it a day.

I'll apply as-is, but once you break the code that calls
pre-receive hook in such a way that it sends unexpected
arguments, you'd thank me for suggesting to print the arguments
separately while debugging the problem with the test script.
