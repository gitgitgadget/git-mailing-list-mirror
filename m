Received: from 1.mo550.mail-out.ovh.net (1.mo550.mail-out.ovh.net [178.32.127.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AEC20C498
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.32.127.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925637; cv=none; b=aKBX7ms4esgNm29+LOKEA4cjkKdNqE+u05VjsR4fDMBD2OCaoQY5n8gmYWjwcZp5Y2dEuPiX3PhxT0Q6OO29WNfWVdrA832h8nadHjhmgo6LgR2oDQ+obaUYjlb5vmFnehqonYdiJLrib8ThLEWgcRB8s4jDu1SdqUSIEQZ7Ak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925637; c=relaxed/simple;
	bh=F9nhVQhDv8CbaEwmYaujhGPdVJU7QTdwRMCHst4P/bo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=n7xKxKgs3pD905NdVCzt+VOufmfyvnTbPvb0Def9KcG+CFypHxy2JJwH1CRIW2Po7ye6MNrmh47pKu83h9KiGki75JSkJtY7RuQXdFC1lR2MinNYAB/W9NV4IbizinnqPF1/GmIcUSuM2ZMSC9DzjIs27Y/AHzu7epauvz6H/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maurel.me; spf=pass smtp.mailfrom=maurel.me; dkim=pass (2048-bit key) header.d=maurel.me header.i=@maurel.me header.b=hytFtgHY; arc=none smtp.client-ip=178.32.127.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maurel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maurel.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maurel.me header.i=@maurel.me header.b="hytFtgHY"
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.139.72])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4XkGs05M5Fz1XPB
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 20:24:36 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-cc4p9 (unknown [10.110.178.46])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 6F5031FD3D
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 20:24:36 +0000 (UTC)
Received: from maurel.me ([37.59.142.107])
	by ghost-submission-5b5ff79f4f-cc4p9 with ESMTPSA
	id mJrED4TQK2eCAAAAxmmxUA
	(envelope-from <julien@maurel.me>)
	for <git@vger.kernel.org>; Wed, 06 Nov 2024 20:24:36 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-107S0019f1227f9-db58-444d-af6c-0a805b05e41e,
                    34AE11586F26B73916293453D1B005C8F15421DB) smtp.auth=julien@maurel.me
X-OVh-ClientIp:176.138.87.53
Message-ID: <711a0faa-6d82-48b6-819d-9ddbeda03f6a@maurel.me>
Date: Wed, 6 Nov 2024 21:24:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Julien Maurel <julien@maurel.me>
Subject: Question about merge & cherry pick
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15025134259535262459
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgddufeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkffggfgfvhffutgfgsehtjeertddtvdejnecuhfhrohhmpefluhhlihgvnhcuofgruhhrvghluceojhhulhhivghnsehmrghurhgvlhdrmhgvqeenucggtffrrghtthgvrhhnpedvveevjefggefgueehhfdvtdffkeeuieeftdetjefgveeiteehfeduiefhhffhhfenucfkphepuddvjedrtddrtddruddpudejiedrudefkedrkeejrdehfedpfeejrdehledrudegvddruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepjhhulhhivghnsehmrghurhgvlhdrmhgvpdhnsggprhgtphhtthhopedupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheehtdgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=OG7t+pAUCk/DTLkjaIbptEIjchjHBOa4myRJeKEIAmc=;
 c=relaxed/relaxed; d=maurel.me; h=From; s=ovhmo4520387-selector1;
 t=1730924676; v=1;
 b=hytFtgHYOdSS2L9RB7ZKs1dsdOwuOp0JDmVebj4Yw6nul6sWB0XOsVOKZfJHmVAX7kG3o18G
 K5Z/Z5/Zvk9iYqaemu+xGIzB46a+Ro+JcBrVrGZ+41WnZVvlOT+pmg+Zc1ywmPK6soHS00BWXHQ
 HrMvqJrSi0ur3Cvo7CBDmDJtm3jsFFD7l8zpFXpj5uAOVfLCm5TMpuyLz4107MkCEuhpfHW7vCb
 gTLluVNYbE5UHkaF+HscVYH7n94aI0H5MF2J2VeV6opuLkyUIMUdDd1NaA9AA62GBF8yEqkuaJy
 XG9Swj1YbfgMQpKbM9HnSleVAtbvw4Wda0u5+tz1qA/PQ==

Hi,
I detect a potential issue with usage of merge and cherry pick.
I do a short script to reproduce my use case.
 From my point of view, after these operations, content on branch master 
and dev should be same with "zZz" on second line and "eDe" on last one.
But it's not the case on second line...
I test the same thing with first commit on master, cherrypick on dev, 
second update on dev, merge dev on master, result is same.
And I test to cherry pick second commit on master after final merge, 
cherry pick is ok and "fix" master content.
Can you help me to understand if it's normal or not ?

The script :
mkdir repo
cd repo

# Create a file and init 2 branches with same content
git init
echo -e "aAa\nzZz\nqQq\neEe" > file
git add .
git commit -a -m "init"
git checkout -b dev

# Update on dev
sed -i "s#Z#Y#" file
git commit -a -m "update"

# Cherrypick on master
git checkout master
git cherry-pick -x dev

# Second update on dev
git checkout dev
sed -i "s#Y#Z#" file
sed -i "s#E#D#" file
git commit -a -m "update that change second line as before first update 
and do another change"

# Merge on master
git checkout master
git merge dev --no-ff -m "Merge"

# Display result
echo
echo
echo MASTER
cat file
git checkout dev > /dev/null 2>&1
echo
echo DEV
cat file


Thanks
