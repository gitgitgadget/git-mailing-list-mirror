From: Tim Visher <tim.visher@gmail.com>
Subject: Re: local configuration
Date: Mon, 20 Jul 2009 07:56:29 -0400
Message-ID: <c115fd3c0907200456m479bc762w91b4a6e0d580e9ac@mail.gmail.com>
References: <33BF73EE-79AB-435F-B35F-E848DD1F3BF3@roalddevries.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Roald de Vries <rdv@roalddevries.nl>
X-From: git-owner@vger.kernel.org Mon Jul 20 13:56:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSrU0-00030U-UF
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 13:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbZGTL4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 07:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbZGTL4h
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 07:56:37 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:59887 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbZGTL4a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 07:56:30 -0400
Received: by an-out-0708.google.com with SMTP id d40so3525489and.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VQMhHGLEBiwvq5zuaE3WbA9HCCBVhprgYFNUXXOVyfQ=;
        b=BwqYMnca7Ri4IHAOKJ+a8JGLnTrnlZ0IxQhWAVN3V8dFyYjmelPZN3wj8AOUr4TtTN
         HipPWSbnl0wp4MmbXFc2ZF83WybI91D+OIdvdrHSyaT6CAGJeqiRuZ57L6DPX70z8Cte
         iVWfmJRqrmofycs8Yf3VrJ/mvFfZsY1/jU0ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kgBy9Nx5m/NxrSTySPa2Vf+F6BaEBifm5nZxOOh1PPPAQT/QD290p9RIBtK1uZR3LX
         mi0tS4eH5m78IslkyM7he1BqPCLZPmfLmCw9WV9mUKnhUxQvNERN/frLUuV4eHwOQcny
         BSEVV5yq+BE1KaEevJF/DA+SUZn0Yzq954UtU=
Received: by 10.100.227.18 with SMTP id z18mr6069313ang.49.1248090989351; Mon, 
	20 Jul 2009 04:56:29 -0700 (PDT)
In-Reply-To: <33BF73EE-79AB-435F-B35F-E848DD1F3BF3@roalddevries.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123590>

Hi Roald,

On Mon, Jul 20, 2009 at 6:54 AM, Roald de Vries<rdv@roalddevries.nl> wrote:
> I want to use git to synchronize my bashrc's (and other configuration files)
> between computers. These have common stuff in them, and stuff that's
> specific to a certain computer. The way I do it now is with a branch for
> each computer, and one common branch. Is this a known use case, am I
> misusing git, and is there a more elegant way to do this?

I'm using git for the same purpose.  I don't think you're going to
find anyone who will get too dogmatic here and say there are any
universally wrong ways to use git.  If it works for you, you should
probably just keep doing it.  However, I could tell you what I'm
doing.

I use git to manage both my bash config files (.bashrc, .inputrc,
.bash_profile) and my .emacs file (a tree .emacs.d).  I manage these
files for use on a Mac and a Windows Box running Cygwin.  What I've
done is I keep all common configuration items in one git repo with a
single branch.  If I'm working on something really large that will be
broken for awhile, which is rare, then I'll branch out and go back to
stable when I'm done working for the day.  Once it's done, obviously,
I merge it back in and delete the branch.  Obviously, though, there is
configuration that only belongs on one box or the other.  For those, I
have files that lie outside of my current repo that I call out to.  I
put them in the same relative locations on either box (obviously, Bash
works the same on Cygwin and the Mac) and so my really local
configuration lives on unbeknownst to my repo.  If I can't locate that
file outside of the repo (for instance, Emacs Easy Configuration file)
then I use the .gitignore file to keep it out of my hair if there are
items local to the box I'm on.

That then begs the question of how to track the local files.  You can
always make a new git repo.  That's easiest to do if the files are
outside of the current repo because you can just make a new repo.  If
the file has to reside in the common repo, then it's a little more
complicated.  You may be able to use sub-repos combined with
.gitignore files?  I haven't had occasion to work this out yet.

Hope that gives you some food for thought.  Again, it's just how I
happen to do things.  Your approach sounds just as good to me.

/me shrugs.

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
