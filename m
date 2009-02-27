From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-1.6.2-rc2 problems on t4034-diff-words.sh
Date: Fri, 27 Feb 2009 12:05:44 -0800
Message-ID: <7vwsbbir1j.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.2.00.0902271103450.19082@suse104.zenez.com>
 <alpine.DEB.1.00.0902271936090.6600@intel-tinevez-2-302>
 <alpine.LNX.2.00.0902271216090.19082@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 21:07:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld8zQ-0005qc-UT
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 21:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbZB0UFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 15:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754872AbZB0UFw
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 15:05:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbZB0UFw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 15:05:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C1ADA13D8;
	Fri, 27 Feb 2009 15:05:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1B24813D6; Fri,
 27 Feb 2009 15:05:45 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.0902271216090.19082@suse104.zenez.com> (Boyd
 Lynn Gerber's message of "Fri, 27 Feb 2009 12:24:49 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 074AA146-050A-11DE-A546-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111707>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> Does the test suite use bash as it's shell?  I seem to have to use
> bash now to run the test.  I do not remember having to use bash on
> earlier 1.6.0

If your /bin/sh is not POSIX enough, you may be using a different shell
when building the scripted commands in the main Makefile by setting
SHELL_PATH.  The tests are supposed to use the same one as that.

> I have to use bash to run the test or I get
>
> $ ./t4034-diff-words.sh
> ./t4034-diff-words.sh: syntax error at line 52: `(' unexpected

The open parenthesis on line 52 is the one between h and 4 here:

    cat > expect <<\EOF
    <WHITE>diff --git a/pre b/post<RESET>
    <WHITE>index 330b04f..5ed8eff 100644<RESET>
    <WHITE>--- a/pre<RESET>
    <WHITE>+++ b/post<RESET>
    <BROWN>@@ -1,3 +1,7 @@<RESET>
    <RED>h(4)<RESET><GREEN>h(4),hh[44]<RESET>
    <RESET>
    a = b + c<RESET>

    <GREEN>aa = a<RESET>

    <GREEN>aeff = aeff * ( aaa )<RESET>
    EOF

Perhaps your shell has a broken here-text?
