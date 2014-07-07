From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t/Makefile: always test all lint targets when running tests
Date: Mon, 07 Jul 2014 11:13:11 -0700
Message-ID: <xmqq38eddolk.fsf@gitster.dls.corp.google.com>
References: <53B5D6FE.2090700@web.de> <53B5D76D.1090509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 20:13:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4DPo-00081A-8r
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 20:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbaGGSNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 14:13:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64487 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281AbaGGSNT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 14:13:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A85A326C09;
	Mon,  7 Jul 2014 14:13:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zL/n8iw5zDGFEhJ/oNZJL7X+DoQ=; b=pSt7fX
	cygsjXc66gwzB8MyzzmEESxGHKZuvYKCEzhh9vIPYt9xgomQ8GFYX/hWubo3UTGX
	v5kdaO1ft8v+5BPpfQZ+xmfb/eIo7FpJq9vFdtmFBf36k9B3dwekQSYoxsq9gVtz
	weScFTPEJCCfOUYBtYBLo/5W0eYXLoiPd4EJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YQoltO20eURp5tb7It7fOQn7+raz4SDp
	DcDbJNowE+Gwqkxdhw2FDTFpu6v4/on/7e554QXo9MMPxqsDFaJH0HI0S+165Rl0
	jUxhIemXlW7my964X0QyULZnvWiZxKaXlBf+ZswCyPuI0LMsEN4ed88j9zp1aJjV
	AGvIKWjD8cY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F39F26C08;
	Mon,  7 Jul 2014 14:13:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4628A26BFB;
	Mon,  7 Jul 2014 14:13:00 -0400 (EDT)
In-Reply-To: <53B5D76D.1090509@web.de> (Jens Lehmann's message of "Fri, 04 Jul
	2014 00:21:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 545C52D2-0602-11E4-8068-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252978>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Only the two targets "test-lint-duplicates" and "test-lint-executable" are
> currently executed when running the test target. This was done on purpose
> when the TEST_LINT variable was added in 81127d74. But as this does not
> include the "test-lint-shell-syntax" target added the same day in commit
> c7ce70ac, it is easy to accidentally add non portable shell constructs
> without noticing that when running the test suite.

I not running the lint-shell-syntax that is fundamentally flaky to
avoid false positives is very much on purpose.  The flakiness is not
the fault of the implementor of the lint-shell-syntax, but comes
from the approach taken to pretend that simple pattern matching can
parse shell scripts.  It may not complain on the current set of
scripts, but that is not really by design but by accident.

So I am not very enthusiastic to see this change myself.
