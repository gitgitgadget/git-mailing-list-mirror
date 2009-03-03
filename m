From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 3 Mar 2009 02:37:34 -0500
Message-ID: <76718490903022337n79a0c11cw95e80d99cd598d17@mail.gmail.com>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com>
	 <1235865822-14625-2-git-send-email-gitster@pobox.com>
	 <1235865822-14625-3-git-send-email-gitster@pobox.com>
	 <20090301031609.GA30384@coredump.intra.peff.net>
	 <7v63itbxe7.fsf@gitster.siamese.dyndns.org>
	 <20090301100039.GD4146@coredump.intra.peff.net>
	 <20090301170436.GA14365@spearce.org>
	 <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org>
	 <20090303070937.GB30609@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 08:39:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LePDU-0003zn-Ja
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 08:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbZCCHhj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 02:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbZCCHhi
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 02:37:38 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:12904 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbZCCHhg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 02:37:36 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2676668rvb.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 23:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Xy1V9ls785zKsWWY/jX5zTRxwgpLNe7UIvlFC17odXs=;
        b=Z9YvUvk0C5revsuT+rEqoAYyyWOGnmOPJl7D2lHoVflkn8Jro5W1o6X1WpzrE+Sizx
         roWFmvrFJ6bQONBKphHm27u2nuDCpP/mgDzZCoA17Ske9Fr5VFx8bRG7LkXkKXdEqYca
         w8iSrcbfkFWOpBLGdx+N/NPZ0Hq3FPBPIyrDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eOBgwxd9lMGEFI7hlKN+bHgzs1DY9rNi9V3PYkuedNZ3xJZHzUu1+A7IpRyXmhsNTm
         DcxxD3zijy/F/Z6pBtJNu9EYvxv4kU5C8znNXFYT8zFI3xa70wnpEauttHm7gqcnM19/
         etizD16V/veHMTU+OIbd7qwNNXlTjFMXdScec=
Received: by 10.141.5.3 with SMTP id h3mr3383278rvi.19.1236065854276; Mon, 02 
	Mar 2009 23:37:34 -0800 (PST)
In-Reply-To: <20090303070937.GB30609@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112013>

On Tue, Mar 3, 2009 at 2:09 AM, Jeff King <peff@peff.net> wrote:
> If you are going to limit it in that way, wouldn't it be better to do=
 it
> entirely client-side? As in, "git push --create remote" will literall=
y
> do:
>
> =C2=A0 =C2=A0ssh remote_host "mkdir -p remote_dir && cd remote_dir &&=
 git init --bare"
>
> ? Then you don't have to care about whether the remote side is recent
> enough to support this, and there are no potential security issues; g=
it
> is merely saving you from typing the commands you could have done
> yourself.

So I was curious how Mercurial implemented this, and it is similar to
what Junio coded. It runs "hg init" on the remote end via ssh. (hg
init <path> takes care of creating the directory; I just also noticed
you can do hg init ssh://host/path to create the repo remotely, which
is I guess sorta interesting.)

> I think a featur like this needs to be triggered manually via
> "--create" or similar. Otherwise a typo on a regular push will be ver=
y
> confusing as your pushes appear to go nowhere. Though I suppose most
> regular pushes happen using a configured remote, in which case it is =
not
> as much of an issue.

So I could've sworn Mercurial creates a remote repo for you on push,
but it turns out it does not:

$ hg push ssh://localhost/~/bar
remote: abort: There is no Mercurial repository here (.hg not found)!
abort: no suitable response from remote hg!

I concur w/Jeff and I think git probably should not as well. I think
that instead adding it to init might be interesting

"git init <arg>" where <arg> is local (and it creates the directory
and repo for you) or arg is ssh://... and it creates the dir and repo
over there for you.

And have "git push" abort with a friendlier message than:

fatal: '~/bar': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly

If that's a plumbing message maybe it can't change, unless push
swallows it and says something nicer like:

fatal: '~/bar' not a git repository. Create the destination repository
with "git init" before pushing.

We can be even friendlier than Mercurial. :-)

j.
