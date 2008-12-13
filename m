From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitweb: allow access to forks with strict_export
Date: Sat, 13 Dec 2008 14:31:08 -0800
Message-ID: <7vr64b4sib.fsf@gitster.siamese.dyndns.org>
References: <1229203014.31181.7.camel@mattlaptop2.local>
 <m3prjvg2st.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 23:32:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBd2I-00014Q-Tm
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 23:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbYLMWbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 17:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbYLMWbR
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 17:31:17 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbYLMWbR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 17:31:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D2F1686214;
	Sat, 13 Dec 2008 17:31:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D1AC786213; Sat,
 13 Dec 2008 17:31:10 -0500 (EST)
In-Reply-To: <m3prjvg2st.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sat, 13 Dec 2008 13:53:26 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C109E8CA-C965-11DD-9DCA-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103031>

Jakub Narebski <jnareb@gmail.com> writes:

> Matt McCutchen <matt@mattmccutchen.net> writes:
>
> CC-ed Petr Baudis, author of forks support in gitweb.
>
>> git_get_projects_list excludes forks in order to unclutter the main
>> project list, but this caused the strict_export check, which also relies
>> on git_get_project_list, to incorrectly fail for forks.  This patch adds
>> an argument so git_get_projects_list knows when it is being called for a
>> strict_export check (as opposed to a user-visible project list) and
>> doesn't exclude the forks.
>>
>> Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
>
> Looks good for me.

That sounds like a broken API to me.

At least, please have the decency to not call the extra parameter "for
strict export".  I would understand it if the extra parameter is called
"toplevel_only" (or its negation, "include_forks").

IOW, don't name a parameter after the name of one caller that happens to
want an unspecified special semantics, without saying what that special
semantics is.  Instead, name it after the special semantics that the
argument triggers.
