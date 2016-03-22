From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule helper: accept '.' for repositories with no submodules
Date: Tue, 22 Mar 2016 15:04:05 -0700
Message-ID: <xmqqpoumf9uy.fsf@gitster.mtv.corp.google.com>
References: <1458669579-32160-1-git-send-email-sbeller@google.com>
	<xmqqy49agx98.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaMa3CyJ-Y9Xn9QShzTUGythos+pmKZXQ7m-2c0bF0u9A@mail.gmail.com>
	<xmqqoaa6gtuu.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka=EJ-L+Zaqh0kWUdjmyUva3fEcbwJn18uxshe3R5ABBQ@mail.gmail.com>
	<xmqqtwjyfb0s.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYNQ46Yett8xwtPL8Mi1TkitB1kuWbQDsR6bg-5dxckNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Per Cederqvist <cederp@opera.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 23:04:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiUPj-00087W-Bc
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 23:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbcCVWEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 18:04:10 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752723AbcCVWEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 18:04:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 43E474E355;
	Tue, 22 Mar 2016 18:04:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fZnS85GxhSPPJh1DJOJuU2sfbZA=; b=wpuCkP
	Gl8yTr7TeJQoT1n+pSgQMv5LaEt/YYUb+2qbWAZ861pIaazebTIZllHET9jwnkoO
	kvLqcRlhZz4UywREcpEq5CmCghbuGyMNXrYkzaue4eWHKHyuA90VhsQX5bpRZKCU
	eZqN7Xvq4LZW9+qqXWJXIrJqm8GYAX0uYAQm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XCbc7Dr2Iz3c1qrhnQcf97FdfNWtim3e
	qmb38FRYGQbKkG3HfL3HV8FbOe2kABiWjUhtT68lHCrfGxlfj590Man1muUxQjEE
	f0pYYNDlzWKh8VriiZ5yWrfvme6XSnuE1KVmFmSG0YDtMvrQZH9bm+b/o2S3opa1
	E+BDKokdeVQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3A5D34E353;
	Tue, 22 Mar 2016 18:04:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B11384E350;
	Tue, 22 Mar 2016 18:04:06 -0400 (EDT)
In-Reply-To: <CAGZ79kYNQ46Yett8xwtPL8Mi1TkitB1kuWbQDsR6bg-5dxckNA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 22 Mar 2016 14:47:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FF2B9BA6-F079-11E5-A9FA-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289574>

Stefan Beller <sbeller@google.com> writes:

> I was under the impression that we do not want to have this bugfix
> (at least long term) and then I tried to come up with an idea,
> which is both:
> * correct in this case
> * and catches the git submodule init -- 'COPYIN*' case as failure

Satisfying both has to be impossible, I am afraid, so coming up with
an idea to do so may be futile.

If "git submodule $subcmd -- 'COPYIN*'" must fail (which I think is
a good property to have), then "git submodule $subcmd -- ." must
fail if there is no submodule in the repository, I would think, if
we want to be consistent.  Both are complaining not just because
there is no path that match the given pathspec, but because there is
no submodule that match the given pathspec.

That is why I said I was in favour of giving some _other_ way, other
than "this is guaranteed to match some submodule" pathspec (which
fundamentally does not exist, because there are projects that do not
have any submodule in them), as a suggestion for "deinit all"
safety.

A slight tangent.

We have --error-unmatch in ls-files to detect pathspec that did not
hit anything, and our Porcelain commands treat a pathspec that does
not hit anything as an error, but there probably need to be
"--unmatch-ok" option?  I.e.

	$ git add 'A*'
        fatal: pathspec 'A*' did not match any files
        $ git add --unmatch-ok 'A*'
        ... nothing is added but we do not get an error ...

Then the interaction may go like this:

	$ git submodule deinit
        You need to limit submodules to deinit with some pathspec
        $ git submodule deinit .
        fatal: pathspec '.' did not match any submodule
        $ git submodule deinit --unmatch-ok .
        ... nothing deinited but we do not get an error ...

For this particular one,

	$ git submodule deinit --force

may be also OK, but there may be _other_ conditions that you may
allow overriding in "deinit" operation (e.g. we may refuse to deinit
when there are unsaved/unuploaded changes, and allow --force to
override it), so...
