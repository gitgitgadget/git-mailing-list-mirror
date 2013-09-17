From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bisect needing to be at repo top-level?
Date: Tue, 17 Sep 2013 10:27:49 -0700
Message-ID: <xmqqbo3rz7ca.fsf@gitster.dls.corp.google.com>
References: <CAJTo0LZ=bNNUc8O=bDDOp2vudsc_wL+-nqsXW5r1rq3H7M0e7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Burton\, Ross" <ross.burton@intel.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 19:27:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLz48-0002ix-F8
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 19:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511Ab3IQR1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 13:27:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753294Ab3IQR1w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 13:27:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A37DC42618;
	Tue, 17 Sep 2013 17:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=akkhHbKy+jpyIYhSkdkd8yUGxTI=; b=CemzIG
	nPFJ6J71aLaB005KVAr+uDUWN35ezWbJB3f+BUlxSVme5iA2oXIyNlnD11BTW8jZ
	vex8a7RosbriLq6+huCT3dkEtdIOK4dtufYH6VeykDkO38bk0CL5XDuf5fY3xjc4
	drDCQys9bLel7G6+m3jyvGpkqt5gUESj5esVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wfu17Y2FR2G/ltTHmzWX6sCx22RQVydN
	BSqm90Z4xyMl6FWz2UByaRUWBNlS/Dc/wDfwQywucOENmnyQGPqoKCzpfv1VgYCr
	FpS9HAA9HVsdsDBFCbo8MN+QT5KuZIbyAuKhBhdHvYSGBOfv8Q1lByU/1YbcoFbN
	JsBQHFHvtb4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99D1642615;
	Tue, 17 Sep 2013 17:27:51 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0944842613;
	Tue, 17 Sep 2013 17:27:50 +0000 (UTC)
In-Reply-To: <CAJTo0LZ=bNNUc8O=bDDOp2vudsc_wL+-nqsXW5r1rq3H7M0e7Q@mail.gmail.com>
	(Ross Burton's message of "Tue, 17 Sep 2013 17:31:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7A7C524E-1FBE-11E3-917D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234894>

"Burton, Ross" <ross.burton@intel.com> writes:

> Why does git-bisect need to be ran from the top level of the working
> tree?  It sources git-sh-setup.sh which sets GIT_DIR, which
> git-bisect.sh then appears to consistently use.  Is there a reason for
> needing to be at the top-level, or is this an old and redundant
> message?

A wild guess.

Imagine if you start from a subdirectory foo/ but the directory did
not exist in the older part of the history of the project.  When
bisect needs to check out a revision that was older than the first
revision that introduced that subdirectory, what should happen?
Worse yet, if "foo" was a file in the older part of the history,
what should happen?
