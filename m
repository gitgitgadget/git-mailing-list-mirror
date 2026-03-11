Received: from mail.univention.de (mail.univention.de [78.138.66.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585E41FE451
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.138.66.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253862; cv=none; b=egRdDlUfQ5wCmirJLBp0nsFrMG6BkCQbqH+vFS4iRKO166Isoa7sdJhPFqGtMn2pQXBorN08sRfO0DT7XJNN8h/7MF2CKLkvnF3QlMmkWtEna1Y0A7wyGl4EZbmhe4h0UCdaXOUosBOLmZpj4P/UDichH6x9PTKajwCQFjFPf9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253862; c=relaxed/simple;
	bh=0w2fTMcIVFLkZCKjeUkMnGXptyLyqM2eFJzHP+V21D0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=QXtTT7riwl03FPyZV9qDxwB50JUf+uM/mFiBo7T3qJUzysAYXioVcOMXqa+t1JA8pxP8GFZQkreUxEWKOiBDPH1uuOcgYVzFxHikXrbPox1xBYUiV33ZfOOWzq5fEwxYTZLNgCo8PjsmIV0tBpdPreIhp7NOm3wjf0NwghVBL2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=univention.de; spf=pass smtp.mailfrom=univention.de; dkim=pass (2048-bit key) header.d=univention.de header.i=@univention.de header.b=gIQT53/f; dkim=pass (2048-bit key) header.d=univention.de header.i=@univention.de header.b=iOK+ZMiT; arc=none smtp.client-ip=78.138.66.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=univention.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univention.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univention.de header.i=@univention.de header.b="gIQT53/f";
	dkim=pass (2048-bit key) header.d=univention.de header.i=@univention.de header.b="iOK+ZMiT"
Received: from localhost (localhost [127.0.0.1])
	by lankmoj.knut.univention.de (Postfix) with ESMTP id 1E86D105FD7
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:30:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=univention.de;
	s=202111; t=1773253858;
	bh=0w2fTMcIVFLkZCKjeUkMnGXptyLyqM2eFJzHP+V21D0=;
	h=Date:From:Subject:To:From;
	b=gIQT53/ffsxNKyBCxUrd8VLDmG88Ow6jqqL+7huS68vb5L0njZ8ka3QjoibBDTUit
	 7bKrbUpj16L06xfatRS6z7WBg7LNO8lTwWLysK8e5r2z5KxbqZHmuLbF8dr552V/Yr
	 QpaJ8UHPyLfwa3rFg9KH3DvSprKI437GEyjxZwCLeW7u/iXnRtKCENj+EtVe3VL4Ua
	 u3IDQ/eP8JolIeUUGpegz4d2/Y2hX6lO5GUZ6UKWTFIsBsvCF/HHiYsLJLi3EYvnCl
	 2X4nfvRgD/I6slKDTmLwBpL/vqIL1op9UbzW6Ec/lEcP0WL51n1Rp6/G2tit3sW/DN
	 ko8T2RFfiyJRg==
X-Virus-Scanned: by amavisd-new-2.11.0 (20160426) (Debian) at
	knut.univention.de
Received: from mail.univention.de ([127.0.0.1])
	by localhost (lankmoj.knut.univention.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UurPU3t7xTWX for <git@vger.kernel.org>;
	Wed, 11 Mar 2026 19:30:56 +0100 (CET)
Received: from [192.168.178.154] (dyndsl-037-138-209-019.ewe-ip-backbone.de [37.138.209.19])
	by lankmoj.knut.univention.de (Postfix) with ESMTPSA id E2A671020D5
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:30:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=univention.de;
	s=202111; t=1773253855;
	bh=0w2fTMcIVFLkZCKjeUkMnGXptyLyqM2eFJzHP+V21D0=;
	h=Date:From:Subject:To:From;
	b=iOK+ZMiTRZiMMGmywL8gAlOAGvs11sVrZdAerFeFdwsQEqIGjAuHNKCY1n/U/tXzO
	 Y+YC6Ymo7s47AwAm0GyzqNofJjcO8arV4Tu+1dE1xcFdbvFnqZSrDv5a7dkTphua4/
	 z94H1zoJ0Msfx/85YHddaxy+0iKCxGcbCVGK2s876XPB1nsNDPdNh2eV2Zat6quOdg
	 NBpjJjZ0kLWw12Nig1L1/Ueu4SrWaLHjKe67Na4pRjay7EbuV5CfCZi2OzgRyK9HCE
	 4B0yrKHOqMgOvujAsfTd/JWmuqXILkCPR+CNkQ/v6TzTY1cvcgHJyMTK+JXhSKC3yZ
	 QaVJ0JJT0IWEA==
Message-ID: <43529695-5987-486a-bdff-46f573868c4c@univention.de>
Date: Wed, 11 Mar 2026 19:30:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Best <best@univention.de>
Subject: cherry-pick: add --show-current-patch
To: git@vger.kernel.org
Content-Language: de-DE
Autocrypt: addr=best@univention.de; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

When running `git cherry-pick` over a range of commits, the command may 
stop due to conflicts. At that point Git reports the conflict but does 
not provide an easy way to see which commit is currently being 
cherry-picked or what patch is being applied.

`git rebase` provides a helpful option for this situation:

`git rebase --show-current-patch`

This prints the patch of the commit that is currently being applied. I 
believe a similar feature would be useful for `git cherry-pick`.

Currently, when a conflict occurs during a range cherry-pick (e.g. `git 
cherry-pick A..B`), there is no straightforward command to show the 
patch of the commit being applied. While it is possible to inspect 
`.git/CHERRY_PICK_HEAD`and run something like:

`git show $(cat .git/CHERRY_PICK_HEAD)`

this is not very discoverable and requires manual steps.


Proposed feature

Add a command:

`git cherry-pick --show-current-patch`

which would display the patch of the commit currently being applied 
during an in-progress cherry-pick operation (similar to `git rebase 
--show-current-patch`).

Behavior could be:

  * If a cherry-pick is in progress, show the patch corresponding to 
`CHERRY_PICK_HEAD`.
  * If no cherry-pick is in progress, report an appropriate error.


Motivation

This would help users:

  * understand which commit caused the conflict
  * review the exact changes being applied
  * debug large range cherry-picks more easily

It would also provide feature parity with `git rebase`.

Best regards
Florian

-- 
Florian Best
Open Source Software Engineer

Geschäftsführer: Peter H. Ganten, Stefan Gohmann
HRB 20755 Amtsgericht Bremen
Steuer-Nr.: 71-597-02876

Univention GmbH
Mary-Somerville-Str. 1
28359 Bremen
Germany / Deutschland

📞 Phone : +49 421 22232-0
🖶 Fax   : +49 421 22232-99
✉️best@univention.de
🌐https://www.univention.de / https://www.univention.com

Managing Directors: Peter H. Ganten, Stefan Gohmann
Local court: Amtsgericht Bremen
HRB 20755 / Steuer-Nr.: 71-597-02876

The information contained in this message is confidential or protected 
by law.
If you are not the intended recipient, please contact the sender and 
delete this message.
Any unauthorized copying of this message or unauthorized distribution of 
the information contained herein is prohibited.
Legally required information for business correspondence: Legal Information

Diese E-Mail enthält vertrauliche oder rechtlich geschützte Informationen.
Wenn Sie nicht der beabsichtigte Empfänger sind, informieren Sie bitte 
sofort den Absender und löschen Sie diese E-Mail. Das unbefugte Kopieren 
dieser E-Mail oder die unbefugte Weitergabe der enthaltenen 
Informationen ist nicht gestattet.
Gesetzliche Pflichtangaben für Geschäftskorrespondenz: Datenschutzerklärung
