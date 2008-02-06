From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH WIP] git-stash: add new 'drop' subcommand
Date: Wed, 06 Feb 2008 11:44:46 -0800
Message-ID: <7vfxw5yimp.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0802051401000.8543@racer.site>
	<47A9DE06.9050307@nrlssc.navy.mil> <47A9EA4A.60101@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Tim Stoakes <tim@stoakes.net>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:45:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqDP-00017G-3V
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 20:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754351AbYBFTpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 14:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbYBFTpL
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 14:45:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564AbYBFTpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 14:45:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 24FCA3D83;
	Wed,  6 Feb 2008 14:45:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EC5F13D79;
	Wed,  6 Feb 2008 14:44:58 -0500 (EST)
In-Reply-To: <47A9EA4A.60101@gnu.org> (Paolo Bonzini's message of "Wed, 06 Feb
	2008 18:11:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72834>

Paolo Bonzini <bonzini@gnu.org> writes:

>> Also missing is the ability to drop multiple stash entries at
>> one time. I think reflog delete will have to be modified to
>> accommodate this. What happens is that the deletions are performed
>> in a loop, and each deletion shifts the reflog entries so that they
>> don't necessarily point to the same thing.
>
> You just have to sort them backwards, either here or in git reflog.
>
>> +drop)
>> +	shift
>> +	drop_stash "$@"
>
> drop_stash $(echo "$@" | tr ' ' '\n' | sort -runt\{ -k2)

Yes, but this makes me suspect that the parameter should be
simply "n m" instead of "stash@{n} stash@{m}".
