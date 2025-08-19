Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [194.59.206.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9878311941
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.59.206.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602733; cv=none; b=d0TWy0BP53tg0mbwfrwPD/oWcX/qYFD4fIEyQhH7/5BkKvewCeHwleXgX1AL9NRnp4ZHb0UvJ/BleeZHN8ze8iK6vpp9q4Og1ZziRxyPpUDxmiXipyVUShlHZsHGRQTiIiR4IQ+flnutZygpN91hvsr9f9Neuz7+aNEkWsE5QEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602733; c=relaxed/simple;
	bh=YMw/3+0oBaYSzR0Z+aGmYl7ZMX8XRUJWi5f2sADCjNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lh6lRdzdnnayq9rxRMXnCdLDR6QCHrZOfNFGSTSY9R7OlIM6MHyutVyFeqaVKmxQoXAPmZJ4kZRJ7CgZxiF1V8rhFfasWHYQyvWWA/j4Nw+jc+BOtqNlwe4N75VODturB8tDLWIqvuMG8CUmqzGkHnmUADIqDqOOMyNtSxKyxBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de; spf=pass smtp.mailfrom=rd10.de; dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b=eflh9O6c; arc=none smtp.client-ip=194.59.206.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rd10.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b="eflh9O6c"
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4c5n7B2Cbbz3wxB;
	Tue, 19 Aug 2025 13:15:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rd10.de; s=key2;
	t=1755602118; bh=YMw/3+0oBaYSzR0Z+aGmYl7ZMX8XRUJWi5f2sADCjNg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eflh9O6cy5Y//IrmLWgVUNorvy6xuyf6Q7Dm5mkQTshYMbT3E04f+MzCKkHM4eSla
	 fk4QtS6JU5jii5H2DKx1sYArbvDpCkKcf5IkFKpx9JVf/52IIxixJu1wXccH9DY0Un
	 3LLGIEoCDV6GwpopeG0k+RoJ5Bm3jlrUnuu8LFv6yOnSbF0uNNB0EtgpVj7juxovSi
	 fsVE/NUraXEUq24eoDOBGZ7WXYjMwyqJXoI7W2P+tBYRVGltOUVKLeTpZBZzjhzzJA
	 2hfwM0m7qxA6t3TkddkmLh/ETlxwURBOAuK510f+Z2spF32IiL6juA7KK5FymsPtog
	 OrSo0TG1tx3sg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4c5n7B0cQHz7ycR;
	Tue, 19 Aug 2025 13:15:04 +0200 (CEST)
Received: from mx2eb1.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4c5n6w39BBz8svc;
	Tue, 19 Aug 2025 13:15:04 +0200 (CEST)
Received: from [IPV6:2003:cf:cf29:c500:2af1:2c6e:b5fc:f414] (p200300cfcf29c5002af12c6eb5fcf414.dip0.t-ipconnect.de [IPv6:2003:cf:cf29:c500:2af1:2c6e:b5fc:f414])
	by mx2eb1.netcup.net (Postfix) with ESMTPSA id B3D24100272;
	Tue, 19 Aug 2025 13:14:59 +0200 (CEST)
Authentication-Results: mx2eb1;
        spf=pass (sender IP is 2003:cf:cf29:c500:2af1:2c6e:b5fc:f414) smtp.mailfrom=rdiez-2006@rd10.de smtp.helo=[IPV6:2003:cf:cf29:c500:2af1:2c6e:b5fc:f414]
Received-SPF: pass (mx2eb1: connection is authenticated)
Message-ID: <f2977c6a-b588-4e30-b7bb-dfa6d4b8b45b@rd10.de>
Date: Tue, 19 Aug 2025 13:14:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Graphical tool to merge and reorder commits
To: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc: git@vger.kernel.org
References: <4398af77-3183-4ac5-9a25-aca6289d8c8f@rd10.de>
 <xmqqplcsiimq.fsf@gitster.g> <aKQws631-giQS5Qr@pks.im>
 <aeb06554-77b5-4f07-a659-7b6825d6f3e4@rd10.de>
 <260a97ce-2ab0-4920-9cea-078369c42f74@petrovitsch.priv.at>
From: "R. Diez" <rdiez-2006@rd10.de>
Content-Language: de-DE, en-GB
In-Reply-To: <260a97ce-2ab0-4920-9cea-078369c42f74@petrovitsch.priv.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <175560210003.19408.2270802354914662793@mx2eb1.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: B3D24100272
X-NC-CID: /Xte63qIXjFjMnyBSw9O1ExvYhY4u9huyNx9p1WO


> - `git rebase -i HEAD~11` (or so;-)
> - move fixA1 and fixA2 under A and change "pick" to "fixup" for fixA1 and fixA2
> - save and exit the editor

I actually did not want to count commits or look at hashes, I wanted to comfortably click around to see the diffs etc. while I make the decisions.

After such posts, I wish people like you had to buy their next online plane or train ticket with curl. }8-)

But let's stay on the command line. I could learn new tricks.


> And done.

OK, git rebase was happy, everything is done.

And now it does not compile anymore.

You'd want to go back to the initial commit sequence and try another approach. But now it's gone, or at least it does not come up anymore in your git-gui. Or is it really gone? Maybe I can dig up the old commit sequence if I find the right Git commands... But that is what I wanted to avoid in the first place!

So I guess I should branch beforehand, just in case. And then move the head back, and rebase the commits there. Or the like. And don't squash yet, just in case. And then squash later, after everything compiles. My keyboard is on fire.

