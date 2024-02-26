Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBA12F5A1
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974477; cv=none; b=LsRXtpo1eQ/Uxfo1V2Y9yX1RVUKln2Wcb6jokdpthp9lB/4vYhH+C/S2S56h9hUQsWsY5g61jPsd0zdd6A+5R7kFDTB3OGFydqCsmHMRp9mEVR/lpI6jdWa0RBXqzvqTxKKIRh5VJTe+Crl/DHlpAva48ZT/s2CNAoHW2pjdlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974477; c=relaxed/simple;
	bh=a0DyIgzXgu/taStWiTcsyHC2esgD9hnjPdrofhvMiXo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ndJnGX3+uG/NydHVRI+bRBqW9BW4PVSK8fcvHD2YLDr5Yg5lMQO1le3RqQiyXefj8S7ro/HYxb3oYC4NWNL7rdTvFf1Xi0VgUxEUgIgC6QWvRSmXw4NCyYHNgWsiRCKrBF/6yHL0MlKCn7dWx1dEV77NQOY59UsXLcQnpPhHNiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=eWLOmhlm; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="eWLOmhlm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202402191026; t=1708974465;
	bh=+xIacDTwtVoeNPKOUVwyPZJfZitO93XJI3hyHsnwhnU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=eWLOmhlmnTFA0v3pYIJbfjxVqdoAkrQAcvCU+BxOJMnqBElkw5j+aT8h5gymhBT6q
	 K/5Ilx/dI9mwc+33WT8je8GMS/ijnP1VydNZZJLUViURSkJqKNHPSefzgZvtF9BMgr
	 ObslY+AJMKGKvr8JupZO/Dc0K4jNfV5e20T5n06zv7H08MQCQUmCy75PT7q3hJqPeI
	 T8cRnysqTbN2AV9fXRMCTKO21xpsUj5btPEwgez4D5mMR6yvrx3sn9JRM9kJdb9JN3
	 RNQ8iwP2InCKX77Tb4vgXwvee0px4i1jP2j6WjX59gqyx7lLKJy/DPuPgcezyGGn28
	 Fx7uE/maXrsug==
Received: from [192.168.42.22] (183-121-142-46.pool.kielnet.net [46.142.121.183])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 606C23C215D;
	Mon, 26 Feb 2024 20:07:45 +0100 (CET)
Message-ID: <6a557891-ffcd-4c42-9768-ec2da0fce92a@haller-berlin.de>
Date: Mon, 26 Feb 2024 20:07:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stefan Haller <lists@haller-berlin.de>
Subject: Re: Interactive rebase: using "pick" for merge commits
To: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <424f2e08-a2ad-4bb2-8a6b-136c426dc127@haller-berlin.de>
 <ad561600-faf6-4d3c-80b2-34b3d1a1b99e@gmail.com>
 <65c65f6b-5ec8-4fa0-a17c-0f2c0d32b390@haller-berlin.de>
 <ZcnFl8kypKRYeLo3@tanuki> <040f142c-7ee2-429e-88eb-d328b01a4b8c@gmail.com>
 <2739325d-93b1-445c-aac9-3e0ec54a27e4@haller-berlin.de>
 <b4781808-f722-4be5-906f-4c3409c3295c@gmail.com>
Content-Language: de-DE, en-US
In-Reply-To: <b4781808-f722-4be5-906f-4c3409c3295c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 26.02.24 11:56, Phillip Wood wrote:
>> It probably makes more sense to teach lazygit to visualize the
>> .git/sequencer/todo file, and then use git cherry-pick.
> 
> If lazygit is generating the todo list for the cherry-pick could it
> check if the commit is a merge and insert "exec cherry-pick -m ..." for
> those commits?

That's a good idea, but it wouldn't buy us very much. We'd still have to
add support for conflicts during a cherry-pick; when there's a conflict
during a rebase, lazygit has this nice visualization of the conflicting
commit (we talked about that in [1], and it turned out to be working
extremely well), so it would have to learn to do the same thing for a
conflicting cherry-pick (although this does seem to be a lot easier).
And then it would have to learn to call "cherry-pick --continue" rather
than "rebase --continue" after resolving. But if we do all these things,
then we're not so far away from being able to just call git cherry-pick
ourselves.

-Stefan

[1] <https://public-inbox.org/git/
     961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de/>
