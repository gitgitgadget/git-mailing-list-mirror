From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mark gitk script executable
Date: Fri, 07 Jan 2011 11:29:59 -0800
Message-ID: <7v4o9k7brc.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1101061943140.6372@dr-wily.mit.edu>
 <7vlj2x8mr4.fsf@alter.siamese.dyndns.org> <20110107030119.GA32290@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anders Kaseorg <andersk@MIT.EDU>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 20:30:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbI0z-0005y5-N1
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 20:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab1AGTaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 14:30:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab1AGTaM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 14:30:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 297BE33F4;
	Fri,  7 Jan 2011 14:30:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6datpjXQ9D7gtkubFKxP0aih2sI=; b=YBGwTs
	8VmXItFcOnFFfyclBxVC6+TG4r7F6z0155r+CfMY4CjVzEcF8ElSkZN2/ve0C6Eq
	25pi0ZXfcHb3a6ZxHApKEQcv7BLMYy0kVxOA2h+PQ7daOOpc3fjWV29S1HstuI89
	QT1GburgdbU3eKUST2azWZXoJWreIqSsmgAcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c73ZWMpQsyJ8PAza++9d6NdBsxoqEzYG
	WqFZ/E7NGNiBnKCFrism+MR2zdh/HUJZDJo/5ZSijDlLRyxvfWAVnYOx46CA8W51
	lgyrXpJqshGg/285t10TwJcWEtIY4LM4N/7/K8hJ7+xVIvsX8VhpN5MLWUZzmdSI
	iwCL5uEqUpE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DAD5B33ED;
	Fri,  7 Jan 2011 14:30:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 606AE33EA; Fri,  7 Jan 2011
 14:30:40 -0500 (EST)
In-Reply-To: <20110107030119.GA32290@burratino> (Jonathan Nieder's message of
 "Thu\, 6 Jan 2011 21\:01\:19 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A055A830-1A94-11E0-A1AA-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164746>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Anders Kaseorg <andersk@MIT.EDU> writes:
>
>>> The executable bit on gitk-git/gitk was lost (accidentally it seems) by 
>>> commit 62ba5143ec2ab9d4083669b1b1679355e7639cd5.  Put it back, so that 
>>> gitk can be run directly from a git.git checkout.
>>>
>>> Note that the script is already executable in gitk.git, just not in 
>>> git.git.
>>
>> It did not lose the bit by accident but 62ba5143 pretty much was a
>> deliberate fix.  "gitk" is a source file, and its build product,
>> gitk-wish, is what is eventually installed with executable bit on.
>
> How does this case differ from other executable source files like
> git-am.sh?

Ok, strike that.

In the old days, some of us (but not me) used to value somewhat to be able
to run git-$frotz.sh from the build directory before installing, and having
the executable bit was in line with that philosophy.

I don't know if it still hold today, though.  For one thing, our Makefile
replace a lot more than it used to when building $(SCRIPTS) out of the
source files and git-$frotz.sh may not run in place as easily as before
anymore.

So it doesn't matter too much either way (and of course you can always say
"sh ./git-$frotz.sh" when it is not executable and the functioning of the
script does not depend on replacement done by the Makefile).

It seems that the majority is marked with executable bit, so just for the
sake of uniformity it probably is Ok to make it executable.  From a
purist's point of view, I'd rather see them uniformly marked as
non-executable, but as I said, it doesn't matter much to me (iow, meh).

The change needs to come from gitk repository, so I'll leave it up to Paul
;-)

Thanks for a sanity, Jonathan.
