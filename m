From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Fri, 18 Jul 2008 01:49:17 +0200
Message-ID: <200807180149.18565.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com> <200807162021.56380.jnareb@gmail.com> <487E5AD3.60202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 01:50:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJdEz-0007Nm-7P
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 01:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760356AbYGQXt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 19:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757620AbYGQXt3
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 19:49:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:44709 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666AbYGQXt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 19:49:28 -0400
Received: by nf-out-0910.google.com with SMTP id d3so52707nfc.21
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 16:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=LqwD1ZzhaBm29N45KCvr+vt8qS9gfnpPMov0fbGBExM=;
        b=EbfjNRLBlV7J2ZrAV6oBMtuiUAPjr3whMp5xBVNb30tqZSeO/k4odu2bsw1roi8UTl
         5+7Z72d87bsAW08CHzLwvdbsZP+hLkeWKgZmtj2e0X5W1hai0MFfAlkBTAqIvAy9OeqK
         OYvtOnZPsImw8JERDfp9psw3bui+EWxnxHu8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=gLD+IiSXvQARvbmENe810AZHsUuYjp+h5aJZ7IcD/Aikn/zdnK8j91+d/pQ4trUT+W
         GaMlj/BPFUVtjeJ0x3t7YOgdo4jJolX7q0bANAs07zCUlC85dWvoo2qw4gjWmvzkyaPO
         k+AXU9oE2JOhjtz3woKV0cc7IrYllJiz+po14=
Received: by 10.210.30.10 with SMTP id d10mr1615215ebd.150.1216338566074;
        Thu, 17 Jul 2008 16:49:26 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.254.74])
        by mx.google.com with ESMTPS id b33sm560796ika.2.2008.07.17.16.49.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 16:49:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <487E5AD3.60202@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88937>

On Wed, 16 July 2008 at 22:32 (13:32:25 -0700 (PDT)), Lea Wiemann wrote:
> Jakub Narebski wrote:
> > Lea Wiemann wrote:

> > > +# Keep documentation in one place to save space.
> > 
> > Embedded PODs in Perl modules serve as sort of literate programming,
> > serving to describe code (technical/usage documentation) in addition
> > to comments in code.
> 
> Yeah, but this part is only a bunch of trivial accessor methods.
> If the module grows and the documentation needs to be split, it can be
> done later.  No need to be purist here. ;-)  Also ...
> 
> > [The fact that documentation is separated from code means that
> >  I cannot easily tell and write if code match documentation]
> 
> Several of the methods actually only exist in the Git::Object base
> class.  I still documented them in the Commit and Tag modules since
> having to look up methods in base class documentation can be a tad
> annoying, especially if the base class is never used by users of the
> API. 

I was wondering (but forgot to ask) why for some files you had
continuous block of documentation, and in others documentation 
interspersed with documented code.

I think that providing documentation for all methods for "front-end"
class, even for those that are implemented in [abstract] base class,
is a very good idea.  Better to have everything in one place, or at
least in "porcelain" documentation.
 
> > NOTE that element of list of revisions has in addition to that also
> > _effective_ parents in the event of history simplification, for
> > example  for 'history' view, or when using '--first-parent' extra
> > option. 
> 
> Yes, but we don't actually care about those effective parents for the
> purpose of the Git::Commit API.  IOW, the effective parent should be
> managed by the code that created a list of revisions, not by the
> Git::Commit API.

True.  Or to be more exact in a Git::Revlist (or somesuch) container
class.
 
> > > +Return the author string of this commit object. [...]
> > > +Return the committer string of this commit object.
> > 
> > It returns whole value of 'author' and 'committer' headers, not
> > something extracted from it (into name, email, epoch and timezone),
> > isn't it?
> 
> Yup; that's why I wrote "{author,committer} *string*". ;)

We would probably want _in the future_ to  return some object wrapper,
which stringifies to value of author and committer headers (to author
and committer string), but allows to extract (and format) parts of it,
for example

  $commit->author->name
  $commit->author->email
  $commit->author->date(format => RFC2822)

or perhaps

  $commit->author{'email'}

> > > +=item $commit->message
> > > +
> > > +Return the undecoded commit message of this commit object.
> > 
> > Just raw data?
> 
> Yes, just raw data.  Decoding is too tricky (i.e. not guaranteed to
> work) to just add a simple method to the API; IOW, it needs error
> handling and perhaps fallback encodings.

I'd rather then have _git_ convert it to UTF=8 for us (using 
--encoding=<encoding> option to git-log/git-rev-list), see below
on using git-log.

> > NOTE that for element of list of revisions (as returned by 
> > git-rev-list or git-log) would probably have commit message decoded
> > to UTF-8 by git.
> 
> Yes, but the API doesn't use any of those commands internally,
> if that's what you're worried about.

I'm not worried about; I think using git-log would be better (see also 
below)

> > > +sub author { [...]
> > > +	$self->{_AUTHOR()} or ''; }
> > 
> > Nowhere in documentation is mentioned that you use empty value
> > for no author or no committer (isn't commit object invalid then?).
> 
> Yes, I'd believe so.  I basically wanted to make sure that those 
> methods always return a string; do you think that this is a bad idea?

It don't know if it is good or bad idea, but you should have mentioned 
it in the documentation.


[HERE IS MAIN PART OF THIS RESPONSE]

> >> +	if (!defined $raw_text) {
> >> +		# Retrieve from the repository.
> >> +		(my $type, $raw_text) = $self->repo->cat_file($sha1);
> > 
> > The above makes Git::Commit good solution for gitweb's 'commit' and
> > 'commitdiff' views, but bad solution for 'log', 'shortlog', 
> > 'history' and 'rss'/'atom' views, where you would need to many 
> > command invocations, which is very bad on OS with slow fork.
> 
> $repo->cat_file (now renamed to get_object) actually doesn't fork but
> uses a pipe (cat-file --batch); I don't think it should be
> a performance issue.
 
It is (much) better than forking git-cat-file for each commit shown
on the list; nevertheless I think that it would be better to use git-log
to generate list (or Git::Revlist) of Git::Commit objects.  It is one
fork less, but what more important you don't have to access repository
twice for the very same objects.

Let me elaborate: if I understand correctly for log-like views you 
propose to first run simple git-rev-list with appropriate starting 
point and limiters (--skip, --max-count, -- <pathname>), perhaps using 
'--parents' option to get parents in simplified/rewritten history,
which would traverse history getting commit objects, but outputting
only fragments of info, then feed list of revisions (perhaps via cache,
i.e. excluding objects which are in cache) to 'git cat-file --batch'
open two-directional pipeline.

What I propose instead is to provide alternate method to fully 
instantiate Git::Commit object (in addition to ->_load), which would 
fill fields by parsing git-log / git-rev-list --headers output
(what gitweb currently does in parse_commits).

On the other hand... "git cat-file --batch" should have commits to be
accessed in filesystem cache, which means in memory; but it is possible
that they wouldn't be in cache because of I/O pressure (git-rev-list and 
git-cat-file are separate processes).  And checking if object is in
cache can be simpler... if less effective.  If you generate Git::Commit 
objects via parsing git-log / git-rev-list output, then you can limit
history further by excluding starting points from cache.

[END OF MAIN PART]

> > > +use 5.006002;
> > 
> > Why is this "use 5.006002" for?
> 
> It signifies that this module won't run with Perl <5.6.2.  I've had to
> bump it to 5.008 (Perl 5.8); more about that in the message announcing
> the next version of the patch series.

I was not asking what this mean, but why do you need to set up lower
bound on Perl version.  What feature pre 5.6.2 Perl lacks...

Requiring 5.8 is bad.  What feature pre 5.8 Perl lacks, that you
absolutely cannot go without it? There will be complaints.

> > > +=item 'git_binary'
> > > +The name or full path of the git binary (default: 'git').
> > 
> > Probably should be Git::Cmd or Git object, instead.
> 
> I don't think something Git::Cmd is a good idea (as I pointed out in 
> my reply to Petr, <487BD0F3.2060508@gmail.com>), or at least it
> shouldn't be implemented as part of this patch series.  This method
> is really just supposed to return an argument for exec*p, nothing
> more. 

I think that _not using_ Git::Cmd (or somesuch) API results in botched,
horrible API like (in the 3/3 patch in this series):

  our $git_version = $repo_root->repo(directory => 'dummy')->version;

Aaaaaargh! My eyes!

  out $git_version = Git->version;
 
(Unless it is not needed any longer, or not used any longer; if it is
so, then perhaps implementing Git::Cmd as generic wrapper around git
commands, hiding for example ActivePerl hack, could be left for later).

> > > +=item $repo->cmd_output(%opts)
> > 
> > Please do remember that there are git commands which do not need
> > access to git repository,
> 
> As I wrote in my reply to Petr, Git::Repo is not trying to be a 
> wrapper around git binaries, so this method really shouldn't be part
> of the official API -- it's just auxiliary; I'll underscore-prefix it.

Just a question: was this reply only to him, or to all?

I think that $repo->cmd_output(%opts) is a great shortcut for invoking
Git->cmd_output with '--git-dir=<repo>' added automatically.  So it
should be left, but perhaps under different implementation.

> > > +# To do: According to Git.pm, this might not work with ActiveState
> > > +# Perl on Win 32.  Need to check or wait for reports.
> > 
> > Why not copy code from Git.pm, then?
> 
> Apart from the fact that I don't do cargo-cult programming? ;-)   
> Git.pm forks, whereas Git::Repo uses open, '-|', so it's actually different
> (and it's not possible to copy the code).

Actually magic open, '-|' _does_ forks, only implicitely. So Git.pm
does generate the same or almost the same code, but it work (around)
with ActiveState Perl.

> > I think I'd rather allow extended SHA1 syntax in Git::Commit
> > and Git::Tag constructors; it is one call to git command less
> > (I think).
> 
> I wouldn't -- see my blurb about error handling at the top of my reply
> to Petr (<487BD0F3.2060508@gmail.com>).  You're not supposed to pass
> anything that you didn't get from get_sha1 into Git::Commit or
> Git::Tag constructors, or your error handling is invariably broken.

O.K.

I can understand this simpler, although less than optimal, and geared
mainly towards gitweb needs.

> > > +	my ($in, $out) = $self->get_bidi_pipe(
> > > +		cmd => ['cat-file','--batch-check'], reuse => 1);
> > 
> > Ahhh... here I can see what 'reuse => 1' means, and when it is 
> > useful. But doesn't it make sense _only_ for _bi-directional pipe_?
> > Are you sure that you wouldn't get deadlock?
> 
> Yes to both questions. :-)

Errr... "yes" to first question means that 'reuse' option makes sense
_only_ for get_bidi_pipe? If so, why it is present in other commands?


> > By the way, for gitweb you would need (for performance and for
> > rewritten parents) also get_log / get_commits / get_commits_list
> 
> No. ;-)  Doing fine without those.

See above.
 
> > > +=item $repo->name_rev($committish_sha1, $tags_only = 0)
> > 
> > Why name_rev, and no describe?
> 
> Feel free to add it. ;-)  (It might take some work to come up with a
> decent interface for that method.)

Why do you _need_ name_rev, if you are not to include git-describe
equivalent.


> > > +Return the tagger string of this tag object.
> > 
> > We would probably want some way to extract name, email, epoch/date
> > (and a way to convert epoch+timezone to RFC or ISO format), 
> > timezone.
> 
> Yeah.  At some point. ;-)

See above, in comment about Git::Commit.

> > Should (for completeness) Git::Tag provide $tag->validate() method?
> 
> No, since 'validate' sounds like it would have to do error handling.
> 
> If you mean that this should check if the object exists (and has the
> advertised type), the user of the API should test for "defined
> $tag->repo->get_sha1($tag->object)" or somesuch and do error handling
> themselves.

I meant here equivalent of "git tag -v <tag>"

-- 
Jakub Narebski
Poland
