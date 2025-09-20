Received: from smtp1.de.opalstack.com (smtp1.de.opalstack.com [46.165.236.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921831D416E
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.165.236.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758370067; cv=none; b=nTcpViLf0kkEzFYuOq+bRGLzRoRgMhvsEGn8RMjkbXmFcPDTZ17Gli8p/Sw/aP7owcygTviohp24X7o4qmzwlnggf7duMIjYIDzt/wIWrSggaQLBOvXkOWuxoUforhPpYhiw5b3D65pMQp+a0doWjNGwB1tSkEJuhh+DgI3v7Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758370067; c=relaxed/simple;
	bh=mJoo+1CBgRymECYTarnWxREoW7/kwsBdnXN7JAFf284=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=inxoXhhsKmqaGhtBl9/6hVqmCmFKD+GpEkRWJMls7/PyvzNukc7PnPdBAmyItVKvG2rJjkADL5vJHvrCJKhYiTJIZRmNkWX8KqRTUoQ+Hv4YZPJCL6bkdqhyEBcAmiK3tjOD9etDpufVbIR9Hh1m1Ip2zVScDHnQKUbsQkbQmKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=humanleg.org.uk; spf=pass smtp.mailfrom=humanleg.org.uk; dkim=pass (1024-bit key) header.d=humanleg.org.uk header.i=@humanleg.org.uk header.b=r0nIgIJK; arc=none smtp.client-ip=46.165.236.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=humanleg.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=humanleg.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=humanleg.org.uk header.i=@humanleg.org.uk header.b="r0nIgIJK"
Received: from alfonse.localnet (lewi-27-b2-v4wan-165698-cust214.vm4.cable.virginm.net [86.22.120.215])
	by smtp1.de.opalstack.com (Postfix) with ESMTPSA id 23E3344E10
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=humanleg.org.uk;
	s=dkim; t=1758369550; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ImWIcziSpea13DKQjCOmKWd52n8yvu+Rk5K8GddqTtI=;
	b=r0nIgIJK2ctl1/0f+kt35Z18H1W+fiW7HySDkFB4rTMxqj4HeTe5dbsqUlGtFyq3HC2Gjb
	uvm3PM+eeGcs980Ipz/5n0UVU1slTU2JuwdJZf1BdZkXHVciGYueQCQeCtIuLaqC2o5jZ3
	/QcsvXAcS9aqaxVjmBc3JHVZk2FfFBk=
From: Robert Scott <lists@humanleg.org.uk>
To: git@vger.kernel.org
Reply-To: lists@humanleg.org.uk
Subject: [BUG] gitk assumes availability of `osascript` on macos
Date: Sat, 20 Sep 2025 12:59:08 +0100
Message-ID: <2994140.eGJsNajkDb@alfonse>
Organization: none
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Tiny one here. On macos, gitk (tested 2.50.1) attempts to call `osascript` so 
it can focus/raise the UI. But it fails hard if `osascript` isn't present in 
the $PATH.

There are a number of reasons `osascript` might not be available in a 
particular environment, e.g. if launched from inside a "pure" nix shell, but 
seeing as it's just a quality-of-life feature it would be nice if failures to 
call `osascript` could just be ignored.

Thanks,


robert.



