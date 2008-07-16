From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Hacks for AIX
Date: Wed, 16 Jul 2008 11:25:50 -0700
Message-ID: <7v3am9sn2p.fsf@gitster.siamese.dyndns.org>
References: <5855afd30807161057v54ed4112jaea3bc07cebf44d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Chris Cowan" <chris.o.cowan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 20:26:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJBiL-0006dg-00
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 20:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbYGPSZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 14:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbYGPSZ6
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 14:25:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbYGPSZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 14:25:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 43AF422718;
	Wed, 16 Jul 2008 14:25:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9AEB122716; Wed, 16 Jul 2008 14:25:52 -0400 (EDT)
In-Reply-To: <5855afd30807161057v54ed4112jaea3bc07cebf44d4@mail.gmail.com>
 (Chris Cowan's message of "Wed, 16 Jul 2008 12:57:43 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A0EBF9C4-5364-11DD-84A1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88710>

"Chris Cowan" <chris.o.cowan@gmail.com> writes:

>     * /usr/bin/grep - behaves badly in t7002.   I believe it is test
> 12 and related to the -n -w -e combination of options.

Perhaps your version of AIX needs to...

    $ make NO_EXTERNAL_GREP=UnfortunatelyYesOnThisAIX

>     * /usr/bin/diff - has problems with -u and -U.
>                          I saw the $GIT_CMP_TEST env var, but this is
> not used everywhere within the test scripts above.
> In some cases, the tests could have been made more portable by using a
> plain "diff" rather than "diff -u", for example.

A patch to the testsuite to replace use of "diff" and "diff -u" that test
the actual output matches expected output with "test_cmp" would be
appreciated.

>     * /usr/bin/patch - really old version, doesn't do well with some
> diff formats.   I avoid using it.

t4109 seems to use patch to produce expected output for the tests; we
should ship a precomputed expected results.  Do you know of any other
places "patch" is used?
