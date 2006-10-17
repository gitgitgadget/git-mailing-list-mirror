From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 10:30:35 +0200
Message-ID: <200610171030.35854.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
	<45345AEF.6070107@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Tue Oct 17 10:30:25 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZkLA-0004qk-Ia
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 17 Oct 2006 10:30:25 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GZkL2-0004X5-OM; Tue, 17 Oct 2006 09:30:16 +0100
Received: from nf-out-0910.google.com ([64.233.182.186])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jnareb@gmail.com>) id 1GZkKx-0004WJ-ON
	for bazaar-ng@lists.canonical.com; Tue, 17 Oct 2006 09:30:11 +0100
Received: by nf-out-0910.google.com with SMTP id l37so228671nfc
	for <bazaar-ng@lists.canonical.com>;
	Tue, 17 Oct 2006 01:30:11 -0700 (PDT)
Received: by 10.49.90.4 with SMTP id s4mr1074063nfl;
	Tue, 17 Oct 2006 01:30:11 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
	by mx.google.com with ESMTP id o45sm540709nfa.2006.10.17.01.30.09;
	Tue, 17 Oct 2006 01:30:11 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <45345AEF.6070107@utoronto.ca>
Content-Disposition: inline
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29035>

Aaron Bentley wrote:
> Linus Torvalds wrote:

>> If you want a short, human-readable name, you _tag_ it. It takes all of a
>> hundredth of a second to to or so.
> 
> But tags have local meaning only, unless someone has access to your
> repository, right?

Tags are propagated during clone, and during fetch/pull (getting changes
from repository). So in that sense they are global.

If you don't publish your repository, then neither tags, nor <URL>+<rev no>
has any sense, any meaning to somebody other than local private repository.
 

>> Well, in the git world, it's really just one shared repository that has
>> separate branch-namespaces, and separate working trees (aka "checkouts").
>> So yes, it probably matches what bazaar would call a checkout.
> 
> The key thing about a checkout is that it's stored in a different
> location from its repository.  This provides a few benefits:
> 
> - you can publish a repository without publishing its working tree,
>   possibly using standard mirroring tools like rsync.

git clone --bare
 
> - you can have working trees on local systems while having the
>   repository on a remote system.  This makes it easy to work on one
>   logical branch from multiple locations, without getting out of sync.

In git we usually use "git clone --local" (with repository database
hardlinked) or "git clone --shared"/"git clone --reference <repository>"
(which automatically sets alternates, i.e. file pointing to alternate
repository database) for that. This way one gets his/her own refs
namespace, so two people can work on different branches simultaneously.

Alternate solution would be to symlink .git, or .git/objects (i.e.
repository "database").

> - you can use a checkout to maintain a local mirror of a read-only
>   branch (I do this with http://bazaar-vcs.com/bzr/bzr.dev).

In git you can access contents _without_ checkout/working area.
For example gitweb (one of git's web interfaces) uses only repository
database and doesn't need checkout/working area.

>> Almost nobody seems to actually use it that way in git - it's mostly more
>> efficient to just have five different branches in the same working tree,
>> and switch between them. When you switch between branches in git, git only
>> rewrites the part of your working tree that actually changed, so switching
>> is extremely efficient even with a large repo.
> 
> You can operate that way in bzr too, but I find it nicer to have one
> checkout for each active branch, plus a checkout of bzr.dev.  Our switch
> command also rewrites only the changed part of the working tree.

Luben (IIRC) works this way.
