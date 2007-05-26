From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Add git-submodule command
Date: Sat, 26 May 2007 11:39:22 +0200
Message-ID: <8c5c35580705260239x4acf0318vfda3651fb315f8c5@mail.gmail.com>
References: <8c5c35580705251501u6346c27by1d133efc3d157bf2@mail.gmail.com>
	 <11801386283399-git-send-email-hjemli@gmail.com>
	 <7v1wh4ped4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 11:39:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrskE-0007vB-24
	for gcvg-git@gmane.org; Sat, 26 May 2007 11:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbXEZJjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 05:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753480AbXEZJjY
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 05:39:24 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:39917 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbXEZJjX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 05:39:23 -0400
Received: by nz-out-0506.google.com with SMTP id n1so532558nzf
        for <git@vger.kernel.org>; Sat, 26 May 2007 02:39:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h96gCXInwjcyjtabr4M0FrOvVAUulJ3FHnhEBo1BMNp26nfe7JjyeQBLW1hgMUIbiRcFEYAm0PoZDFGC6uHsmmAHcReFemYw2yQOcsSIMJIVwCgn3mz95tuSBfkv4OOjNdH4eUHhQ2T5is7QVAYjAM7ku879EJyiKihIgBnInyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I1LHOvxjikE5sLkBn3m7U/qGgqMJKbY2QGTdQ59/jJVSlodQ+O3fS/VJxc48xuZZZKE3P8oDbPWD87jY2iJpEC1C85ou4YLMS/5cfEBoRBd7Wzoo6BbE3dHfHaRTbRC5gf4LRIRVECxJ/J4WHUyNyAMiALHMk1EhyXQAdZHizzM=
Received: by 10.114.174.2 with SMTP id w2mr1881445wae.1180172362553;
        Sat, 26 May 2007 02:39:22 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 26 May 2007 02:39:22 -0700 (PDT)
In-Reply-To: <7v1wh4ped4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48466>

On 5/26/07, Junio C Hamano <junkio@cox.net> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
> > With this entry in .gitmodules (and a commit reference in the index entry for
> > the path "git"), the command 'git submodule init' will clone the repository
> > at kernel.org into the directory "git".
> >
> > Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> > ---
> >
> > On 5/26/07, Lars Hjemli <hjemli@gmail.com> wrote:
> >> I'll redo the patch, removing the branch-specific things, and try to
> >> shut up :)
>
> Hey, don't shut up.  Starting small and covering corner cases
> incrementally is really the right approach.

Ok, my meds have kicked in and I'm ready for more ;-)

>
> > +status::
> > +     Show the status of the submodules. This will print the sha1 of the
> > +     currently checked out commit for each submodule, along with the
> > +     submodule path and the output of gitlink:git-describe[1] for the
> > +     sha1. Each sha1 will be prefixed with '-' if the submodule is not
> > +     initialized and '+' if the currently checked out submodule commit
> > +     does not match the sha1 found in the index of the containing
> > +     repository. This command is the default command for git-submodule.
>
> (markup) probably you would want `` there for typewriter face.

Ok, will fix

>
> (wording) didn't we have "the name of the hash function is
> SHA-1" patch earlier?  I'd personally prefer calling them
> "object names", though...

Some quick grepping wasn't helpfull:

~/src/git/Documentation$ git grep sha1 | wc -l
98
~/src/git/Documentation$ git grep SHA1 | wc -l
80
~/src/git/Documentation$ git grep SHA-1 | wc -l
22

Would you prefer SHA-1?

>
> Other than that, the command description is very nicely done,
> which means the design of the command set hence the semantics is
> cleanly done.  Good job.

Thanks!

>
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > new file mode 100755
> > index 0000000..247b1ee
> > --- /dev/null
> > +++ b/git-submodule.sh
> > @@ -0,0 +1,172 @@
> > ...
> > +#
> > +# print stuff on stdout unless -q was specified
> > +#
> > +say()
> > +{
> > +     if test -z "$quiet"
> > +     then
> > +             echo -e "$@"
> > +     fi
> > +}
>
> We tend to avoid "echo -e" (not POSIX).  I do not see any string
> you feed to this function that you would _want_ backslash
> escaped sequences (actually I would suspect you would not want
> them).

I do use \t between submodule path and the result of git-describe, but
it's not really needed. I'll drop it.

>
> > +
> > +#
> > +# Run clone + checkout on missing submodules
> > +#
> > +# $@ = requested paths (default to all)
> > +#
> > +modules_init()
> > +{
> > +     git ls-files --stage -- $@ | grep -e '^160000 ' |
>
> Did you mean "$@", i.e. inside double-quotes?

That looks right, yes


> > +             test -d "$path/.git" && continue
> > +
> > +             if test -d "$path"
> > +             then
> > +                     rmdir "$path" 2>/dev/null ||
> > +                     die "Directory '$path' exist, but not as a submodule"
> > +             fi
>
> Could the currently checked-out $path be a symlink to another
> directory, and what does the code do in such a case?

This I will have to test, but I _suspect_ it would fail on "test -e
path" _unless_ the "test -d $path/.git" kicks in.

>
> > +
> > +             test -e "$path" &&
> > +             die "A file already exist at path '$path'"
>
> "test -e" is a relatively new invention and I tended to stay
> away from it, but it should be safe to use these days...

Would you prefer separate -f and -l instead? Hmm, that would match up
nicely with your concern about symlinks ;-)

>
> > +             url=$(GIT_CONFIG=.gitmodules git-config module."$path".url)
> > +             test -z "$url" &&
> > +             die "No url found for submodule '$path' in .gitmodules"
> > +
> > +             git-clone "$url" "$path" ||
> > +             die "Clone of submodule '$path' failed"
>
> "git-clone -n" please, as you will checkout something different
> in the next step anyway.

Nice, I hadn't noticed -n, will fix

>
> > +
> > +             $(unset GIT_DIR && cd "$path" && git-checkout -q "$sha1") ||
> > +             die "Checkout of submodule '$path' failed"
>
> Lose $() around this, as it is not producing a string which is
> the name of the command to run.  You do want a subshell here
> because of chdir, so instead of losing $(), replace them with
> ().

Heh, there's always something new to learn on this list, thanks.

--
larsh
