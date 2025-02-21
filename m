Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF81F4299
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132248; cv=none; b=WNhDdVp3Tvh0m0G4AKjuEbs46jl8aJoGl3t8xzDJQSLi9stcF+zVMfXNtQrYX/4sx8rD5lLG5a1XKmgvG1Spg9gqYqFL0LLNnfiAaT0T7txdPK3KXHTzKSwhottusXMePlXLlYfHU6kIJ0BZIKYQHFkZZIsj1iTptQArjfTb5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132248; c=relaxed/simple;
	bh=e5kR5z1h093hXgPJZMp5X54SESmZ9XKNicB6ywkF+dA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WOmZpZyh2vesHBxFCYfIV44apB/HHcZCQC7BEInXz36gs7uiPJNU9JDDfK4tzrCOBo+0nuzx5S6unSMlkpcf0nbe2PrhHhKMDdTYZIUu3ba4349kIMBEOT56LEuJg477C2W2YBfRzBfaZ/tmgtdfBKkL6CunbLxghZVADjH7sYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=J1q5g1v5; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="J1q5g1v5"
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2d94:0:640:e777:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id CEDD460AB5
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 13:03:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id u3VB1tALcmI0-VrxcaNuM;
	Fri, 21 Feb 2025 13:03:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1740132236; bh=3NV63GgolX6abegIz+/sprU/zMOnb1DyGpV3d4Zlyd0=;
	h=Subject:From:To:Date:Message-ID;
	b=J1q5g1v5FgNQJgJAi636+9dGh7WSK/LE7vKRbCIy8cjQAPV56o42fETvsm7k3BNR1
	 ftOx6A6roJkquBSHzwSovXq/ysnJEVW6Wm3AGddBtBgxeStsqkWaoFQOkB9dVuchTJ
	 dIR2TJ4wzXSptDYb5VICkWFGphR0qEMayohWIn2E=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <cae34516-5437-49d3-8d39-16f4059a81a8@yandex.ru>
Date: Fri, 21 Feb 2025 13:03:56 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git mailing list <git@vger.kernel.org>
From: stsp <stsp2@yandex.ru>
Subject: unable to delete branch with forgotten bisect
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Trying to delete the branch, I
was getting this error:

error: cannot delete branch '<branch_name>' used by worktree at 
'<wtree_path>'

It wasn't used by that work-tree
directly, so I was very confused.
It appears this branch had the
forgotten bisect.

It would be very good if git can
write a more prominent message
for such a case, like:

error: cannot delete branch '<branch_name>' because bisect is in progress

