From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Prepare Git::SVN for extraction into its own file.
Date: Thu, 26 Jul 2012 22:23:44 -0700
Message-ID: <7va9yl3hgf.fsf@alter.siamese.dyndns.org>
References: <1343344945-3717-1-git-send-email-schwern@pobox.com>
 <1343344945-3717-3-git-send-email-schwern@pobox.com>
 <7vvch93hpy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net,
	jrnieder@gmail.com
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 07:23:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sud1n-0006YM-9O
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 07:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266Ab2G0FXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 01:23:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55480 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930Ab2G0FXr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 01:23:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6ABA693F;
	Fri, 27 Jul 2012 01:23:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tadC5ec+5UHYpWR2DqrhAVi2LsU=; b=VOkyJD
	siHQQd/jP7N7u6H6H51fpREnXQ50U64h2nAV6WrNGCElkAnNn3LVDJ0BSKW/OXAA
	oodNGQNrIy1gxT8X1aLstiy+ebL0hEm0b6PEZK64YsNUv0A/pUyEhq630dCnaX4K
	kGG93S+VmTpw/Q2OcqBJkw3/oStOP2fevGOQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hhggDDwVXrll51akMOnizHdwobAKcFb9
	Qjv8oDiCLnRbRqsdNiBBHwCMo1wQXgl3cevQIEI5hynUJq2/8ZjlldgGNibQsVar
	C2HMLdJLTuhwGEDkgvFz76pImDFUX/+I+/nfHRpjmSoOwnS9oI/SNjbsuxvn6XmP
	hyGhQgH4D5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4BD2693E;
	Fri, 27 Jul 2012 01:23:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35B8F693D; Fri, 27 Jul 2012
 01:23:46 -0400 (EDT)
In-Reply-To: <7vvch93hpy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Jul 2012 22:18:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3D1D067A-D7AB-11E1-B5B7-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202336>

Junio C Hamano <gitster@pobox.com> writes:

> "Michael G. Schwern" <schwern@pobox.com> writes:
>
>> From: "Michael G. Schwern" <schwern@pobox.com>
>>
>> This means it should be able to load without git-svn being loaded.
>>
>> * Load Git.pm on its own and all the needed command functions.
>>
>> * It needs to grab at a git-svn lexical $_prefix representing the --prefix
>>   option.  Provide opt_prefix() for that.  This is a refactoring artifact.
>>   The prefix should really be passed into Git::SVN->new.
>
> I agree that the prefix is part of SVN->new arguments in the final

s/is/should be/; sorry for the noise.

> state after applying the whole series (not just these four but also
> with the follow-up patches).
> ...
> Again, I agree with you that passing $prefix as one of the arguments
> to ->new is the right thing to do in the final state after applying
> the whole series.  I don't know if later steps in your patch series
> will do so, but it _might_ make more sense to update ->new and its
> callers to do so without doing anything else first, so that you do
> not have to call out to the ::opt_prefix() when you split things
> out.
