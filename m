From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Interest in locking mechanism?
Date: Tue, 12 Jan 2010 14:24:52 -0500
Message-ID: <32541b131001121124u541de280na9184183d8704dc8@mail.gmail.com>
References: <1263319565-sup-1767@ezyang> <32541b131001121101i76ad8062p3a7f3571ad86b0ce@mail.gmail.com> 
	<1263323292-sup-4182@ezyang>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: "Edward Z. Yang" <ezyang@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jan 12 20:25:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUmMm-0004Np-UZ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 20:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356Ab0ALTZP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jan 2010 14:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932067Ab0ALTZO
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 14:25:14 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:38697 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab0ALTZM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2010 14:25:12 -0500
Received: by ywh6 with SMTP id 6so22764058ywh.4
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 11:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zYNMiECRKjr8WxDRmviyeFUO+rTo5MK87Cw8W4IYDY0=;
        b=KJ8tGGoJDyGAhIVpD5DSFxELiSffTgo6ajJaIXU/Bn1/FpyS1CKr8Oh3WxDS9qjFUm
         4AkldPiLFvMMd3PlIrytreNnUPdyHk25ia7y/G//y9qYcJIXFzpzCrIL5lvmEaR1MhKf
         8C/oaKwZwglzkQFhDRxUd7pp2YERtYNKj5dwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oTHZVvbQO3ctlXGQxtdLP0AeZv5mx8IwiYb4wMB36D0zZ50MdFrFGtX9r9bQzNOSwT
         COkIXpBCzDQsiUBJSrRvDSpf3m/C0+pGngD51ytv4+/bq3CvpfCQoCCXHU0IuklF3Y2m
         ccyUtnbER0IyD4DqpU14llIJz9AsBJflrkQsg=
Received: by 10.150.44.21 with SMTP id r21mr8629299ybr.78.1263324312107; Tue, 
	12 Jan 2010 11:25:12 -0800 (PST)
In-Reply-To: <1263323292-sup-4182@ezyang>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136752>

On Tue, Jan 12, 2010 at 2:11 PM, Edward Z. Yang <ezyang@mit.edu> wrote:
> =A0 =A0* I use Git on a regular basis, and do not use RCS. =A0I const=
antly
> =A0 =A0 =A0have to go digging through the manpages when I occasionall=
y do
> =A0 =A0 =A0stumble upon an RCS system. =A0Interface familiarity is ni=
ce.

But the users who are arguing in favour RCS would say the opposite, rig=
ht?

> =A0 =A0* Putting it in Git means that you can easily grow; you can de=
cide
> =A0 =A0 =A0"Hey, maybe we want to do branchy development" and just do=
 it,
> =A0 =A0 =A0rather than have to drum up the activation energy to do an
> =A0 =A0 =A0rcsimport.

But then you'd have to do an import now instead of later, for no
immediate gain.  The extreme programming people would say YAGNI here;
delay the work until it's actually required, because it'll be no more
work later than it is right now.

> =A0 =A0* If code is deployed in a production context as a Git checkou=
t,
> =A0 =A0 =A0you can definitely have both branchy development as well a=
s
> =A0 =A0 =A0a shared working copy (with low contention, but contention=
 nonetheless).

I would suggest that by the time you're doing this, you're just lying
to yourself if you think you have RCS-style locking.  People will
quite easy be able to change the same files as other people, then push
into git, and sooner or later someone will have to pull from git into
the original shared repository, possibly stomping on other people's
work.  So you end up not having the advantage you were trying to
achieve.

BTW, I will try be a bit more constructive in case you *really* want
this: I've never heard of anyone doing RCS-style locking with git, so
you're probably out of luck if you're looking for a pre-made solution.
 But it's probably rather easy to construct a simple shell script
implementation that's independent of your revision control system
(since locking files has nothing to do with revision tracking,
really).  Just make a 'co' command that writes your username to
=2Efilename.lock and chmods the file; then write a ci command that
checks the lockfile to make sure it's yours, deletes the lock file,
git commits it, and chmods the file back again.

Have fun,

Avery
