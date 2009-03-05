From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH] Clarify the "cannot lock existing info/refs" error
Date: Thu, 5 Mar 2009 08:00:37 +0000
Message-ID: <43d8ce650903050000g4466ab2fne5fb8ed009808346@mail.gmail.com>
References: <1236181026-15385-1-git-send-email-johnflux@gmail.com>
	 <20090304192853.GA10567@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Mar 05 09:02:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf8Wv-0000W8-2K
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 09:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbZCEIAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 03:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbZCEIAj
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 03:00:39 -0500
Received: from wf-out-1314.google.com ([209.85.200.175]:61966 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbZCEIAj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 03:00:39 -0500
Received: by wf-out-1314.google.com with SMTP id 28so4409447wfa.4
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 00:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9IsYMaF2MnkZQTtcO/qZPsLH1QoqydOtaQPbXWelmiE=;
        b=ZIaDcHzMG2jNH5rhGAKXsNxvQ5Z97WoMBO0eNHbl66iNC2kRShpFvbXsr3wOqsAT0Y
         FgO5fy6XGcApj92a6nJfIZgW2WI4gi8CzTGR0Z9OhpboHLGjK7eb8XqojG1fFJhB4/VS
         tebCBrxawCdPdHJPTE2X9Pq6j5EokusZgNqzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qEtw1PUWYwfP2SSG3OjlU10JGi1yEiQaK3/68Jveg/3WrGgavraVbfWV0CYbRO/yet
         7V5rKq7fxelGF2eDQG/CIcROlofR1NefnVM0CbaflQlw5UmNKxKfEKOWLR1HiNDHIYtW
         iNejSgKeSwa1g1NwljDo9/KZWoZulWB11F8IA=
Received: by 10.143.42.6 with SMTP id u6mr406661wfj.121.1236240037423; Thu, 05 
	Mar 2009 00:00:37 -0800 (PST)
In-Reply-To: <20090304192853.GA10567@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112265>

2009/3/4 Clemens Buchacher <drizzd@aon.at>:
> On Wed, Mar 04, 2009 at 03:37:06PM +0000, John Tapsell wrote:
>> -fprintf(stderr, "Error: cannot lock existing info/refs\n");
>> +error("cannot lock existing info/refs on remote server\nPerhaps the
>> server is currently busy, or your ~/.netrc file is not configured
>> correctly.");
>
> In my experience this is usually caused by http-push crashing and leaving
> stale locks behind until it times out after 10 minutes. I don't think we
> should speculate here unless we can narrow down the error condition.

Yeah, I was thinking of trying to narrow it down as well.

I personally get that error 3 out of 4 times, roughly, that I try to
push.  But that's probably because I'm using a very busy git server.
So in my case, I just keep retrying until it succeeds.

On google I found that people had been getting that error if they have
the wrong password.

Can we at least change it to:

-fprintf(stderr, "Error: cannot lock existing info/refs\n");
+error("cannot lock existing info/refs on remote server\n");

It's currently confusing as to whether it's a local error or a remote error.

John
