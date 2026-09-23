Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D6372B2F
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164553; cv=none; b=GM1t+sI1lKP77NBVP6QhnPN1I4rER53DgbC2vtA/ENeDV3wJYGgqsfXBlmCGTTys57pkE+NCD9O4UA56+AqYij4LOeIQ80NSH+dRM/buP6qXgkYFN0X6sSwWnciVKoSREUkZxKm9pSN3WQcZXYdv28E4vRnqVEHJBQxiG024dyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164553; c=relaxed/simple;
	bh=6tHBqkK4dZMfjCKVCcTNpxhlT3hIi9kmpkVWYVISVW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pObA0AtnTfCkGXjyVgdxGMtlPFDWqu/uOew0z7ZP72fbRmpqB5nnc4CNA7O1D5MbeWX9EgbidZUGFkWE0aCqInptPUrIKxQ0gPf8MLER5UG2Ek7DCYubyueiFXNbGJU/APe/NQ+g5AJAbzqmaEZ+XwgzjBd609MeIkI+F/sNJy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlMguSUw; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlMguSUw"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a98505364aso1372804a12.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790164535; x=1790769335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/CavyVRz2vy/DJMgmFgvWVjnoUzpikyKn2Xv+IxXGk=;
        b=LlMguSUwZuz9ysBUBnopPPVoCCn3hfnVx3IsNCoqXMGIi63tH7YWvxV0Qs4an8Lq+G
         uxwMhHTAYwdCEYK+r7hSzo2SDoAOK2mWIYl3FMcl5Cwb3IVeK6Kr0frSxrdYyoAeDgSS
         tWpKFE+E/oOWIqVLlh7CMVjNw+BHLn4MHuX816qL6cgpwn2jIeC8CNdauXWU4VWLwwCi
         82oN+tdxsEA7kv6XKg9vGvV6Wc53glz2JyUqTtgV1RHFFb++prsbNsiqkvciM9iGy6+1
         53lH23RdroqAtZHl8JcEknMOv11ttfy16m71BlVtMLOEMAdZE9qx84Vp4Aa8CzlTXfDe
         tMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790164535; x=1790769335;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T/CavyVRz2vy/DJMgmFgvWVjnoUzpikyKn2Xv+IxXGk=;
        b=04gdnsYdJqagZLQ9Q9w/0yyfLxvOqII35KFIJ9t3ML4JZ+jzEz/eNs6VBSt+8d6dRD
         dSnHb3wojAfGWZ5XX1ZK8fIAd+aqH8hDOthd/YiHUmTEv73SP2Yt82ANDui1PpDNZXnv
         Z4LzFhPEaYI89T+5C3fM78OmlxXhrPcI0wohg8R33Dz5TPiGi9qKNkTkODxCVFa3YJWn
         RTJqiF55E3+RJCybTLcKlWiKIvc+7682tj8YaV0JJh50eJwRKAozR7dF1n382YDZ+Ihc
         PLZbE4SO8BPd+Bd+Vz8pPjFA2pVWUMUNDVV4FBe0qyG8azYyXdrEuafZTHyAVlQvb2qb
         qzVg==
X-Gm-Message-State: AFuF++mlngdRHYJNQqp3Vb93X3bYkFJibg0OO7sSa6psu1h2VOykXsfc
	Y1yS5KUyb/Cx9hh3TUocxn8kYvzmgmk2lfVnm1dmH9H35/mJmnlFiVm5
X-Gm-Gg: AYBFou226x9EWDlsfFwFO4ZzvF325vGB+r5fpM4JoK7+b8OIJMd5MJjqqOq0voSDzFj
	xD310+pk2+OW/z7jXjfhvYiwTs5yD9605uTxy50oU4eNDN6D/4EdDWDhg+V1YhyrTALgqN93rcx
	wDHhYma8C9S+XC3fTnP8Itc5IhbFwdMfNauREaADm004KUsm3z6IeX9lGfx5v8veWGMyqmcAn1I
	TbJdGc6QtD2MMEsEVaJoYj7JOLwtOcC7XKn1L30PLT3nndA5Epz4V1VmHzykSkbnPpHF8Ppxw5s
	Fg3pOsDHX745uF507U0nCkSHUMwklKYhmb36N53YWUNEddqFujIsU3nWiOpq2njzcxh5IXL4+Lz
	eXDl0Hn1E5UNR6LIORHxZIuHLaUU/rkJCwJGeqOZA0YiXsLgHdm8CjHavJJirjAmg38Y2wMxSnS
	z36FLv0ZZ2jSxfd8hn46zPItDNY40c0pRisXt3Y7I4UR3emnvOOCOYyFG6fs1jTt/87X19N4VqQ
	bUlti6FENHc+5lDPGhK7NtHK2UN37RWedfkoVMwYmvK4z73VRsd1dcO/pONNtzeOvRtbAbg6Hfg
	Slwex8dKAeRadUj/04dAypINhBS8zlAiltb0mD0U7JFwu/uPTsrC+e0RW3kUkaZVURH+Ed19B5A
	dK2UlAcrtzAZo+j5i4C/2eqv1UIbHOQTVzm/j+u6Wes3yOQtpqO0hKfDedo02LAjOQAslrR0nyL
	By6Y7XJ5HU/CtfJOZN
X-Received: by 2002:a05:6402:52d7:b0:6a9:232b:ec64 with SMTP id 4fb4d7f45d1cf-6aab3af68c6mr1834324a12.3.1790164534410;
        Wed, 23 Sep 2026 04:55:34 -0700 (PDT)
Received: from ?IPV6:2a02:c7c:ec1b:7400:e5e5:fada:814c:b693? ([2a02:c7c:ec1b:7400:e5e5:fada:814c:b693])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab38a9756sm1652820a12.25.2026.09.23.04.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 04:55:32 -0700 (PDT)
Message-ID: <c12b9da1-b679-43e5-9485-2cedeb1dc613@gmail.com>
Date: Wed, 23 Sep 2026 12:55:32 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: My summary of the Git Contributors' Summit 2026, was Re: Git v3.0
 timeline, was Re: What's cooking in git.git (Sep 2026, #08)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqwlsei1pv.fsf@gitster.g>
 <76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de> <xmqq4ifhgzvx.fsf@gitster.g>
 <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
Content-Language: en-US
From: Daniele Sassoli <danielesassoli@gmail.com>
In-Reply-To: <5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johannes,

Thanks so much for this summary, I didn't participate at the contributor 
summit
as I was leading one of the breakout sessions in the morning and had a 
plane to
catch in the afternoon, so I'm very grateful of your summary.

On 22/09/2026 19:44, Johannes Schindelin wrote:
> Hi Junio,
>
> On Tue, 22 Sep 2026, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> On Mon, 21 Sep 2026, Junio C Hamano wrote:
>>>
>>>> Git 2.56-rc1 has been tagged.  We may merge last-minute fixes before
>>>> the final Git 2.56 release, but otherwise I do not expect any new
>>>> feature topics to be ready before the final, so most of the
>>>> in-flight topics will stay cooking in 'next' until then.  As
>>>> discussed at the Git Contributors' Summit, the version after the
>>>> upcoming Git 2.56 will be Git 2.98, scheduled near the end of this
>>>> year.
>>> Would you say that the following is an accurate characterization of the
>>> timeline, so that people who need to plan dependent projects can rely on
>>> it?
>> My outline was deliberately limited up to end of this year as I am
>> hesitant to say beyond that point before the meeting notes are made
>> public.
> I originally wrote this summary of the Git Contributor Summit only for my
> own records, but since you hinted at wanting some meeting notes, figured
> it might be interesting to other people, too. So here goes my distillation
> of the breakout-sessions from this year's Contributors' Summit. Many of
> these ideas still need discussion on the list; proposals below are not
> project-wide decisions.
>
> Security mailing list and process
>
> The security list is seeing a large influx of outside reports, apparently
> often AI-assisted or generated. Duplicates and reports outside Git's
> security model consume triage time, while some patches have waited for
> months. Waiting for an empty queue is not a workable release criterion: we
> need to release the fixes we have, rather than hold them indefinitely
> while more reports arrive. No fixed release cadence or guaranteed response
> time was settled.
>
> Documenting Git's security model would save repeated explanations of what
> does and does not constitute a vulnerability. (Personal note, not
> discussed at the Summit: Stolee had tried to start a conversation about
> Git's security boundary a long time ago, but nobody replied. Maybe the AI
> onslaught will provide enough motivation to get that discussion going.)
> Moving non-security bugs to the public list more readily was also
> encouraged. A timeout after which public discussion would be presumed OK
> was proposed, but not agreed.
>
> More company staffing would help, without turning this into an obligation
> for volunteers. Paying for dedicated help was discussed, with onboarding
> costs a concern. Using AI for triage or fixes raises confidentiality and
> DCO questions of its own. (Personal note: There seemed to be some
> sentiment in the room that contradicted the earlier agreed-on finding on
> the mailing list that using AI for triaging and for investigating wasn't a
> copyright concern and should therefore be considered permissible.)
>
> The release bottleneck is not really tag automation. Merging and
> backporting fixes, preparing advisories, and handling CVEs take work, and
> too much of that knowledge lives in people's heads. Peff volunteered to
> start a public discussion of the process and dig up existing resources.
> (Personal note: I have done that merging, backporting, etc plenty of
> times, and I don't think that it is the bottleneck, and I was rather
> surprised to hear that it is complicated. Sure, there are the expected
> merge conflicts when merging `maint-*` branches, and running -- and
> fixing! -- CI on all of the tags in a private repository should go without
> saying, but that's all craft of the trade. Rather, the indecision and lack
> of engagement on the git-security mailing list is what I see as the
> blocker. I'd happily volunteer to juggle those branch thickets if that was
> truly the make-or-break issue here.)
>
> Microsoft's release process reportedly needs about seven weeks. There were
> no objections in the room to proceeding without waiting for that schedule.
> (Personal note: That release process was misrepresented, which is
> surprising, as I coordinated two or three Git for Windows security bugfix
> releases _on the git-security list_ since the most recent Git security
> bugfix release, it's always the same thing: release on a second Tuesday of
> the month, three weeks before that the patches need to have settled,
> everybody goes home with a dependable timeline. It's not really that big
> of a deal. Testing patches, constructive feedback, these are the things
> that are missing and therefore blocking the process. I sensed a lot of
> finger-pointing in this discussion. I mean, I don't blame anybody for
> avoiding security work: it is stressful and intense. The responsibility
> for getting things wrong is enormous. I know that because I've done my
> share of that, probably more than most in the Git project, and I will do
> even more in the future. But when I don't have the time, or the energy, I
> am aware that I, myself, am the bottleneck; I don't need to blame others.)
>
> Git v3.0
>
> The proposed target is spring 2027: v2.56 in September 2026, v2.98 in
> December, then v2.99 and v3.0 next spring. The jump in version numbers is
> intended to signal the approaching breaking changes. March and April were
> both mentioned; the precise timing is not settled.
>
> There was agreement on releasing v2.99.1 and v3.0 together, differing only
> in the BREAKING_CHANGES (v3.0 switches them on). That keeps the transition
> separate from another round of feature development. Nobody in the room
> objected to Rust becoming mandatory in v3.0. (Personal note: probably
> because Randall wasn't there, to say that NonStop support would be a
> blocker and that Git please wait.) A v2.x LTS remains an open question,
> with Gentoo mentioned as an interested party. (Personal note: I am still
> advocating for an in-tree Long Term Support branch, and since Junio
> indicated that he's less than eager to take care of that, I would love for
> Patrick Steinhardt to be the "LTS lieutenant", I vaguely remember that he
> said he'd do it if asked, and I trust his judgement, so I'd ask.)
>
> SHA-256 support across the ecosystem had been a blocker. GitHub reported
> experimental support, with general availability expected around November.
> GitLab already had public, non-experimental support, and libgit2 supports
> it, too. JGit remains a gap; Google was not planning to fund that work.
>
> The SHA-1/SHA-256 interoperability work, including historical tags, was
> reported to be implemented but not yet sent to the list. (Personal note: I
> think that the room seriously "mis-underestimated" the real-world impact
> of this. The code is not even on the Git mailing list, and the
> ramifications of not having a robust plan how to deal with partial clones
> or submodules or even signed tags strikes me as a dealbreaker. I would not
> be surprised if the decision to enforce SHA-256 as default would have to
> be revisited before v3.0, and possibly overturned.)
>
> Documentation
>
> Julia's work highlights the gap between documentation written by people
> who know Git inside out and users who do not yet know what objects, the
> index, or upstream mean. We need approachable learning material as well as
> reference documentation. Both need work; keeping manpages concise does not
> mean they cannot have better explanations and examples. (Personal note: I
> am beyond excited that Julia, whose work I have always admired, got
> interested in improving Git's documentation, which is in dear need of
> being improved, mainly because it does not cater to the majority of Git
> users out there who are unlikely to wander onto the Git mailing list,
> ever. I just hope that old-timers who really do not need the documentation
> nor understand the need of those who do need it show enough appreciation
> for the fresh views and for Julia's understanding of the target audience.)
>
> Discoverability matters, too. The website (https://git-scm.com/) needs
> clearer entry points for learning Git, and existing guides are harder to
> find than manpages. Missing subsection links are another improvement we
> could make incrementally. (Personal note: Judging by the history of that
> site, I do wonder whether the core Git contributors are interested in
> helping this effort at all. For example, there are a growing number of PRs
> suggesting to add new UIs to the growing list, but I gave up reviewing
> them because I was the only one doing so.)
>
> There was support for replacing outdated material and for merging useful
> improvements, then iterating, rather than trying to perfect everything
> before it lands. Bringing user feedback to the list without flooding it
> remains a challenge.
>
> The current funding covers only 100 hours split between two people.
> Additional project and company funding was encouraged; brian, Emily, and
> Mark offered to explore company support. (Personal note: I had tried, back
> when GitHub still funded my team, to start something like that, without
> any success. To the contrary, even Git for Windows and Git Credential
> Manager got defunded.)
>
> On the tooling side, using only Asciidoctor instead of maintaining both
> AsciiDoc and Asciidoctor support was proposed as a possible Git v3.0
> change. Distribution support and rendering differences need checking, with
> doc-diff suggested for comparing the outputs. Patrick filed an issue
> during the discussion. (Personal note: AFAIU the AsciiDoc spec is now
> maintained by Asciidoctor, and I am aware already of one change that was
> made to the spec without adapting AsciiDoc accordingly. So the entire
> discussion might be quite moot already.)
>
> Other ideas included richer diagrams for HTML while retaining text
> versions for manpages, and privacy-respecting traffic measurements to help
> prioritize documentation work. No diagram format was chosen, and caching
> and AI scraping complicate getting useful traffic data. Mermaid was
> proposed, and even GraphViz. (Personal note: I added support for Mermaid
> diagrams to https://git-scm.com/, but it turned out to be too limited, so
> I added GraphViz support. The support code for this is a bit of a beast,
> having a wasm version of GraphViz for development, pre-rendering the
> diagrams as SVG and as PDF during deployment of the site; it was quite a
> bit of fun to implement all that.)
>
> Outreachy sponsoring
>
> The goal is to support three interns in the round starting in early
> December, at $10,000 each. The corporate sponsorship previously provided
> by GitLab and GitHub has dried up, leaving Git itself to pay. There are
> company contacts to follow up with; Emily offered to ask Google's OSPO,
> without high expectations. No new sponsorship commitments were made.
> (Personal note: I don't think that these internships provide enough
> publicity to give companies much of an incentive to fund this. Which I
> find a bit of a shame, Outreachy in particular does a lot of important,
> good work, and if I wasn't so constantly overworked, I would want to
> mentor again; I always found it rewarding, even if I hold myself to a
> quite high bar which is quite draining.)
>
> A related point for Git Merge 2027: announcing the location early would
> help Outreachy and GSoC interns plan attendance. No location was selected.
>
> Pluggable object database
>
> Patrick's pluggable object database is working, but it is not complete:
> commit-graph and multi-pack-index integration are still outstanding, and a
> repository extension is planned. (Personal note: It might be interesting
> to see whether implementing a storage backend is easier in core Git or in
> another Git-compatible implementation. JGit should be a natural target,
> having originated within BigTable-sized constraints, i.e. a different
> storage system, but funding seems to have dried up, there's not even
> SHA-256 support, so JGit might not be as hackable as it once was.)
Pluggable backend implementations for JGit have been possible for quite some
time, although, admittedly, I don't think any made it to production. 
Maybe at
the time when this was introduced(16 years ago!!) by Shawn[1] in JGit it 
wasn't
fashionable yet and so the project was never carried forward. I know Luca
submitted a talk for the Gerrit User Summit to present a Cassandra 
back-end, for
which I can see conversation started 10 years ago[2].

Regarding JGit support's for SHA256, I know some corporations have had 
interest
in sponsoring this work and have discussed potentially implementing 
together it
with GerritForge, but, as far as I know, work isn't ongoing yet. JGit is 
still
very much developed and kept up to date with great effort from the 
community, so
I believe it to still be as hackable as it was, there just hasn't been 
enough
interest for SHA-256 yet, which I agree is a shame, hopefully in the 
near future
this gets remediated.

[1] https://github.com/spearce/jgit_cassandra
[2] https://groups.google.com/g/repo-discuss/c/IekVPmow0yE
>
> Content-defined chunking prompted an important distinction between
> changing how objects are stored and changing the logical object model.
> Starting at the storage layer would let us preserve existing blob OIDs
> rather than require ecosystem-wide changes. A new pack/index format could
> provide another representation of the same object, much as deltas do
> today. No particular representation was agreed. (Personal note: It is
> curious to me why nobody tought about inventing a "meta blob", i.e. an
> object much like a tree object, except that it stitches together a larger
> blob. This would allow for the content-defined chunking that `rsync`
> already championed, way before Git was born! It would have allowed a Git
> native large file support worth writing home about, and could have
> replaced Git LFS. Xet (https://huggingface.co/docs/hub/xet/index) would
> not have had to be invented, and it would have allowed game development to
> move to Git. I can only imagine that the time it would cost to get even
> the first patches of this into core Git would be seen as prohibitive by
> any company who may have considered the effort.)
>
> There is also an API question: does a backend seeing only object content
> have enough context to make good storage and delta choices, or should it
> receive richer information? More searchable tree storage and a Git "commit
> cloud" were other possibilities raised, not committed plans. (Personal
> note: At a previous GitMerge, Facebook presented their work, see e.g.
> https://github.com/facebook/sapling/blob/main/eden/mononoke/blobstore/packblob/README.md,
> which includes separating actual storage from transport. That is, already
> at push time, derived metadata is computed in async jobs which provide
> several potential deltas ready-to-go when a client clones or fetches. They
> reported clones with regular Git clients that are twice as fast, just
> because the server doesn't need to spend much compute on the data it
> sends. So there is a lot to be learned out there already.)
>
> AI
>
> The current SubmittingPatches policy is rooted in DCO certification and
> advice from SFC lawyers. The unresolved question is whether, and to what
> extent, contributors can certify AI-generated code. There was substantial
> disagreement about acceptable use, provenance and legal risks, community
> trust, review burden, and whether the current caution excludes useful
> tools. No policy change was agreed. (Personal note: You'd think that the
> opinion of lawyers is taken at face value, but no, it seems that some core
> Git contributors seem to disagree with the lawyers in favor of their own
> opinion...)
>
> Several participants found language and proofreading assistance useful. A
> particular concern was submissions where the human does little more than
> relay agent output, leaving reviewers to deal with the consequences. The
> influx of poor GSoC contributions was one example. Attribution such as
> Assisted-by was suggested to make tool use clearer, but attribution alone
> does not answer the quality or DCO questions. (Personal note: my precedent
> of "Assisted-by" was called out as helpful, and I do think it is. I make a
> difference between AI-generated and AI-assisted. I'm not a fast typer, so
> I benefit a lot from being able to tell an LLM to please refactor out
> these four lines with the appropriate signature. There's not much
> creativity in there. I also like to let AI present me the call graphs for
> certain code locations, because due to the choice of C, which thanks to
> the C preprocessor is not easy to analyze statically, there are no
> competent tools other than LLMs that I can use for the task. I was highly
> surprised, though, to see how much enmity against AI in general was
> voiced, not by many, but many, many times, and how that contrasts with the
> Linux project which I hitherto had not considered to be as particularly
> open to modern practices.)
>
> brian and Taylor agreed to put differing policy proposals on the list. The
> suggested process is to have alternatives examined by SFC counsel, make
> the risks clear, and then consider a vote. Emily volunteered to organize
> the voting procedure. Eligibility and the details remain open; Junio's
> authority as maintainer remains central. (Personal note: Since Taylor
> works for OpenAI now, I was not surprised by his stance, but brian works
> at GitHub, home of GitHub Copilot, and I am not sure how favorable their
> employer would look at their semi-public utterings about AI...)
>
> Protocol v2 for pushes
>
> There are concrete use cases now: repositories with millions of refs,
> including a reported 896 MB ref advertisement. Reftable improves ref
> update throughput, but does not by itself solve the advertisement problem.
> Nobody objected to push protocol v2, and the fetch-v2 infrastructure
> already provides much of the foundation.
>
> The discussion covered advertising fewer refs, letting clients identify
> useful branches, and replacing large advertisements with a few rounds of
> push negotiation. Negotiation results could also help optimize the
> server's connectivity checks. Some improvements might be possible in the
> existing protocol before introducing v2.
>
> We need to measure the tradeoffs rather than assume fewer bytes means
> faster pushes. One example involved a shallow push taking 35 seconds
> instead of two because of work to minimize the transfer. Shallow
> boundaries and unrelated histories complicate the proposed heuristics.
>
> SHA-256 interoperability is another reason to want push v2: the current
> push protocol requires using the server's primary hash algorithm.
> Negotiation could make that more flexible.
>
> Forge replication to thousands of mirrors would benefit from finding out
> cheaply whether refs have changed, rather than downloading full
> advertisements from every target. Checksums, ETag-like values, and
> reftable generation numbers were discussed, with concurrent updates
> complicating the picture.
>
> Compact or compressed advertisements are also worth exploring and
> benchmarking, possibly reusing reftable's format. That does not mean
> sending the server's actual reftable, including hidden refs. There are
> several promising directions here, but no final design yet.
>
> Some breakout sessions were planned, but apparently had to be cut.
>
> Personal notes: I wasn't present for all of the sessions, in the afternoon
> I had other commitments; Therefore these notes (which AI assisted me in
> distilling) came partially from what I dictated and partially from the
> shared Google Document in which a few volunteers gracefully wrote notes. I
> found it challenging to connect as a remote participant. The link to the
> Google Meet, as well as control over the lobby thereof, seems to have been
> restricted to at most a few people, which might have contributed to the
> long waiting time before I was allowed in, and it definitely contributed
> to my comments not reaching the discussion in time to have an impact. I
> would have loved for Junio or the other two brave souls who also
> participated remotedly to have had more "air time". I am still a fan of
> the idea to have more frequent, smaller, virtual Contributor Summits,
> organized by a rotating cast. (Maybe I can get Emily to host the next
> one.) I was very happy that Junio was participating, as he _is_ the
> project lead, and in past Contributor Summits decisions were taken without
> him, which I found odd. Timing was really challenging for him, though, it
> was way past midnight for him. I'm all the more grateful that he
> did participate.
>
> Final remark: This summary is obviously biased. I lightly edited it to
> separate better between my personal views and a hopefully unbiased account
> of what was discussed, and how, and by who. Nevertheless, I am but human.
> As a consequence, I would be delighted if other participants would share
> their summaries, so that my bias can be balanced out.
>
> Ciao,
> Johannes
