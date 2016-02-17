From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 02/12] ref-filter: use strbuf_split_str_omit_term()
Date: Wed, 17 Feb 2016 12:39:38 -0500
Message-ID: <CAPig+cTrh4u7vgQRXOT0a-5St2a6TV4qfhOMCVSetbQD0kGTrQ@mail.gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
	<1455649215-23260-3-git-send-email-Karthik.188@gmail.com>
	<20160216192231.GA16567@sigill.intra.peff.net>
	<CAPig+cTiwHs+dD+jqAp8SNkwjQ2OzDsC8yopRgF7gctrGi5uUw@mail.gmail.com>
	<20160216204954.GC27484@sigill.intra.peff.net>
	<CAPig+cQDs35Uirm5cG552tR8iCFOstNJoOzLCZiXCgnq+g7MRQ@mail.gmail.com>
	<CAOLa=ZQO065j5VfJabbV6jww5Z2f3jbaRQDfDcG9NY4x2txrFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 18:39:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW64m-0002hw-GT
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 18:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965268AbcBQRjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 12:39:40 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34171 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965212AbcBQRjj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 12:39:39 -0500
Received: by mail-vk0-f46.google.com with SMTP id e185so21196603vkb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 09:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=g/FpOjiSoPH3OyhfOMW2MJVpcoTym9QWdi9OccX6hb4=;
        b=hFZmqYB6Rcvz4tXtYqFHJgDfVZ+ERDEFDt6hR1IcEg95AORH7U6e3ARS4EBb77KXar
         E2rBBM2a3C6suGjcw9Yri8SRydkj26GIBo5bPc/yqkiYaJiXMBiZ88ZoEHNO6bz0rwSy
         jybGMKAT8x3iBOWyggcX4B9eIY1iy5tm8rpGh6Y9yrIuYwESIMJI4x8uvfUmw8qGQnK2
         UYAssVt99H+rLpWFbo141TgqP3ZqLKORL6ytxb5kuiBcqn8VJ5LRrEUsOfJ9G8QD3/pZ
         /4M4AuAXBt7O+jhGtTIkEnaLw9yskXCTU49J8xRrcDQT/YFXaDTBsztmJy1e4UYX8zLY
         JvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=g/FpOjiSoPH3OyhfOMW2MJVpcoTym9QWdi9OccX6hb4=;
        b=YAOTpOYuwDyEumb52FtIeacaNBdDgOLibbctmFeBOhyBY1qQYBaZ1W0fgy4v7zyjtv
         9zrSksjJKJc4ij36XbjQkkjnHcpK+ryWSlXqA403geo4mqcYD1nAjxXonM+4WjeZwG3e
         UPxRRivFJQs3SoKdCgKdzAW4Znkgb32l1G9wd6qK3xceyiiwCpyCdryEmA4WdMNTMGeb
         plWyn/1tCNFnWJHd2ROQcewdypvHfDLEDrAHaUIE+fvAozw6NWOiRkjq7vA25Vk9eGoK
         Q7qGzwJojKYXKvQ0uFTV74aVAm8IvyHK7jyZb7ZeTgNWT0xK7c7ICIuLxB4oT7Ig0Khl
         Fmcw==
X-Gm-Message-State: AG10YOT2f7cHYiSTCIaVS7SnW27Iu9q9cvqzV35RTfl+BEdfCX4VZTP0G9I0lacdSBeunWZCiYvrqgbIPSnZPg==
X-Received: by 10.31.164.78 with SMTP id n75mr2418861vke.14.1455730778681;
 Wed, 17 Feb 2016 09:39:38 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 17 Feb 2016 09:39:38 -0800 (PST)
In-Reply-To: <CAOLa=ZQO065j5VfJabbV6jww5Z2f3jbaRQDfDcG9NY4x2txrFQ@mail.gmail.com>
X-Google-Sender-Auth: qfLdW8RoFARNuF3PwurmaAws1WY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286514>

On Wed, Feb 17, 2016 at 12:04 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Wed, Feb 17, 2016 at 2:39 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> My initial reaction was negative due to the heavy review burden this
>> series has demanded thus far, however, my mind was changing even as I
>> composed the above response. [...]
>>
>> So, I think I'm fine with it, if Karthik is game.
>
> Sounds good to me.
>
> I just read the conversation between Jeff, Junio and You about the whitespace
> counter-argument and I think its good to go ahead with v6 with Jeff's suggested
> change.
>
> Since he's already pushed the changes on top of my changes to:
>  git://github.com/peff/git.git jk/tweaked-ref-filter
> I'll just have a look and push that to the list as v6.

I reviewed the entire series again, including Peff's changes, so this
entire series is:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Karthik, feel free to include my Reviewed-by: in all the patches
(including Peff's) when you post v6.

Thanks.
