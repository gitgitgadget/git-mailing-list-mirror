Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B54A10A01
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090690; cv=none; b=B1D9EzfHhmRwIlKgRh3/F/w0lnwpgBuYY/3bfYVTJk4qhEA7EuZLzZPZbHye3EOkelqUPJIRM2dpqHkH0G8DVZzSdF2YJjB1tUlLBApgKoZI9Om25iPXNYQ214dmZU7Y3kFEr+dfc9XRJ7gxoj+unm8VL7iHRr5jOtyb++ajcuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090690; c=relaxed/simple;
	bh=BURnpgo6xiiYw+JH7EvMuPWOJEMvdYsTk7pIvP4Pzug=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VW+YdAvOkFi0NdcfKn5t7w84lPvXkOrE5FEXXlrKa+TLSrJYM8hKRrYxmazf6aRAH3wgsNDpG9qLkLKmc8WAsLY5yBu5FOfo+CjjijfSt4CFuX4ASEelYED3AhDO+DMVl6yT+VSrTy7PZcwYEN56kjdBdUC6ufv6h25UtAb9yIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSzRysXd; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSzRysXd"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d46dd8b0b8so23263771fa.2
        for <git@vger.kernel.org>; Thu, 21 Mar 2024 23:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711090686; x=1711695486; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BURnpgo6xiiYw+JH7EvMuPWOJEMvdYsTk7pIvP4Pzug=;
        b=gSzRysXdc52rjo3kAtZQA8XjWKzMQ75LDtdysK3mWJJY783nCnFkNCkWCctmDc/PN3
         axa1nDOeKB9rxzrru0hiNd67N2xAp99Qv46zI2qadNNMgm1BjPXLQ4LpE8N6LQM7uF//
         BboaOyKFa3NWt+UdqlnU8tmWnNg7BYl1I2kI4bu5OIiss5C/CQFJbmPTBRYhMgO88C7U
         2P3jMJqfXwggqHgs3AN+9hr02vxkfyNkxFffh9WxYPMHgqeIsozS+jX7H3BsqszZF3Lj
         HJVdRoOTf7Thss9TIgjMUbLdeeVWAGvgKOhUJC03oAnJgewAfbeLetj129cFw2KvvHbI
         vS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711090686; x=1711695486;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BURnpgo6xiiYw+JH7EvMuPWOJEMvdYsTk7pIvP4Pzug=;
        b=JCrLehXiwmAM6BhF4d7iI/N19EUKxaAmUE5l32unbsZFSu9u96mS5akkFWi3Y9gTW7
         ekuSfspsnTKAdHOjywF1WwLg3vmr0zIE8WNUZCvOw5FlD6W5dPLCKTDVHYRo2pm0/lE3
         uvFYHo8gOqDVHbRHjliW297aaJGx32kZ4Cubd0Pa5CH0dbJr+3A8ccHghPmsoZmukrF1
         268ZJJB9bjhl8V60nvI/S2yocoDMz3EYWpmny/RXp0/KHQMDkmjFgH0EnYNTUH9waWWZ
         Hk7uoKXXJGe6p8prQst5ch/bvVtk0gwrUQZUGGzP2DkgOrOt1CwgqLjTClPLKSFyjQ/J
         HzVg==
X-Gm-Message-State: AOJu0Ywm0PBcJsjAz3TBNAFqYTiPg1FuxjpcO5xr3/T7yFtdLo2jeVEU
	biY/cqegpTL/Lg0YXem/RH2JI4GTDiD8eVeOB5gTFHYr17MVmkoRclROU+ay3wopa9V+pbjs+8k
	1q67vwXcoMEmE9UwVqy/A+N2JxdIvp57dfPHNeA==
X-Google-Smtp-Source: AGHT+IGwneGqW8Q/VN8XqepUCL2Iu4wEXchyKgFhfAqijpoG98Ddc3Q+dyCYinF12fwFliCxDcbtis3eHSAWvIFcjrQ=
X-Received: by 2002:a2e:80d8:0:b0:2d6:a9be:19e with SMTP id
 r24-20020a2e80d8000000b002d6a9be019emr1100279ljg.46.1711090685912; Thu, 21
 Mar 2024 23:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aishwarya Narayanan <aishnana.03@gmail.com>
Date: Fri, 22 Mar 2024 12:27:59 +0530
Message-ID: <CAHCXyj3U69qyhYewOLY9hN2rvi_5ZuSxQEBJbDxrKefm9MzVWg@mail.gmail.com>
Subject: GSoC 2024
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Git Organization,

I hope this email finds you well. I am reaching out regarding a
Request for Assistance with Microproject aimed at improving the
integration test scripts in the Git project by avoiding the
suppression of Git exit codes. As a beginner, I would greatly
appreciate your guidance on how to approach this task effectively.

Here's a breakdown of the microproject and how I plan to tackle it as
a beginner:

Understanding the Problem:

The Git project utilizes Shell scripts for integration testing to
ensure software stability.
It's crucial to avoid suppressing the exit codes of Git commands in
these scripts, as it may lead to errors going unnoticed.

Identifying Problematic Patterns:

I will examine the integration test scripts located in the t directory
of the Git project.
Specifically, I will search for instances where Git commands are piped
into other commands, or where command substitution is used with Git
commands.

Learning from Examples:

I will refer to the provided examples of bad and good practices to
understand what to look for and how to correct it.
Understanding why certain practices are bad and others are good will
help me grasp the underlying concepts better.

Applying Correct Practices:

When I identify instances of suppressed exit codes, I will modify the
scripts to adhere to the good practices outlined.
This may involve replacing problematic commands with alternatives that
properly handle Git exit codes.

Validation and Documentation:

After making modifications, I will ensure that the scripts still
function correctly by running the affected integration tests.
I will document the changes made and provide explanations for why
certain commands were modified. This documentation will aid in
understanding the improvements made to the test suite.

Seeking Feedback:

Once the changes are implemented, I will seek feedback from mentors or
collaborators to ensure that the modifications are in line with
project standards.

I would greatly appreciate any insights or advice you can offer to
help me navigate through this microproject effectively. Additionally,
if you could provide guidance on where to find another test script
similar to the one referenced in commit c6f44e1da5, it would be
immensely helpful.

Thank you very much for your time and assistance. I look forward to
your guidance.

Best regards,
Aishwarya Narayanan
