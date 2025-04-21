Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8541E5B62
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257333; cv=none; b=SLiYhVIZ0+BaFqhjyCJ1/L53/h44flD5zvUULeTEydpbrb8jBZ358QW+h2HqtCBwNphAM2x3ZapPWlq6g86lPsD3k2dc8VRdDfITz8zLHWvuz9fGoJierXEB1BGZ7Ahkpr7QzBotTxHCIy5JSfFeQyCEa5vGuwFlfTGAK+w7HQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257333; c=relaxed/simple;
	bh=mx+xq2XFXBMXfdzkbU3vos/E1x5sN1EVyUJcXwMsDtw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rOIgWitms5TltPe5B7KJF/nqmk/PnHLM0LWhadYSFIgd0Lm00aXCm4sR+kmfsFt1/tO8XAwra+xN8e2r+4wptm4oqVHDW/W2y2rsuyDj4h+3Imauxf1xkpTUWYcWqLJQigyh7h50VTnIvNkkC6xDIxDFHcLny+UfNT+DZNxiwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ThwHUqUF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DR9xRDXP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ThwHUqUF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DR9xRDXP"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A62AC1140195;
	Mon, 21 Apr 2025 13:42:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 21 Apr 2025 13:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745257328; x=1745343728; bh=O082w2g1aF
	gAPmoKhHrrqQdHcQ/aZt7YIW7Yv47lEEg=; b=ThwHUqUFaMQbfYFlxLHhDxPBB+
	ptCiC64P0CnRxKpijxXujBMDZMTkxIFvRue2fYaQelOgI/EicwuoiKlAzc5lznOo
	YmraZ4rWmFwvaY1+lhb/svmLvGOK0odV+QAAcIClcc73y9BKaXIOzm6DIgy7Fski
	e8xORC38mzfotMAq6PWD2BcXL8PjpmcneW87t587OwEkGcp4QTBB4FT7mAjjxioh
	6LRL9ogOlIQt8SoRr7+bhlbAKv4s21MHh6rY9UimzJUb6vrnqaeIDNDcQkVVrv92
	ncf2qw+hRyFMagJDDwWjFJ3bjBH1C/oGQ+KipCRGVKXcKCkjVaAMaihVIrzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745257328; x=1745343728; bh=O082w2g1aFgAPmoKhHrrqQdHcQ/aZt7YIW7
	Yv47lEEg=; b=DR9xRDXP2+bixXEjarzEDhkzmy3hlnpw4WbS0MAh/HV8Ccl2PHA
	UfCGv3eMUwAdXUmkFGuVKU63EkZ6KTwUN9k+LESt16A3N4Y692+1nA/mbxA7lNLZ
	qjjnDDLa07Bwc1HVqrA4zwXKfdRiK8w49/RVDGx3NJZZ4wNsltG21JnpIw4jn5zB
	C57ektQb/z9aweQSdONQq2qXdUmdYc3cK3fCb00R8j1VT0Z9HJ1dix8E99Ht5Ki8
	AU+b+LHxSx/DWwIKaUuGdtzvw34liCGGEvvMYQsO2LJrPp+p56Zw4FmxO9Td+hKC
	gOcDg3pDVlEszTgdi2VkKGBDmNzkQ4A6otw==
X-ME-Sender: <xms:cIMGaJ5E2y13PfqjW0cLm8bZDe22lXcQU7LaPqqZwSlux8zzpDRs-w>
    <xme:cIMGaG5HoBO8Ci4BdBNYR_ESzhGclOSfvN_xI30MvL7PQ9afN8sZQuc1mWKt1EGW3
    JvWACKYaWMdtOeU2Q>
X-ME-Received: <xmr:cIMGaAeWM5BtTBfUn0W8CclHD4HyvxPA2uF9iiTPp0-KVjb8vuDLPpyvim8_Tsa7haCBmJLQSgLeC9NahgQl_VU_IJU0UwhD6Bkn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedugeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheplefhkeehvdegledvffehgeejfeekhfdt
    uefgjeeuieegjedvhfevgfduffeiiedvnecuffhomhgrihhnpehgtgdrtgifpdhmrghnph
    grghgviidrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhshhhihhgvihhnrhhitghhshes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cIMGaCKXGGS6gtT3oOmZlQVvCxO4H0KMgK7lbVRTXzVodBgFmq4guQ>
    <xmx:cIMGaNKp3MH7h905KqL0bK4LpDgs7hNhNGKvAYZlpia1dOZg7KQRtg>
    <xmx:cIMGaLyWBfYa4jn2sWuIRlC41seNVCToRdZ8dniYM0s1QtnZH40kwg>
    <xmx:cIMGaJKnuzUTA1JhSqqiFkqvUg82-u-e_dnog7swHn2h9T5lZOAXcw>
    <xmx:cIMGaIUlvQxtadkCjhQLl_V0h2hGM5Tj9k1vS5-V99ei-nIMw4nArb2J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 13:42:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Heinrichs <joshiheinrichs@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] maintenance: fix launchctl calendar intervals
In-Reply-To: <20250421054633.231069-2-joshiheinrichs@gmail.com> (Josh
	Heinrichs's message of "Sun, 20 Apr 2025 23:46:33 -0600")
References: <20250421054633.231069-1-joshiheinrichs@gmail.com>
	<20250421054633.231069-2-joshiheinrichs@gmail.com>
Date: Mon, 21 Apr 2025 10:42:06 -0700
Message-ID: <xmqq1ptl76oh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Heinrichs <joshiheinrichs@gmail.com> writes:

> When using the launchctl scheduler, the weekly job runs daily, and the
> daily job runs on the first six days of each month. This appears to be
> due to specifying "Day" in the calendar intervals, which according to
> launchd.plist(5) is for specifying days of the month rather than days of
> the week. The behaviour of running a job on the 0th day is undocumented,
> but in my testing appears to be the same as not specifying "Day" in the
> calendar interval, in which case the job will run daily.
>
> Use "Weekday" in the calendar intervals, which is the correct way to
> schedule jobs to run on specific days of the week.
>
> Signed-off-by: Josh Heinrichs <joshiheinrichs@gmail.com>
> ---

With a bit wider context, the patch looks like so.  As I do not use
macOS or launchctl myself, my guess may be way off but please bear
with me.

>  builtin/gc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git i/builtin/gc.c w/builtin/gc.c
> index 99431fd467..cc13baa3bd 100644
> --- i/builtin/gc.c
> +++ w/builtin/gc.c
> @@ -2072,24 +2072,24 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
>  		for (i = 1; i <= 23; i++)
>  			strbuf_addf(&plist, repeat, i, minute);
>  		break;
>  
>  	case SCHEDULE_DAILY:
>  		repeat = "<dict>\n"
> -			 "<key>Day</key><integer>%d</integer>\n"
> +			 "<key>Weekday</key><integer>%d</integer>\n"
>  			 "<key>Hour</key><integer>0</integer>\n"
>  			 "<key>Minute</key><integer>%d</integer>\n"
>  			 "</dict>\n";
>  		for (i = 1; i <= 6; i++)
>  			strbuf_addf(&plist, repeat, i, minute);
>  		break;

So we used to say that "we want the task to run on days 1 thru 6 (6
days in total) of a month at certain minute of the day past
midnight", which clearly not how people think of "daily" task.

Updated one specifies the task to run on day 1 (Monday) thru 6
(Saturday) of a week.  The manual page seems to say that day 0 and
day 7 of a week are both Sundays.

  https://www.manpagez.com/man/5/launchd.plist/ look for
  StartCalendarInterval to read about Day and Weekday.

Curious that day 7/0 are ignored.  Other schedulers are somewhat
inconsistent but generally agree, so I won't worry about changing it
in this patch.  schtasks_schedule_task() excludes Sundays, and
crontab_update_schedule() says that it wants to run daily scheduled
tasks on day 1-6.  systemd_timer_write_timer_file() however seems to
say that it wants to run things on Tue..Sun (excluding Mondays),
which may want to be corrected, I dunno.


>  	case SCHEDULE_WEEKLY:
>  		strbuf_addf(&plist,
>  			    "<dict>\n"
> -			    "<key>Day</key><integer>0</integer>\n"
> +			    "<key>Weekday</key><integer>0</integer>\n"
>  			    "<key>Hour</key><integer>0</integer>\n"
>  			    "<key>Minute</key><integer>%d</integer>\n"
>  			    "</dict>\n",
>  			    minute);
>  		break;

This one used to say "run on 0th day of the month", but now it says
"run on 0th day of the week", which is on Sundays.  Makes sense.

Will queue.  Thanks.
