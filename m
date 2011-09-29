From: Phil Hord <phil.hord@gmail.com>
Subject: Re: In favor of "git commit --no-parent"
Date: Thu, 29 Sep 2011 17:02:14 -0400
Message-ID: <CABURp0q4wi5ruLmeaZtN=8QvuX2ftSFQo1uJL0_8-wtm1nYaGA@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr> <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr> <553B5FA1A43748B1ADD759572EADA6FF@PhilipOakley>
 <e4f46b39e9ed4203bfab8a81e25eb600-mfwitten@gmail.com> <7vaa9oz9rl.fsf@alter.siamese.dyndns.org>
 <271cc2ed03774b4988bb61cb3e79750e-mfwitten@gmail.com> <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Witten <mfwitten@gmail.com>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Raible <raible@nextest.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 23:07:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9NpY-0005c1-3c
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 23:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870Ab1I2VHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 17:07:35 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:40672 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757773Ab1I2VHd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 17:07:33 -0400
Received: by wwn22 with SMTP id 22so3606766wwn.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8WBYrelA3XED+6rFe0haPTXh/ulKs2qxMZjZHSjk44Y=;
        b=xXNbKlGJ1Otc6IpRZoEmhaWcwbx3seeDXdxPz4/TpdhHlbVcaMtXCFMvkX+2gd8moV
         xoAtwtdJL6Gd/405JfDvz40t4rnpSN3xCuKxI/KE26yn8UcYboGVPC9PXn+qLmJBrtm2
         r8UDTzuw8ZlrfyionOeib+GFbY9qHEv8N787U=
Received: by 10.216.186.205 with SMTP id w55mr13303056wem.102.1317330155147;
 Thu, 29 Sep 2011 14:02:35 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Thu, 29 Sep 2011 14:02:14 -0700 (PDT)
In-Reply-To: <7vmxdnte0j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182440>

On Thu, Sep 29, 2011 at 2:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
[...]
> Step back a bit. There are two independent issues:
>
>  - When does it make sense to originate two independent histories in a
>   single repository that has a working tree?
>
>  - What is the best tool to originate a new independent history in a
>   single repository that has a working tree?
>
> As I said number of times already, be it done with "checkout --orphan" or
> "commit --no-parent", the "Separate History" use case is better done in a
> separate repository. There is *no* advantage to originate the two separate
> histories that do not share any resemblance of tree shape as branches in a
> single repository with a working tree; "git checkout $branch" between the
> two would actively work against you.

I think a user looking for this functionality -- either a new git user
or a user who seldom uses the "create secondary root commit" command
-- would first try 'git help init'.  It seems logical to me that I
should be able to do this:

 cd my-git-repo
 git init --root=<newbranch> .

This feels natural to me for this operation.

And it doesn't add "dangerous options" to the more commonly used
commands (checkout, commit)

[...]
> That leaves "Hidden History" the only useful use case. IOW, the answer to
> the first question above is not "Separate or Hidden History", but is
> "Hidden History and nothing else".

I think you're saying that the "hidden history" scenario is more
special than the "separate history" one because of these reasons:
1. It is already possible to create a "hidden history".

And that's it. No more reason than that.

But isn't it also possible already to create a "separate history" just
as easily?  I can think of at least three methods that do not involve
git-reset.  And I'm a relative newbie.

> And a half of the the answer to the second question is "checkout --orphan"
> (and the other half would be "filter-branch"). "checkout --orphan" does
> have major safety advantage than introducing "commit --no-parent", as Peff
> pointed out earlier (to which I agreed).

The thing I don't understand about "checkout --orphan" is exactly what
you're getting when you do this.  I assume you get a populated index
and a non-existent HEAD.  This seems a lot like "git init" to me,
especially in the non-existent HEAD area.

I didn't think git init would be much use for this scenario before,
but now I've changed my mind.

 git init --root=<newbranch> --keep-index

Again, this avoids complicating the common commands.  But maybe it
does overload init with extra baggage.

>From this user's perspective it still makes more sense.

Phil

p.s. Sorry for jumping in so late.
