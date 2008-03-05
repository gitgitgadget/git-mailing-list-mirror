From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2] git-submodule: multi-level module definition
Date: Wed, 05 Mar 2008 15:18:13 -0800
Message-ID: <7vd4q8kbey.fsf@gitster.siamese.dyndns.org>
References: <1204646661-7776-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 00:19:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX2tC-0007o4-Rr
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 00:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932862AbYCEXSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 18:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbYCEXS3
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 18:18:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991AbYCEXSY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 18:18:24 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 85FB3257C;
	Wed,  5 Mar 2008 18:18:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CD5C9257B; Wed,  5 Mar 2008 18:18:16 -0500 (EST)
In-Reply-To: <1204646661-7776-1-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Wed, 5 Mar 2008 00:04:21 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76288>

Ping Yin <pkufranky@gmail.com> writes:

> This patch allows multi-level module definition in .gitmodules as
> Linus and Sven Verdoolaege etc. have suggested in mails
> "Let .git/config specify the url for submodules"
> (http://article.gmane.org/gmane.comp.version-control.git/48939).
> 
> Following shows an example of such a .gitmodules.
>
> .gitmodules with with multiple level of indirection
> ------------------------------------------------------
> [submodule "service"]
>    submodule = crawler
>    submodule = search
> ...
> [submodule "util"]
>    url = git://xyzzy/util.git
> [submodule "imsearch"]
>    path = search/imsearch
>    url = git://xyzzy/imsearch.git
> [submodule "imcrawler"]
>    path = crawler/imcrawter
>    url = git://xyzzy/imcrawter.git
> ------------------------------------------------------

I would agree that allowing the user to use a short-hand to name a group
of modules the user is interested in would be a good idea, but I think
.gitmodules is a wrong place to do so.  The grouping is a user preference,
isn't it?

The place the owner of the repository (not the project) expresses which
modules are of interest, what transports she wants to use to access it,
etc. is $GIT_DIR/config, and .gitmodules is a vehicle to supply hints to
be used when the user populates that information.
