Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF931E507
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713288; cv=none; b=fewr71NznnHMKDo/sRPNYFF8hlMkEW70b81me/KKgqTMN/ZXUM1s9653GklwM1UmT58TRts4ZNEYTe74ZmX2zuCuc9w5gZD+D/hjx3157Mgz9xiWmsC9mLjkluh+1vYih7+dspMrmWAPSZ3TRIcI+sm3/oSczzW3Bitk6Cua8y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713288; c=relaxed/simple;
	bh=hE/vh6uUGFbpjb6Q6cuot9ji9Yrs+sTz3GpzwG4rsBM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XxUtiYtVUuXuRrDbR+jfWaaPWzIf8HXPLdcn+ZQWl/paFD5gsCIKw60br26s7CMUAkY/EHKvNusKAsQ/oAS5zo3ydBBIhWUxMFCA0QVHgGYKfnrBbPfVOZ+pzGslv677JT9560c3KTg3TXI5vNu7nx/07+6MD9u8KL1zDEnFfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+q9URpN; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+q9URpN"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4582fa01090so551031cf.0
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727713285; x=1728318085; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hE/vh6uUGFbpjb6Q6cuot9ji9Yrs+sTz3GpzwG4rsBM=;
        b=B+q9URpNMXZZROIBpPeQ9AaDuq4SOBaJY3sJ/F+qQhVb7WkNVkFOjl1u/eM1VQQhRw
         phq0iUX/JsTob9dJ+Uhy7SkG3dfZxC9qJxlYh2gI78m1b1eVRZb+supevhzDw69lBt62
         H15qN+ngwHO82c7qhjgud3Oy91wHA0cECmUy6WsUOKoDFTL1AmY46cm2zjejPAbJ3uKY
         TlVHvwd1/FjwPoFIdzMAyPmsSvXPEWqW3y/ozRUWg5LB0OoNLkT4O3IPBiRjUeogkQFF
         3Su19Spbp5uJIcFcXBOSsGcaKRN3pystRIk+uEsjNcs6C3G81ioOemJAHPoRzwKdZoXb
         p3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727713285; x=1728318085;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hE/vh6uUGFbpjb6Q6cuot9ji9Yrs+sTz3GpzwG4rsBM=;
        b=HFduSgFzumN4FkKzRQuLAdU9D1Ug8oqIoITW5ltzkncWn5CKxmjyEG2d89Di9O1bNN
         3NH2FdYOwaTeN7zlBwPp1+R6jKfN5qvvEDDHRS+evhq3Ez6m8doUAOz4Vu7dKRqG1duR
         yJl1BLxb1ije/p/gXJiIFr2zP4aePuXnqyM1jAPxRTPXB9PeuvDywY79rUPabc2SeQ8Q
         nmVCEKXGwwwa6tNv3i9F05pYnn2zRvrTGWtHxhXB4I8zPfZPVaiSmL9Ii0baBJhZL1e+
         9SYOdM4Kd+fbS3L3jd7Lz6VkiI/qYcunDtfyFewWobXGBGGqIlaB5ATgnSWo2x+P3ly6
         iLMQ==
X-Gm-Message-State: AOJu0Yyeh5RnsFQU2KFOwnXskIu88tWT3/UoMSX/B9IxXoSpxsvsrlxY
	DcLD5/I0bQewTtXW/Wt4DgwrDVO4nOs4di7Q7gLLRDxCwbI+epeWSkpueWodBO3nJXuf5gumDi2
	GRbPEzHsMBAFzFcfTLT+XR6rN4z4kxyHeFaaS3bHXZ6cZ6DE3rw==
X-Google-Smtp-Source: AGHT+IHtMsKY8eC+qW5mhp4zPniVkAaYlsiFt3r0CyzF8KkaavSqqaT5nQrmDutvyg+PRE21Ef5IikRKKo0iYmSk4cY=
X-Received: by 2002:a05:622a:790a:b0:45c:9c6e:6dba with SMTP id
 d75a77b69052e-45d730083cfmr541041cf.27.1727713285183; Mon, 30 Sep 2024
 09:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Emily Shaffer <nasamuffin@google.com>
Date: Mon, 30 Sep 2024 09:21:11 -0700
Message-ID: <CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com>
Subject: Linking topic merges to mailing list threads
To: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,

We've been wanting to gather metrics on Git's code review process -
how long it takes from first contact on list to merge, how many
iterations are needed, time between iterations, etc. One missing link
is the actual merge time in `next` and `master` - a human can infer
the link between the patch and the mailing list thread, but it's more
challenging for a script to do it.

Would it be possible to modify the maintainer workflow to include a
link to the cover letter as merged in the merge commit message (or the
link to the latest iteration of the patch if it's a single-patch
change)? What issues could come up with that workflow?

I guess one is that we could move from lore.kernel.org to something
else, like we saw the migration from public-inbox.org some years ago.
But the Message-ID was preserved between the two archives, so maybe
it's enough to include the Message-ID in the merge commit? Another is,
of course, the added burden on the maintainer. But maybe there is some
script that is already used that we can modify to make the extra load
negligible?

(Or, even better, if anybody else is already successfully measuring
these kinds of metrics without such a reference, could you let me know
how you're doing it? :) )

Thanks,
 - Emily
