From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] parse_options: Add flag to prevent errors for
 further processing
Date: Wed, 18 Jun 2008 11:52:42 -0700
Message-ID: <7v8wx2zibp.fsf@gitster.siamese.dyndns.org>
References: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com>
 <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com>
 <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org>
 <20080618033010.GA19657@sigill.intra.peff.net>
 <7vwskn1g2p.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806181709300.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Shawn Bohrer <shawn.bohrer@gmail.com>,
	git@vger.kernel.org, madcoder@debian.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 18 20:53:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K92n1-0007Oy-NK
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 20:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbYFRSw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 14:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbYFRSw4
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 14:52:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbYFRSw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 14:52:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D21B1660A;
	Wed, 18 Jun 2008 14:52:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 351BE16608; Wed, 18 Jun 2008 14:52:44 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806181709300.6439@racer> (Johannes
 Schindelin's message of "Wed, 18 Jun 2008 17:50:31 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C1AA423C-3D67-11DD-9CE6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85398>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 17 Jun 2008, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > I think the only right way to accomplish this is to convert the revision
>> > and diff parameters into a parseopt-understandable format.
>> 
>> Not necessarily.  You could structure individual option parsers like how 
>> diff option parsers are done.  You iterate over argv[], feed diff option 
>> parser the current index into argv[] and ask if it is an option diff 
>> understands, have diff eat the option (and possibly its parameter) to 
>> advance the index, or allow diff option to say "I do not understand 
>> this", and then handle it yourself or hand it to other parsers.
>
> AFAIR Pierre tried a few ways, and settled with a macro to introduce the 
> diff options into a caller's options.
>
> IOW it would look something like this:
>
> static struct option builtin_what_options[] = {
> 	[... options specific to this command ...]
> 	DIFF__OPT(&diff_options)
> };

I think that is the more painful approach Jeff mentioned, and my comment
was to show that it is not the only way.
