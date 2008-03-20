From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH Second draft] Fast forward strategies allow, never, and only
Date: Wed, 19 Mar 2008 23:47:01 -0700
Message-ID: <402c10cd0803192347q7b4a3fb0s35737f361d53a86a@mail.gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
	 <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
	 <7vskym310l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 07:47:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcEZ2-0007JL-IA
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 07:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbYCTGrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 02:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbYCTGrG
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 02:47:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:24483 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbYCTGrF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 02:47:05 -0400
Received: by fg-out-1718.google.com with SMTP id l27so702260fgb.17
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 23:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vpmno6iQdwJgcX48JYW8MxqWgeT+4NuzFfPGRwmjPz8=;
        b=d97UWgoBUAMFqjetmUqA/W023u6O96yCZoLkNfylUmFIk3iQMkuIrtrUOi35lx7xPHwe/g6vyIoKmNn45X1Z5/030d9Lct67VCOfJsw+NdJFOL73tQhKt2y6CtxCX8goMFVf1b3pSLKgiEJFHAo+fdJx7xVblObQ9lMD0DanAmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ElhMN/8qhwRRlmNe28ehIGmisHPm7Ue/jzYKv054AtdHmCumgluQtM7446xND+apw8IqwQnjuJ7/3lxYkXvhWh1XKbxdfbgUSuGspY3rZaGFDfJalhd0q9p4Nl3oi2Gojt4VJP8cFJZ1jlV1N3c5n9Ff9qYRiZPF/zMqCpvWShc=
Received: by 10.82.170.2 with SMTP id s2mr3102042bue.30.1205995621594;
        Wed, 19 Mar 2008 23:47:01 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Wed, 19 Mar 2008 23:47:01 -0700 (PDT)
In-Reply-To: <7vskym310l.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77635>

On Wed, Mar 19, 2008 at 12:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > ...
>  This might be easier to review if split into two parts.  Code suffling to
>  do --ff/--no-ff => ff={allow,never} and documentation updates to improve
>  the description of these two options in the first patch, and addition of
>  "only" to code and the updated docuemntation in the second.

What I would like to do is to split it in three like this:

1. Head reduction

2. --ff/--no-ff => ff={allow,never} and documentation updates.

3. --ff=only

If you would like me to do this please tell me.

> ...
>  might even be a worthy addition to the current documentation.  However it
>  lacks a crucial bit of information: it is _not enough_ to just use --no-ff
>  to maintain the "special status" of "master".  You also need to prevent
>  direct committing to it.

True, but the special case where you have a topic that only consists
of one commit you might as well apply it directly on master.  In any
case, when you commit something directly on the special branch master
you usually know what you are doing. It is perfectly OK to combine the
two.  I am not sure we need to explain this.

>  > +You may therefor need to use this policy on the topic branches as
>  > +well.
>
>  combined with the above, would make "only" an incomplete implementation of
>  the goal you stated earlier, i.e. "to force a completely linear history",

Actually that is not my goal for this implementation, I just tried to
describe a useful use case, but failed.  Let me try again.

I actually need this for the integration between accurev and git I am
using/maintaining/developing (at some point I intend to release it).
At work I am forced to use accurev, but the user interface for accurev
is horrible and it is slow.  I therefor have complete history of
accurev streams in git and are doing all my work in git with branches
and everything.  The git-accurev integrator creates one merge commit
object in git for each time i check something into accurev, .   This
merge commit object ties the content in accurev that was committed
into accurev with the corresponding content in git.  It is important
that further work I do is based on this special merge commit object.
It works if I don't, but  the history gets really messy, and for this
I need the --ff=only so I don't forget to pull or rebase before the
next commit I make into accurev.

>  but I think you can trivially fix this by making sure that there is no
>  merge commit in ORIG_HEAD..MERGE_HEAD and refusing if you find one.  And
>  by fixing the implementation, you do not have to make excuses like the
>  above two and half paragraphs.

I don't intend to do that, simply because I don't need it and it would
actually not work for my workflow.

>  So if that is what you are trying to achieve, you need to update your
>  description.  If you aim for "Totally linear", I think many people will
>  find it is practically useless, but if you are aiming for something
>  different, you should advertise it as such.

You are right, I will try to come up with something better.

>  > @@ -153,8 +153,6 @@ parse_config () {
>  >                 --summary)
>  >                         show_diffstat=t ;;
>  >                 --squash)
>  > -                       test "$allow_fast_forward" = t ||
>  > -                               die "You cannot combine --squash with --no-ff."
>
>  I do not think you defended why it is good idea to drop this sanity check.

I don't see any good idea for having this check.  Nothing bad happens
by allowing to combine these options the way I currently implement it.

-- 
Sverre Hvammen Johansen
