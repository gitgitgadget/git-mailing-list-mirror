From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Wed, 16 Jan 2008 09:55:55 -0800
Message-ID: <7v1w8hslhw.fsf@gitster.siamese.dyndns.org>
References: <20080114202932.GA25130@steel.home>
	<20080115200437.GB3213@steel.home>
	<a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com>
	<200801160002.51048.robin.rosenberg.lists@dewire.com>
	<20080116071832.GA2896@steel.home>
	<a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Paul Umbers" <paul.umbers@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:56:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFCVD-0005V2-B7
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 18:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbYAPR4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 12:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbYAPR4K
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 12:56:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbYAPR4J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 12:56:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CB0214967;
	Wed, 16 Jan 2008 12:56:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D77A4494C;
	Wed, 16 Jan 2008 12:55:57 -0500 (EST)
In-Reply-To: <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com>
	(Paul Umbers's message of "Wed, 16 Jan 2008 08:42:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70710>

"Paul Umbers" <paul.umbers@gmail.com> writes:

> OK, I think this worked (I'm a Java man, not C/C++). I downloaded the
> latest 1.5.3 source from the git repository and ran "make" with
> GIT_TEST_OPTS="--verbose --debug". Here's the output:
>
> paulumbers@Devteam29 ~/workspace/git/git-1.5.3/t
> $ make
> *** t0000-basic.sh ***
> *   ok 1: .git/objects should be empty after git init in an empty repo.
> *   ok 2: .git/objects should have 3 subdirectories.
> *   ok 3: git update-index without --add should fail adding.
> *   ok 4: git update-index with --add should succeed.
> * FAIL 5: writing tree out with git write-tree
>         tree=$(git write-tree)

Often the first error is the most interesting, as your build is
failing the most basic operation (like creating a tree), and
later parts of the test uses the tree to validate other aspects
of your build.

After seeing the above error, running the test with -i (stop
immediately on failure):

	$ cd t
        $ sh -x ./t0000-basic.sh -i -v

and looking at the exact command that fails is the usual
approach for debugging something like this.  During that
debugging session, the contents of the directory t/trash (which
is where the test script runs) left by the failed test is what
we often do.
