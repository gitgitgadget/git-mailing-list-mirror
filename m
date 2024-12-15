Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660E1B3949
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734305057; cv=none; b=Fw7PdtWeSZrTXx+5CkmUVMg4gGj1aPldeNFNm4wL/IOKWX8aQZk/D7A4Smt6lCffV0z4iiouA4UqAGHJssECXQo0v96odUQHNqHk26qG+tyjaK4GaxnvOXaYrHl9OF/PLGwHM33I1uM2YwkS+Ly+ubDpl8LXCVaUdiDMmzivPuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734305057; c=relaxed/simple;
	bh=8qMAcSDQLHLBMgVhJ3mJKCo9t2lFfv60+ax/yFJ0xmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pn3qLdy7BFaEQRODNamN7biNeMoFnHFPnUGRsgTp1austYMb/+Q1aswtUIUB5HCV1566/62y2nLX4vOnspLJLmpj3D/Ni01+LxORqQwDezR/uErZ7V+7qLUP15wj1jmPS3bjAc1YVvSQEBzUs3a6uDRMRE1cy7ol4jP5xYTgZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a1HNi9N9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pdBxwlW7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a1HNi9N9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pdBxwlW7"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7A8C211400D4;
	Sun, 15 Dec 2024 18:24:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sun, 15 Dec 2024 18:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734305053; x=1734391453; bh=kAFAo+dPa9
	4/6rGsyHDxohuJ4V+9YeSj3fQBjlGRT2k=; b=a1HNi9N98PzkLy57eMDXqYFUY2
	aeenByOLlPnLeyBqDk7t3GFYe97l1yC+4iSLUpVGXwid1AZzwyY0t0AfezxRfH49
	9UxDMUgHzTcMizaVMj0yxacpvpF6vhz4kGC98303pT6/tylnRoCU/e+FG7imkfZ3
	41JtbJYfTtNssfn8p0di6YQEcBGApOskuuOwgzc/z0cafnjb6pU59m+pCzV4x7I7
	rE5KOcPPQCfGgVvIdFU7KX0W/l5+lXu+TJBOz5aReV3GLNhMskijpgR8jLZ9YAxB
	mZvOa09Sy9PQ7nmdksE6fSrNs5/y/9eqlN64XX/ZNe9RCHpcJgxN3yMHJMqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734305053; x=1734391453; bh=kAFAo+dPa94/6rGsyHDxohuJ4V+9YeSj3fQ
	BjlGRT2k=; b=pdBxwlW7lFiW7i0eWEnyJt9oSXh2L3rUpc3qVn4eAvIdbj3Ngdt
	99bSvCiRzqooLGeRHucxA9bpbFMzwTSz2yU7sROVCopDxj+rbYF8+haHX/NlJCkM
	2GTVxMz1So9P5GfCTX961uWrJdgOvQ98uLF9N/yCdsv+X3lw644FMN6HtAhxvqdM
	S79PRlr6cIgB1pl02ah5RLeM7krKj5Bg9cSbzDy+s0USnMd0Xr0SQe0JLqlPSX1W
	nPJ4SBOvxmpR0SNZvIaY02EBqrP0NFVpfwtQF1KDrEinfBdt1+XT2iEiM8wEoAYF
	51KoEZPAl4mW8TPQxKOflbne4kq6n7mojxw==
X-ME-Sender: <xms:HWVfZ3I9CB-i-ChqgYCjf8B9WBF2RcEK3zkOZv009ybz8yIcmawtbw>
    <xme:HWVfZ7KxxGb1L4_viBcEDIpt3z7JX8Hy2PfjB_aVMAGCIqIqhRy7Cv2TQseqPACNa
    1H65kuWhtUa4mlq1g>
X-ME-Received: <xmr:HWVfZ_vs3ZxjEPQ0E-v13wRLxMlN6O3-fYltrvXIJvVCmXWLJ8ejA8tnV6npRxaylZfvaNKmF0INbyXnuLI7DuQtRybfA1QdVVppncU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledvgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeevteev
    veeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HWVfZwbVrpOmLNepvoj05Fr5LLalsQGtVJuwZXMIlxb_ljH7OJwFcg>
    <xmx:HWVfZ-bbn8bIvAroWrOFOuIscXIIEtfYp3fkOI4FFXHbKxqMTWeaRw>
    <xmx:HWVfZ0Dhj94ghoM--ID5GoDxdoesYrrrWRHhLIcnOR8QGJzIJskeWA>
    <xmx:HWVfZ8b5P6HUwadzpBDHH4X_m-fbJdoVZi762auzrGOcn9USrTLMoA>
    <xmx:HWVfZ1wXczSf1U5ZtcZdSycZsSG5koT6nhedV8mSJJOaSPrtD_TYo4Ft>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Dec 2024 18:24:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
In-Reply-To: <xmqqldwj9pq0.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	13 Dec 2024 14:34:47 -0800")
References: <20241213042312.2890841-1-jltobler@gmail.com>
	<20241213081211.GA1443203@coredump.intra.peff.net>
	<xmqqldwj9pq0.fsf@gitster.g>
Date: Sun, 15 Dec 2024 15:24:11 -0800
Message-ID: <xmqqa5cw8r8k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> So ideally we'd have an input format that encapsulates that extra
>> context data and provides some mechanism for quoting. And it turns out
>> we do: the --raw diff format.
>
> Funny.  The raw diff format indeed was designed as an interchange
> format from various "compare two sets of things" front-ends (like
> diff-files, diff-cache, and diff-tree) that emits the raw format, to
> be read by "diff-helper" (initially called "diff-tree-helper") that
> takes the raw format and
>
>  - matches removed and added paths with similar contents to detect
>    renames and copies
>
>  - computes the output in various formats including "patch".
>
> So I guess we came a full circle, finally ;-).  Looking in the archive
> for messages exchanged between junkio@ and torvalds@ mentioning diff
> before 2005-05-30 finds some interesting gems.
>
> https://lore.kernel.org/git/7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net/

So, if we were to do what Justin tried to do honoring the overall
design of our diff machinery, I think what we can do is as follows:

 * Use the "diff --raw" output format as the input, but with a bit
   of twist.

   (1) a narrow special case that takes only a single diff_filepair
       of <old> and <new> blobs, and immediately run diff_queue() on
       that single diff_filepair, which is Justin's use case.  For
       this mode of operation, "flush after reach record of input"
       may be sufficient.

   (2) as a general "interchange format" to feed "comparison between
       two sets of <object, path>" into our diff machinery, we are
       better off if we can treat the input stream as multiple
       records that describes comparison between two sets.  Imagine
       "git log --oneline --first-parent -2 --raw HEAD", where one
       set of "diff --raw" records show the changed blobs with their
       paths between HEAD~1 and HEAD, and another set does so for
       HEAD~2 and HEAD~1.  We need to be able to tell where the
       first set ends and the second set starts, so that rename
       detection and other things, if requested, can be done within
       each set.

   My recommendation is to use a single blank line as a separator,
   e.g.

        :100644 100644 ce31f93061 9829984b0a M	Documentation/git-refs.txt
        :100644 100644 8b3882cff1 4a74f7c7bd M	refs.c
        :100755 100755 1bfff3a7af f59bc4860f M	t/t1460-refs-migrate.sh

        :100644 100644 c11213f520 8953d1c6d3 M	refs/files-backend.c
        :100644 100644 b2e3ba877d bec5962deb M	refs/reftable-backend.c

   so an application that wants to compare only one diff_filepair
   at a time would issue something like

        :100644 100644 ce31f93061 9829984b0a M	Documentation/git-refs.txt

        :100644 100644 8b3882cff1 4a74f7c7bd M	refs.c

        :100755 100755 1bfff3a7af f59bc4860f M	t/t1460-refs-migrate.sh

   so the parsing machinery does not have to worry about case (1) above.

 * Parse and append the input into diff_queue(), until you see an
   blank line.

   - If at EOF you are done, but if you have something accumulated
     in diff_queue(), show them (like below) first.  In any case, at
     EOF, you are done.

 * Run diffcore_std() followed by diff_flush() to have the contents
   of the queue nicely formatted and emptied.  Go back to parsing
   more input lines.

