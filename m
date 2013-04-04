From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Thu, 4 Apr 2013 00:42:22 -0600
Message-ID: <CAMP44s3qAPJtNVsb4gvYd1PunN4c-crxpVJc0K9520eiBO8iwA@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<20130402200948.GF2222@serenity.lan>
	<2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
	<CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
	<EF2F8946-4F60-4659-9215-6C21C9641AB0@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, gitifyhg@googlegroups.com
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Apr 04 08:43:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNdst-0005S0-Ns
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 08:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418Ab3DDGm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 02:42:26 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:50709 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763744Ab3DDGmY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Apr 2013 02:42:24 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so2390039lbi.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2013 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=p1DHk5ZzwKIZWOMNQ+64CNYpLBBttGCk2gNUSlKcnXs=;
        b=lzn1STh/k4ICiFYCO1h5HV1DkzDCeizwk7nLgd4AA9VTmm3IcFXW4cbT+LCI9nDGr3
         W04Vm+cXvdiSLpxKaG7f4FYUw3EX8N4fRU6fmawCRPdSEyKjvuSbxJXm+2SOCOCZmDLM
         eNnDggBzOSx5MxZ7V0WGoF3fhe3sTw4x+pEJn8YlNKCK6PJWaDc3Pt0wDuupoUvDftTs
         OD2qEUKiQ7vb50bsnJDe71qkC1R8Bs9uD6kbUSYnHv6TX0gL2PA5V9PZjv1taRhC7+b6
         BDeYKiRlGGI7s9jdSHVSximjt5b3r6ELJ5PcTuK33ELX/P0A/XJ9n2Er0txJzffzm0dp
         xSYA==
X-Received: by 10.152.147.36 with SMTP id th4mr2534662lab.19.1365057742697;
 Wed, 03 Apr 2013 23:42:22 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Wed, 3 Apr 2013 23:42:22 -0700 (PDT)
In-Reply-To: <EF2F8946-4F60-4659-9215-6C21C9641AB0@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219988>

On Wed, Apr 3, 2013 at 6:25 PM, Max Horn <max@quendi.de> wrote:
> On 03.04.2013, at 03:31, Felipe Contreras wrote:

>> I only learned about it recently, I've looked at the history and to me
>> it seems rather chaotic, and a lot of the code was simply copied from
>> git-remote-hg without comment.
>
> gitifyhg was scrapped and completely restarted from scratch at some point. Based largely on your git-remote-hg code. A bit more on its history can be read here:
>   http://archlinux.me/dusty/2013/01/06/gitifyhg-rewritten/

Yeah, I'm aware of that, but look at the README:

---
To the best of our knowledge, this is the most robust and usable git
to hg bridge currently available. It has a large test suite and better
documentation than the alternatives we know about. It has been tested
on several large mercurial repositories (including that of mercurial
itself and the pypy repository) that break with various other
git-to-hg bridge projects and is used daily in normal workflow
scenarios.
---

It reads as though gitifyhg was this marvelous piece of code developed
independently, and everything else (including remote-hg) pales in
comparison. There's no mention at all of remote-hg until the very
bitter end where it's mentioned that it's "heavily inspired by and
borrows code" from it, but it's much more than that, it's *based* on
this code. When I read the code, not only do I see it's the same
design, has the same function names, the same variables, the same
order, huge tracks of code are exactly the same, and in fact, I have
too look very carefully to see the differences.

Take a look at this commit:
http://github.com/buchuki/gitifyhg/commit/2c4fd7329fa0db8dd56df3ac8c62fa292580b74e

Geez, that's an awfully nice author sanitize function, but Dusty
Phillips was not the author, I am, he just added 2 lines of code.

But what really bothers me is that the first public version of
remote-hg happened after many many tries and commits, different
designs were discarded based on bad performance, feasibility, or
complexity, and gitifyhg just copies this code and runs with it.

Take a look at this function, which I took a long time to develop,
clean, and improve so it performs as efficiently as possible through
arduous profiling in huge repositories:

    def get_filechanges(self, context, parent):
        modified = set()
        added = set()
        removed = set()

        current = context.manifest()
        previous = self.repo[parent].manifest().copy()

        for fn in current:
            if fn in previous:
                if (current.flags(fn) != previous.flags(fn) or
current[fn] != previous[fn]):
                    modified.add(fn)
                del previous[fn]
            else:
                added.add(fn)
        removed |= set(previous.keys())

        return added | modified, removed

Nobody from gitifyhg even bothered to try to understand this function,
what it does, or why, just copied it:

http://github.com/buchuki/gitifyhg/commit/a46d518e2b8df5e8339c8caa9fa113642bc7ac3a

In fact, it's co clear the code was simply copied without much
thought, that the parent caller was introduced *before* the actual
function:

http://github.com/buchuki/gitifyhg/commit/54be060e1928b7e750bdf3981c32d5bc88851ed1

To me the strategy was clear: copy code of remote-hg until gitifyhg
works, then fix a few bugs, add a few features, and then claim
gitifyhg is superior, even though remote-hg will clearly fix those
bugs, and add those features soon enough. I don't see why nobody tried
to contact git.git, cooperate, and improve what is clearly the
original code of gitifyhg.

>>> * added many new test cases, sadly still including some xfails. Several of these (both passing and xfailing) also apply to remote-hg (i.e. the issue is also present in contrib's remote-hg)
>>
>> I ran these test-cases with remote-hg, and the same test-cases pass. I
>> only had to do minor modifications, most of the failures came from
>> subtle differences such as different strategies to sanitize authors,
>> and which branch to pick for HEAD.
>
> Yeah, that's because what I wrote was based on the situation before your recent patch series. Glad to see that git/contrib's remote-hg is improving!

No, that's not true, this test run is from v1.8.2 without the latest
fix patches, simply the compatibility ones:

========================================================================
test session starts
========================================================================
platform linux2 -- Python 2.7.3 -- pytest-2.3.4
collected 80 items

test/test_author.py ........F
test/test_clone.py ......xx.........x...x..
test/test_notes.py ..FxF
test/test_pull.py ....x..xx..
test/test_push.py ...FFFFF.FF...x....FFFFFFFFF
test/test_special_cases.py ...

=============================================================================
FAILURES ==============================================================================
/home/felipec/tmp/gitifyhg/test/helpers.py:118: assert 'totally
<bad...e used in hg>' == 'totally <unknown>'
/usr/lib/python2.7/site-packages/sh.py:309: ErrorReturnCode_128:
/home/felipec/tmp/gitifyhg/test/test_notes.py:107: assert not 'error'
in 'From hg::file:///tmp/pytest-0/test_simple_push_updates_notes_after_contentful_pull0/hg_base\n
  66d7a5d..a8745f0  mas...rror: refs/notes/hg does not point to a
valid object!\nerror: refs/notes/hg-origin does not point to a valid
object!\n'
/home/felipec/tmp/gitifyhg/test/test_push.py:77: assert -1 > 0
/home/felipec/tmp/gitifyhg/test/test_push.py:86: assert -1 > 0
/home/felipec/tmp/gitifyhg/test/test_push.py:97: assert -1 > 0
/home/felipec/tmp/gitifyhg/test/test_push.py:117: assert 'default' ==
'branch_one'
/home/felipec/tmp/gitifyhg/test/test_push.py:136: assert 'default' ==
'branch one'
/home/felipec/tmp/gitifyhg/test/test_push.py:168: assert 'default' ==
'branch_one'
/home/felipec/tmp/gitifyhg/test/test_push.py:181: assert -1 > 0
/home/felipec/tmp/gitifyhg/test/test_push.py:334: assert 'anewbranch'
in 'no bookmarks set\n'
/home/felipec/tmp/gitifyhg/test/test_push.py:346: assert
'this_is_a_tag' in 'tip
0:1b3b36fc0158\n'
/home/felipec/tmp/gitifyhg/test/test_push.py:358: assert
'this_is_a_tag' in 'tip
1:7ca4e066c47f\n'
/home/felipec/tmp/gitifyhg/test/test_push.py:376: assert
'this_is_a_tag' in 'tip
2:5b8c7a98dfa4\nan_old_tag                         0:af90a856304c\n'
/home/felipec/tmp/gitifyhg/test/test_push.py:391: assert
'this_is_a_tag' in 'tip
0:3c2288c2c93b\n'
/home/felipec/tmp/gitifyhg/test/test_push.py:407: assert
'this_is_a_tag' in 'tip
1:090867df4300\n'
/home/felipec/tmp/gitifyhg/test/test_push.py:420: assert 'this is a
tag' in 'tip                                0:b7c5bfb3bdbc\n'
/home/felipec/tmp/gitifyhg/test/test_push.py:432: assert
'this_is_a_tag' in 'tip
1:10504139dfc4\nan_old_tag                         0:b7c5bfb3bdbc\n'
/usr/lib/python2.7/site-packages/sh.py:309: ErrorReturnCode_128:
========================================================= 19 failed,
52 passed, 9 xfailed in 74.35 seconds
==========================================================

The only real bugs is that tags are not pushed, and named branches are
wrong, the rest are differences in how errors are reported. I doubt
whomever ran these tests spent much time analyzing the results.
Certainly there's no way to think that remote-hg was completely broken
and couldn't be fixed to pass these.

>>> * improved handling of hg user names (remote-hg is not able to deal with some pathological cases, failing to import commits). Sadly, mercurial allows arbitrary strings as usernames, git doesn't...
>>
>> I wouldn't call it improved. In some cases the remote-hg result is
>> better, in others gitifyhg is,
>
> I'd love to learn about cases where remote-hg's result is better in your opinion, so that I can see if the mapping in gitifyhg could be improved for those cases.

For example "no email quoting email@example.com" results in "no email
quoting <email@example.com>", but I already have the code that does
that in remote-hg.

> That said, this part is really quite subjective I guess. In the end, since Mercurial names can be *anything*, one can never get a "perfect" mapping. Luckily, for most real repositories out there, user names will be quite sane and remote-hg and gitifyhg will produce identical results. (Although some hg repos out there have some really weird stuff going on. Yuck.)

Indeed, which is why I advocate for an author mapping solution, so if
the user is not happy, they can manually fix the wrong authors.
Moreover, the author sanitizing should be done by 'git fast-import',
so that people don't have to implement and re-implement the same
sanitizing code all the time. Also, the mapping should be part of 'git
fast-import' so it works the same for all solutions.

>>> * failed pushes to hg are cleanly rolled back (using mq.strip() from the mq extension), instead of resulting in inconsistent internal state. This is quite important in real life, and has bitten me several times with remote-hg (and was the initial reason why I switched to gitifyhg). A typical way to reproduce this is to push to a remote repository that has commits not yet in my local clone.
>>
>> This is not an issue in remote-hg any more since now we force the
>> push. It's not nice, but there's no other way to push multiple
>> bookmarks (aka git branches) to the same branch (aka commit label).
>
> Uhh, what? The push is forced? That sounds to me like a much, much bigger issue with remote-hg than anything else ever was, from my point of view. That seems tobe akin to making "--force" default to "git push", and I don't think anybody here would consider that a good idea.

It's absolutely nothing like that; with 'git push --force' you
**loose** commits, with 'hg push --force' you don't, you simply have
another head. It's mercurial's fault that multiple bookmarks cannot be
pushed any other way.

>> I doubt these inconsistent states can happen any more, but if they do,
>
> Seriously? This is triggered quite frequently in real life. And it will very likely cause somebody to mess up a hg repository they work on. As long is this in, using remote-hg is a total no-go for me. Just consider the following scenario:
> * user A clones a hg repository into a git repository
> * user A commits some commits in the git clone
> * meanwhile, user B pushes changes to the hg repository
> * user A tries to push his changes to the hg remote
>
> The last step causes this result in gitifyhg (similar to what one gets when the remote is a git repos):
>
> With remote-hg, you just force push the change, creating a new head in the remote repo. So, yeah, failed pushes which mess up the internal state don't happen anymore. But I rather have those than potentially mess up the upstream repository like that.

Unfortunately that's per mercurial design; you can't have git-like
branches any other way.

>> the plan in remote-hg is to simply ignore those revisions, and only
>> push the ones that have git refs. I have the code for that, but I'll
>> not be pushing it to git.git for the time being.
>
> I am not quite sure what you mean here, but I'll just wait for your code and hope it'll explain itself.

Even if you end with a dangling head because of a failed push, you can
do 'hg push -r good_head', and the bad head will be ignored.

>>> * git notes are used to associate to each git commit the sha1 of the corresponding hg commit, to help users figure out that mapping
>>
>> This is a minor feature. I've had the code for this for quite some
>> time, but for the moment I think there are higher priorities.
>
> Well, I guess it depends on how you use this. In my daily work with hg repositories, that's a quite important feature.

It's more important to fix clone, fetch and push failures.

> Actually, I wonder: Are you actually using remote-hg yourself for day-to-day development? Or for any other regular activities? You seem to have quite different usage patterns from me and other people involved with gitifyhg.

No, I don't, but plenty of people use hg-git, and I'd say remote-hg is
superior, because it does the same as hg-git, and more.

>>> * internally, the marks are using the hg sha1s instead of the hg rev ids. The latter are not necessarily invariant, and using the sha1s makes it much easier to recover from semi-broken states.
>>
>> I doubt this makes any difference (except for more wasted space).
>
> I disagree. Especially since remote-hg does treat local hg repositories differently than remote ones, by not cloning them but rather working with them directly. As soon as somebody uses "hg strip" or "hg graft", etc. on that, your mark files will contain incorrect data.

That might be correct, but doing so on a public repository is not a
good idea, it causes problems even in git.

When I'm done with other tasks I will do some tests to see for sure
what are the real issues, what is merely hypothetical, and what is
likely. For the moment worrying a workflow that is actually a bad
practice is not sensible.

> With a  remote hg repository, that is of course not as much of an issue, since you have a local hg clone stored inside of .git/. In theory, the user would never touch that, so nothing in there changes. In reality, though, sometimes the user still has to dig in there and modify things (e.g. to undo a "bad" push; although of course for now you "fixed" that particular problem by force pushing). Of course in an ideal world, a user never should have to do that, but as long as there are bugs, users may have to. And based on painful experience, it is *much* easier to do that when the marks use the invariant hashes instead of the transient rev ids.

How do you end up with a bad push in remote-hg?

> As for the wasted space: For a repository with 999,999 commits, the size of the "marks-hg file should increase from about 1.5 MB to about 5 MB. To use your words: Hardly worth mentioning.

It is a parenthesis (it was hardly mentioned).

>>> * Better handling of various hg errors, see e.g. [2]. More work is still needed there with both tools, though [3].
>>
>> This is literally a three lines fix, and it simply makes one error
>> nicer. Hardly worth mentioning.
>
> Perhaps not for you, but for users who just want to use remote-hg resp. gitifyhg, getting a helpful error message instead of seeing an (to them) unreadable stack trace is quite important. I guess this just shows that we have quite different goals and ideas about how to interact with users of our respective tools :-).

I have a suspicion that gitifyhg converts dates wrong, how is getting
a helpful error message on something the user would rarely (if ever)
do, more important than that (something the user always does)? We
might have different priorities, but I think mine are correct.

And don't speak about the "goals", because as I said I already have
the fix, saying we have different goals is implying that I don't want
to fix this issue, as if somehow not fixing a trivial error message
would not allow me to achieve my "goals". The priorities might be
different, but the goals are the same, and I think remote-hg is much
closer.

Also, anybody can send patches to the git mailing list, so _my_ goals,
and _my_ priorities shouldn't matter much.

>>> * The gitifyhg test suite is run after each push on Travis CI against several git / mercurial combinations [4].
>>> In particular, unlike all other remote-hg implementations I know, we explicitly promise (and test) compatibility with a specific range of Mercurial versions (not just the one the dev happens to have installed right now). This has been a frequent issue for me with the msysgit remote-hg
>>
>> I've personally checked against multiple versions of Mercurial. It's
>> possible that some error might slip by, but it would get quickly
>> noticed.
>
> Really? This sounds close to some people who say things like "I don't need a test suite, I personally run some tests every now and then on my machine."

Do you see any compatibility issues reported in the git mailing list,
or my github[1]? No? KTHXBYE. There _were_ compatibility issues, and
those got reported, and fixed, not any more.

Also, having CI testing doesn't ensure a project has better code, it's
the actual code that matters, and so far you haven't proved why
remote-hg's code would be inherently inferior. Moreover, gitifyhg
doesn't seem to have bidirectionality tests, remote-hg does, and
gitifyhg basically fails all of them, not to mention the ones that
compare the output with hg-git's, which has had far many more years of
development and testing, and their extensive tests have been harnessed
by remote-hg.

> Furthermore, you don't seem to document what versions of Mercurial are supposed to work / not work. (Indeed, as far as I can tell, remote-hg has no documentation whatsoever, another difference. Granted, the gitifyhg README is not particular great at this point, but at least it exists and tells people how to get started and where to get help).

When a user has a problem with that, we can deal with it. It's not
hard to do, and in fact it was done only one month ago in gitifyhg.
Nothing inherently different.

> In contrast, the gitifyhg README clearly states that it "requires at least Mercurial 1.9". And its setup.py refuses to install it if the Mercurial version is too old. Again, for us devs that's not very important, but for users, I think it is. In recent months, I had to provide assistance with using hg to tons of people (*sigh*), and old Mercurial versions came up in a considerable portion of those (perhaps 30-40% or so).

remote-hg certainly works on versions older than 1.9, again, I find it
annoying that you claim to know what is important for users, as if
somehow knowing that gitifyhg doesn't work with the user's version of
mercurial (e.g. 1.8) is better than remote-hg's situation; where it
*actually works*, but it's not mentioned. Yeah, mentioning that it
doesn't work is better than working, right.

>>> * Renaming a gitifyhg remote just works [5]. Doing that with remote-hg triggers a re-clone of the remote repository (if it works at all, I don't remember).
>>
>> Yeah, now you can change the alias of the remote, but you can't change
>> the remote url.
>
> That's simply wrong. You still can change the remote URL, it will just lead to the creation of a fresh separate local clone.

Exactly the same will happen with remote-hg when you change the alias.
Either creating a new local clone is "working", or it's not, you can't
have your cake and eat it at the same time. remote-hg reclones on
alias change, gitifyhg reclones on URL change. There is no advantage
here.

> In contrast, with remote-hg, renaming the remote will create a fresh local clone, while changing the remote URL will *not* do that -- instead, the changes from the new remote will be pulled into the existing local clone. Which in some cases may be exactly what you want (e.g. if a repository just moved to a different remote URL). But in other cases, it won't be, namely when the repository at the new URL contains different content. This is not that unlikely when you consider that it comment Mercurial workflow to use separate repositories for different branches.

It doesn't matter. The "extra content" that you get from the different
URL will just create that; extra content, both in the local git, and
mercurial repos. Since remote-hg will selectively push specific
revisions, that extra content will simply remain there, ignored.

>> This is not really an advantage, simply an almost
>> imperceptible different choice.
>
> These are indeed different design choices, but at least to me, they are very much perceptible :-). And we made this design choice quite consciously, after looking at how it is done in remote-hg, and not liking that.

This is not design, a few lines of code would change the behavior. And
you still haven't shown a single *important* use case where a user
would decide, you know what, yeah, I'll use gitifyhg because of that;
"I rename remote aliases a lot", "My upstream repo gets constantly
rebased" are very, very, unlikely phrases any user will ever utter.

And ultimately it doesn't matter, because if it's somehow decided that
one way is better than the other, we can switch it rather easily
(because they are not design decisions). So again, no, there's nothing
inherently superior here, merely subtle different behavior.

> Anyway: At least in my day-to-day operations, I occasionally rename a remote (very rare, but it happens). So far I never had to change a remote URL. Of course that is just me, perhaps others occasionally (well, more of than me :-) have to change remote URLs. But as I said, that's still possible in gitifyhg.

And I've changed the remote URL plenty of times, and again, changing
the alias works just fine as well.

>> I still don't see any good reason why a user might prefer gitifyhg,
>
> Well, for me it is exactly the other way around :-). That said, gitifyhg certainly also still has issues and problems, but I am confident it will even better in the coming weeks. And it certainly wouldn't be were it is now without your great work on remote-hg, and also on related improvements you got into git.git. Kudos!

You know what would be a proper way to thank? Mention where most of
the code and design came from in the README, and _at least_ mention
why you decided to work on your own rather than cooperate. When I
announced the work on remote-hg I discussed with the authors of other
solutions to try to explain why this work was needed until I
demonstrated that this was indeed superior, and I didn't even borrowed
code. I also provided a public summary when I announced it in my
blog[2].

>> even more importantly, why gitifyhg developers don't contribute to
>> remote-hg.
>
> I can only speak for myself, as a (minor) contributor to both remote-hg and gitifyhg. But here are my reasons why I prefer contributing to remote-hg over gitifyhg:
>
> 1) Apparent difference between your goals and mine / those of gitifyhg. I think this is quite visible if one looks at our exchange above. Features that are quite important to me, even crucial, are unimportant for you, or even outright rejected. In contrast, so far with the couple people working on gitifyhg we always managed to arrive at solutions that satisfy all of us. I.e. it seems our ideas and goals are much better aligned within that group.

Again, my goals are irrelevant, if you present a good case for a
patch, it will be merged by the maintainer, Junio, I'm not the
maintainer. But be prepared for argumentation from me, and others.

And no, I haven't rejected any patch, I couldn't reject a patch sent
to the git mailing list even if I wanted. I have only argued against
proposals, and if you give up when somebody argues against your ideas,
perhaps they were not so good in the first place.

But most of the "features" that you mentioned I said I ALREADY HAVE
THE PATCH FOR IT. So don't say we have different goals.

> 2) Lack of reactions on pull requests and bug reports on your github pages. Perhaps you never intended this to be used for pull requests / bug reports, but I never (until recently) saw you state that, nor can one read such a statement on your github pages.

I was not working on remote-hg. But it doesn't matter, git's
development happens in the git mailing list, and anybody can send
patches.

> 3) Not shipping gitifyhg as part of git/contrib but rather as a separate package is important to me, too. It means that we can make new releases whenever we want, not tied to git. Users can install it easily via "pip", and I also think it gets a lot more visibility this way.

% wget http://raw.github.com/felipec/git/fc/remote/hg/contrib/remote-helpers/git-remote-hg
-O ~/bin/git-remote-hg

There, you now have the latest and greatest version of remote-hg, you
don't need to wait for git.git to make a release. In fact, I'm in
contact with a few people that are having issues that are running
precisely this version; the latest and greatest.

>> Also, unlike remote-hg, which basically passes all the tests of
>> gitifyhg, gitifyhg barely passes any tests of remote-hg (three).
>
> Heh, bad, but OK (as I said, my message was based on an older version of remote-hg, and actually also on an older gitifyhg). Thank you for the report, I'll look into it as soon as I can (or somebody else might).
>
> BTW, I just pulled you hg-next branch, and run "make test" in that. The tests in test-hg-hg-git.sh actually all failed (with remote-hg). Do I need to do something special for those to work?

No, they should just work. Perhaps you have an old version of hg-git
(I have v0.4). You can check the errors with
GIT_TEST_OPTS="--verbose".

Cheers.

[1] https://github.com/felipec/git/issues
[2] http://felipec.wordpress.com/2012/11/13/git-remote-hg-bzr-2/

-- 
Felipe Contreras
