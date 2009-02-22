From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] Add some tests of git-cvsimport's handling of
 vendor branches
Date: Sun, 22 Feb 2009 08:49:24 -0800
Message-ID: <7vzlge1kob.fsf@gitster.siamese.dyndns.org>
References: <1235221480-31473-1-git-send-email-mhagger@alum.mit.edu>
 <ee46eff8fc1cb2d0ad3d8dfac2fbe4d79f225e3a.1235220105.git.mhagger@alum.mit.edu> <7d834a5a7542df6bfa8963bb6440cc4b4531ead7.1235220105.git.mhagger@alum.mit.edu> <cda1b6751447f990ca0e45e2e54f62ae9c53e6c1.1235220105.git.mhagger@alum.mit.edu> <ee46eff8fc1cb2d0ad3d8dfac2fbe4d79f225e3a.1235220105.git.mhagger@alum.mit.edu> <62960fa97012833859a8f4f8d68a625f8851f8be.1235220105.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de, jnareb@gmail.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Feb 22 17:51:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbHXq-0004uL-T2
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 17:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbZBVQtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 11:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbZBVQtl
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 11:49:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58047 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079AbZBVQtl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 11:49:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6A4369CADF;
	Sun, 22 Feb 2009 11:49:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 115139CADB; Sun,
 22 Feb 2009 11:49:27 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CC2261E2-0100-11DE-A47D-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111018>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> CVS's handling of vendor branches is tricky; add some tests to check
> whether revisions added via "cvs imports" then imported to git via
> "git cvsimport" are reflected correctly on master.
> ...
> One of these tests fail and is therefore marked "test_expect_failure".

In addition to the one marked with expect-failure, 2, 4, 6, 7, 8 and 9
seems to fail for me as well.

    $ sh t9601-cvsimport-vendor-branch.sh -i -v
    Initialized empty Git repository in /git/git.git/t/trash directory.t9601-cvsimport-vendor-branch/.git/
    * expecting success:

            git cvsimport -C module-git module


    Initialized empty Git repository in /git/git.git/t/trash directory.t9601-cvsimport-vendor-branch/module-git/.git/
    Skipping #CVSPS_NO_BRANCH
    *   ok 1: import a module with a vendor branch

    * expecting success: test_cvs_co master
    ./test-lib.sh: line 256: test_cvs_co: command not found
    * FAIL 2: check HEAD out of cvs repository
            test_cvs_co master

The reported line is where the broken test is actually "eval"ed; the 
second test tries to use the undefined test_cvs_co function.
