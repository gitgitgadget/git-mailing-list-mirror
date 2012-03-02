From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] Allow Overriding GIT_BUILD_DIR
Date: Fri, 2 Mar 2012 10:25:37 +0100
Message-ID: <87hay7e4mm.fsf@thomas.inf.ethz.ch>
References: <87vcmu5psm.fsf@smith.obbligato.org>
	<7vpqd1dyq7.fsf@alter.siamese.dyndns.org>
	<87fwdrk6d4.fsf@smith.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Fri Mar 02 10:25:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3OkH-0006Mj-OM
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 10:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758582Ab2CBJZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 04:25:43 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:11082 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758567Ab2CBJZl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 04:25:41 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Mar
 2012 10:25:34 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Mar
 2012 10:25:38 +0100
In-Reply-To: <87fwdrk6d4.fsf@smith.obbligato.org> (David A. Greene's message
	of "Thu, 01 Mar 2012 21:51:35 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192017>

greened@obbligato.org (David A. Greene) writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> We use it to find where the test-lib.sh and other lib-*.sh helper
>> definitions are, also we use it to find large-ish test vectors like
>> t3900/ and t4013/.  If an external test script t1234-git-subtree.sh
>> wants to use a separate file to keep its own helper definitions, how
>> should it name it?  It cannot be relative to TEST_DIRECTORY that is
>> typically "t/".  It cannot be relative to "../" as TRASH_DIRECTORY
>> where the script runs, as the --root option may move it elsewhere on
>> the filesystem (and is the reason TEST_DIRECTORY variable exists in
>> the first place).
>
> I must admit I am still confused about what these variables do even
> after reading this explanation several times.  I have a pretty good
> idea what TRASH_DIRECTORY is.
>
>> And how well does an external test script work with the --root option that
>> moves the TEST_DIRECTORY?

I think Junio meant TRASH_DIRECTORY here, too.

> I have no idea.  I didn't even know about --root and I still don't know
> what it does.  It would be helpful to have some commentary about
> options.

--root tells the tests where to put its TRASH_DIRECTORY and is
frequently used to place it on a tmpfs (such as /dev/shm) as that gives
the tests a *huge* speed boost.

That is, if I say

  ./t5510-fetch.sh --root=/dev/shm

then the "main test repo" aka TRASH_DIRECTORY is

  /dev/shm/trash directory.t5510-fetch

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
