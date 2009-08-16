From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 1/2] add a --delete option to git push
Date: Sun, 16 Aug 2009 11:19:19 +0200
Message-ID: <200908161119.19563.jnareb@gmail.com>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com> <7v7hx6suiy.fsf@alter.siamese.dyndns.org> <7vprax4yzd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	"Git List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 11:20:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McbuW-00082J-2h
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 11:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbZHPJTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 05:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbZHPJTc
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 05:19:32 -0400
Received: from mail-fx0-f215.google.com ([209.85.220.215]:44010 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbZHPJTa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 05:19:30 -0400
Received: by fxm11 with SMTP id 11so1818380fxm.39
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hTM37Z5UHHInOQzgR+MwKwxPirWK0eI8GAmVhL2lJAQ=;
        b=O0xPbeQgVZBRemaZVAkwbSGGTlg+4mXe5hFFHiZBNE3Aau19K2DyWdptgFQbbbwV6x
         YLuyRbe42ZN/VGdNFjOjToVUP4W45qzLimjFgNk8E1XovrcnlVJUZCCr2sQu8kKYZt8H
         9qgK+bXjJPr8u0Bt4rx+j2Og1iTaZIgzEcwIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Zgu3HkL5VNJyIYJWa3/3ytHNurQdXgmWI6wRtSMKhd15irw88rVez+xMIalDLq0iSs
         9BY5sfOZ1GKFTkMBYNhKolrysZX+GrYqI1cdkay8uMIrql3+qvXhIZd9nFd1Y7aS61hI
         ikrwbhFjRkhToIESuZJ+noVdG+y829I1D/fGg=
Received: by 10.103.242.1 with SMTP id u1mr1003370mur.113.1250414370545;
        Sun, 16 Aug 2009 02:19:30 -0700 (PDT)
Received: from ?192.168.1.13? (abwr1.neoplus.adsl.tpnet.pl [83.8.241.1])
        by mx.google.com with ESMTPS id i5sm13808921mue.25.2009.08.16.02.19.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 02:19:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vprax4yzd.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126054>

On Sat, 15 Aug 2009, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > One more thing.  I suspect that adding --delete and nothing else probably
> > makes things worse than not doing anything.

I don't necessarily agree with that.  Having '--delete=<dst>' being long
version equivalent of ':<dst>' doesn't in my opinion change parading 
used by git-push to the "<scm> push <operation> <refs>..." paradigm used
by Mercurial.

It's just a convenience syntax sugar: have more readable but longer
version.  Just like equivalent short and long options.

BTW. there are few other places where git is TMTOWDI...

> > In a mental model where "push there --delete $branch" is natural, there
> > are branches on the other side, and when you run 'push' command, you name
> > the special operation, 'delete', that you would want to inflict on them.
> >
> > In such a world, there probably are other (perhaps not so special)
> > operations you can inflict on the branches on the other side as well.
> > They are probably called something like:
> >
> > 	push there --create $branch $commit
> > 	push there --update $branch $commit
> >
> > If you give them only --delete without completing the vocabulary by giving
> > these operations as well, you would force people to mix "git native" world
> > model (i.e. there is no "mode" nor "opration"; there is only "list of
> > instructions, each of which encodes the equivalent of 'mode'") with this
> > Hg-inspired world model.
> 
> One final note on this topic.  A more problematic is --rename.
> 
> In the "there are branches on the other side, and a push command can be
> told to operate on them in different ways" world model, you naturally
> would want to:
> 
> 	push there --delete $branch
>       push there --rename $old $new
>       push there --copy $old $new
> 
> The first one you can implement as a syntax sugar by turning it into the
> native way of pushing ":$branch".  You however cannot shoehorn rename and
> copy, because the way in which git push works does not have direct access
> to their "original" values of remote branches.  If we do not have the
> current object $old points at, you cannot emulate "rename $old $new" nor
> "copy $old $new" only with simple syntax sugarcoating.  We would likely
> need a protocol extension to fit them in, and that is of dubious value.

True.  I'm against introducing "<scm> push <remote> <operation> <refs>"
paradigm.

If you think that '--delete=<dst>' for ':<dst>' would cause too much 
confusion...

> 
> Among the ones Jakub listed in another message:

http://nubyonrails.com/articles/five-features-from-mercurial-that-would-make-git-suck-less

>     1. "<scm> init <directory>" (done)
>     2. "hg commit --close-branch" vs slightly cryptic 
>        "git push origin :refs/heads/feature-tweak", which can be written
>        simply as "git push origin :feature-tweak" I think.
>        (that is what this patch series is about)
>     3. Numeric local references, e.g. 18:a432bc and "hg checkout 18"...
>        but more realistic example would be "hg checkout 6324" :-P
>     4. sensible defaults: meaning of revert, staging area (i.e. commit -a)
>     5. "hg serve" (gitweb and a kind of git-daemon equivalent)

Note that I didn't said that I have agree with those points (as you can
see with comment to #3 for example), and I did say to read original
blog post instead of relying on this bare-bones summary.

> 
> I think only #1 and #5 make sense (and I wonder if it would be enough to
> mention "instaweb" and "daemon" to cover #5).

I think #5 is also about native transport over HTTP, i.e. the "smart"
HTTP protocol idea (which didn't pass protocol design stage, AFAIK
no code).

> 
> As we discussed in this thread at length, #2 is on the borderline.  It
> makes sense if you take only --delete out of possible vocabulary, but when
> you think about it as a part of a coherent whole, it becomes somewhat
> iffy---it does not fit particularly well with other parts of the system.

I can agree that #2 is borderline and a bit problematic (when one is in
the mood for bikeshedding at least ;-))).

> 
> I think #3 and #4 comes from fundamental difference of the world views.
> 
> Regarding #3, giving monotonically increasing numbers to local commits
> would not be very hard without breaking the underlying data model.  You
> would automatically tag the original commit whenever a new branch is
> created, and count commits relative to that origin-point tag for the
> current branch, perhaps following only the first parent chain, or
> something like that.
> 
> For such a incrementing number be any useful, the user's history should
> rarely rewind, and this also introduces a notion/illusion that a branch
> somehow has its own identity, which we deliberately have rejected. I doubt
> this is worth it.  Most of the time you are interested in the recent past,
> and HEAD~14 would be far easier to use than r19354 anyway ;-)

Also there is a matter of fast-forward merges that git use, which
I think is against 'branch have identity' idea.

On the other side there was considered adding 'generation' header
  generation(this) = max(generation(this.parents)) + 1
which was intended to help speed up traversal, but it was decided it
was not worth the hassle to add such commit object header to existing
repository which do not use it.  There was idea to put it in cache,
as it is recalculable, but that idea was never put into code. 

> 
> About #4, in general, I do not think it is worth discussing a topic that
> begins with the word "sensible" when the person who uses that word does
> not realize that what is sensible is in the eyes of beholder.  Different
> SCMs use "revert" to mean different things, because there are a lot of
> combinations of _things_ you would want to revert, _states_ you would want
> to revert to, and _ways_ you would want the revert to be expressed.  You
> may be familiar with the way BK used the word revert, or you may be
> familiar with the way SVN used the word revert.  There is no single
> "right" use of the word.
> 
> It also is not worth repeating the discussion on fear of index, either.

IHMO the very minor disadvantage of having to specify "git commit -a"
with '-a' option in usual case is well worth it when you need more
complicated staging / index manipulation, e.g. during more involved
merging.

> 
> This is a good example of why you should _think_ before blindly parrotting
> whatever random people say on the net.  They have not necessarily thought
> things through before saying "git can learn from X".  You need to do the
> thinking for them to decide if they are making any sense when you read
> these things.

I was just listing what he said ;-)

-- 
Jakub Narebski
Poland
