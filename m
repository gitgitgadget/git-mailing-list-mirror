From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] diff: make "too many files" rename warning optional
Date: Mon, 05 May 2008 12:52:59 -0700
Message-ID: <7vd4o0o7dw.fsf@gitster.siamese.dyndns.org>
References: <20080430172136.GA22601@sigill.intra.peff.net>
 <20080430172553.GC23747@sigill.intra.peff.net>
 <481CA227.1000801@ramsay1.demon.co.uk>
 <20080504192332.GB13029@sigill.intra.peff.net>
 <18462.18066.769759.585596@cargo.ozlabs.ibm.com>
 <20080505135954.GA17334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 05 21:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt6l7-0008NG-Sf
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 21:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbYEETxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 15:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbYEETxN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 15:53:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53899 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbYEETxM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 15:53:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CA91823AD;
	Mon,  5 May 2008 15:53:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E1EDD23A6; Mon,  5 May 2008 15:53:02 -0400 (EDT)
In-Reply-To: <20080505135954.GA17334@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 5 May 2008 09:59:55 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3375DA2-1ADC-11DD-BCFE-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81308>

Jeff King <peff@peff.net> writes:

> On Mon, May 05, 2008 at 09:28:18AM +1000, Paul Mackerras wrote:
>
>> At the moment I don't think there is a good way in Tcl to get hold of
>> the stderr output if a subcommand returns a non-zero exit status, but
>> ignore it if the exit status is 0, other than by redirecting stderr to
>> a temporary file, which has its own problems.  Tcl can bundle stderr
>> in with stdout, or ignore it, or take it as an error indication, or
>> send it to a file.
>> 
>> So if git commands can avoid writing non-error messages to stderr,
>> that will make my life easier...
>
> In that case, Junio, perhaps we should restrict this particular warning
> just to merge.

I am not sure if we really want to work around Tcl's braindamage like
that.

There is no stdwarn or stdinfo stream and I think it is a bug on the
receiving end to assume that anything that comes to stderr is an error.
