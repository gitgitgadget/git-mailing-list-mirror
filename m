Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E003719884A
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529836; cv=none; b=c6tDt1gkpqE8eyHaZ5jPN/OVgMVftBG1q5flyRBQ0WrD3CtN3VpJBiLkpG1lDkhg33QeICHSY+Gw7FbGfHhBaJjgbb0fg24158iMWDa7W5cFhAvZdX0PQKO5BkO2BkH6ozK9wiEeAOF7ZmGaw83cDq0s9rWxhTD3nlKr39sZLsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529836; c=relaxed/simple;
	bh=yWqhVmgZw5mkev0IDPS7hNC+OdGnvM2sPPjozP6hM8I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WV6R7HWin952gSyucCGC+5OxBJSZ2VFtuqv5t/MXQjgbbDAnKzONZnlp/DyGi1C36pEmU39wUKtPn0nYiywYjx83HJXvLprww0E+TaZZxDn3e72bLvkqZwY6Pt1e1gVgjhgB6flaDK8X3bvGkdijQEaAxiBR9VQUnVXo4JxZTnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUk9QnZP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUk9QnZP"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso55929366b.0
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 02:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725529833; x=1726134633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yWqhVmgZw5mkev0IDPS7hNC+OdGnvM2sPPjozP6hM8I=;
        b=PUk9QnZPT8bjJs/gCC5v91VoQi6BSLJfVC9bGBUBuM2TGsZFzUb95NH9pRoSffhvUB
         pEDNlREInRTHX5V9McJfXJGmGzNtAn9MdEcm1hALUNx8c9nAKQIqtmaeFrMh2tp6IF5N
         eF8lRqtxylKClpuVPWRdS6J1YyCC2whjoYILku03hFHcp0moTnjZzTw3BH9psbCx9031
         aIAzP5mZl98mSMBNvu7tghjJBjHbazTvZ4xxoDrpbDjUyrzA+T+HBCw2JlhIMkwsKtlc
         VrHboRkgGArUn76+Fhldy/Un3m+s1agrr+hSO1FOFcwnJXzBpBkHI9RY8BBR2Yjz+w0+
         LyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725529833; x=1726134633;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWqhVmgZw5mkev0IDPS7hNC+OdGnvM2sPPjozP6hM8I=;
        b=LtKPhmhFNoBB5Nwi7Ov/Mq5d2jSk+TA53L7vJhW+j9Qvl7Ddgfb1gv7cmlf2J0rBvg
         5L4IPqGeNhcvraBd45f17Q0/Z3UmffMczGOONQfWDoAHtUCUVga/bmMMjfAr4gJBGbPa
         x8rm8IsD/d07GW1PZraJ0ooYY3wewUbeIfuaQ7pcN869RTCSy0MT4AtOUheZ59Igo76S
         2/sJpOw6mLQySQAU7F2qtOzZpeeh/V96igNnMggLBwE8FwTTv2sIV6UkUvjKNHT6SY49
         Eoy+84Ztd6XSChWTYqEiGBopXFNKVfk90qJvyHpQqFfTbfvp/ZTS0zcSjlLp5gSfPIIc
         rHiA==
X-Gm-Message-State: AOJu0YwtcYHDbDDDsBZNaVENd31PGDY+a1jlq9mmsl5OLI7qXHtcwy/9
	EbvrfyT60JnzOypE/vvXswP3mi9lp7W8GKmPBjHn7KV4ZYsBAByAa8c29rZtLE6N/xScKHmykoy
	vZohMuhfcsrHjlqHXPwPfuXWH4EBnrUnR
X-Google-Smtp-Source: AGHT+IHcAYJjgYajb/MbFG0EKTtaFsHBX4rRc/dDOhJkwGXX7guqI2DI0xsSjL0eHSRjAIdpv37b6nqRXfMKPdb5yXg=
X-Received: by 2002:a17:906:6a1a:b0:a75:7a8:d70c with SMTP id
 a640c23a62f3a-a8a42fb15e5mr526661566b.4.1725529831787; Thu, 05 Sep 2024
 02:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 5 Sep 2024 11:50:20 +0200
Message-ID: <CAP8UFD10B4ROEjvP7MPygALuUFgyBQqZVhAjgSUris3cdiowsQ@mail.gmail.com>
Subject: [ANNOUNCE] Outreachy mentor sign-up deadline is Wednesday September
 11th at 4pm UTC
To: git <git@vger.kernel.org>
Cc: Git at SFC <git@sfconservancy.org>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Tilda Udufo - Outreachy Organizer <organizers@outreachy.org>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

I signed up for Git as a mentoring community in the Outreachy December
2024 internship cohort. The deadline was September 6th at 4pm UTC and
I think we will be able to change our mind later if we decide to not
participate for some reason. So it was better to just sign-up.

I have also added a project with the title: "Finish adding a
'os-version' capability to Git protocol v2" that I am willing to
mentor or co-mentor. I think it's possible to add more projects and to
remove this one if we find better ones.

The mentor sign-up deadline is very soon too: Wednesday September 11th
at 4pm UTC

So if you are interested in mentoring please sign-up. I think
co-mentors might be able to sign-up later but I am not sure.

Tilda, please correct me if I am wrong.

Also please let us know if some companies might be willing to sponsor
an Outreachy intern or Outreachy itself. Outreachy is part of the
Software Freedom Conservancy (https://sfconservancy.org/) like the Git
project.

See: https://www.outreachy.org/communities/cfp/git/

Thanks,
Christian.
