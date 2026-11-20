Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212934;
	b=Sy+KzsBEg84FJ3ZQRyj/h09TUHYaumBDjQoAeifvnJjppKfDV2iKO1o60GT22CZimBEo
	 NMo00baGWHS8pwkF5huMPnI0G+FFxLhjlvlUSxKhv7MyR/E5jran9ZG1EdVHWsqN5xnQY
	 ypju02ZF71/9FC5qW/Bl3zJERGVOImN8NkOfTTHXU58+kMoPmIPTKhSXjxiijTFVJTOE+
	 Pp836I2YCFkfmmo7KJy/0QRP0TcACLVLE1ths2TamWnQFLn/sxL/Or/5E0qjP7B35M9OE
	 AKGe5aEGsYWyzA0fFaCdX4o+23L6jxahuKWVGXSIe6zkCmu0Hb6HNgVcuP+xdDpkryw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212934;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=6hsxUyPAHnYTfuRL4Xi2aRrH5zuLLWsN4KyS5r8mSc8=;
	b=PT8YapQEzpsS+l/PsNL/E3WVX0zxzipeeuETKw/ANPPOMVquz2/mYfW24arbIP5GTZew
	 nt9AEX1JLaP7ugSUaC7oKge0PyNCp9NXEo1bUS5npiWoD5bAc42S8rOhA4C2PSCC1Pxns
	 nvU0OYNbglOyEWYqaGp7CuMgPAEJ0UI+seeXdbNnCUlVRww6St2ce6n7NEkOgfJsq7d3j
	 lsy0ykeOBcRAlRrQB9osyRm87/q4KHEAWGQHxOdwdcWQ5lAbEJ1UzUMOmo0oFTgXuCE9W
	 FfXe09VV6zGBHP2ak5F63+ZgqeN2BhjbxpLq3XJ+MQ3nrJEX8Qlf4rCuhFe++bK72ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=aGBptfID;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F7A606A68C
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 22:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87F7A606A68C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=aGBptfID
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 56D02401CB;
	Fri, 20 Nov 2026 22:15:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id CE56220010;
	Fri, 20 Nov 2026 22:15:29 +0000 (UTC)
Date: Fri, 20 Nov 2026 17:15:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: Prevent git reset --hard from losing data
Message-ID: <20261120171528.3e6c3f5b@gandalf.local.home>
In-Reply-To: <xmqqqzgfnouv.fsf@gitster.g>
References: <20261120145444.13061eb7@gandalf.local.home>
	<xmqqqzgfnouv.fsf@gitster.g>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6h8z3i9nqe4f7rhmnhwif73orp1igscd
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: CE56220010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19icT3UWr6Wmq7/sQhZENOq2ZoTlDs1xiQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=6hsxUyPAHnYTfuRL4Xi2aRrH5zuLLWsN4KyS5r8mSc8=; b=aGBptfIDwsarclSHOvBUDn9icvIKxbfs+Mpz6t7Sh5oXTELGDG+N1kv12ksOg5GVEAnVkYSQErbhwHnxELtdD4/FkLs/7kMVK4DmnC5dN/irx29JPIJcaxzuBbWA0GpQr95rQZXKvEkruhANTMFtc326p9t89Ju+hicV9ijRImA=
X-HE-Tag: 1795212929-99685
X-HE-Meta: U2FsdGVkX187ddYt6MWUhr0kM1moKawC4Hj+lPDLxqwCGY+IOUzl9jKYaUhl8xECNAJwFbR5aE/yKbkxby6ADI1poueNejs8EALUE2OGPE9Tag5VDgNh2OvsxfOZPR/SL7lisQu3yNzMBAJHb89uaTJBefrXmhO1adhj9hxaDM5xaU6lsL0QG4DLz86CcSqZTji17cXXO5tSpIH0kitK6qpDIm/aipoOm7h4VnXCmNddRqx9M3KskcDWG0lMuCBxGqiuQw3kwEHkJEKTfBNB0AdC9Qs4eDeiMdup0BzVxh6kTddEjax6/wJsLQUUFUSxwwJKzPqN9yjX0be02GrjWHX8BRIMLG6F9dAWfPTkaFkDvjQ8cOYRsZh6fHuB10x7+3xiL8RJTPVK/Sy90ekHOIwsItYnNE+R9U1apDqnbMMXUsIiW/h0+aZu+thbZ5HP

On Fri, 20 Nov 2026 14:02:16 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > Too many times I do a "git reset --hard" in the wrong directory and end up
> > losing uncommitted changes. Is there a way to add a configuration to have
> > that command check if there's any uncommitted changes and ask if you really
> > want to do the reset?  
> 
> I do not think so.  Castrating an existing command without harming
> others is a hard thing to do once the tool gains more than a few
> hundred of users, and we probably have more users than that.

I was hoping that there was just a way to add a hook that could run before
executing the command. I wasn't suggesting that we make that the default.
Just some kind of .gitrc that says "do this before executing X".

> 
> I think you need to go to the root of the issue.  Find out what made
> you want to run "git reset --hard" and see if there are less drastic
> solution to the same issue.  And come up with a way to package that
> less drastic solution in a form that would be useful to many people.

Well, it's something I do on a daily basis and have for the last decade ;-)

The reason I use git reset --hard is because I work on several topic
branches and create development ones all the time. Sometimes I add commits
across branches. I'll create a temp branch and work on it until I like it
and then copy the sha1 of that branch, checkout the branch I want to use,
and do a "git reset --hard sha1" to convert the actual branch to the temp
one.

> 
> That way, people would start using that newer solution and less
> often be running "git reset --hard", reducing the risk.  When
> somebody really needs to do "git reset --hard" or a script that has
> happily been running "git reset --hard", it will continue to do the
> destructive thing as it was designed to, and everybody will be
> happy.

I could just make a script that would do what I want (do a git diff, and
ask if there's any changes pending before doing a git reset --hard), and
then train myself to use that instead.

I simply emailed to see if there wasn't a way to do that type of hook
before committing to that. There's a lot of things git does that I wish I
knew before and I was wondering if this wasn't one of them.

Thanks,

-- Steve

