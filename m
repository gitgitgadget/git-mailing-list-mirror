Received: from hamza.pair.com (hamza.pair.com [209.68.5.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58107E9
	for <git@vger.kernel.org>; Sat, 11 May 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.68.5.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715431229; cv=none; b=ulQursGJhx3lMSAmHmW+RFcnjRSCLx8aivNME7NzlWlHCyyb3Sw2FnvWhZUj5xMFPV+vJHHMDAZTkXqjz6iTM6R9e3SGVMVtQzw5Qb0CK11OnVtA5j3qs1CRgHxym8QojrqfqULQkIxFZmhojTg8KOYK14YKcnFZhgMRI3ZBqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715431229; c=relaxed/simple;
	bh=vOezWw0VFD1Qi6+j7pKeu+37RK107IpzoR2LVZcC5uk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=BzkwH5j15eyebAVsQlr+wX9zUG/6TIuKOKvyHv2ztfw9+hzdOgn3GsIQvH/G+kQVbB+LfVFCS48AAtxK8pQPI7XXxl6xPf8ZLh0P6y+hfuX8b7BKi8L8dnL9KR14ekshga47zgOe8GB91D7vbqvuDuFCSLkO3QFISB6+SrFrfhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pfeifer.com; spf=pass smtp.mailfrom=pfeifer.com; dkim=pass (2048-bit key) header.d=pfeifer.com header.i=@pfeifer.com header.b=YLAs3Vls; arc=none smtp.client-ip=209.68.5.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pfeifer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pfeifer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pfeifer.com header.i=@pfeifer.com header.b="YLAs3Vls"
Received: from hamza.pair.com (localhost [127.0.0.1])
	by hamza.pair.com (Postfix) with ESMTP id 9AC0733E87
	for <git@vger.kernel.org>; Sat, 11 May 2024 08:34:18 -0400 (EDT)
Received: from daya.localdomain (188-23-56-169.adsl.highway.telekom.at [188.23.56.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by hamza.pair.com (Postfix) with ESMTPSA id 28CAA33E86
	for <git@vger.kernel.org>; Sat, 11 May 2024 08:34:18 -0400 (EDT)
Date: Sat, 11 May 2024 14:34:12 +0200 (CEST)
From: Gerald Pfeifer <gerald@pfeifer.com>
To: git@vger.kernel.org
Subject: git shortlog --committer=name is documented, alas not implemented
Message-ID: <77e42d15-fcaf-5c1b-3a00-f1f1e3cedfc4@pfeifer.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pfeifer.com; h=date:from:to:subject:message-id:mime-version:content-type; s=pair-202402271039; bh=bJMAbauIdirl74Pn7CmMaSk1Tgyxxv3DUFP+05Ltn4U=; b=YLAs3Vls3qlp1sqoxvj05vDJmz7p9s1GrMPlcZqDiH2DfMp0TI3vC88PxNtnn0fiKz7SaQxe45GqojMDMTBWnBG5K1F1W81dZk2RFFr0hxyhE5xvoGr6PZdyFSIRiqmml042bGkCBTB1bKlP+YMIl8P2IbfZV+UMOs5wDgPSvwiIyIszW0p73wTCe6jFbpkkOPLsPCNVnhwTRteaq7jq6O/uu4lPQbWZbw91s8kHKNyAPQzND7AAKL4MHJ7ajdyGAVXXJuaPIIhkHWpR20qu4vvDJSRHULDs0FxwUiCPZ0FMUshQ0Cp5XdKHkOfWTbV6mYPJj4L6vxwAZsieijw09A==
X-Scanned-By: mailmunge 3.11 on 209.68.5.143

`man git shortlog` (from git 2.45.0) has the following:

   --author=<pattern>, --committer=<pattern>
       Limit the commits output to ones with author/committer header lines 
       that match the specified pattern (regular expression). With more 
       than one --author=<pattern>, commits whose author matches any of 
       the given patterns are chosen (similarly for multiple 
       --committer=<pattern>).

Now `git shortlog --author=gerald` works as expected.

However `git shortlog --committer=gerald` results in an error:

  error: option `committer' takes no value

This is either a doc bug or an implementation issue?


Also, how does one list all commits by a certain committer (as opposed 
to author) then?


Thanks,
Gerald
