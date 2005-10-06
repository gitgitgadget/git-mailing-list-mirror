From: Santi Bejar <sbejar@gmail.com>
Subject: Re: [PATCH] Write .editmsg in GIT_DIR to avoid being in git-status.
Date: Thu, 6 Oct 2005 15:30:30 +0200
Message-ID: <8aa486160510060630m2afb18ffx@mail.gmail.com>
References: <87achnq4z7.fsf@gmail.com>
	 <7vk6griq8d.fsf@assigned-by-dhcp.cox.net>
Reply-To: Santi Bejar <sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 15:32:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENVpS-0002VL-Nx
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 15:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVJFNab (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 09:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbVJFNab
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 09:30:31 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:5711 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750911AbVJFNab convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Oct 2005 09:30:31 -0400
Received: by xproxy.gmail.com with SMTP id i30so259294wxd
        for <git@vger.kernel.org>; Thu, 06 Oct 2005 06:30:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KysgceLuaDHoEFiZ7IbOEMVgHHXBxXyDB2R5JE7v4uHgH5BKK8u3GzJmlv0ruQjgzwlXuL4nsKAY4WUKZcTaVckF+hxUSyeE9CneInNyIZR5UnUM9kIxsCnY0r9l9p+kDw2I1s7E1JqxNIG6eox19FS6fLggjn8N5TfscTTXeQo=
Received: by 10.70.100.16 with SMTP id x16mr1255461wxb;
        Thu, 06 Oct 2005 06:30:30 -0700 (PDT)
Received: by 10.70.73.19 with HTTP; Thu, 6 Oct 2005 06:30:30 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6griq8d.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9768>

2005/10/5, Junio C Hamano <junkio@cox.net>:
> Santi B.ANijar <sbejar@gmail.com> writes:
>
> > It appears in the git-status output during a git-commit if you have
> > something in info/exclude.
>
> ... which does not worry me too much; you'll get used to it ;-).
>

I'm used too, but I don't think it's a 1.0 thing.

> > Also for .cmitmsg and .cmitchk to make git-commit work
> > in read-only working trees.
>
> If a working tree is read-only, I wonder what you are committing.
>

I keep my /etc modifications in git, and I want to commit as a user not as root.

> It might not be a bad idea to think about this a bit more before
> actually coding.  You are moving things out of the working tree
> root level, which is a valid thing to do when worrying about a
> repository (or working tree) that you do not have write access
> to.  We've had a fix similar to this for temporary files used by
> diff commands, which moved them to $TMPDIR or something like
> that.  If the working tree root level is not writable for you,
> is it valid/reasonable to assume that $GIT_DIR is?  Are there
> better places?  E.g. perhaps $HOME/.gittmp/?

Yes, it was just quick. I think the best way would be to write to /tmp
but honor $TMPDIR.

>
> >  ret="$?"
> > -rm -f .cmitmsg .editmsg .cmitchk
> > +rm -f "$GIT_DIR"/{.cmitmsg,.editmsg,.cmitchk}
>
> Please do not do "{a,b,c}".  I think ksh can grok the rest of
> the git-commit.sh code, but not this.

OK.
