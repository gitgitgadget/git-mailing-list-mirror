From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 13:15:34 +0200
Message-ID: <45375E56.4090106@op5.se>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca> <871wp6e7o9.wl%cworth@cworth.org> <45359B2A.1070102@utoronto.ca> <87y7rdd47j.wl%cworth@cworth.org> <20061019091045.GV75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carl Worth <cworth@cworth.org>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 19 13:15:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaVsE-0002hW-49
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 13:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423290AbWJSLPj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 19 Oct 2006 07:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423291AbWJSLPi
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 07:15:38 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:41622 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1423290AbWJSLPi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 07:15:38 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 8021A6BE9F; Thu, 19 Oct 2006 13:15:36 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.4
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 87A106BE9E; Thu, 19 Oct 2006 13:15:34 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <20061019091045.GV75501@over-yonder.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29339>

Matthew D. Fuller wrote:
> On Wed, Oct 18, 2006 at 08:38:24AM -0700 I heard the voice of
> Carl Worth, and lo! it spake thus:
>> But as you already said, it's often avoided specifically because it
>> destroys locally-created revision numbers.
>=20
> I think this has the causality backward.  It's avoided because it
> changes the ancestry of the branch in question, by rearranging the
> left parents; this ties into Linus' assertion that all parents ought
> to be treated equally, which I'm beginning to think is the base
> lynchpin of this whole dissension.
>=20
>=20
> Without a differentiation of the parents, there's no such creature as
> a "mainline" on a branch, so it's hard to find anything to base revno=
s
> on from the get-go; the whole discussion becomes meaningless and
> incomprehensible then.
>=20
> With the differentiation, numbering along the leftmost 'mainline'


You, and others, keep saying "leftmost". What on earth does left or=20
right have to do with anything? Or rather, how do you determine which=20
side anything at all is on?

> makes sense, and fits the way people tend to work.  "I did this, then
> I did this, then I merged in Joe's stuff, then I did this", and the
> numbering follows along that.  And as long as it's the same branch,
> those revnos will always be the same; I can't go back and add
> something in between my first and second commits.  THAT'S where revno=
s
> are useful; referring to a point on given branch.
>=20

So long as the given branch is, in git-speak, "master"? I think I'm=20
starting to see how this would work, but I still fail to see how you ca=
n=20
then come up with revnos such as 2343.1.14.7.19, since the only ones=20
that seem to actually make any sense are the ones that track the=20
strictly linear development.

In git, this can be accomplished by auto-tagging each update of any=20
branch with a tag named numerically and incrementally, although no-one=20
really bothers with it.

Let's say you have the following graph, where A is the root commit, B=20
introduces the base for a couple of new features that three separate=20
coders start to work on in their own repositories. The feature started=20
on in D is logically coded as a two-stage change. F fixes a bug=20
introduced in D. I is the result of an octopus merge of all three=20
branches, where the three features are implemented and all bugs are=20
fixed (this is btw by far the most common pattern we have in our repos=20
here at work).

   A
   |
   B
  /|\
C |  D
| |  |\
| |  E F
| |  |/
| |  G
| H /
  \|/
   I

Now a couple of questions arise.
- How do I do to get to C, D, E, F, G and H?
- When these get merged, which one will be considered the "left" parent=
,=20
and why?

>=20
>> So there are some aspects of the bzr design that rob from its
>> ability to function as a distributed version control system. It
>> really does bias itself toward centralization, (the so called "star
>> topoloogy" as opposed to something "fully" distributed).
>=20
> That depends on what you mean by 'bias' (and for that matter, what yo=
u
> mean by 'centralization'; I think that's being used in very different
> ways here).  If you don't care about the ancestry changes, you can go
> ahead and change it around by merging and pushing like there's no
> tomorrow, and it'll keep up just fine.  Some attributes of it like th=
e
> revnos which assume you do care about the ancestry simply cease to be
> of any applicability.


How deep will I have to dig to get the immutable revids instead?


>  That doesn't make it a useless feature, any
> more than diff being inapplicable in a branch I'm using to store
> binary files makes diff useless; it's just not one that's meaningful
> in a given case.
>=20

Binary diffs work just fine, thank you very much ;-)

> bzr (the project) does care about the ordering of the parents, so it
> doesn't do that.  bzr (the tool) assumes that the majority of its
> users will care, which is why it has revnos; because in the case wher=
e
> you don't disturb the ancestry of given branches, revnos are very
> useful in reference to that branch.
>=20
>=20
>> So even a project that's very oriented around a single, central tree
>> can get a lot of benefit from being able to share things arbitrarily
>> between any two given repositories.
>=20
> I agree wholeheartedly.  That's one of the reasons I'm using bzr, eve=
n
> though 95% or better of what I do is very oriented around single,
> central trees, after all    8-}
>=20

I'm sure it's supported. The question is whether or not bazaar makes it=
=20
easy for those developers to exchange valuable information (revids,=20
since their revnos will be mixed up) so they can communicate detailed=20
info about "commit X introduced a bug in foo_diddle(). I fixed it in=20
commit Y, so if you merge it we can release". If revids are always=20
printed anyways, I see even less need for revnos. If it's hard to get=20
the revids I wouldn't consider the truly distributed workflow supported=
=20
any more than I consider CVS file rename support =E1 la "just hand-edit=
=20
the ,v-files" to actually work.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
