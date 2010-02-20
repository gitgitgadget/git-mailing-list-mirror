From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Storing (hidden) per-commit metadata
Date: Sat, 20 Feb 2010 13:57:31 -0500
Message-ID: <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com>
References: <1266599485.29753.54.camel@ganieda> <1266687636-sup-7641@ben-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Ben Gamari <bgamari@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 21:11:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiuWb-0004XC-VY
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 19:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405Ab0BTS5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 13:57:52 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:62548 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab0BTS5w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 13:57:52 -0500
Received: by yxe38 with SMTP id 38so1200314yxe.4
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 10:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=3s6OOZoi0Qfd/LrfnmCZ8/NBYEv1ez4EpAE91Hui5sg=;
        b=AX9JahBqGlBcia6Wlu/Ewpzi6GhOAcGNsQP13WNnUctG/yvv+eLUhPIaHEJ0+CDPWa
         yHWKeJIdpn39i6QC0y1fDaboBAc0wZy7Ak+iCPf6cZ74bhUgUatftdsvxacfvfp/pIRt
         sEJ3N5jvg0M/IBnCtvOrwJK/CzqQ7URON2lq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=nKxHB6UaUml8BDJdXussjpIgUw7tu7FOQFZa7d3eQDjwH2TJ+vxRwn1QTx+EW+2VYH
         fQ9wyfF5xGq6/FkbF5Z4maaRwGzL3hNmX4qMa2ZR7nqwtt/wfx/ZtxPLvr6L1xlTXvsy
         B96MSIB2ei1A9Sd0mhJQDE0VKii0VCSx7tZC8=
Received: by 10.150.210.9 with SMTP id i9mr3779697ybg.174.1266692271224; Sat, 
	20 Feb 2010 10:57:51 -0800 (PST)
In-Reply-To: <1266687636-sup-7641@ben-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140547>

On Sat, Feb 20, 2010 at 12:41 PM, Ben Gamari <bgamari@gmail.com> wrote:
> Excerpts from Jelmer Vernooij's message of Fri Feb 19 12:11:25 -0500 2010:
>> To allow round-tripping pushes from Bazaar into Git, I'm looking for a
>> good place to store Bazaar semantics that can not be represented in Git
>> at the moment. This data should ideally be hidden from the user as much
>> as possible; it would e.g. contain mappings from git hashes to Bazaar
>> ids.
>>
> Are you sure you want to hide this? I believe git-svn puts this
> information in its commit messages (although I don't know whether it's
> stored elsewhere as well).

Note that git-svn doesn't store *all* the stuff from svn in the git
repository.  So you couldn't, for example, regenerate an svn repo
identical to the original from its git-svn clone.  This limitation is
rarely noticed since the stuff git-svn doesn't store is stuff that git
mostly does differently/automatically/etc.  But that's why git-svn can
get away with cluttering your commit messages with "only" one line of
git-svn cruft each.

However, this does bring up the question: how important is it *really*
to be able to "round trip" from bzr to git and back without losing
information?  Maybe you only need to store enough information to pull
from bzr and then push back your commits.

As for git-notes, they sound like they would be useful for this sort
of thing.  I haven't tried them yet, but my understanding is that
notes anywhere other than the "default" notes ref are not shown in
commit messages, so you can use them for whatever you want.

Have fun,

Avery
