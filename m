Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FBA3CAA53
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005878; cv=none; b=g/GM6C09LszFQLeaD0pOrlG6DL2LTH97GpGt00UejG0wVHGnMX3ETO+OzTUj8ZQExhMdymR/UbE90b7td/eZ/lA0MPsCSzdKL1kcgayGWBlGf3rd+BbE+trokRoVPq+rqtGYtUWrjYkVzc54d17mQ3D73gFex7xKmz/czpsd6is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005878; c=relaxed/simple;
	bh=9jOq9VQKl+styfNSXFyleXavw1YqftaJ1l+Mi/wrrug=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZQOs5BpBAM61VdK5tkpIntj3W85FLtbQGfgvnxXjI+8aRk8fXP48PteoArd1TmsECdi/taMd5840pmiokh7sJdoWU9c58gYmtYoDxeORwXyW7thRV014AaAefAN7HoKxoCIN2ajjhRpSY79z2YCuVr8b5lX9Srf5G827HUVhDQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=D7Uy7yRM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VKS/mTgH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="D7Uy7yRM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VKS/mTgH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C700EC049D
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 15:24:34 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Wed, 14 Oct 2026 15:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792005874;
	 x=1792092274; bh=scU/sz5HKZPnZ1R0Qb5NZrxmBk8Di7TY3JdsyQuJD8w=; b=
	D7Uy7yRME8GIWn0zBblUzMzGbMwLk0OXEqQyPhVLl4lGBcoI5DdRPPf3HBW+VHwB
	gOnyueBLdvxynK30UZr+crAsFaITZ6LqJ7AgnrrcMlTrPPe+YOPwly5lVjFHwytW
	kIt7yt2ElJ+7Uv9Ja+tRuGvL3Wec4thFwSp3HIaqTpB8CZPzQZhQUdtaFSjBltQk
	cq+388mRYSLuHxGWKEZiW6/Mz2aQWNf2Kp7A4/9lvB40n5k2r6gMHeLQoD5TuFQc
	5buDkMKoD8/pRhU6sxT65+3DLawRliu4l9zGWuqTUqht2cEZscPqQDYaBhj7QoP/
	k7Jvp8mrS3/ey02cD5Y1zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792005874; x=
	1792092274; bh=scU/sz5HKZPnZ1R0Qb5NZrxmBk8Di7TY3JdsyQuJD8w=; b=V
	KS/mTgHMjh0toqTIOShiv8MeFUOj4256o5fhVIrWNuCUuWtqHjMKRrLG7o8a62wJ
	6zdfPVam1Ogee/vo1eOv5DqiYvtA8VPq9elgI94x+JX4juNT7M42c2WLp58Of0i5
	gQxmvinBl37gpy/+AFRQ9kd+vQhZ1PF70n0LYu3yTH/YhCYD4BQRDTrmsrnLUedy
	TUxdAbKJqKWmlH1YQsyUKhwuDu+vkfnRSgmH5M4zda7xG2I0ADKrDyQ8QW05tzsj
	YGCm0/3DyvyStVYT26vDo8//J6o8m5ZYrcUMrR0+RUzmls65Oc8Zi3w2ov5e6x4X
	j8o//W7PcG+3QRKW0lAAQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792005874; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KIdu4Z1sHJcMhqViWoP2MbHkyfluBQG0Go2P+3tkpSSe4pl
	funhS5FNDOPUbwp0m42bJ2hqm7ik9e29FPv8A4vLcv/X+0Vkz3AlbxOYiXIHktgB
	dk7vHCQn1YwHLpvXewdESKegNqEboPqc9XCfjxph5c+lQgZy3hrVLHXJrbR6qPAL
	W9BoKjW5MH+PHeHgk3rCWF/2y4aAgZbCyby6m4yIEY0qUZ216/nolv75uSKx1pKt
	JqRbeMYbLjVBhFOW4/nYs7CMxU30tgSR0Se0L7VoFokR2hcRNAva9Pd6YaCiqhfm
	QKyAUc+8H0NMD+YNNWu4f5T3HCZ0VhhLQIkndvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ARJkUKhdec9h8TdSbQrkWAujojgqKsJmonVNNSi/pcA=:9jOq9VQKl+styfNSXFyleXavw1YqftaJ1l+Mi/wrrug=;
X-ME-Sender: <xms:8tbPalbTjJuCyHdxAZt0188vwwOhU6LnXqCbl1qCBuMiFfuesD-GTw>
    <xme:8tbPanMTrAP5IKpBdK9Y_msCdsmHxCL1guz2ZOuQsdNbdW-7KfPvTXe1x3MPmeJC8
    PRhgeZwzjwqZEKlLj61tKz4Arx2zLA4f6fN4_98ZdapiC7Et2Qdolbz>
X-ME-Proxy-Cause: dmFkZTFZbppt5Sd++aq5mKDDj8SJOBKxjd9eUTB0tV3vVPjvNsBMwkyLeTYTKgFILW8k7n
    O5dtMbWyqSBzPGqY3kvsutQMkencxSDChl85pZ0nwtHXbiurPzt0f1OlgvwmpfUjyfxYVL
    AhRft9JmJeXtZaL8E33Z4lzwwyY5785bGMBJ5hN+1BMrTnlGp9WdOTxws+itbx9RGJTQmS
    XpHJtkyS+Xw2vD7lBtBrOaRaScoaQ6wl9qaSuOFXWhZ3JePGqAvDTF2ivehYljmQZJS8xP
    Cv57aw3KdbYhERMCIjmzVRO9zM8HVmW4trkOktse3cpITrnsaoQA26NhHfNs+B14iWg1AW
    bTXSxX7RN7MiqYBjQ3xM/tOWo1tax5TbTP3UgX8St69awqs0+tAaya0NqQfe/NqW6XNp9p
    CINqKZOQuGUI6KC6A+g5mQbW10r8SJX8oGi2GLtztUlIUVsBhKubKO1GKqk+5+ZeTrj0bV
    9LCNDq+RfqwLiwlSb0dub+sQ+BlqQrIfi5a07aLlQt7XPH4mNXM9UmhoozzN7PGO8RT4Rb
    8inC+BP7xVCSWy30U9JJF0wxyYCWCq4Fi+qC1koxGMimeOzd1wY/GMBYRCohXj6vygPeW4
    Ba1Q9N/jzNqj3CxjD7dSSpB6M3bkIzhliRkoqqa6zeXCGr9loLVjYGS4JpDQ
X-ME-Proxy: <xmx:8tbPatEPR2e_FyxQMVrkyTNuo4Qhq-ge0jgzAYDLPRY_KjJ-OGWMgQ>
    <xmx:8tbParrxEIjylZ9f2MWedXjKpsqKcxbU9GvWO9LoyGXo0fJpYw8CBw>
    <xmx:8tbPambXUbISD2RbhGWCoWhX1JZVjQVs6TZxmAjzpwlbgY3-H3lzkw>
    <xmx:8tbPakV5lgnkib2FgNUy-9JcJ9Ei_VKHf34La8W90K2g0dwUNLnCPg>
    <xmx:8tbParyb6DnI5ZQ49MZ_9ZH0BA840CGYhxeUMZS1s6kfcFJyb1ZOQtNZ>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 00762782738; Wed, 14 Oct 2026 15:24:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AndINfi0Ib6w
Date: Wed, 14 Oct 2026 15:24:13 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 "Jeff King" <peff@peff.net>, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <89df0444-1447-4267-9e28-bc4dc70b0478@app.fastmail.com>
In-Reply-To: <xmqqwlrm7pii.fsf@gitster.g>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
 <7aa0ae7ec3c1d02aa1533c27fa40f4815c03ba6e.1791816795.git.gitgitgadget@gmail.com>
 <xmqqwlrm7pii.fsf@gitster.g>
Subject: Re: [PATCH v3 1/6] doc: add new gitmergeconflicts man page
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Oct 12, 2026, at 2:16 PM, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Julia Evans <julia@jvns.ca>
>>
>> Introduce a new page, `gitmergeconflicts`, that explains the process of
>> handling a merge conflict in a way that addresses the following issues,
>> which came from feedback from Git users on the current explanation of
>> merge conflicts in the `git merge` man page:
>>
>> - The process for resolving a merge conflict is only explained in the
>> ...
>> - It sometimes uses the term "area" and sometimes uses the term "hunk"
>
> It looks a bit annoying that these sentences in the enumeration all
> lack their full stops.

Sure, will fix.

>> Only discuss merge, rebase, cherry-pick, and revert for now even though
>> there are other ways that merge conflicts can happen because it's
>> awkward to talk about `am`, `apply`, and `checkout -m`.
>
> I do not know "because it's awkward" is a good justification,
> though.  "awkward" why?

It's because `apply` and `am` can also apply patches, and that's a whole
separate topic than explaining the 3-way merge. I think explaining the
difference between applying a patch and doing a 3-way merge could
be interesting to do in the future but this is already quite a big patch
series.

> It might be tempting to omit some commands that are less common for
> new users, but we are touching the main part of the technical manual
> that are meant ot be used by everybody, so that is not a good reason
> to choose covering some but not others.
>
> I however agree that it is better to avoid appearing to be complete
> and leaving others (including future ones we add) with "any other
> command that does a merge" as this round of document gives.
>
>> diff --git a/Documentation/gitmergeconflicts.adoc b/Documentation/gitmergeconflicts.adoc
>> ...
>> +There are 3 ways to handle a merge conflict:
>> +
>> +* Resolve the conflict. (see <<resolve,HOW TO RESOLVE A MERGE CONFLICT>>
>> +  below for details)
>> +* Stop the operation and return your branch to its original state
>> +  with the appropriate `--abort` command, for example `git merge --abort`
>> +  or `git rebase --abort`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>> below
>> +  for how to find the command to run.
>> +* Or (if you're in a multi-step rebase or cherry-pick) skip the problematic
>> +  commit with the appropriate `--skip` command
>
> The third entry is a nice addition.  multi-step anything are the
> same, including revert, right?  I'd recommend updating it to
> something like "if you are in a multi-step operation like `rebase`"
> in the same spirit as the "or any other command" change you made at
> the beginning of this file.

Done.

>> +When there's a merge conflict, Git will update the conflicted file
>> +to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
>> +For example, here's a merge conflict where both sides edited a list of
>> +fruits in different ways -- one side added "cherry" and the other side
>> +added "banana":
>
> You added "-- one side added ..." at the end, which I think sends a
> wrong message.  With rcs-merge style conflict, you cannot simply
> tell, because it is ambiguous.  The original may have had both
> banana and cherry, in which case the sample output shows the result
> of one side removing banana and the other side removing cherry.

Make sense, will replace "added" with "has".

>> +[[diff3]]
>> +DIFF3
>> +-----
>> +
>> +By default, Git doesn't include the original code when formatting
>> +a merge conflict. To include the original code, you can set the
>> +configuration option `merge.conflictstyle` to `diff3`.
>> +This extra context can make it much easier to understand what's
>> +happening in a merge conflict.
>> +
>> +Here's an example of what a merge conflict would look like when using
>> +`diff3`. There's an extra section (between `|||||||` and `=======`)
>> +with the original code.
>> +
>> +With this view, you can see that both sides fixed a spelling
>> +mistake in "mango", and each added one fruit to the list.
>> +
>> +----
>> +FRUITS = [
>> +    "apple",
>> +<<<<<<< HEAD
>> +    "cherry",
>> +    "mango",
>> +||||||| 1c22e48
>> +    "mangoooo",
>> +=======
>> +    "banana",
>> +    "mango",
>> +>>>>>>> add-fruit
>> +    "orange",
>> +]
>> +----
>
> THis is a great example.  
>
> But an even better example would be to give this:
>
>         FRUITS = [
>             "apple",
>         <<<<<<< HEAD
>             "cherry",
>             "mango",
>         ||||||| 1c22e48
>             "banana",
>             "cherry",
>             "mangoooo",
>         =======
>             "banana",
>             "mango",
>         >>>>>>> add-fruit
>             "orange",
>         ]
>
> and tell the readers that that the correct resolution is to have
> "apply, mango, orange", as each of cherry and banana was removed by
> one side while the other side did not touch it.  Having cherry and
> banana in the result is a tempting but not always correct conclusion
> unexperienced people would draw from the rcs-merge style output that
> is ambiguous, and here is a great place to teach it in this flow.

Thanks, this is a much better example, for the reasons you say. Will use it.

I always appreciate thinking carefully about which examples to give,
it's so important.

> Especially because it would make it stand out that the point of
> diff3's verboseness compared to the rcs-merge output is to
> disambiguate two cases.  If you start from ABCmO and one side has
> ABMO while the other side has ACMO, the right resolution would be
> AMO (the above case I added), but if your starting point were AmO
> and the two sides ends with ABMO and ACMO respectively, the right
> resolution would be ABCMO.  The rcs-merge output does not tell you
> which is more likely to be correct, diff3 disambiguates these two
> cases by being more verbose.
>
> And telling that value of diff3 is about disambiguating is valuable
> when ...
>
>> +[NOTE]
>> +================================
>> +`zdiff3` is an alternative to `diff3` that makes the merge conflict
>> +shorter by making it more ambiguous.
>> +================================
>
> ... this note tells the readers that zdiff3 is a ambigous variant of
> diff3, hinting its flaw.
