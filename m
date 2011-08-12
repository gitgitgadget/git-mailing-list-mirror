From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Overriding ~/.gitconfig using GIT_CONFIG
Date: Fri, 12 Aug 2011 12:39:07 -0700
Message-ID: <7vmxfemnc4.fsf@alter.siamese.dyndns.org>
References: <1313163498.14274.505.camel@rex>
 <7vr54qmodf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Richard Purdie <rpurdie@rpsys.net>,
	Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 21:39:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrxZf-0000Jj-Jw
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 21:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab1HLTjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 15:39:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53282 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066Ab1HLTjK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 15:39:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B700642D7;
	Fri, 12 Aug 2011 15:39:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8EAjoaaAarDrYhv0TRR8eGEb3ys=; b=bvR0nc
	EW+VvVmR46mg6Jv134vXVigY1W/HRTHM/6mHFDbPFfFqanLEbJcOyjEtYb3eZmIZ
	9nARgqYKyBNSzElnvY0qYTYTCBPVIrJE3IOTVjLqx1gSKRg4OodQWCtu3HVzkyvD
	6Nl/RRoRoVuKFq5QkG9RJVelHUU2XEb4LKMO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xZiNUvNKmHhX6HxO3MD0JFyfbfgYMqxn
	bji9LOgTsweKqsl0uPnKxj9yW3sGTQU4cHbGd08QtD5r4701u36+l/N7A74z6R00
	FilFWMMilmhMAL4xEExgGn4YD2K9i1OgimvtwcMH758t/MO5SQlEouAtBT/gknO5
	LA+YppnSJM8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF39C42D6;
	Fri, 12 Aug 2011 15:39:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29E3342D2; Fri, 12 Aug 2011
 15:39:09 -0400 (EDT)
In-Reply-To: <7vr54qmodf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 12 Aug 2011 12:16:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF626F84-C51A-11E0-8937-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179242>

Junio C Hamano <gitster@pobox.com> writes:

> Richard Purdie <rpurdie@rpsys.net> writes:
>
>> Looking through the manuals/code, it suggests I should be able to do:
>>
>> GIT_CONFIG=/dev/null git XXX
>>
>> and all should work happily. It doesn't though. As an example, with a
>> ~/.gitconfig, "GIT_CONFIG=/dev/null git fetch --all" is clearly
>> accessing the file in ~ and then acting upon it.
>
> If the manual says the above is expected for any value of XXX, then that
> is a bug in the manual since mid 2008, I think.
>
> See dc87183 (Only use GIT_CONFIG in "git config", not other programs,
> 2008-06-30).
>
> I _think_ these days a workaround to force a known config is to set HOME
> to a value that has a known .gitconfig (or no such file), and decline
> usage of /etc/git.config by exporting GIT_CONFIG_NOSYSTEM.

Side note. Here is what dc87183 says:

commit dc87183189b54441e315d35d48983d80ab085299
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Mon Jun 30 03:37:47 2008 -0400

    Only use GIT_CONFIG in "git config", not other programs
    
    For everything other than using "git config" to read or write a
    git-style config file that isn't the current repo's config file,
    GIT_CONFIG was actively detrimental. Rather than argue over which
    programs are important enough to have work anyway, just fix all of
    them at the root.
    
    Also removes GIT_LOCAL_CONFIG, which would only be useful for programs
    that do want to use global git-specific config, but not the repo's own
    git-specific config, and want to use some other, presumably
    git-specific config. Despite being documented, I can't find any sign that
    it was ever used.
    
    Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

It clearly explains the reason why LOCAL_CONFIG was removed (the reader
does not have to agree with "I can't find any sign that it was ever used",
though), but I cannot read from the first paragraph the reason why it was
felt necessary not to honor GIT_CONFIG in other programs, i.e. "was
actively detrimental" is not backed by any example in the paragraph. I can
sort of sense from "Rather than argue over..." that there may have been a
discussion on the list, and reading the archive from that timeframe may
reveal why many felt it was not a good idea.

Daniel, do you recall the context?
