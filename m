From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: Re: [SoC] egit: pre-proposal, problem recognition
Date: Tue, 25 Mar 2008 17:29:41 +0100
Message-ID: <47E92875.6030208@gmail.com>
References: <47E532DD.7030901@gmail.com> <20080323075241.GL8410@spearce.org> <200803232244.11031.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gsoc@spearce.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 17:31:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeC2g-0005xQ-Di
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 17:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756301AbYCYQ3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 12:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756243AbYCYQ3r
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 12:29:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:1716 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756204AbYCYQ3q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 12:29:46 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3562905fgb.17
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 09:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=K7PPJ9a9vWrgFsr+xuaGN2aQqRUnN22rTi7Dlc3NSTA=;
        b=ew+9xjQlJVJFglu8kHzdW5IqWZBGEulgKiRsLde4uAwIHK1Nte/deBxzB5fMsNJ9LSpe+ny3ZYJBcsmQb27GYwrDESt3nfv98VLsINI2EigL5XnFG4Rt44eqfZfzg3jhuXdqStwcw3XKgHQMYJIPjuxtKHT3N+DpZqqIZFQMzrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qmfSN+E4bVsP/Xkdsq9S6hMpR8ep5tJ4bDGHKZE/XNtR8iU0syegDnfQBOPq+QpOijmyFbyUJAhR2HJ60X16Us82wMMSSe+neLEqNyZbdTqADOlX4L2HsOyym1xPgnrRYBQnDmDNsvNPFJKN/cqWMs3JvIMG9eXvr9MQXH6No68=
Received: by 10.82.175.17 with SMTP id x17mr21470828bue.19.1206462584820;
        Tue, 25 Mar 2008 09:29:44 -0700 (PDT)
Received: from ?62.21.4.140? ( [62.21.4.140])
        by mx.google.com with ESMTPS id d4sm8520542fga.2.2008.03.25.09.29.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Mar 2008 09:29:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080129 Iceape/1.1.8 (Debian-1.1.8-2)
In-Reply-To: <200803232244.11031.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78196>


Hi, coming back to git-dev. Was nice to get some valuable comments from 
Shawn and Robin :]

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
>> Fetch and clone are in progress.  Robin Rosenburg (the current egit
>> maintainer) has it just about finished and will probably contribute
>> it soon.  But I think its going to cause merge conflicts with my own
>> revwalk work.  So that's why fetch isn't on the GSoC 2008 ideas list.
> Yes, fetch (and clone) over git and git+ssh works on my machine. I did not go 
> into the http based version which is a different story altoghether so it is 
> still open.
> 
>> I did want to start on push work myself.  But if a student comes
>> along and does it for me, then awesome. :)
> 
> Push implies writing a highly efficient packing mechanism (actually could
> work without the efficiency in form of delya packing, but I'm not sure we want 
> that).

I've tried to look at this problem closer.
I've seen that egit supports packed objects reading already. What makes
me not-sleeping is builtin-pack-objects.c code - mentioned packs
creation support. Hacking git story.... IMHO porting it into Java is a 
really big task , also because of its dependencies - especially 
delta/diff related code. It looks for me that it could be as difficult 
as merge support, or even harder :/

So... by not efficient packing you probably mean only compressing 
objects (+possibly arranging some order), but not finding deltas? I 
believe that the main reason why Robin said that he don't know whether 
it is wanted, is that when we are creating and sending such packs, 
they'll be stored on remote side in such inefficient way. Until repo 
admin make some cleanup (packing). I suspect that it's not enough reason 
for creating git-receive-pack --repack option (configuration/protocol 
negotiated, in SSH case, simply forced by client)?
BTW it shows that git receiver is very trusty (efficiency on top?) for
repo users: not only about what they transfer, but also about the way
they transfer and format it.

Anyway, I though that even push code without highly efficient
packing mechanism may be valuable for a meantime - at least as a base 
for further enhancements. I imagine that it maybe easy to abstract packs 
creation algorithm, that could be enhanced later. While rest of a commit 
operation would be already implemented.
In a meantime user could get warning in Commit dialog, that produced 
pack is not so efficient (yeah, not so pretty...).

>> Yes.  Lots of interesting git features (cherry-pick, revert, rebase)
>> are heavily based upon diff/apply and merge.  diff/apply can be
>> implemented in terms of merge in many cases, and we do that a lot
>> in C Git. So we do really need a working merge implementation.

.. so I now see that merge and packing operations look like most needed 
and most hard to do;)

> A subproject of that is making graphical merge resolution inside Eclipse. That
> might not be such a big project though depending on how much support
> there is in eclipse. I haven't looked into it really.

I've been looking around. There is general Eclipse Synchronization API 
as part of Team API, and related Synchronize View to provide user 
similar look&feel across different synchronization schemes.
Subclipse and CVS for Eclipse implements this API. I'm not very 
experienced CVS user, but saw that there are 2 Synchronization Views for 
CVS: for synchronization with repository (head?) and merging/conflicts 
resolutions. The second one is easier, and is what you probably mean. So 
there is pretty nice support from Eclipse. However, without stable merge 
API (not existing yet) is hard to do anything around that.

At the beginning, there could be just Compare Editor (CompareUI) for 
conflicting file edition without whole synchronization perspective and 
view  - not a big project. It is nice Eclipse editor, that "only" needs 
tree of DiffNode objects as input: result tree of three-way or two-way 
merge algorithm. Maybe some ad-hoc version could be provided without 
merge API (not sure), basing on git-merge result file with marked 
conflicts for creation of DiffNode tree (showing just two-way merge).


>> Yea, I wrote that statement about using merge code from Eclipse,
>> but lately I have been thinking that is a bad idea.  Another person
>> has stated to talk about using jgit to build a Git NetBeans plugin,
>> and in another case there may be some idea of compiling jgit to
>> CLR and using it for a Git Mono plugin.

Wow;) However, it seems that Microsoft is abandonning J# language? Don't 
know what is current status, I've been coding in C# only.

>> There is currently little-to-no merge support in jgit.  All of it
>> needs to be ported in, or obtained from a suitable Java library that
>> we can embed and ship as part of the package.  C Git for example
>> embeds and ships libxdiff for most of its diff/merge code.

That makes things harder. On the other hand, some people also faced this 
problem before. SVNKit ("jgit for svn") provides some 3-way merge and 
Differencer class from Eclipse org.eclipse.compare, possibly used by 
CVS. However, both of these solutions are product specific, so the code 
(if used; license issues) need to be copied & adapted for jgit. 
Especially SVNKit seems to depend on their own classes.

>> I think merge is a huge task, especially if you have to do your own
>> file level merge implementation by porting in say libxdiff to Java.
>> Focusing on merge may take the better part (or all!) of a GSoC
>> summer, but if you finished early then I would suggest doing the
>> much needed UI additions like you discussed above.

Well, words "better part (or all!)" doesn't sound very enthiusiatic for 
me... (explanation below)

>> Interesting that JSch wasn't a good experience.  Eclipse has just made it
>> an official part of the core platform, even without the IDE and its CVS
>> plugin.  I was sort of hoping that given it is now fully integrated into
>> Eclipse, and its key management is just part of the workspace, that we
>> could take advantage of that in egit.
> The current fetch uses Ganymedes for SSH. It seesm to work well and has
> lots of features for key management. There is an SHA-1 implementation there
> also that should be a bit faster than Sun's default.

Trilead for SSH is successor of Ganymed for SSH, as WWW tells. Yes, it 
was surprising for me, that JSch became official Eclipse core part. 
AFAIR especially annoying things were 1) you had to do polling for 
checking results of some operations(!) 2) no javadoc. I thought that in 
21st century people used to blocking operations, or non-blocking with 
Listener pattern and so on;> Or maybe something changed in library or 
I'm stupid and couldn't read library usage examples correctly.
Both libraries uses same OpenSSH key formats possibly, so maybe key 
management in workspace is possible even if case of "mixing" them.

>> You can join any time.  GSoC is just a good execuse.  :)

Especially good if I don't have much of free time except holidays for 
GSoC :)

To sum up a little. If you don't mind much, I would prefer doing some 
jgit task that will not fill my whole project, as I would like to do 
some Eclipse-related stuff also. Full merge implementation (with 
diff&merge algorithm adaptation) and full push operation (with efficient 
packing)  seems to be tasks that may take a really long time, as I've 
learned from your comments.

My reasons for interesting in tasks that are related to Eclipse are:
- it's nice to play with Eclipse, learn it more
- don't want to dig into real git internals for whole summer, if 
possible; I believe that coming into details for git-newbie may take 
much time
- There is friendly IBM Eclipse Support Center team in Poznan. As they 
are very enthusiastic about supporting Eclipse-related products, they've 
proposed to support GSOC Eclipse-related projects for free:) This means 
that I can work on GSoC in their office and get advices, ask for their 
knowledge (they are pros, Eclipse Foundation contributors) anytime. I 
think it's reasonable to benefit from such proposal.

Reasons for taking tasks related more to git:
- I always appreciate some network/distributed stuff ;)
- possibly interesting algorithms or Java profiling
- merge&packing is much NEEDED

So I would balance them if possible. For example, providing push 
implementation for GIT and SSH with some simple (extensible) packing 
algorithm at first and/or providing HTTP-based (commit walkers as you 
name them) fetch. Then moving to Eclipse/UI related stuff. What do you 
think?

I also see that project is very dynamic, so in 2 months some things may 
change, even some basic merge may support may come? If you agree, I can 
make in my application/proposal longer tasks list with priorities, and 
annotation that specific tasks for implementation will be chosen from 
top, depending on what is current dependencies status.

Maybe it would be easier to chat on IRC for us. What are your nicks if 
you are there (mine: zawir)?

Again, RFC & thanks for support :)

-- 
Marek Zawirski [zawir]
marek.zawirski@gmail.com
