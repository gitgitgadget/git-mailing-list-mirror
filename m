From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [L10N] Startup of Git 2.2.0 l10n round 1
Date: Sun, 02 Nov 2014 20:06:47 +0100 (CET)
Message-ID: <20141102.200647.1807459583469654728.chriscool@tuxfamily.org>
References: <CANYiYbH-Gz8rSo1OX8ApA1ysgpi=YaE+yq9XDOa-DUXeppxQOw@mail.gmail.com>
	<CAP6f5M=OqzH8R6QPxPr3yn1xCFJPA8N6q33BZGg4t8T96KaEgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: worldhello.net@gmail.com, barkalow@iabervon.org, gitster@pobox.com,
	git@vger.kernel.org
To: ash@kambanaria.org
X-From: git-owner@vger.kernel.org Sun Nov 02 20:06:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xl0UJ-0001Kf-Ra
	for gcvg-git-2@plane.gmane.org; Sun, 02 Nov 2014 20:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbaKBTGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2014 14:06:52 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:60711 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbaKBTGv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2014 14:06:51 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 3CB879E;
	Sun,  2 Nov 2014 20:06:48 +0100 (CET)
In-Reply-To: <CAP6f5M=OqzH8R6QPxPr3yn1xCFJPA8N6q33BZGg4t8T96KaEgg@mail.gmail.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexander Shopov <ash@kambanaria.org>

> Can you please disambiguate message:
> msgid "more than one %s"
> 
> It means that something somewhere was repeated but does not point what
> and where. Perhaps users care about that.

If you configure something like:

[trailer "stuff"]
        key = Stuff
        key = Other

You will get:

$ echo | LANG=C git interpret-trailers
warning: more than one trailer.stuff.key

Which means that more than value was configured for the
"trailer.stuff.key" configuration option. And it makes no sense
because only one should be the canonical one.

> It is now used 3 times (trailer.c:552 trailer.c:557
> builtin/remote.c:288) but points to different things that were
> repeated. It used to mean only that there is a "remote' section
> repeated.

In builtin/remote.c the warning is also when more than one value is
given for a configuration option.

Feel free to suggest some more explicit warning in both cases if you
want. (Maybe adding " is configured" at the end would be enough.) A
patch would be even better.

Thanks,
Christian.
