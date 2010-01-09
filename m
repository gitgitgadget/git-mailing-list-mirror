From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Linking multiple Git repositories for version tracking
Date: Fri, 8 Jan 2010 23:25:33 -0600
Message-ID: <b4087cc51001082125h37fc43f0t5f2a9809f558388c@mail.gmail.com>
References: <op.u573txvdn3qeew@klee> <op.u574cwxqn3qeew@klee>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: James Beck <james@jmbeck.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 06:26:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTTpo-0002E7-GX
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 06:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045Ab0AIFZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 00:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030Ab0AIFZz
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 00:25:55 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:24656 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab0AIFZy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 00:25:54 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1397829eye.19
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 21:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=T1hEjnyJPTA7u9HMzzTc0AqfFdBAGHQpjfVQifcnqRU=;
        b=bfX2LeKCRLIOmT165jc3bm9Uwxt+KOnlzgsjML+JAtlfX0yES7/0tBiotlMK+d5wWR
         BvOv2IMRLTCHAXPmG28GKbsDBSL0M6TTyPS4cQxceFnB1pvCGcufPS2zU/PNPA4SaK1B
         kOg8i+JBdLl6DvUvnV/dhXQFj5/POoRepiHwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HCZKe9DbWeHslIRhqUvESkBOzhf5YRFw/B8UzXNqbzja08KRt/5SaQ4x5m/OP/3KZc
         uFGlh8NEbKoKM54w8opC+8Mt06c2gZjqYtNVdQ9wShAo79E+N9B+WfsrbOvfv/hWHCHf
         onXWW/HGzEQ0ORHnDrE0411OGHDVeg4tn92e0=
Received: by 10.213.100.229 with SMTP id z37mr4266185ebn.87.1263014753106; 
	Fri, 08 Jan 2010 21:25:53 -0800 (PST)
In-Reply-To: <op.u574cwxqn3qeew@klee>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136515>

On Fri, Jan 8, 2010 at 11:03 AM, James Beck <james@jmbeck.com> wrote:
> I'm starting to move into alpha with this code, so I really need to have a
> system that keeps track of compatible firmware versions. The best I can
> come up with is a plain text file (or Excel spreadsheet) that lists the
> overall firmware version, and the Git hash for each individual project.
> That way, if I want to load up a particular firmware version, I can
> checkout each hash for that version. Seems foolproof, but not terribly
> easy, and somewhat annoying.

The Xorg project is currently composed of 197 separate `modules', and
I believe that (practically) each has its own Git repo.

Their solution seems to be the exact same as yours, though it involves
translating between official release numbers and commits from what I
recall, all of which uses this hand-written list:

    http://cgit.freedesktop.org/xorg/util/modular/tree/module-list.txt

So, perhaps you just need to write a small script to do the checkouts
automatically for you.

Also, you could use Git tags rather than raw Git hashes. If you have
"releases", you could just make the same tag name in each Git repo, so
that checking out any particular "release" just amounts to having a
script loop through the repos and checkout the necesarry commit using
the associated tag. In fact, I suggested this to the Xorg guys not
long ago:

    http://www.mail-archive.com/xorg-devel@lists.x.org/msg03037.html

See:

    http://cgit.freedesktop.org/xorg/util/modular/tree/
    http://www.x.org/wiki/Development/Documentation/ReleaseHOWTO
