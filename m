From: "Raimund Berger" <raimund.berger@gmail.com>
Subject: Re: Newbie question regarding 3way merge order.
Date: Fri, 30 Jan 2009 20:09:56 +0100
Message-ID: <87vdrwbofv.fsf@gigli.quasi.internal>
References: <871vulda2r.fsf@gigli.quasi.internal>
	<slrngo6eat.s1d.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 20:12:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSymF-00085F-Oc
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 20:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbZA3TKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 14:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbZA3TKT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 14:10:19 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:52505 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbZA3TKR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 14:10:17 -0500
Received: by fg-out-1718.google.com with SMTP id 16so100942fgg.17
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 11:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:references
         :mail-followup-to:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=9C0EgqGL4NpsGMvbKA79mDN8sV/LQuKcMIP9XHjUiBU=;
        b=r77T9QHlf1JT2fxq99XD8UKFzsrt0gwwfBp6FALFpdpfzn/5oqSf/SbhL/2vNY16nH
         o6Brmj5D/E79eB3ZZ9hTiLXLSRg7Ot//AoqUCc6qARdmr5zF5wQJ2bf+x082NRlwS70N
         7xexwVDHTtUZe2mfaiHWZxJPdueGzQBSNFAms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:references:mail-followup-to:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=JUgYp4/mR9ws5cNokpgmFy7XkJG6W17N0yqcy2//9e8dh9S3DteElQ5FU6eyAumNdK
         EcfY4h8VjGhbFx2rQszsTQ+/s6g7K1mNQNAUay34CVODLyVZc5K1jpZE8ChQQK//gdKK
         f4C47Mo5rfBdO7yh3s16EWFX9ZP+xx4xP9DGM=
Received: by 10.103.241.15 with SMTP id t15mr714599mur.85.1233342615839;
        Fri, 30 Jan 2009 11:10:15 -0800 (PST)
Received: from gigli.quasi.internal (p5DC33F84.dip.t-dialin.net [93.195.63.132])
        by mx.google.com with ESMTPS id b9sm302298mug.56.2009.01.30.11.09.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 11:09:59 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <slrngo6eat.s1d.sitaramc@sitaramc.homelinux.net> (Sitaram
	Chamarty's message of "Fri, 30 Jan 2009 17:31:09 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107865>


Sitaram Chamarty <sitaramc@gmail.com> writes:

> [replying only because no one else did; caveat reader!]
>
> On 2009-01-29, Raimund Berger <raimund.berger@gmail.com> wrote:
>
>> The question is whether a (3way) merge is commutative, purely in terms
>> of content (i.e. disregarding commit history for now). Iow if no matter
>> in which order I merge A and B, i.e. A into B or B into A, I'd be
>> guaranteed to arrive at the same content.
>
> I'd say yes.  Finding the common ancestor and then applying
> the differences from both sides are operations that do not
> appear to be order dependent.

That's exactly the point which I'd like to have clarified.

E.g. with A, B and ancestor C, the merging and conflict resolution
algorithm had to be completely symmetric if diff(A,C)+diff(B,C) applied
to C should always be the same as diff(B,C)+diff(A,C) applied to C.

So I'm really asking if that is a fact upon which I can rely.

>
>> If yes, a followup question would be if the merge machinery sitting
>> beneath rebase is exactly the same as that of a standard merge.
>
> The merge "machinery" can be explicitly chosen using the
> "-s" (strategy) option, but for the same chosen strategy, I
> think yes it would be the same for a merge as for a rebase.

An interesting hint. Up to now, I assumed that rebase would always
perform implicit merging strategies. I mean what else would one expect
in the above picture to happen when rebasing A on B? I'd assume it'd
produce the same tree as a merge of A into B, by employing exactly the
same machinery. E.g. fast forward of C to B, then merge A in. So that,
effectively, the only difference between rebase and merge is just commit
history but not (tree) content.

>From reading the rebase man page though it seems that merging machinery
has to be explicitly requested via '-m'. Which makes me wonder how the
default rebase actually works.

>
>> The reason I ask is obvious I guess. What basically interests me is if I
>> gave a bunch of topic branches exposure on a test branch and, after
>> resolving issues, applied them to stable, that I could be 100% sure to
>> not introduce new issues content wise just by applying merges in a
>> different order or form (rebase, patch set).
>
> That appears to be a different question than the one you
> started with.
>
> Reversing A and B is one thing, applying a sequence of
> merges in a different order is quite something else.

Mathematically speaking, if A1 and A2 commute with regard to a binary
operation, A1 ... An do as well. So I'd still think the latter question
boils down to the commutativity question above *iff* rebase actually
does an implicit merge by default. Which I'm now led to question.

Thanks for you answer, much appreciated.
