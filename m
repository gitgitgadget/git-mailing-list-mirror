From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Make section_name_match start on '[', and return the
 length on success
Date: Sat, 25 Jul 2009 10:39:04 -0700
Message-ID: <7vbpn8u0g7.fsf@alter.siamese.dyndns.org>
References: <1248470504-16326-1-git-send-email-alex@chmrr.net>
 <1248470504-16326-2-git-send-email-alex@chmrr.net>
 <alpine.DEB.1.00.0907251605240.8306@pacific.mpi-cbg.de>
 <1248542170-sup-4264@utwig>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Sat Jul 25 19:39:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUlDY-0002gh-QB
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 19:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbZGYRjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 13:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbZGYRjZ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 13:39:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbZGYRjY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 13:39:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 666A811136;
	Sat, 25 Jul 2009 13:39:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E861B11133; Sat, 25 Jul 2009
 13:39:16 -0400 (EDT)
In-Reply-To: <1248542170-sup-4264@utwig> (Alex Vandiver's message of "Sat\,
 25 Jul 2009 13\:18\:52 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 17EC7108-7942-11DE-B22C-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124025>

Alex Vandiver <alex@chmrr.net> writes:

> At Sat Jul 25 10:09:56 -0400 2009, Johannes Schindelin wrote:
>> Is this not unnecessary, given that we  only call that function when we 
>> know that buf[0] == '[':
>
> Yes.  However, given that I had changed the calling convention for the
> code, (it used to be passed the string starting just _inside_ the
> '['), I wanted to make the new calling convention clearer, and catch
> any places that were using the old convention.

It's Ok.  I do not think this is performance critical part of the system,
and I'd feel safer with a bit of defensive programming like this,
especially because "git config" that writes (reader is Ok) has
traditionally been one of the most fragile part of the system.

> I'm happy to submit a new version without it, if you wish.
>
>> I was a bit surprised that "offset" is not used further in your patch, but 
>> I saw that 2/2 uses it.
>
> Yeah, this hunk should probably have gone in 2/2 instead.

I actually thought about suggesting to squash these two patches into one,
as the change in [1/2] only makes sense in the context of the [2/2], but
decided against it.

I haven't applied (actually, I didn't even notice until this morning) the
small documentation update from Nana.  Have any comments on that one?
