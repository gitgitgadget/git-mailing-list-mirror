From: Junio C Hamano <junio@pobox.com>
Subject: Re: [kernel.org users] README and ChangeLog files
Date: Fri, 22 Aug 2008 14:13:35 -0700
Message-ID: <7vej4g92io.fsf@gitster.siamese.dyndns.org>
References: <48AC6839.7050605@zytor.com> <1219264114.7576.1121.camel@calx>
 <20080820210733.GA418@smurf.noris.de>
 <20080820223033.GD18947@flint.arm.linux.org.uk>
 <alpine.LFD.1.10.0808201552070.3487@nehalem.linux-foundation.org>
 <1219273792.7576.1146.camel@calx>
 <alpine.LFD.1.10.0808201622260.3487@nehalem.linux-foundation.org>
 <1219294266.7576.1180.camel@calx> <20080821125945.GE16634@mit.edu>
 <7vk5eaez0m.fsf@gitster.siamese.dyndns.org>
 <20080822082908.GA29475@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Russell@hera.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	users@kernel.org, Matt Mackall <mpm@selenic.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	King <rmk@arm.linux.org.uk>, git@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 23:14:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWdyD-0006mb-6H
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbYHVVNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753143AbYHVVNv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:13:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbYHVVNu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:13:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D4B1C63D6D;
	Fri, 22 Aug 2008 17:13:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4ADF063D62; Fri, 22 Aug 2008 17:13:37 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 37223CB8-708F-11DD-A2FC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93368>

Dominik Brodowski <linux@dominikbrodowski.net> writes:

> On Thu, Aug 21, 2008 at 04:20:25PM -0700, Junio C Hamano wrote:
>> Yes, and the fact that it is not "git-foo" that was deprecated, but
>> running the dashed-form without adjusting PATH was, makes it impractical
>> to issue warning messages before the transition actually happened.
>
> So I can safely ignore the warning in the release notes which states
>
> | but users are again strongly encouraged to adjust their
> | scripts to use "git xyzzy" form, as we will stop installing
> | "git-xyzzy" hardlinks for built-in commands in later releases.
>
> ?

No.  What the above means is that the deprecation and removal of git-foo
for builtins (such as "git commit") are not done in 1.6.0, but it will
eventually happen.  So your two choices are:

 (1) stop using dashed form "git-foo" and replace them with "git foo" form
     everywhere in your script now and won't worry about this anymore; or

 (2) add this to the beginning of your existing scripts:

     PATH=$(git --exec-path):$PATH

     and later do (1) when you have time.

But if you choose to do the latter, please do so after promising that you
won't complain like this time everybody did, saying "Oh, I knew it was
coming but I have postponed doing it for a long time because it continued
to work" ;-)

[jc: git list cc'ed]

Maybe we should try to see how hard it would be to issue warnings when
"git-foo" form is used for builtins before we declare that dashed form is
deprecated for builtins, and start warning when the deprecation actually
happens.  As many people on this thread suggested, it would make the
transition easier.
