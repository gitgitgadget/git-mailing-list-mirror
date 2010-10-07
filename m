From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] git.txt: document limitations on non-typical repos (and hints)
Date: Thu, 7 Oct 2010 09:25:02 +0700
Message-ID: <AANLkTinuT9f8B3b=osCkdxtpZR2zJV9WmmTMAAHb8SZD@mail.gmail.com>
References: <1286283653-22616-1-git-send-email-pclouds@gmail.com>
 <4cac8659.0541730a.0ef0.3ff9@mx.google.com> <7vsk0j46zk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, weigelt@metux.de, spearce@spearce.org,
	jrnieder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	raa.lkml@gmail.com, judge.packham@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 04:25:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3gAq-0005k3-Sx
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 04:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760029Ab0JGCZ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 22:25:26 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46277 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759825Ab0JGCZY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 22:25:24 -0400
Received: by wyb28 with SMTP id 28so217555wyb.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 19:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=65xRY9cM91GB0yDalOLOifSxKWBi33zcscSSYbOKib0=;
        b=wZ/H0w2CpMf9Uhl1yZFrmtI+3B70gMcGNcg7/1fqqoCSBu09MS3YEwRWDDKell05Ig
         sH9YBuSy2JQEZ2q1/1+moyubXJ45g9K1PcayXyqiAdDFZEU3CX+rd0Oa3gNzaQilF7hA
         OJskSrXNG8fdT5WIRYVwNnicVqdhDqPNiykaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fSQXlDNaJHKRgIZ2rlXa5yHXIVxdUfHW6bq9rq+9DwEVwEYLihPe6XUEHloGdIEafV
         VqivI4mmntW7pmRPX8jqbAivJveCaQv9yI+5NG11xY/8iT5n3mQoDCCeHpVl8V7wL7sO
         G3rYubIbhA2DEkF9qGYHLmy8SMXApukWlVpx8=
Received: by 10.227.23.213 with SMTP id s21mr103853wbb.84.1286418323017; Wed,
 06 Oct 2010 19:25:23 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Wed, 6 Oct 2010 19:25:02 -0700 (PDT)
In-Reply-To: <7vsk0j46zk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158361>

On Wed, Oct 6, 2010 at 11:32 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> +Performance concerns
>> +--------------------
>> +
>> +Git is written with performance in mind and it works extremely well
>> +with its typical repositories (i.e. source code repositories, with
>> +a moderate number of small text files, possibly with long history).
>> +Non-typical repositories (a lot of files, or very large files...)
>> +may experience mild performance degradation. This section describes
>> +how Git behaves in such repositories and how to reduce impact.
>> +
>
> I have seen this "mild" suggested in the discussion, but do we want a=
ny
> adjective here? =C2=A0The runtime for, say, "git log" from the tip to=
 the root
> obviously would grow proportionally to the length of the history, i.e=
=2E the
> number of records you would want to see, and it may not be "mild" if =
your
> history is very deep. =C2=A0Same for the runtime for "git diff" in a =
wide
> project with many changed paths.

I don't want to give an impression that the sky will fall when someone
puts a 200MB file in his repo.

> More importantly, what is "degradation"? =C2=A0It is not a degradatio=
n if "git
> log" took 100x as long for a project with 100k commits compared to a
> similar project with 1k commits.

=46rom my perspective, git commands that are instant in typical repos
should still be instant in non-typical ones. Yes "git add hugefile"
will take longer than "git add git.c", but it should not take, say, 1
hour for that command. It's hard to draw a clear line here.

> If you do not have enough core to hold the part of the ancestry graph=
 that
> is involved to compute "git log A..B" to show a gazillion commits, it=
 will
> eat into the swap, take a lot more time than it takes "git log B" to =
show
> the same number of commits. =C2=A0That _is_ degradation, and I suspec=
t it won't
> be mild at all.
>
>> +For repositories with a large number of files (~50k files or more),
>
> How did you come up with this 50k number?

Quite unscientific, I started with gentoo-x86 (~130k files) which I
know git performs less than satisfactory. I also looked how big other
repos are, wine.git, linux-2.6.git... then choose a number in the
middle.

>> +but you only need a few of them present in working tree, you can us=
e
>> +sparse checkout (see linkgit:git-read-tree[1], section 'Sparse
>> +checkout').
>
> Is "sparse checkout" a real feature that has been made usable by mere
> mortals, battle tested, and shown to be reliable?

Hopefully. In 2010 survey, there are 331 answers they use "partial
(sparse) checkout". I hope that they used this feature, not something
else.

> It feels funny that we have to refer to the documentation of plumbing
> read-tree when the key verb in this paragraph is "checkout". =C2=A0Wi=
th the
> current documentation set, you can follow read-tree page that mention=
s
> some magic called skip-worktree-bit, get tempted to jump to update-in=
dex
> page and get lost in the implementation details of the feature, which=
 is
> irrelevant to the end user. =C2=A0If you resisted the temptation and =
keep
> reading read-tree page, you see the description of info/sparse-checko=
ut to
> learn how to control the feature, but it does not come with an
> easy-to-follow example. =C2=A0A few concrete suggestions to "Sparse c=
heckout"
> section in read-tree:
>
> ...
>

Hmm.. yeah. Will do something.

> I think the suggestion to use Sparse checkout in git(1)---i.e. your p=
atch
> we are discussing here, is a bit premature before the above happens.
>
>> +... If you need all of them present in working tree, but you
>> +know in advance only a few of them may be modified, please consider
>> +using assume-unchanged bit (see linkgit:git-update-index[1]).
>> +... The following commands are
>> +however known to do full index refresh in some cases:
>
> It is "need to", not "are known to", isn't it?

In case of "git commit", as you said in another mail, index refresh is
needed because of post-commit hook. If there are no hooks, I think
index refresh can be skipped. But yes, probably "need to".

>> +Some commands need entire file content in memory to process.
>> +Files that have size a significant portion of physical RAM may
>> +affect performance. You may want to avoid using the following
>> +commands if possible on such large files:
>
> "If possible" is not a good excuse. =C2=A0How would one _avoid_ check=
out of a
> file if one wants to use it? =C2=A0You can't. =C2=A0Similarly to "dif=
f". =C2=A0This
> advice is pretty much useless, isn't it? =C2=A0It's not much better t=
han saying
> "if your machine has too little RAM, things will get slow---deal with=
 it".

That's more of bug acknowledgement, or to-be-improved TODOs. I didn't
want to say that out loud. Should I?
--=20
Duy
