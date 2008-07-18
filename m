From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: [PATCH] Teach git submodule update to use distributed repositories
Date: Fri, 18 Jul 2008 09:11:53 +0100
Message-ID: <320075ff0807180111q4ca55cc4v15487af35f6fa63c@mail.gmail.com>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>
	 <alpine.DEB.1.00.0807171311010.8986@racer>
	 <320075ff0807170520r200e546ejbad2ed103bd65f82@mail.gmail.com>
	 <320075ff0807170521s26693381m60648468cce1c41c@mail.gmail.com>
	 <alpine.DEB.1.00.0807171351380.8986@racer>
	 <320075ff0807170703l57fe26d2h1e9c4db1c38dd6f1@mail.gmail.com>
	 <alpine.DEB.1.00.0807171513560.8986@racer>
	 <320075ff0807170807l1537e34ev510deda537e4d11e@mail.gmail.com>
	 <20080717182253.GZ32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jul 18 10:13:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJl5I-0005rm-0q
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 10:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbYGRIL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 04:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbYGRIL6
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 04:11:58 -0400
Received: from gv-out-0910.google.com ([216.239.58.191]:63982 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbYGRIL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 04:11:56 -0400
Received: by gv-out-0910.google.com with SMTP id e6so55859gvc.37
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yQp2wSJhx9VHqts64+GzlJf3QVSv0+aSRsj8YiTKLj8=;
        b=UfZIceqBFe7+4cOjXXDfs8mMnEF8KvyaekTo5CDQ6RKOb61gXotcmI79J6k0VDUaV7
         KsiNsUs4BDSlcRZxkCJZTVi/hS0kJZd7q+NXK42yW4xfHA2eEmcRkSv1pioWnvw3o0s0
         0mPcCnpTgTW5HwWGoZUSTBaYS8Ey3ywPArCRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uQSaeljmVWOhDJASj/aPhkAfZwmSCsKlDt6XNvFED8DlsMZ9tMGdP3ArvP829VguFw
         aK958if/VHxfj16afH+0lfj97P5qI2uL9/ZaJa79JkhYelNj76xfhORGT85DNEnawx5C
         uY2UEZoc7L7DHy3UqnlzzBpLjI82rsq7JFNO8=
Received: by 10.103.203.4 with SMTP id f4mr2754841muq.8.1216368713995;
        Fri, 18 Jul 2008 01:11:53 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Fri, 18 Jul 2008 01:11:53 -0700 (PDT)
In-Reply-To: <20080717182253.GZ32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89006>

On Thu, Jul 17, 2008 at 7:22 PM, Petr Baudis <pasky@suse.cz> wrote:
> On Thu, Jul 17, 2008 at 04:07:11PM +0100, Nigel Magnay wrote:
>> And it works, but
>>
>> $ git pull fred
>> $ git submodule update
>>
>> Can leave you with problems, because if a submodule wasn't pushed to
>> origin, you won't have it available. This is because the commands are
>> equivalent to
>>
>> $ git pull fred
>> for each submodule()
>>   cd submodule
>>   git fetch origin
>>   git checkout <sha1>
>
> Oh! So, only after replying to most of your mail, I have realized what
> are you talking about all the time - _just_ this particular failure
> mode:
>
>        "Someone pushed out a repository repointing submodules to
>        invalid commits, and instead of waiting for the person to fix
>        this breakage, we want to do a one-off fetch of all submodules
>        from a different repository."
>
> There's nothing else you're trying to solve by this, right?
>

No.
"Someone says 'please review the state of my tree, _before_ I push it
out to a (central) repository"

Fred is a person (and != origin). His tree(s) are entirely correct and
consistent, and he doesn't yet wish to push to origin (and perhaps he
cannot, because he does not have permission to do so).

All the tutorials give credit to the fact that in git you don't need a
central server - you can pull directly from people. Except in the case
where you're using submodules, where you're basically forced to
hand-modify .git/config (in this instance, to point to where 'fred' is
storing his submodule trees) before doing a submodule update. This
makes git complicated for users.

I'm trying to improve the UI for projects using submodules to make it
mostly transparent; the best way I can come up with is to pick on
individual usecases and show that they're a particular pain and that
perhaps they don't need to be.

>
> Now, I think that this is a completely wrong problem to solve. Your
> gitweb is going to be broken, everyone has to jump through hoops because
> of this, and that all just because of a single mistake. It shouldn't
> have _happenned_ in the first place.
>
> So the proper solution for this should be to make an update hook that
> will simply not _let_ you push out a tree that's broken like this.
> Something like this (completely untested):
>
> die() { echo "$@"; exit 1; }
> git rev-list ^$2 $3 | while read commit; do
>        git show $commit:.gitmodules >/tmp/gm$$
>        git config -f /tmp/gm$$ --get-regexp 'submodule\..*\.path' |
>                cut -d ' ' -f 1 |
>                sed 's/^.*\.//; s/\..*$//;' |
>                while read submodule; do
>                        path=$(git config -f /tmp/gm$$ "submodule.$submodule.path")
>                        url=$(git config -f /tmp/gm$$ "submodule.$submodule.url")
>                        entry=$(git ls-tree $commit "$path")
>                        [ -n "$entry" ] || die "submodule $submodule points at a non-existing path"
>                        [ "$(echo "$entry" | cut -d ' ' -f 1)" = "160000" ] || die "submodule $submodule does not point to a gitlink entry"
>
>                        subcommit="$(echo "$entry" | cut -d ' ' -f 2)"
>                        urlhash="$(echo "$url" | sha1sum | cut -d ' ' -f 1)"
>                        # We keep local copies of submodule repositories
>                        # for commit existence checking
>                        echo "Please wait, updating $url cache..."
>                        if [ -d /tmp/ucache/$urlhash ]; then
>                                (cd /tmp/ucache/$urlhash && git fetch)
>                        else
>                                git clone --bare "$url" /tmp/ucache/$urlhash
>                        fi
>                        [ "$(git --git-dir=/tmp/ucache/$urlhash cat-file -t "$subcommit" 2>/dev/null)" = "commit" ] || die "submodule $submodule does not point at an existing commit"
>                done
>        done
>
> Comments? If it seems good, it might be worth including in
> contrib/hooks/. Maybe even in the default update hook, controlled by
> a config option.
>
> All the troubles here stem from the fact that normally, Git will not let
> you push any invalid state to the server. This is not completely true in
> this case, but we should prevent this behaviour instead of inventing
> hacks to work it around.
>
>> Unless each submodule had a [remote] specified for "fred", you'd be
>> stuffed. But what you could do is either by passing the right URL, or
>> looking at the superproject [remote] for "fred" - i.e: If in the
>> superproject you have
>>
>> [remote "fred"]
>>         url = ssh://git@fred.local/pub/scm/git/workspace/thing/.git
>> [submodule "module"]
>>         url = ssh://git@repo/pub/scm/git/module.git
>>
>> Then the submodule "module" on fred, if it's a working-copy, can be calculated
>>        ssh://git@fred.local/pub/scm/git/workspace/thing/module/.git
>>
>> If it isn't a WC then you'd have to have a [remote "fred"] in that
>> submodule, but I'm thinking that'd be a rare case.
>
> This is ultra-evil. I think assuming things like this is extremely dirty
> and not reasonable for a universal code, _unless_ we explicitly decide
> that this is a new convention you want to introduce as a recommendation.
> But you should've been very clear about this upfront.
>
> _If_ you still insist on the one-off fetches for some reason, I think
> it's reasonable to provide your own simple script for your users that
> will autogenerate these URLs appropriately for your particular setup.
> I don't think there is any real need for a more generic solution.
>
>> I'd assumed (possibly wrongly?) that there was resistance to putting
>> any of the submodule logic in things other than git-submodules.
>
> Are you following the thread about submodule support for git mv, git rm?
>
> --
>                                Petr "Pasky" Baudis
> GNU, n. An animal of South Africa, which in its domesticated state
> resembles a horse, a buffalo and a stag. In its wild condition it is
> something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
>
