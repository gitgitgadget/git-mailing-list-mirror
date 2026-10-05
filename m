Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0884214A84
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218199; cv=none; b=Y/UFUYmQBD0DIQ12zK1KzPxnDbbJL23nX/kZ+fvH5c6D5EBKPxoyc5+Xi2CND8XdsrIcZELOSN5cP0/5t9nzJGHIxGuDkXzn1HSdUtkt7CQenZg/lfmhfN58rjn2t2NtRkPSJu5+ZFHPSt0hemY9iv/lXBwjCzWVazGruyKh5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218199; c=relaxed/simple;
	bh=g5HRhbxIilqfAokZCgC/ZaKPoLNr5QcZO8vfQ7dFa4c=;
	h=To:From:Subject:Date:Message-ID:Mime-Version:Content-Type; b=gPY3cTLEFwr/Y80FfJt9i/nxIuTlTLpQdrg3xjK6ju4CU9PlVqS4uR7HFySMoCvhZqd3NVgcyd/6ciiuurLGrTbjSZcgbke4TA+V1XS6GpVkiaEc2eSNX3vmmVt1cx5wsQup8cXnmC4Hpimd6OSUtqY08NmycIRVxQjb0vI3Gcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gcvg-git-3@m.gmane-mx.org>)
	id 1xDlfx-0006rH-Os
	for git@vger.kernel.org; Mon, 05 Oct 2026 18:36:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
From: Jon Forrest <nobozo@gmail.com>
Subject: OT - Idea for Speeding Up Building Git and Other Large C/C++ Packages
Date: Mon, 5 Oct 2026 09:36:20 -0700
Message-ID: <11a0jm6$p29$1@ciao.gmane.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Content-Language: en-US

Git, and other large C/C++ packages, follows the convention of guarding
include files with, for example in http.h, a "#ifndef HTTP_H" directive.
This is nice because if http.h has already been included, its contents
won't be seen more than once by the compiler.

The trouble with this is that a substantial(?) amount of work
still has to get done in order for the preprocessor to see the
"#ifndef", such as opening the include file.

What if the preprocessor were changed so that doing "include http.h"
first checks if HTTP_H (or some agreed on symbol) is defined,
and then, if not, actually opens and processes http.h. This would
eliminate the overhead of needlessly opening include files.
This obviously wouldn't be a change to Git itself, which is why I
said it's OT, but Git would benefit from it.

Is this a good idea?

Cordially,
Jon Forrest
UC Berkeley (ret.)

