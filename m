From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add: add a newline at the end of pathless 'add
 [-u|-A]' warning
Date: Tue, 02 Apr 2013 09:31:25 -0700
Message-ID: <7vppycgahu.fsf@alter.siamese.dyndns.org>
References: <vpqk3pefjs4.fsf@grenoble-inp.fr>
 <1362988893-27539-1-git-send-email-Matthieu.Moy@imag.fr>
 <1362988893-27539-2-git-send-email-Matthieu.Moy@imag.fr>
 <7v7gldc44p.fsf@alter.siamese.dyndns.org> <vpqehetgfh0.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 02 18:31:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN47q-0003FE-Lf
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 18:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759664Ab3DBQba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 12:31:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58966 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756980Ab3DBQb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 12:31:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49FD8115EB;
	Tue,  2 Apr 2013 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wZ5X8SS+JrhsI7a7bQ9RJ/4ldpo=; b=lNeLnV
	QrB0pDwWvE115Ctab1VcxFFwP1tIisWwoj+FBAh0p3JVf1TmZy5wDCfs45Anv4UM
	hUxYg3DPVFLeP6USVI4xZQzPH+3fd+Gd3EiLSV0iq5w86wJILQGgcG5GF5Nhc8Qr
	hJXWDt3uy9W7xgYsUy+kmFfWy2Wp0rWcOLSrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EZfWB/L1lbTV4rz8wSsgB1pUC4cNwYIQ
	21CeWXrfvu7luvfrxbrWx1Egi4zbxAZKZCEDyMIubisMuxSls8Z6fD4qs+hoW/YW
	waB8Cl8WfXCE5zCXLn1F1sdhQwRjVixQbsDtgLN5GfkBnmNs+Mu98D9hzutohSLd
	XkrMAV8XCdA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 415BB115EA;
	Tue,  2 Apr 2013 16:31:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93B81115E8; Tue,  2 Apr
 2013 16:31:26 +0000 (UTC)
In-Reply-To: <vpqehetgfh0.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Tue, 02 Apr 2013 16:43:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3CF350A-9BB2-11E2-9168-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219792>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I'm fine with either dropping my patch or applying it as-is (with
> s/newline/blank line/ in the commit message).

OK; let's insert it immediately after e24afab09137 (add: make
pathless 'add [-u|-A]' warning a file-global function, 2013-03-19),
like the attached.

I'd prefer to spell this

	die("...\n"
	    "");

over

	die("...\n");

as the latter _looks_ as if the author didn't know die() gives us
line termination.  The former hopefully is more explicit that we do
want an empty line at the end.

commit a8ed21a59219e8fe81b76ed0961641555f25cdad
Author: Matthieu Moy <Matthieu.Moy@imag.fr>
Date:   Mon Mar 11 09:01:33 2013 +0100

    add: add a blank line at the end of pathless 'add [-u|-A]' warning
    
    When the commands give an actual output (e.g. when ran with -v), the
    output is visually mixed with the warning.
    
    An additional blank line makes the actual output more visible.
    
    Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/builtin/add.c b/builtin/add.c
index a4028ee..db02233 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -57,7 +57,9 @@ static void warn_pathless_add(void)
 		  "  git add %s .\n"
 		  "  (or git add %s .)\n"
 		  "\n"
-		  "With the current Git version, the command is restricted to the current directory."),
+		  "With the current Git version, the command is restricted to "
+		  "the current directory.\n",
+		  ""),
 		option_with_implicit_dot, short_option_with_implicit_dot,
 		option_with_implicit_dot, short_option_with_implicit_dot,
 		option_with_implicit_dot, short_option_with_implicit_dot);
