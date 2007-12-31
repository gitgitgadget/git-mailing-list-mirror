From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix race condition in t9119-git-svn-info.sh
Date: Mon, 31 Dec 2007 14:29:15 -0800
Message-ID: <7vodc65whw.fsf@gitster.siamese.dyndns.org>
References: <377939.62541.qm@web52402.mail.re2.yahoo.com>
	<377939.62541.qm@web52402.mail.re2.yahoo.com>
	<1199131665-1633-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Mon Dec 31 23:29:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9T8q-0007an-FC
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 23:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbXLaW3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 17:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbXLaW3X
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 17:29:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbXLaW3W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 17:29:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D7AF2956F;
	Mon, 31 Dec 2007 17:29:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E971956E;
	Mon, 31 Dec 2007 17:29:17 -0500 (EST)
In-Reply-To: <1199131665-1633-1-git-send-email-ddkilzer@kilzer.net> (David
	D. Kilzer's message of "Mon, 31 Dec 2007 12:07:45 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69421>

"David D. Kilzer" <ddkilzer@kilzer.net> writes:

> Changed the ptouch bash function to use the "Text Last Updated"
> date reported by 'svn info' when changing the modified time
> (mtime) of the file/symlink/directory in the git working
> directory.  Previously it used the mtime of the item in the
> svn working directory, which caused the race condition.
>
> Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>

> @@ -350,8 +355,8 @@ test_expect_success 'info unknown-symlink-directory' "
>  	cd svnwc &&
>  		ln -s unknown-directory unknown-symlink-directory &&
>  	cd .. &&
> -	ptouch gitwc/unknown-symlink-directory \
> -	       svnwc/unknown-symlink-directory &&
> +	ptouch svnwc/unknown-symlink-directory \
> +	       gitwc/unknown-symlink-directory &&

Hmph.  Am I the only one who finds this repetition somewhat
disturbing?
