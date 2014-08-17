From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.1.0
Date: Sun, 17 Aug 2014 12:19:21 -0700
Message-ID: <xmqq38cuzzye.fsf@gitster.dls.corp.google.com>
References: <xmqqd2c1z7zu.fsf@gitster.dls.corp.google.com>
	<20140815231822.GM10808@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, Andi Kleen <ak@linux.intel.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 21:23:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJ62e-0008D5-Gx
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 21:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbaHQTTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 15:19:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63751 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbaHQTTb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 15:19:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D1C6530714;
	Sun, 17 Aug 2014 15:19:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=05gPFT/LK6gp4zP+AqpI3x2HXMg=; b=KG18JW
	l3fv4CQbOHF9RbNcYB+J0VXbyaGjkU7mPeud354WQ07TwFicQAX2sHkZpd1kh7/m
	Tk0TpNJsJEvQou7fLKarCZ3MRhLucpeBjc0ngBMCjT4XQhiz9cJ1UP/uHb40CWzU
	puZSfRxkOjLlObN5rKZLo9ACfvRdMNTEsakV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iUJpId/MnHoDd9ojGmRYDmLNWrk94pma
	oVL3s6GxjOVwbzKMj4BccueGJqGeYX9PV23gN5vvdMWFsk03VX1WEOFwWk9QgWqV
	wKrtBigkddHI4hKnXBZ3zooTKlLNAszrB5iaBQLTCTu6nOdEeROSyYpxcCPYRXqa
	obeYEuuzNcE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C771630713;
	Sun, 17 Aug 2014 15:19:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 783DB30706;
	Sun, 17 Aug 2014 15:19:23 -0400 (EDT)
In-Reply-To: <20140815231822.GM10808@thunk.org> (Theodore Ts'o's message of
	"Fri, 15 Aug 2014 19:18:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6578A834-2643-11E4-BE74-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255373>

Theodore Ts'o <tytso@mit.edu> writes:

> On Fri, Aug 15, 2014 at 03:46:29PM -0700, Junio C Hamano wrote:
>> The latest feature release Git v2.1.0 is now available at the
>> usual places.
>
> I pulled down git v2.1.0, and when I tried to build it via:
>
>    make prefix=/usr/local profile-fast
>
> The build died with this:
>
> cannot open test-results/p5302-pack-index.subtests: No such file or directory at ./aggregate.perl line 77.
> Makefile:7: recipe for target 'perf' failed
> make[2]: *** [perf] Error 2
> make[2]: Leaving directory '/usr/projects/git/git/t/perf'
>
> Not a big deal, but I thought I would mention it.

Thanks.

But this does not seem to reproduce for me (note: I never build
profile-anything myself so I may not be seeing the error even there
is---the only thing I checked was the lack of make errors).

We did have changes to profile-feedback build during this round:

    $ git shortlog 3b3b61c^..3b3b61c^2
    Andi Kleen (4):
          Use BASIC_FLAGS for profile feedback
          Don't define away __attribute__ on gcc
          Run the perf test suite for profile feedback too
          Fix profile feedback with -jN and add profile-fast

I admit I didn't try -jN, and if there are leaky dependencies in the
last patch, it may explain the symptom.
