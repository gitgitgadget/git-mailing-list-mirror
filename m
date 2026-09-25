Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0501E3B14C7
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790355610; cv=none; b=iz0eu8XGQm509T87auvzvT8Odayve7pBj7b9cdV8NbeN2nNaihJlmk6Hr+v/x+iV4vRHYMFEmcG551hY/6kGgS6HGt0ZyJ+24aqTMT5oGlDLbfnQsbAj5JKs4o35tk65+fLf4JI/4JA5b+Rg6zW1SBsqm6zHKbxDz4D2SYdbCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790355610; c=relaxed/simple;
	bh=JpV+mmDdcbUbLCCNNeIjDyvZxMxRi9CbgvEF3CLggqs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qvpchxCH1ZeSIXSe0+hOmbaflMAlOd1nhlnMFdZmLvPm7H0bjZQgnGi2MwKYvIFrEzCxXJnq02gW0cbQwC8HCOHxZmQp8pVLEEGHERuwwvD2FCKF50Z7HVBRAg1dSmtr8xkGm4g/tjw4RcAA71fwRgmLTMGXn9RZiRNs1cEWMpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=5jlTB1Wf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YyQrUmaZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="5jlTB1Wf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YyQrUmaZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F4F51400101;
	Fri, 25 Sep 2026 12:59:57 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Fri, 25 Sep 2026 12:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790355597;
	 x=1790441997; bh=y8AaGB/JOJhRaonrvdO24Hcq8CZt8ZGPzmeEp8hStQU=; b=
	5jlTB1WfbJD4Q44oDIGtxWBOM/wm6Y6OZPXbAxUTlgy0lOmXPaiLUOpFaLMyNyOS
	P/jp0UbosJv9TEiBXd+EreTQsVytqsKfSO+PzK9nbUUo5EHN4EYjbCTX/gLQ76VN
	GvTKGO5e1so8HXaIMq6Llpyi2HQC2LLmtGtwnm4x+eAA4gbZFxmwHpzg3icsO5l/
	eGpV5Pw/+fD3gttr9QC+B9bSQLGHylGQFGcHwn4Lb7B6gg/fSqc6obxU6cAoH3dg
	s7mhDfOc+3Nx9zgXtDzwpgcoOZMWLIxKwtJ+uYOm5hVF52nTY5rRkCrixGIZ4t25
	veVoYGqUwn7NM/WT8/OO/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790355597; x=
	1790441997; bh=y8AaGB/JOJhRaonrvdO24Hcq8CZt8ZGPzmeEp8hStQU=; b=Y
	yQrUmaZLCWOYa0gupETPcrJFLks+zzxREz3mnvWeygS0wv/hHvejEV8uZBCoM2jx
	5HUoKPgHH0XueIOCkrRld9qph0RB5zFGeKg/9+wEQWA18ayLHoSr3VfOTt4658aV
	rx5a0HhS1i7lCq2TujiVnr4i5gKK5zE8Oq8PYAwVUkHuOstsClG7x8JvxAxjs1w+
	zNZ/9j3ymlqMHHqdhpiouuab4+Yse+0SycdXL5+DabDh9YOAW73/Wm/FFs14HkbR
	u2Irn3CO96pvDPXysHD6VZZ68Rabg+9qshgmdYgLnWXTl8bYySHoMN5fVBWv0Tow
	uwbbUMLteHglf+NRg+tfw==
X-ME-Sender: <xms:jai2an2I9zgxmcCpwIuMhQ8FpiCmRxU94sj7_KYJPXRztb4aqXiUrQ>
    <xme:jai2ag4_0LoE5IV109zV1wWslEXn_Xk2YJSjEtaQ9mwLA-DYYvBHvbkvQhTYveplS
    3BbwSr60gWE09Y4EdE2Yw9dCNmJVpK7cNlMmiUUZMe2TVVk2jI9Fv1k>
X-ME-Proxy-Cause: dmFkZTGhgQ/ZspvF55DWuRdURC7lsADAOSRmiM+pOjw5qYKNzoP+Wf6Q4LxthJnBkcZ8TL
    Ls5rrYf4fUvPti4pbAbv9/6BsEvd5vVi5T/LeusjcBR0vBaz8NsugOfRGHjSkXZFsLrNId
    YULluMMZqKepSQ5D4tzMFU1oVKFjDqJkPrKlwylbphB39xpYNY9qzVkMMBrwHYIqUScwxg
    32PFKpXwtD+f5gzsji78tefgT5bhpZheIFEbLr+9EDRO9UzRX3vXHukpRO5CEFFcVyYjS7
    jyZzX6xi4PVr/O37aS4w0HJZgEAUuDTeKymOspj6sll2EeRWnRtafRA5QJ5yZzDqm2UgLp
    lfMu1/7ZHCZrY6BuSVDucTuV7uZbBGDLqzPQc1JxUHja+9lDO/ECIT9dknwsAkPC4iAAY+
    rtMQqQv4Ux2/TPeSo7hxikCmvrVDIXogAoFxe46fpohcp9vWt0fs0agEjcM4/9zI0i2izv
    4cxhrUj7JoIewftD4Tc/TpAuC4Wbt58DOZst9QXonLCylWdxVxQqHGLkNouJziYcAUPTc2
    8dyw84KYMggJV5Tgt8E+h4InF0CiPHSzzlVDTAFyRI0SvEJnIF4a3OWSFuC6e1ccE+3ku2
    J6rY7/kaV11DdYRX6EjLwTdPXNap+9VGbm6VHH5R6e6lg0IEFJBG/RC8hjmA
X-ME-Proxy: <xmx:jai2atdaEmv6r-UZ9FL0WEqjqTPNy8iatNykgD_XsFUJbMTIk0mwdQ>
    <xmx:jai2apDlwR0RRsh8L6jaXE_NsI7umnq2Gb0hJzIw4eWAXp4GH_CY7g>
    <xmx:jai2ag9Uzw1CXivOI3Tq3r-9TrMXKBZ4C1ZKkgyRqj7II91iq5TsuQ>
    <xmx:jai2akKSNvVSMZwQnEkDmNt-xzRcms8UKQJdx5aDmQ8v6b8ksNMlOg>
    <xmx:jai2as_T6wJ7Hy2c2g1dIUonJiJtMg7xUPoP9gv-4L-AX4265aOvrK_l>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1E228780078; Fri, 25 Sep 2026 12:59:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ3yMKGvzUL-
Date: Fri, 25 Sep 2026 12:59:35 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <2f71028f-d58e-400f-a02e-7a25c032d889@app.fastmail.com>
In-Reply-To: 
 <CALnO6CDdoqE2hyZMJg6OZkzNtcnjNXRz=HO4q6cZVpF_wbTXyw@mail.gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <a1686a2d82ef9357ecff07c1247092d3dd5ecf95.1790261062.git.gitgitgadget@gmail.com>
 <CALnO6CDdoqE2hyZMJg6OZkzNtcnjNXRz=HO4q6cZVpF_wbTXyw@mail.gmail.com>
Subject: Re: [PATCH 2/7] [doc] git-merge: link to new merge conflicts guide
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Sep 25, 2026, at 12:36 PM, D. Ben Knoble wrote:
> Hi Julia,
>
> On Thu, Sep 24, 2026 at 10:46=E2=80=AFAM Julia Evans via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Julia Evans <julia@jvns.ca>
>>
>> All of the info about merge conflicts has been moved to the new guide
>
>> Among the changes made to the common ancestor's version,
>> -non-overlapping ones (that is, you changed an area of the file while=
 the
>> -other side left that area intact, or vice versa) are incorporated in=
 the
>> -final result verbatim.  When both sides made changes to the same are=
a,
>> -however, Git cannot randomly pick one side over the other, and asks =
you to
>> -resolve it by leaving what both sides did to that area.
>
>> - * Look at the diffs from each branch. `git log --merge -p <path>`
>> -   will show diffs first for the `HEAD` version and then the
>> -   `MERGE_HEAD` version.
>
> I think these are both valuable pieces of information we have lost in
> the new guide (unless I misremember just having read patch 1 :).
>
> The first explains a bit more about what a conflict *is*. Maybe that's
> old-hat nowadays, but I think it could be nice to keep a statement
> about why conflicts exist.

Will think about this!

> The second is a very useful way to get more context to help resolve
> conflicts! I have an alias "conflict =3D log --oneline --graph
> --left-right --boundary --merge" for a similar purpose, and I think
> the new guide should help folks discover --merge. Often I can get a
> better sense of how to resolve conflicts by comparing the original
> changes on each side, or I might at least know who to ask about what
> to do.

Thanks, I meant to flag this: the reason I deleted it was really
just that I couldn't understand what `git log --merge -p <path>`  did
from the documentation and so I removed it until I could figure it out.
I thought that `--merge` meant that it had something to do with merge
commits, but upon further investigation it looks like that's not true, a=
nd
that `--merges` is related to merge commits, `--merge` is something
totally different which is relevant any time there's a conflict

My best guess now is that it would make sense to include this
under "Tools to get more context". Maybe something like this:

> `git log --merge -p <filename>`  will print out all commits which
>   caused the merge conflict for `<filename>`, and the diff
>  of how they changed the file.=20

("which caused the merge conflict for" is a little more vague, but
I'm trying to convey the intent, and hopefully folks can look at
`man git log` if they want to know the specifics)

This does sound really useful.
