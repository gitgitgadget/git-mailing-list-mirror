Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A2E36AE9
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 02:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706582630; cv=none; b=jlYpwe3OEKGFzXRjh7GJsAFbe2iG4nHsiSl3NHTZfRwgf9ZlWMWGaiVY+2+Bu3XpC4qx1LYAkx55p7nG4bwaBZRe2+muyvIXjYX77MVgtnO8ujyRsFxaMXsOWwh9Kkx8B/VFo7cIpBIaD1hZk6zo5RCHrTFNcRYrkm56r1wzND8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706582630; c=relaxed/simple;
	bh=Lfu2ntWV0K5q+XH0I8NJ0VEFqjal86jH/A10epluZ3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RsfLNFM9Ie/R7BBXMc30taKRY8JIdaZkjL4a7fe4IebtfEFx4hMJSH9T2ScdC1phJ/1XPNqByb8IYezOU+ypNT3/bmMZtL+aGZaxiREfdFecFmhFo2t9DR01TAWC5qHqyqt9PTWqGvageBo0Z7voTdmnr78r+UjbUP9b7Szgm48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hYghge4p; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYghge4p"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-602d22a54caso50296087b3.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 18:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706582628; x=1707187428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsYZ6yVYEECCNUdyAFVgFhLHU0fRZgVrwJIiGrZBwRQ=;
        b=hYghge4pLXjfKIFVuvHcOkF6gbIKRKsTO0H0onTCM7Qm2Xk1jOqecutHGdFwpcyO8u
         a7jqlzbrqg2h1uGFOnQPwoTZLAZyVjzorfBDwyAEE3oM4uLJvtp5tXLnERdJDTXoYT3U
         syRL0rve7LQ6xkh97xlVtQjSgcgcLVS3iPA0w2FxnaFubXwEzdQdL8giuBtbzn7T+2qf
         +MgeIOSotqDPILHlfFymi9C8dFy1iZd8IuJUpbcs1dyrP8mxIxVoFkRws5uOcA3NbbrS
         JI2ioOXrbuQbUqdjEv5K6da8BnsxDwZOc0i2xQzk8BPCG+y+xIqHrAa3FlhAMW3Ie6hH
         FLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706582628; x=1707187428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsYZ6yVYEECCNUdyAFVgFhLHU0fRZgVrwJIiGrZBwRQ=;
        b=dOxDPNPgxZBneMCrGKbm9cXN4qzlgAhnxL+KVOeeXuftzRp3dmb+Yu+u1/gbA+yff7
         sz+mAkOBtX8yph98jlfTop+qEX5yBPVGJmJ5brrP2wctb9h9PEzyGVDmNAau/WldwiS1
         hKlBCwYp5vjdbjGpBwzYDDFCYn/rXLGwEmudgQIkpvlxo/bODYEEqp/bEMmAillM0sHR
         AkvBE5bswgY/AAmhJdpNvnd1+5aEV+m9HlvsyQsOSzcVzEEr/F7LIZUGZ794u4Sj1H1X
         JRBvzCJdqvqsEGSm0Akfuzbx7NhwzZC0geJqxfZZ/fN6399ijSNRi0ILaPmHUy9BLxqy
         zGJg==
X-Gm-Message-State: AOJu0YwxAtVTObtXOy35e7aAsbLF4OiQ3jwPIZDhZk2VXgTYD7e9rqvP
	wMscMmGRH01ESXhBUN4fF9w33oFQl4Whd6YcvhhowspQGlnX+MXB4CSTfCvpdLGWBKJ++ookz4z
	v5Q==
X-Google-Smtp-Source: AGHT+IGX+ysHd/VvBfUFsqu5RntGNfuCCpeokAEq9RkvM2keCIle5Eqc+R7qvv7mjlaPwDVx+vi51D6pxyE=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:57c3:0:b0:5f9:4fa1:1a0b with SMTP id
 l186-20020a8157c3000000b005f94fa11a0bmr1673092ywb.0.1706582627867; Mon, 29
 Jan 2024 18:43:47 -0800 (PST)
Date: Mon, 29 Jan 2024 18:43:46 -0800
In-Reply-To: <ZbhGUYcxEaeOXPAi@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com> <e2d3ed9b5b6d67273c22671374daf7695c67709f.1706308737.git.gitgitgadget@gmail.com>
 <ZbhGUYcxEaeOXPAi@google.com>
Message-ID: <owlybk9335i5.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 01/10] trailer: prepare to expose functions as part of API
From: Linus Arver <linusa@google.com>
To: Josh Steadmon <steadmon@google.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Josh Steadmon <steadmon@google.com> writes:

> On 2024.01.26 22:38, Linus Arver via GitGitGadget wrote:
>> From: Linus Arver <linusa@google.com>
>> 
>> In the next patch, we will move "process_trailers" from trailer.c to
>> builtin/interpret-trailers.c. That move will necessitate the growth of
>> the trailer.h API, forcing us to expose some additional functions in
>> trailer.h.
>> 
>> Rename relevant functions so that they include the term "trailer" in
>> their name, so that clients of the API will be able to easily identify
>> them by their "trailer" moniker, just like all the other functions
>> already exposed by trailer.h.
>> 
>> The the opportunity to start putting trailer processions options (opts)
>
> Nitpick: typo in the commit message.
> s/The the opportunity/Take the opportunity/ ?

Ack, will update in reroll.
