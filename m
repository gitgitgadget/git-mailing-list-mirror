From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge --date --author
Date: Fri, 07 Mar 2014 11:43:16 -0800
Message-ID: <xmqqvbvpu757.fsf@gitster.dls.corp.google.com>
References: <1394188215.3257.17.camel@localhost.localdomain>
	<87y50mxj0b.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Droneaud <ydroneaud@opteya.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 20:43:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM0g0-0002yD-6p
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 20:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbaCGTnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 14:43:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbaCGTnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 14:43:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E28872CA3;
	Fri,  7 Mar 2014 14:43:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z/0G8W/dMcrtLY5TwMlskVDvmbo=; b=WmMaLE
	NcW02C58Nn9553NrKe9a54Rdaa/lz7Yeajj9hylCJSVvvZiBF+BQ6is/sdQp1Z+f
	ir3DdWa676M6ujokEJM0UOfD9ZL0vZwZagzRM//HxpaDpVLKFEUm8AdpzUPEJa4V
	7bHwJmpPJYZzTv80ATg+DoXpl99rDsI7rriH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fySnVbnXn9PmklC/B2/+OBP1FzPEjVGP
	50psAXg75TPBNghmwdJQE5PT+xbSMExl4uoYszRsiP7eiLxz8Bx6va5UNxNqoE7c
	KvQcT8UFE8VR6VLaTvQSI8QoKSi9Wd5eD/0zY+UHkfzSKP7SBmgQmtDLk37Ze53Q
	1z3oQm7WY4o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06B3F72CA2;
	Fri,  7 Mar 2014 14:43:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3030472C9F;
	Fri,  7 Mar 2014 14:43:18 -0500 (EST)
In-Reply-To: <87y50mxj0b.fsf@igel.home> (Andreas Schwab's message of "Fri, 07
	Mar 2014 13:58:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BB49FF94-A630-11E3-9E00-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243626>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Yann Droneaud <ydroneaud@opteya.com> writes:
>
>> But I'd like to know if there's a specific reason for git merge to not
>> support --date and --author ?
>
> It's rather unusual that a merge is performed on behalf of a different
> author.

Yes.  Michael's "Nobody bothered to implement it" is also correct
but the reason why nobody bothered to most likely is due to "why
would you want to lie?".

If the use case is to rebuild history, you would need to be able to
also lie about the committer, so

>> git merge \
>>     --date "2013-12-31 23:59:59 +0000" \
>>     --author "Happy New Year <happy.new-year@gregorian.calendar>" \
>>     current-year

in such a history-rebuild script would not be sufficient.  The
script can set necessary environment variables to lie about both
author and commiter, though, of course.
