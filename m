From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Continue git clone after interruption
Date: Thu, 20 Aug 2009 09:37:04 +0200
Message-ID: <200908200937.05412.jnareb@gmail.com>
References: <1250509342.2885.13.camel@cf-48> <200908192142.51384.jnareb@gmail.com> <alpine.LFD.2.00.0908191552020.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 20 09:37:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me2D6-0001g6-1H
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 09:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbZHTHhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 03:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbZHTHhN
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 03:37:13 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:46422 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbZHTHhL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 03:37:11 -0400
Received: by fxm17 with SMTP id 17so289623fxm.37
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 00:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=f9ruNNQdkdtalUfPFwIAE7vCHTQxDNgd+6dyPHEwqwI=;
        b=a5t0lR1qJDEyezdoaLuLvjXOyEVbjMHsh34W5wq3OQsEcTUkv686p4altEU9rbTOBS
         4A6bqyztjYbi06ZEOoN8iOCbs6prp1LJF4EUYd4PNGk1rOIBNSkJPbXlTK7LnBiR3GTB
         Z/R3hGzBFJQsMZSbT0HkNC6/ya7MOZxymjSwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PRBo6hW7y6LP8bfacvPhZocDe/QGO81gS3gGTJ7DZJGUCudTo7c78FWBbUfvF9gWCn
         iUyPVd944/6l3JEISY5QL5ir5rkw56l0/qhZxN+4LQ9pSev4tN7OEleH6CA48bFEUybY
         p5Jv2hS2qLWCfZhxlsSeJIp+46XxNtVkK9X2Y=
Received: by 10.103.84.12 with SMTP id m12mr2923906mul.79.1250753830477;
        Thu, 20 Aug 2009 00:37:10 -0700 (PDT)
Received: from ?192.168.1.13? (abvn197.neoplus.adsl.tpnet.pl [83.8.211.197])
        by mx.google.com with ESMTPS id 25sm3389436mul.53.2009.08.20.00.37.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 00:37:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.0908191552020.6044@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126612>

On Wed, 19 Aug 2009, Nicolas Pitre wrote:
> On Wed, 19 Aug 2009, Jakub Narebski wrote:
> > 
> > On Wed, 19 Aug 2009, Nicolas Pitre wrote:
> > > On Wed, 19 Aug 2009, Jakub Narebski wrote:

[...]
> > > Yet, that bundle would probably not contain the latest revision if it is 
> > > only periodically updated, even less so if it is shared between multiple 
> > > repositories as outlined above.  And what people with slow/unreliable 
> > > network links are probably most interested in is the latest revision and 
> > > maybe a few older revisions, but probably not the whole repository as 
> > > that is simply too long to wait for.  Hence having a big bundle is not 
> > > flexible either with regards to the actual data transfer size.
> > 
> > I agree that bundle would be useful for restartable clone, and not
> > useful for restartable fetch.  Well, unless you count (non-existing)
> > GitTorrent / git-mirror-sync as this solution... ;-)
> 
> I don't think fetches after a clone are such an issue.  They are 
> typically transfers being orders of magnitude smaller than the initial 
> clone.  Same goes for fetches to deepen a shallow clone which are in 
> fact fetches going back in history instead of forward.  I still stands 
> by my assertion that bundles are suboptimal for a restartable clone.

They are good as a workaround for lack of resumable clone in a pinch,
but I agree that because  a) like packfile they cannot guarantee that
for the same arguments (endpoints) they would generate the same file,
b) you can't generate currently resume pat of bundle only (and it would
be probably difficult to add it)  they are not optimal solution.

> As for GitTorrent / git-mirror-sync... those are still vaporwares to me 
> and I therefore have doubts about their actual feasability. So no, I 
> don't count on them.

Well... there is _some_ code.

> > > Hence having a restartable git-archive service to create the top 
> > > revision with the ability to cheaply (in terms of network bandwidth) 
> > > deepen the history afterwards is probably the most straight forward way 
> > > to achieve that.  The server needs no be aware of separate bundles, etc.  
> > > And the shared object store still works as usual with the same cached IO 
> > > whether the data is needed for a traditional fetch or a "git archive" 
> > > operation.
> > 
> > It's the "cheaply deepen history" that I doubt would be easy.  This is
> > the most difficult part, I think (see also below).
> 
> Don't think so.  Try this:
> 
> 	mkdir test
> 	cd test
> 	git init
> 	git fetch --depth=1 git://git.kernel.org/pub/scm/git/git.git
> 
> Result:
> 
> remote: Counting objects: 1824, done.
> remote: Compressing objects: 100% (1575/1575), done.
> Receiving objects: 100% (1824/1824), 3.01 MiB | 975 KiB/s, done.
> remote: Total 1824 (delta 299), reused 1165 (delta 180)
> Resolving deltas: 100% (299/299), done.
> From git://git.kernel.org/pub/scm/git/git
>  * branch            HEAD       -> FETCH_HEAD
> 
> You'll get the very latest revision for HEAD, and only that.  The size 
> of the transfer will be roughly the size of a daily snapshot, except it 
> is fully up to date.  It is however non resumable in the event of a 
> network outage.  My proposal is to replace this with a "git archive" 
> call.  It won't get all branches, but for the purpose of initialising 
> one's repository that should be good enough.  And the "git archive" can 
> be fully resumable as I explained.

It is however only 2.5 MB out of 37 MB that are resumable, which is 7%
(well, that of course depends on repository).  Not that much that is
resumable.

> Now to deepen that history.  Let's say you want 10 more revisions going 
> back then you simply perform the fetch again with a --depth=10.  Right 
> now it doesn't seem to work optimally, but the pack that is then being 
> sent could be made of deltas against objects found in the commits we 
> already have.  Currently it seems that a pack that also includes those 
> objects we already have in addition to those we want is created, which 
> is IMHO a flaw in the shallow support that shouldn't be too hard to fix.  
> Each level of deepening should then be as small as standard fetches 
> going forward when updating the repository with new revisions.

You would have the same (or at least quite similar) problems with 
deepening part (the 'incrementals' transfer part) as you found with my
first proposal of server bisection / division of rev-list, and serving
1/Nth of revisions (where N is selected so packfile is reasonable) to
client as incrementals.  Yours is top-down, mine was bottom-up approach
to sending series of smaller packs.  The problem is how to select size
of incrementals, and that incrementals are all-or-nothing (but see also
comment below).

In proposal using git-archive and shallow clone deepening as incrementals
you have this small seed (how small it depends on repository: 50% - 5%)
which is resumable.  And presumably with deepening you can somehow make
some use from incomplete packfile, only part of which was transferred 
before network error / disconnect.  And even tell server about objects
which you managed to extract from *.pack.part.

> > > Why "git archive"?  Because its content is well defined.  So if you give 
> > > it a commit SHA1 you will always get the same stream of bytes (after 
> > > decompression) since the way git sort files is strictly defined.  It is 
> > > therefore easy to tell a remote "git archive" instance that we want the 
> > > content for commit xyz but that we already got n files already, and that 
> > > the last file we've got has m bytes.  There is simply no confusion about 
> > > what we've got already, unlike with a partial pack which might need 
> > > yet-to-be-received objects in order to make sense of what has been 
> > > already received.  The server simply has to skip that many files and 
> > > resume the transfer at that point, independently of the compression or 
> > > even the archive format.
> > 
> > Let's reiterate it to check if I understand it correctly:
> > 
> > Any "restartable clone" / "resumable fetch" solution must begin with
> > a file which is rock-solid stable wrt. reproductability given the same
> > parameters.  git-archive has this feature, packfile doesn't (so I guess
> > that bundle also doesn't, unless it was cached / saved on disk).
> 
> Right.

*NEW IDEA*

Another solution would be to try to come up with some sort of stable
sorting of objects so that packfile generated for the same parameters
(endpoints) would be always byte-for-byte the same.  But that might be
difficult, or even impossible.

Well, we could send the list of objects in pack in order used later by
pack creation to client (non-resumable but small part), and if packfile
transport was interrupted in the middle client would compare list of 
complete objects in part of packfile against this manifest, and sent
request to server with *sorted* list of object it doesn't have yet.
Server would probably have to check validity of objects list first (the
object list might be needed to be more than just object list; it might
need to specify topology of deltas, i.e. which objects are base for which
ones).  Then it would generate rest of packfile.
 
> > It would be useful if it was possible to generate part of this rock-solid
> > file for partial (range, resume) request, without need to generate 
> > (calculate) parts that client already downloaded.  Otherwise server has
> > to either waste disk space and IO for caching, or waste CPU (and IO)
> > on generating part which is not needed and dropping it to /dev/null.
> > git-archive you say has this feature.
> 
> "Could easily have" is more appropriate.

O.K.  And I can see how this can be easy done.

> > Next you need to tell server that you have those objects got using
> > resumable download part ("git archive HEAD" in your proposal), and
> > that it can use them and do not include them in prepared file/pack.
> > "have" is limited to commits, and "have <sha1>" tells server that
> > you have <sha1> and all its prerequisites (dependences).  You can't 
> > use "have <sha1>" with git-archive solution.  I don't know enough
> > about 'shallow' capability (and what it enables) to know whether
> > it can be used for that.  Can you elaborate?
> 
> See above, or Documentation/technical/shallow.txt.
 
Documentation/technical/shallow.txt doesn't cover "shallow", "unshallow"
and "deepen" commands from 'shallow' capability extension to git pack
protocol (http://git-scm.com/gitserver.txt).

> > Then you have to finish clone / fetch.  All solutions so far include
> > some kind of incremental improvements.  My first proposal of bisect
> > fetching 1/nth or predefined size pack is buttom-up solution, where
> > we build full clone from root commits up.  You propose, from what
> > I understand build full clone from top commit down, using deepening
> > from shallow clone.  In this step you either get full incremental
> > or not; downloading incremental (from what I understand) is not
> > resumable / they do not support partial fetch.
> 
> Right.  However, like I said, the incremental part should be much 
> smaller and therefore less susceptible to network troubles.

If you have 7% total pack size of git-archive resumable part, how small
do you plan to have those incremental deepening?  Besides in my 1/Nth
proposal those bottom-up packs werealso meant to be sufficiently small
to avoid network troubles.


P.S. As you can see implementing resumable clone isn't easy...

-- 
Jakub Narebski
Poland
