From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-stash: Display help message if git-stash is run with wrong sub-commands
Date: Sun, 02 Dec 2007 18:48:00 -0800
Message-ID: <7vwsrwqysf.fsf@gitster.siamese.dyndns.org>
References: <e66701d40712021834h64bf8d0y14f0e222d0f9a617@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git ML" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nanako Shiraishi" <nanako3@bluebottle.com>
To: "Kevin Leung" <kevinlsk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 03:48:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz1MH-0004Qt-2X
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 03:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbXLCCsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 21:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbXLCCsL
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 21:48:11 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59245 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbXLCCsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 21:48:10 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 624902EF;
	Sun,  2 Dec 2007 21:48:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C94169C563;
	Sun,  2 Dec 2007 21:48:24 -0500 (EST)
In-Reply-To: <e66701d40712021834h64bf8d0y14f0e222d0f9a617@mail.gmail.com>
	(Kevin Leung's message of "Mon, 3 Dec 2007 10:34:05 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66851>

"Kevin Leung" <kevinlsk@gmail.com> writes:

> The current git-stash behaviour is very error prone to typos. For example,
> if you typed "git-stash llist", git-stash would think that you wanted to
> save to a stash named "llist", but in fact, you meant "git-stash list".
>
> Signed-off-by: Kevin Leung <kevinlsk@gmail.com>

Thanks.  Looks good.  except...

> @@ -195,6 +195,10 @@ show)
>         shift
>         show_stash "$@"
>         ;;
> +save)
> +       shift
> +       save_stash "$@" && git-reset --hard
> +       ;;

... this should be "$*" as it was originally spelled.

Save this script in foo.sh and run "foo.sh a b c" to see what I mean.

#!/bin/sh

foo () {
	msg="$1"
	echo "Foo here <$1>"
}

foo "$@"
foo "$*"
