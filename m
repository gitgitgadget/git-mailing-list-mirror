X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf-gmane@stephan-feder.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 23:35:58 +0100
Message-ID: <4570AE4E.8000600@stephan-feder.de>
References: <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703174.8000609@op5.se> <20061201134610.GW18810@admingilde.org> <457041AD.4010601@op5.se> <20061201150045.GZ18810@admingilde.org> <45705A94.2070509@op5.se> <Pine.LNX.4.64.0612010844380.3695@woody.osdl.org> <457061A7.2000102@b-i-t.de> <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org>
Reply-To: sf-gmane@stephan-feder.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 22:36:26 +0000 (UTC)
Cc: git@vger.kernel.org, Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.4 (X11/20060606)
In-Reply-To: <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32977>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqGzO-00056Q-FS for gcvg-git@gmane.org; Fri, 01 Dec
 2006 23:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162143AbWLAWgH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 17:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162140AbWLAWgH
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 17:36:07 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:47848 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S1162138AbWLAWgE
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 17:36:04 -0500
Received: (qmail 28741 invoked by uid 1011); 1 Dec 2006 22:36:02 -0000
Received: from sf-gmane@stephan-feder.de by mail1 by uid 1003 with
 qmail-scanner-1.22  (ExcuBAtor: 1.0.2. 
 Clear:RC:1(213.157.24.137):SA:0(0.0/5.0):.  Processed in 1.083832 secs); 01
 Dec 2006 22:36:02 -0000
Received: from unknown (HELO mx.stephan-feder.de) (213.157.24.137) by
 mail.medianet-world.de with SMTP; 1 Dec 2006 22:36:01 -0000
Received: from [192.168.3.69] (unknown [192.168.0.2]) by mx.stephan-feder.de
 (Postfix) with ESMTP id 2568496248; Fri,  1 Dec 2006 23:36:00 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 1 Dec 2006, sf wrote:
>> Linus Torvalds wrote:
>> ...
>>> Think of it this way: one common use for submodules is really to just
>>> (occasionally) track somebody elses code. The submodule should be a
>>> totally pristine copy from somebody else (ie it might be the "intel driver
>>> for X.org" submodule, maintained within intel), and the supermodule just
>>> refers to it indirectly (ie the supermodule might be the "Fedora Core X
>>> group" which contains all the different drivers from different people).
>> Could you please be a little bit more specific about how you would store the
>> "pristine copy".
> 
> Note that it's not necessarily "pristine", since the submodule clearly is 
> a local git repository in its own right. So like _any_ git repository, you 
> can (and may well end up) having your own local branches in the submodule, 
> with your own local modifications.
> 
> So I'm not claiming that a submodule must always match some external git 
> tree 100%, and that it must be read-only or anything like that. I'm just 
> saying that I suspect that quite often, one of the MOST IMPORTANT parts is 
> that the submodule is really something that somebody else technically 
> maintains, and that this is actually one of the _reasons_ why it is a 
> submodule in the first place. 
> 
> For example, a lot of projects end up having some kind of "library 
> component" as a submodule. Take something like a video player project, 
> which would have something like ffmpeg as a submodule, not because you'd 
> maintain ffmpeg yourself, but simply because (let's say) the library 
> interface changes enough, or you need a specific version with some of your 
> own fixes that haven't been released widely yet, so you want to carry all 
> the libraries you need _with_ you, even though you don't really maintain 
> that submodule. You at most have some small extensions of your own.
> 
> Now, in this situation, it's relaly really _important_ that the submodule 
> really is totally independent of the supermodule, for several reasons.
> 
> For example, since you don't "really" own that project, carrying around 
> your own fixes is really really painful. We know it happens all the time, 
> and a lot of projects end up needing their own version, but the _last_ 
> thing you want is to be in merge hell all the time. So as a supermodule 
> maintainer, the best possible thing for you is to be able to push back 
> those local changes to the original project maintainer, so that you 
> _don't_ have to maintain your own changes.

True. But if you need the changes to the submodule for your supermodule
to function, and upstream either does not want to merge your changes or
the merge will be available only after a long time, then what is the
alternative? You must be able to keep local changes, and you must be
able to keep pulling from upstream. Of course, what you describe is the
ideal case: You find a bug, push the fix upstream, and in no time at all
your fix is merged and you can just pull a new version into your
superproject, but that might be wishful thinking.

> But you need to realize that the real maintainer of the submodule is 
> TOTALLY UNINTERESTED in your supermodule. He's not going to maintain it, 
> and in fact, if you have anything in the submodule that ends up talking 
> about your supermodule, that's just going to make it a lot less likely 
> that the upstream maintainer will ever pull your changes. He might take a 
> diff from you, but in a perfect world, you'd actually be able to tell him: 
> 
>  "Hey, I've got a git repository with a few fixes to your ffmpeg git tree, 
>   please pull from git://myhost.com/submodule.git to get these fixes:
> 
> 	... explanation of fixes and commits that are relevant to
> 	ffmpeg, and have nothing to do with the supermodule, except
> 	that you need those bug-fixes because you _use_ ffmpeg ...
> 
>   Thanks"
> 
> See?

No! All you need is a naming scheme to address the commit of the
subproject that should be pulled. The extreme case would be to just
address it with its id (well, currently you cannot do that with git
pull, but that is fixable). But I already proposed a syntax for naming
commits which are "hidden" in a superproject: Just name the path as
described in git-rev-parse and append double slashes (to indicate that
you mean the commit, not the tree it contains). So no manual work needs
be done by upstream.

[snipped: about independence of submodule branches]

>> There seems to be some agreement to store the commit id of
>> the submodule instead of a plain tree id in the supermodules tree object, and
>> that all objects that are reachable from this commit are made part of the
>> supermodule repository (either fetched or via alternates). Do you agree?
> 
> Well, I would actually argue that you may often want to have a supermodule 
> and then at least have the _option_ to decide to not fetch all the 
> submodules.

[transmeta example snipped]

> So no, I don't think the supermodule should even _force_ people to always 
> get all the submodules. It migth be the default case, but at the same 
> time, it's just being polite to let users decide on their own whether they 
> really want _all_ of the build infrastructure sources.

If you want to track some chosen submodules there are two easy solutions:

1. If you want to track their state as it appears from the supermodule's
view, pull from master:<submodule>//
2. If you want to track their state from their own development branches,
 pull from <submodule>/master

Can you see the difference?

>> If I understand you correctly you cannot make any changes to the submodules
>> code _in the supermodule's repository_, no bugfixes, no extensions, no
>> adaptions, nothing. Do you mean that?
> 
> Yes. I think you should make all changes _within_ the submodule, because 
> the submodule should still be an independent git tree in its own right.

Every commit is a git tree in its own right, is it not?

[description of independent submodule development snipped]

> And the importance of keeping the submodule independent is partly just 
> stability and sanity, but partly also scalability. For example, the 
> "index" in a supermodule should NOT include the indexes of all the 
> submodules. That's really important, because the index doesn't really 
> scale. Things do slow down with large indexes. 
> 
> For example, git can handle tens of thousands of files easily. I suspect 
> it scales well to hundreds of thousands of filenames. But with 
> supermodules, you really can end up in the situation where you have _tens_ 
> of these submodules, maybe even hundreds. And if you try to maintain one 
> unified index for the _whole_ thing, I guarantee you that you'll start 
> feeling the pain. Indexing millions of files is just not going to be 
> pretty.

I am not sure I understand what you say.

1. If you are working on a submodule, then the supermodule never enters
the picture. You are working independently. So far, so good.

2. If you are working on the supermodule, git will not be able to
function? How would you work without submodules, in which case you would
 have simply one large project?

> So just from a git stability and scalability point, it's important to keep 
> subprojects _separate_. There is obviously integration stuff, but they 
> should still be seen as truly independent projects. Even the supermodule 
> should have clearly its own life even _regardless_ of submodules, because 
> (as I said) quite often you may want the supermodule, but you don't want 
> to have _all_ of the submodules.
> 
> But it's more than that stability and scalability thing too - keeping them 
> separate is what allows you to do pulls and pushes on an individual 
> subproject basis, and have people really work at that level. For example, 
> if you're the compiler guy at a company, you really do want to work with 
> other compiler people _outside_ the company, but you sure as hell may not 
> be able to give them access to your supermodule. But you may want to work 
> on _just_ the compiler parts (or at least share some branches in public), 
> which means that the subproject really has to be able to work 
> _independently_ of the supermodule.

I totally agree. When I try to explain why submodules work that only
exist as part of one or more supermodules, I do not mean to say that you
cannot or should not have independent branches or repositories for the
submodules' code.

> So "independent" here is really key, for several reasons. And that all 
> means, for example, that here must NEVER be any "backpointers". A 
> subproject really can _never_ have backpointers to the superproject, 
> because that fundamentally means that the above kind of "compiler guy 
> works on the compiler subproject in public" cannot work, if your 
> supermodule isn't public.

I took that for granted: from a commit you only ever look backwards (in
time/history dimension) or downwards (in content dimension).

Regards

