From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] http-push: update tests
Date: Sat, 17 Jan 2009 10:54:50 -0800
Message-ID: <7vsknh7og5.fsf@gitster.siamese.dyndns.org>
References: <be6fef0d0901161859qbea135bwe89e48caaa69a77c@mail.gmail.com>
 <alpine.DEB.1.00.0901170621440.3586@pacific.mpi-cbg.de>
 <be6fef0d0901170040r7e11806et87cc5dc3c6f13a2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ray Chuan" <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 19:56:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOGLM-0007hd-F7
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 19:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763315AbZAQSzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 13:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762628AbZAQSzE
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 13:55:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762245AbZAQSzD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 13:55:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2577691E4B;
	Sat, 17 Jan 2009 13:55:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3B05591E46; Sat,
 17 Jan 2009 13:54:57 -0500 (EST)
In-Reply-To: <be6fef0d0901170040r7e11806et87cc5dc3c6f13a2a@mail.gmail.com>
 (Ray Chuan's message of "Sat, 17 Jan 2009 16:40:38 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 57F783C8-E4C8-11DD-BFF5-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106092>

"Ray Chuan" <rctay89@gmail.com> writes:

>>> -test_expect_failure 'push to remote repository' '
>>> +test_expect_success 'push to remote repository' '
>>>       cd "$ROOT_PATH"/test_repo_clone &&
>>>       : >path2 &&
>>>       git add path2 &&
>>>       test_tick &&
>>>       git commit -m path2 &&
>>> -     git push &&
>>> -     [ -f "$HTTPD_DOCUMENT_ROOT_PATH/test_repo.git/refs/heads/master" ]
>>> +     git push origin master
>>>  '
>>
>> ... this removal?  I do not think this is a good change, as it removes
>> a test that is actually pretty important.
>
> i'm sorry for the poor commit message, what i wanted to do was to
> change the tests to expect success rather than failure. no tests were
> removed; only their expected outcomes were modified. currently, the
> pushes fail, so the test 'fails as expected'; now the pushes succeed,
> so they shouldn't be expecting failed pushes (or anything else).

The original seems to want the push to succeed, and also it wants the file
refs/heads/master to be present after the push (presumably because there
should be that ref when the push succeeds).  If you fixed "push" that used
to fail to succeed, that is great, and s/failure/success/ is a good thing.

But you are removing something else without explanation.  Why do you need
to remove the part of the test that checks if refs/heads/master is present?
Is it looking for a file in a wrong place?
