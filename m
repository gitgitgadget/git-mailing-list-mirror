From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] mingw: introduce the 'core.hideDotFiles' setting
Date: Tue, 10 May 2016 10:19:16 -0700
Message-ID: <xmqqlh3hrfu3.fsf@gitster.mtv.corp.google.com>
References: <17d30bb680a0452efd7b3c4f42e2f94478a86273.1462372716.git.johannes.schindelin@gmx.de>
	<cover.1462603453.git.johannes.schindelin@gmx.de>
	<32f14c212946c7c1da8007c8eff536fe82872f5b.1462603453.git.johannes.schindelin@gmx.de>
	<xmqqeg9bw3gi.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1605101047510.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 10 19:19:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0BJd-0006nV-2f
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 19:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbcEJRTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 13:19:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751182AbcEJRTV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 13:19:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E49F19BF5;
	Tue, 10 May 2016 13:19:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EnTyN4Y3/VCoTHYeQdke5IjvOhQ=; b=hXkzvn
	gomn6bza9jOIsIvpDa7su9ZqVzK17H3cPMVWFADyqdGziYRrXf8S1VtEq3E4bOwm
	VkfHk5gewReXsh7/jxRIfP+LSZqrYaed1DCOLyEh46OaNVuJJJA+YZZCB7ROZLy2
	+k+obqxdgDl7NCmMSkVPnp2XIjvnWP39RjyxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ag08Xq+uVUDdGt998Q40s1sQvefwH00D
	bXa9Ss1XXD7gDm/eqPcbvwnk7xbomEy+DU04nS+sZl6+gsqB2B0RvQT5XVVMIrwO
	h6HxHb9ZzvcneryZhb9ImEJW5db2ZEjKe+SyO0iZCnQ1unzPm9h4JOpZpeGgKj3Z
	LbieS+qR3vY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7651419BF4;
	Tue, 10 May 2016 13:19:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0A5F19BF3;
	Tue, 10 May 2016 13:19:18 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605101047510.4092@virtualbox> (Johannes
	Schindelin's message of "Tue, 10 May 2016 13:58:07 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5452D7A0-16D3-11E6-A944-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294156>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 9 May 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > +core.hideDotFiles::
>> > +	(Windows-only) If true, mark newly-created directories and files whose
>> > +	name starts with a dot as hidden.  If 'dotGitOnly', only the `.git/`
>> > +	directory is hidden, but no other files starting with a dot.  The
>> > +	default mode is to mark only the `.git/` directory as hidden.
>> 
>> I think "The default mode is 'dotGitOnly'" is sufficient, given that
>> it is described just one sentence before, which is still likely to
>> be in readers' mind.  But I'll let it pass without tweaking.
>
> Yeah, when rewriting this after Ramsay pointed out the erroneous
> documentation, I wanted to fail on the crystal-clear side.

Saying the same thing twice in rapid succession does not make it
any clearer, though.  If you are rerolling anyway, then I think it
would be better to shorten it to clarify.

>> The other is why you do not have to retry creation in a similar way
>> when !needs_hiding(filename).  I didn't see anything in the function
>> before reaching this point that does anything differently based on
>> needs_hiding().  Can't the same 'ERROR_ACCESS_DENIED' error trigger
>> if CREATE_ALWAYS was specified and file attributes of an existing
>> file match, and if it can, don't you want to retry that too, even if
>> you are not going to hide the filename?
>
> The attributes that can trigger the ERROR_ACCESS_DENIED error are the
> hidden flag and the system flag. Since Git *never* marks any file as
> system file, we should be safe.

I was just wondering Git's trying to open it via this codepath
trigger the "if CREATE_ALWAYS was specified and an already existing
file's attributes do not match *exactly*.", if the path is already
hidden.  But again, I am clueless on Windows API, expected use
pattern of Git for Windows, and your future project plans
(e.g. basing future work on Karsten's clean-up patch), so I defer to
your judgment.

> Anyway, the next iteration of this patch is on its way.

OK.  Thanks.
