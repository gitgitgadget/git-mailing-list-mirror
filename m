From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse: Fix shell scripts whose cwd is a symlink into
 a git work-dir
Date: Tue, 25 Nov 2008 10:17:56 -0800
Message-ID: <7vtz9vk6uj.fsf@gitster.siamese.dyndns.org>
References: <cover.1226759762.git.marcel@oak.homeunix.org>
 <1227389614-10946-1-git-send-email-marcel@oak.homeunix.org>
 <492BA998.5050106@viscovery.net> <492C24D4.1010306@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Tue Nov 25 19:20:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L52W9-0004CY-6z
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 19:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbYKYSSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 13:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYKYSSw
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 13:18:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbYKYSSv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 13:18:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EBDFD176C6;
	Tue, 25 Nov 2008 13:18:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7532617790; Tue,
 25 Nov 2008 13:17:58 -0500 (EST)
In-Reply-To: <492C24D4.1010306@oak.homeunix.org> (Marcel M. Cary's message of
 "Tue, 25 Nov 2008 08:16:20 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 81F1D162-BB1D-11DD-8405-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101673>

"Marcel M. Cary" <marcel@oak.homeunix.org> writes:

> Nor have I seen a response to the idea of correcting the shell's
> behavior in cd_to_toplevel, for example by adding a "cd `pwd`",...

I think you probably could fool the shell by unsetting PWD or something
silly like that (or "cd -P" which may not be supported by non POSIX shells
but I suspect the ones we care about do support it).

Doing a 'cd "$(pwd)"' inside cd_to_toplevel would be a less objectionable
and arguably more portable workaround for the case where you have a
symlink pointing into somewhere in your work tree.
