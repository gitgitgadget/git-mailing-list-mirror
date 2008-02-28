From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff --name-status does not always list changed files
Date: Thu, 28 Feb 2008 11:33:15 -0800
Message-ID: <7vablkkhac.fsf@gitster.siamese.dyndns.org>
References: <fq6hhi$cub$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 20:34:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUoW9-0003Eh-92
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 20:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762853AbYB1Tda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 14:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762993AbYB1Tda
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 14:33:30 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44967 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762589AbYB1Td2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 14:33:28 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D07291222;
	Thu, 28 Feb 2008 14:33:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 244CE11F5; Thu, 28 Feb 2008 14:33:18 -0500 (EST)
In-Reply-To: <fq6hhi$cub$1@ger.gmane.org> (Sebastian Schuberth's message of
 "Thu, 28 Feb 2008 15:47:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75436>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> ...
> so I decided to fix these files in my clean working tree with
>
> for i in `find . -iname "*.c" -o -iname "*.cc" -o -iname "*.cpp" -o
> -iname "*.h" -o -iname "*.hpp"`; do
>     echo $i
>     echo wq | ed $i > /dev/null 2>&1
> done
>
> Afterwards, I wanted so see a list of files that were actually
> affected, but to my wonderment "git diff --name-status" did not list
> any files, although both "git diff" and "gitk" showed the diffs
> correctly.

Doesn't reproduce for me.

        $ rm -fr /var/tmp/j && mkdir -p /var/tmp/j && cd /var/tmp/j
        $ git init
        Initialized empty Git repository in .git/
        $ echo -n hello > world
        $ git add world
        $ od -c world
        0000000   h   e   l   l   o
        0000005
        $ echo wq | ed world
        Newline appended
        6
        6
        $ od -c world
        0000000   h   e   l   l   o  \n
        0000006
        $ git diff --name-status
        M	world
        $ git diff --raw
        :100644 100644 b6fc4c6... 0000000... M	world
        $ exit

