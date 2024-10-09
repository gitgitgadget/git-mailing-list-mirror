Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C97E765
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493108; cv=none; b=dnP1TW7jrYhQ4pvzg2G1SiS48AbuVhdV7aIOjnFpCdO7iC5S7mf442rS5Sa9uxlLTxHr8wbhSlgOgPbX2b1950rMXs2nRL+HMnwxe4ewJADW04zKu1sNh3d4z6MItU50RHms/vdXQaw5sCq/WlM1h4pou3z+/QAKqqWsWKjxmjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493108; c=relaxed/simple;
	bh=4exv8WEkIPxTVc5X7uEP1NXo7cqsFrIVqJkcjt3jF0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f7l7YFZqTWZK7aQqQl9KJvQM6CakKf99e43XuPjaXyuGm6dJojGe+wPni4GSPbJ3svQc6KF1WLn5Mgj8hlpgkH9U2YeKcp1Klul5nIYNUJTdqp/YgmedmCc6XqWf/jA3tPuTbu99zX28GnigHPHuHGslLximeR7QBMZ6KWKJ66k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4XNzbq28dNz1sCHv;
	Wed,  9 Oct 2024 18:58:15 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4XNzbq1hCsz1qqlW;
	Wed,  9 Oct 2024 18:58:15 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id jM9Hgb7bj2G5; Wed,  9 Oct 2024 18:58:14 +0200 (CEST)
X-Auth-Info: q7f6kdqpq67sMxJ1HntVftZkzZiYDK5SG/mxHUWHrtLL4y8K6EHmY362yNbdORm9
Received: from igel.home (aftr-82-135-83-188.dynamic.mnet-online.de [82.135.83.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed,  9 Oct 2024 18:58:14 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 4C9402C19C6; Wed,  9 Oct 2024 18:58:14 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org,  Eric
 Sunshine <sunshine@sunshineco.com>,  newren@gmail.com
Subject: Re: [PATCH v2 1/2] doc: merge-tree: provide a commit message
In-Reply-To: <xmqqo73uz5qg.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	08 Oct 2024 13:42:31 -0700")
References: <cover.1728298931.git.code@khaugsbakk.name>
	<cover.1728413450.git.code@khaugsbakk.name>
	<b1ca5cae76845f84147d385cc5ff47f219cd471e.1728413450.git.code@khaugsbakk.name>
	<xmqqo73uz5qg.fsf@gitster.g>
X-Yow: Now I'm concentrating on a specific tank battle toward
 the end of World War II!
Date: Wed, 09 Oct 2024 18:58:14 +0200
Message-ID: <878quxfc2h.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Okt 08 2024, Junio C Hamano wrote:

>> -       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
>> +       NEWCOMMIT=$(git commit-tree $NEWTREE -F $FILE_WITH_COMMIT_MESSAGE \
>> +           -p $BRANCH1 -p $BRANCH2)
>>         git update-ref $BRANCH1 $NEWCOMMIT
>
> The shell should know, after seeing $FILE_WITH_COMMIT_MESSAGE and
> encountering the end of line, that you haven't completed telling
> what you started telling it.  Do you need " \" at the end of the
> line?

The contents of $(...) is a (multiline) shell script, with the same
whitespace and newline rules as a regular script.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
