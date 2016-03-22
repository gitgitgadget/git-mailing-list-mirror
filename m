From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC_PATCHv4 4/7] submodule init: redirect stdout to stderr
Date: Tue, 22 Mar 2016 09:14:06 -0700
Message-ID: <xmqqd1qmjxrl.fsf@gitster.mtv.corp.google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
	<1458612372-10966-5-git-send-email-sbeller@google.com>
	<CAHGBnuMs4D0LeMvdcS0yzKoQgmE+UTb+QFfOkSy7T20PbH86UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jens.Lehmann@web.de,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 17:14:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiOwi-000079-6R
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 17:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948AbcCVQOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 12:14:12 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751735AbcCVQOL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 12:14:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A22534EEC3;
	Tue, 22 Mar 2016 12:14:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PBV1mbY0W989aiUBOBT6yiRBwx8=; b=mFkmwz
	BK3EjOCBgGBC4saL4YkjqH4Ffd24t4tEcz1MOk4/01hVQIdBndlv3hc5oO8dI9SX
	x9byqTHlNJ6+cJtL7CKY+ussOgc8+W5DaoWftaalVhyoWY43XCrVHi3MLB6DUTYI
	+RhkvRRL/QAWZCqESXH1AqJHr9Ey42zcSsCBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XvJ7e8dsDig2Hbz9U67N5mS/KFMR9iIc
	cUk8FNDA8E1B/XOvfrNvk8mLL+c/mANFGpiBCAPh+1jQoV8vTjUUBUOFyV9qOtB4
	/hY8i0FaI01ApDV+yxgra/denEb17MMx2DH/zMdlfHTTUGo72OuXDRJ4hPheriLv
	9kumdx6UHlw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 97A954EEC2;
	Tue, 22 Mar 2016 12:14:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 92D3C4EEBF;
	Tue, 22 Mar 2016 12:14:08 -0400 (EDT)
In-Reply-To: <CAHGBnuMs4D0LeMvdcS0yzKoQgmE+UTb+QFfOkSy7T20PbH86UQ@mail.gmail.com>
	(Sebastian Schuberth's message of "Tue, 22 Mar 2016 08:46:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1B501C98-F049-11E5-B915-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289512>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Just wondering, what's Git's policy on this? This message is neither
> an error nor a warning, but just purely informational. As such it
> semantically does not belong to stderr, or?

Some people believe that a clean execution should not give anything
to stderr (Tcl is one example, IIRC), but I think the core part of
Git takes the opposite stance (probably unix tradition?).  Anything
that is not the primary output of the program should go to stdout.

We may not have been very strict in code reviews to enfore it, and
especially on the fringes of the system it may be easy to find
violators, though.
