From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: autostash is lost after aborted rebase
Date: Tue, 20 May 2014 10:34:36 -0700
Message-ID: <xmqqegzo1hhv.fsf@gitster.dls.corp.google.com>
References: <20140519005719.GB38299@tequila> <vpqlhtym8lp.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karen Etheridge <ether@cpan.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 20 19:34:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmnw6-0007Lq-8K
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 19:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbaETRem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 13:34:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56544 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128AbaETRel (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 13:34:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AF10180D0;
	Tue, 20 May 2014 13:34:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bdVLAJOW9iNoo/iRNIF54M7a3dE=; b=lFV1OI
	kkq6aq2YTes6Sa1tsMvint/bz2oi7KKBLMOTy+Ynm/DdNlMTffoII1PjaS47cOmz
	Jua1ybOtVry4F3S2iCFPK/MYkq0CaKk8hFOa/RS+OYxyVPHlrl66uezIsnXgvBX2
	X9BVxD9srgMGKPGOql5XYuzmHBy6R/lvW2LWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CbB3+9lOyJ/mYsP2RcbF9LviojXSp66E
	i4C9hMAYYlXmbeiMqrqmHj6UwEBeEHkpzL4mHTFxX8MG4U3y3naENLV9ujS/SQEO
	10csbRTohVdDnRJLItH6df5tN+cgCg9/YTWtsK3qK52/slSIVraUda0+gHjKgr2W
	zhqoEKX5QXs=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 416E5180CF;
	Tue, 20 May 2014 13:34:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3EE67180CB;
	Tue, 20 May 2014 13:34:38 -0400 (EDT)
In-Reply-To: <vpqlhtym8lp.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	19 May 2014 11:16:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0469F3DE-E045-11E3-BAF3-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249709>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> [ Cc-ing Ramkumar ]
>
> Karen Etheridge <ether@cpan.org> writes:
>
>> scenario: 
>> - edit some tracked files; do not add them to the index
>> - "git config rebase.autostash true"
>> - "git rebase -i HEAD~3" (an autostash will be created)
>> - delete the entire buffer and save/exit the editor - this will abort the
>>   rebase
>>
>> poof, the autostash is gone (it is not reapplied) -- it must be explicitly
>> applied again via the SHA that was printed earlier.
>
> Indeed. Confirmed, even with pu (I thought I remembered seeing a fix on
> the list, but I must have mixed up with something else).

Thanks.  I see Ram's patch to address this on the list.  Will pick
it up and queue for post-release, as this is a fairly old breakage
dating as far back as v1.8.4, if I am not mistaken.
