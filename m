From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Newbie falls at first hurdle
Date: Mon, 19 Sep 2005 07:06:39 +1200
Message-ID: <46a038f90509181206643bce7@mail.gmail.com>
References: <alan@chandlerfamily.org.uk>
	 <200509180135.j8I1Z34n023252@inti.inf.utfsm.cl>
	 <46a038f9050918035436352f71@mail.gmail.com>
	 <200509181347.11403.alan@chandlerfamily.org.uk>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 21:09:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH4Ut-0006IH-OD
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 21:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVIRTGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 15:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVIRTGk
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 15:06:40 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:30303 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751272AbVIRTGk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 15:06:40 -0400
Received: by rproxy.gmail.com with SMTP id i8so192047rne
        for <git@vger.kernel.org>; Sun, 18 Sep 2005 12:06:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p9+BLGys6NMIKgDDWk02YBEWxRmbgk4Q9me48K7KTQh0LGSs2+Djcix4CYb1rXwlmqt7UVjIURkpyeuF/NPk1xFoIS74bGjYxaVYL2L0jTeWiju/RH+8DaKqA11MthVYhIeZPzKk2US/t14ueIVvp3aHwaToMdQIDvs5wvi09+s=
Received: by 10.38.97.78 with SMTP id u78mr120616rnb;
        Sun, 18 Sep 2005 12:06:39 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Sun, 18 Sep 2005 12:06:39 -0700 (PDT)
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200509181347.11403.alan@chandlerfamily.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8805>

On 9/19/05, Alan Chandler <alan@chandlerfamily.org.uk> wrote:
> Still struggling with how to cherry pick parts a previous update (between
> possibly two other branches) and apply them to a current branch - all the
> tutorials assume you want it all, and I can't really understand what the
> cherry pick commands do from their manuals.

Forget the cherry pick commands -- here's a usable, easy strategy.

git-checkout the "source" branch, create a temporary directory to hold
the patches, and call

    git-format-patch --mbox -o patchdir destbranch

This will create one file per patch in the destination directory. Feel
free to delete patches you don't want, and edit the patches you've got
there. Then switch to the destination branch, and use git-applymbox to
merge them in.

If you do this repeatedly, git-format-patch will not reexport patches
you've merged to the destination branch already (if they merged
cleanly unchanged)... or at least that's the theory ;)

The only limitation I've found in this strategy is that it doesn't
deal with binary objects. I'm lost as to what to do in those cases.

cheers,


martin
