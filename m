From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git svn --add-author-from implies --use-log-author
Date: Mon, 23 Jun 2008 16:12:37 -0400
Message-ID: <32541b130806231312l679aba31ra3daac2bb634cf1b@mail.gmail.com>
References: <20080620113147.GC27940@frsk.net>
	 <485BB134.9080203@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Fredrik Skolmli" <fredrik@frsk.net>
To: "Mircea Bardac" <dev@mircea.bardac.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 22:13:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAsQ1-00025Z-LS
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 22:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbYFWUMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 16:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753062AbYFWUMo
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 16:12:44 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:22724 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbYFWUMo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 16:12:44 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2456051fkq.5
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 13:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=D9yPBo8dMuBmjkFO3kRwQRwTvnTRxIiZUcabuJ7zH6U=;
        b=NzakipZdbgkyA3E1cz786Wxc6CLKhjDaha9cp98FejwiFA4IA9M3b6WvWHghYkJGZb
         Nyj0C5ZPEFD6RgNx/IiHzlYGngKiy0peyQCcfP4kZ5IesltglyfEhjn/WUGkU9Ypg6Ug
         +FK6B6IiQc1akJAeATSdK+Yzp8khhICzaIrog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vCzI5EiQcg5zAo3NsFId2ZZvN4E61cyCZyQniR3BXLzIRWw8WVtI0128CU7SwlqUVL
         PHqu7WHCU1+te1kASySRFFdPeVvceU4c28c9Te+qRHOzvPByUDBqEhk51qXw9NzMgUaW
         0R3GdSq2LRrIsbMAKioXHyZzNqlQtNQjc9am8=
Received: by 10.82.150.15 with SMTP id x15mr515679bud.23.1214251962114;
        Mon, 23 Jun 2008 13:12:42 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Mon, 23 Jun 2008 13:12:37 -0700 (PDT)
In-Reply-To: <485BB134.9080203@mircea.bardac.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85915>

On 6/20/08, Mircea Bardac <dev@mircea.bardac.net> wrote:
> > when running git svn dcommit --add-author-from on a git-svn repository,
> > --use-log-author is not implied by itself. This causes the rewritten history
> > to not show the author in the way most users would expect it to be, "Name
> > <email@domain.tld>", but instead "<user@uuid>".
> >
> > Instead of forcing people to write "svn dcommit --add-author-from
> > --use-log-author", is it a bad move to imply the last argument, making the
> > history look more user-friendly to start with?
>
>  The documentation mentions that these 2 parameters are for init and, like
> other parameters, I had the feeling they will affect either the "init"
> process or the entire existance of the repository. Now that I look better, I
> see that there is no "config" note next to them.

They are separate options; --add-author-from affects dcommit (but not
fetch or clone), while --use-log-author affects fetch and clone (but
not dcommit).  They do different things, and I can imagine wanting one
and not the other, so having one imply the other isn't very safe.

You can set config options for these, however:

git config svn.addAuthorFrom true
git config svn.useLogAuthor true

(I actually use "git config --global" to set these on my system so
they apply to all my git-svn repositories.)

>  I would also like some option to stop pushing a commit if it doesn't have
> any From/Signed-off-by line in it.
[...]
>  P.S. I am very curious why using From and not Signed-off-by. I had the
> feeling that Signed-off-by is being used to also mark the path of a patch.
> Also, is there a centralized list of all the ways a patch can be "marked"

Signed-off-by is a legal declaration.  Please read the documentation
carefully before using it.

From: is automatically added (when you enable the option and there's
no Signed-off-by or From already) and is just informational.

Have fun,

Avery
