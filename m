Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964CA185F
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="IdgNmmA4"
Received: from st43p00im-ztdg10061801.me.com (st43p00im-ztdg10061801.me.com [17.58.63.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856A7DA
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 00:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1697355199;
	bh=XdC85oaUU319l5d4DhcprLpOq4j53XNwoS/a6eliII8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=IdgNmmA48pkFO6wuuMsJLC6cxMPXeaQIAMWaCeCRfweOj4QfxKa2enqulIsUCQcv6
	 Mn380E5N/YThq9VstpYt3+/V7+njUE06PoTBrhl1CcnyaF0IMgD6miKM2aqtw8yxmH
	 4Ims5Ijf4GS0J0Ojm6Bz8Pbi7fEziAN8Wy4ZpCDrYdUM2Z/CwDBdUJlR+9tER9Q1+w
	 q+a0gcXjbMEvhmpaAMMVirKMRhmsMnqw7gZN5unPMW5VnNfYV0VWOY4ZU5U/OICV86
	 jkYIFlqpdx1zNjK9mvD57c4fw+hwJJ8jyXWRAC1OqG+M15vaqpXmk4Zw5liXdQUgLu
	 wUqW2dOsrP6jg==
Received: from [169.254.239.4] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id E8E35600113;
	Sun, 15 Oct 2023 07:33:18 +0000 (UTC)
From: Sebastian Thiel <sebastian.thiel@icloud.com>
To: Elijah Newren <newren@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
Date: Sun, 15 Oct 2023 09:33:17 +0200
X-Mailer: MailMate (1.14r5937)
Message-ID: <B088FC28-BE30-424D-9CDD-7A53EDFC1710@icloud.com>
In-Reply-To: <CABPp-BEg6vxiUpcJAG_=KB_sTrVgCF19JZh-+ZGCTPXdbo9ekg@mail.gmail.com>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
 <xmqqttqytnqb.fsf@gitster.g> <ZSouSI_zPusOefsv@localhost>
 <CABPp-BEg6vxiUpcJAG_=KB_sTrVgCF19JZh-+ZGCTPXdbo9ekg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dYKhzlLXrm76RUsrlD4r46o8JRY8G-KG
X-Proofpoint-GUID: dYKhzlLXrm76RUsrlD4r46o8JRY8G-KG
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.573,18.0.957,17.11.170.22.0000000_definitions?=
 =?UTF-8?Q?=3D2023-05-18=5F15:2023-05-17=5F02,2023-05-18=5F15,2023-02-09?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2310150066
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks so much Elijah for your eye-opening response. Thus far I was both
naive and ignorant about the complexity of the matter, and also never
asked the question as to why it wasn't tackled earlier since it came up
already.

Since so many areas of git are affected by precious files, it seems that
rolling it out with everything working is unrealistic and I wonder if
it even had to be behind a feature toggle at first.

A particularly interesting question brought up here also was the question
of what's more important: untracked files, or precious files? Are they
effectively treated the same, or is there a difference?

In any case, it seems easiest to set the desired syntax for such a
feature and/or validate it, and then devise a plan for how it could all
come together.


On 15 Oct 2023, at 8:44, Elijah Newren wrote:

> Hi,
>
> On Fri, Oct 13, 2023 at 11:00 PM Josh Triplett <josh@joshtriplett.org> wrote:
>>
>> On Tue, Oct 10, 2023 at 10:02:20AM -0700, Junio C Hamano wrote:
>>> Sebastian Thiel <sebastian.thiel@icloud.com> writes:
>>>
>>>> I'd like to propose adding a new standard gitattribute "precious".
>>>
>>> ;-).
>>>
>>> Over the years, I've seen many times scenarios that would have been
>>> helped if we had not just "tracked? ignored? unignored?" but also
>>> the fourth kind [*].  The word "ignored" (or "excluded") has always
>>> meant "not tracked, not to be tracked, and expendable" to Git, and
>>> "ignored but unexpendable" class was missing.  I even used the term
>>> "precious" myself in those discussions.  At the concept level, I
>>> support the effort 100%, but as always, the devil will be in the
>>> details.
>>
>> "I've already wanted this for years" is, honestly, the best response we
>> could *possibly* have hoped for.
>>
>>> Scenarios that people wished for "precious" traditionally have been
>>>
>>>  * You are working on 'master'.  You have in your .gitignore or
>>>    .git/info/exclude a line to ignore path A, and have random
>>>    scribbles in a throw-away file there.  There is another branch
>>>    'seen', where they added some tracked contents at path A/B.  You
>>>    do "git checkout seen" and your file A that is an expendable file,
>>>    because it is listed as ignored in .git/info/exclude, is removed
>>>    to make room for creating A/B.
>>
>> Ouch, I hadn't even thought about the issue of branch-switching
>> overwriting a file like that, but that's another great reason to have
>> "precious". (I've been thinking about "precious" as primarily to protect
>> files like `.config`, where they'd be unlikely to be checked in on any
>> branch because they have an established purpose in the project. Though,
>> of course, people *do* sometimes check in `.config` files in
>> special-purpose branches that aren't meant for upstreaming.)
>
> If we're going to implement precious files, I think we should take a
> step back and figure out what parts of the system are affected.  It's
> way more than branch switching and `git clean`.  Some notes (including
> some useful implementation pointers):
>
> A) You will probably learn a lot and get a leg up on the
> implementation by grepping for "preserve_ignored"; lots of the
> plumbing has already been created related to this.
>
> B) checkout has a --no-overwrite-ignore, which for checkout
> operations, essentially turns all ignored files into precious files.
> B1) The code behind --no-overwrite-ignore will probably be helpful in
> your implementation of precious files
> B2) What happens to this --no-overwrite-ignore option?
> Deprecate/remove it after adding precious files, since precious files
> now serve that purpose?  Keep the flag anyway?  What happens to the
> docs around the flag?
> B3) If we keep --no-overwrite-ignore, do we also need to add a
> --overwrite-precious option to allow those to be similarly tweaked?
>
> C) merge has a --no-overwrite-ignore option, which for supported merge
> operations (which are sadly very few), essentially turns all ignored
> files into precious files.
> C1) Same comments as A1-A3 but for merges
> C2) Sadly, merge's --no-overwrite-ignore is almost garbage.
> builtin/merge.c will only pass this option to the "fast-forward" merge
> backend, causing any other type of merge to overwrite ignored files
> despite any such flag.
> C3) most merge backends don't have logic to handle
> --no-overwrite-ignore even if they were passed it, and would need
> explicit support added.
> C4) merge-ort would only essentially need a one-liner; it basically
> has the code in place and a comment but the flag was never plumbed
> through
> C5) it'd be a herculean effort to support this with merge-recursive,
> and a sisyphean effort to attempt to maintain.  Deprecating and
> removing merge-recursive is probably a better option
> C6) merge-resolve and merge-octopus could probably be handled
> automatically by ensuring `git read-tree` gained support for it.
> C7) there'd be no way to ensure user-written merge algorithms would
> support it, but that's kind of a general problem with user-written
> anythings
>
> D) git ls-files would need to have a way to query for precious files,
> much as it can currently be used to query for ignored files (or
> tracked files, or conflicted file, or skip-worktree files, or...).
> Backward compatibility questions arise about whether precious files
> should appear in `git ls-files -o` output.
>
> E) git status has an --ignored option, with multiple flags for
> controlling it.  We'll likely need more flags to be able to pick out
> precious files.
>
> F) We'd probably need to look through several other commands and look
> at what they need for special handling.  e.g., am, stash, reset.  I
> suspect stash will be a particularly sore point, as its unfortunate
> design of implementing shell in C code and attempting to decompose the
> command in terms of other high-level commands is basically a leaky
> abstraction that is very likely to be susceptible to edge and corner
> cases here.  (In fact, I think I may have left some of the issues for
> untracked/ignored files in stash broken when I was fixing such
> problems for other commands.)
>
> G) Documentation.  Commands like `git reset --hard`, `git checkout
> -f`, and `read-tree --reset` are documented to nuke untracked files
> specifically because we expect most commands to preserve untracked
> files.  These would need to mention that "precious" files are also
> nuked (or, if we don't nuke them, why precious-and-ignored files are
> more precious than untracked files).
>
> H) Design of `reset --hard`.  As per
> https://lore.kernel.org/git/xmqqr1e2ejs9.fsf@gitster.g/, `git reset
> --hard` is a little funny and we have thought about changing it.  Will
> the addition of "precious" objects provide more impetus to do so, and
> should a migration story be part of such a new feature?
>
> I) Although git's stated behavior was to nuke ignored files and
> protect untracked files, just a couple years ago we found _many_ bugs
> where Git didn't do that.  A series was pushed to fix most of those[1]
> (incidentally, the same series the introduced the preserve_ignored
> flag I pointed you to earlier), but it left a few things
> commented/broken.  The cover letter and some emails in the thread also
> discussed in more detail some of the ramifications around a "precious"
> setting.  It may be worth reading to catch other things to cover and
> think about.
>
> J) To implement this feature, you're going to have to touch dir.c.
> Good luck with that.  (Seriously, good luck.  The more people that
> touch it that aren't me, the less I'll be pinged/queried about that
> monstrosity.)
>
>
>>> In any case, the "precious" paths are expected to be small minority
>>> of what people never want to "git add" or "git commit", so coming up
>>> with a special syntax to be used in .gitignore, even if that special
>>> syntax is ugly and cumbersome to type, would be perfectly OK.
>>
>> [Following up both to this and to Sebastian's response.]
>>
>> One potentially important question: should the behavior of old git be to
>> treat precious files as ignored, or as not-ignored? If the syntax were
>> something like
>>
>> $.config
>>
>> then old git would treat the file as not-ignored. If the syntax were
>> something like
>>
>> $precious
>> .config
>>
>> then old git would treat the file as ignored.
>>
>> Seems like it would be obtrusive if `git status` in old git showed the
>> file, and `git add .` in old git added it.
>
> A very good set of questions, along similar lines as the question
> about `git ls-files -o` handling.
>
>
> Anyway, I'm a bit worried after digging up and dumping all these
> concerns on you, that it'll sound like I'm trying to bury the feature
> and discourage folks.  In the past I have been against this at times,
> but mostly because it looked like lots of work, I didn't want to touch
> dir.c anymore, and I was worried we'd add a bunch more edge & corner
> cases to the code (when we already had plenty with our more limited
> number of file types).  In a way, the preserve_ignored stuff kind of
> made this a lot more reasonable for us to switch to.  But I do still
> think it's a fair amount of work, and I am kind of worried about
> potential new edge and corner case.
>
>
> Hope that helps,
> Elijah
