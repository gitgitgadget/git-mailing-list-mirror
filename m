Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2239E6FC
	for <git@vger.kernel.org>; Fri, 29 May 2026 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030915; cv=none; b=ceWDSp7Z5ffrWFkj5qjhgTsC+mjmN2XFcSWnNa5+kZbUTBSNpJk827mWyQjcAxNR8xcWDFBrzw13exTI93MGu3QHp7wQcnN3PEPzP8W99FKJ3kM5WYrqoK5Tmvgs8AA3pVraeTuOMSSSPtr4mIReqTsT24TXedz8SS62CtrjN+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030915; c=relaxed/simple;
	bh=FCvWZDfmjKxttqUKHsDYnXcBX1gfYvBAu9XblsBXDso=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=gMdhYuemFglZ1yK16Jc+rCfm5BiSQGrfbeA68cbx3cjspoiq9+v+oVJvo2SfN0zSWz6tEv76r2dW7AQuoxPBvd8goZFv9/JMDc6hKTYw2CbH2uzw9Vx7KPsSYyVMhitNVNBzW6LXQy9IFQJ64MoyapFjOHEtQ/AWSYVCfBc6qvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net; spf=pass smtp.mailfrom=opperschaap.net; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opperschaap.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opperschaap.net
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gRWRP1lbDz9tPs
	for <git@vger.kernel.org>; Fri, 29 May 2026 07:01:37 +0200 (CEST)
Message-ID: <cc9fda14-d8e8-4982-9a3d-9aa816c0b90c@opperschaap.net>
Date: Fri, 29 May 2026 01:01:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Git maillinglist <git@vger.kernel.org>
From: Wesley Schwengle <wesleys@opperschaap.net>
Subject: git hook question
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hello,

I added the following to my gitconfig:

hook.npm-test.event=pre-push
hook.npm-test.command=npm run test

This works well when I run `git hook run pre-push' but when using `git 
push' this breaks a little because it adds the remote and the location, 
as seen via `GIT_TRACE=1 git push origin':

00:46:53.714453 run-command.c:673       trace: run_command: 'npm run 
test' origin git@gitlab.com:waterkip/mything.git
00:46:53.714458 run-command.c:765       trace: start_command: /bin/sh -c 
'npm run test "$@"' 'npm run test' origin 
git@gitlab.com:waterkip/mything.git

I understand the why, normally pre-push gets `<local-ref> SP 
<local-object-name> SP <remote-ref> SP <remote-object-name> LF'. This 
has a similar feel, albeit a different syntax. The difference feels like 
a minor bug, but not one I'm worried about at this moment: you would 
expect it to get the same arguments/parameters as the regular pre-push 
hook. But I digress.

My actual question is: Is there a way to tell the hook "Don't give me 
arguments, just run the plain command that is defined". I looked in `man 
1 git-hook', but I was unable to find something that looks like it.


Cheers,
Wesley

-- 
Wesley Schwengle

