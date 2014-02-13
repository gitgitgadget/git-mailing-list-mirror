From: Stefan Zager <szager@google.com>
Subject: Re: Make the git codebase thread-safe
Date: Thu, 13 Feb 2014 10:40:06 -0800
Message-ID: <CAHOQ7J-Fy3mcqx6hmtawBOPCRF9i7hvpZWvbHNVLoxhpG9Dzsw@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
	<52FBC9E5.6010609@gmail.com>
	<CAHOQ7J9A7zPV-kYe1WiQrVuWXXTNDVOQJEbnB+_jzEQ2_4Umxw@mail.gmail.com>
	<52FC820F.3030707@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stefan Zager <szager@chromium.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 13 19:40:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE1Cq-0007cE-7N
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 19:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbaBMSkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 13:40:09 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:60094 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaBMSkH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 13:40:07 -0500
Received: by mail-ob0-f170.google.com with SMTP id va2so12761953obc.29
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 10:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bzAJpP7L0sacq1oGA1UIFUp7oeTBooarb6h+/OFNwfw=;
        b=ktfS7UZmSipxFk1xZaZ7HcOr1G8x8ErWh9jIb0nuoY86UjG5P27/+uifUywQKTCTH+
         foJJHSW5zZ3VS6kKGtpwIohzeijZ7lRoGPaoPwCzwg/kMqWCOY9yaSV74kLRtEyKYPX5
         mu46Sdl0/u5tWqlRj9BHdXj5LBt6tDpY1TCXZoHQlH2urYGXV4/b4SOhnwWMRuXLWo69
         kLvNlnUQHvEHeU/ipdM16WuXq42pVqxgSjRwo4UbK3bT4EgqdMOMYDIWy5Z+GReKnJti
         acvc3nN5yv9QB23teU8n9EE+/5TJxyE2xFMv4wjWFYiePhzXWC1E0n6L/vxH98o+2GU3
         3uWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bzAJpP7L0sacq1oGA1UIFUp7oeTBooarb6h+/OFNwfw=;
        b=LGYfywSweuGbkhFdgC91hoTvLLZ9vWjZCkA1FkKkjuVNykwE1MncXVAg9+/ffbIV1a
         ng1NxKcgCAdXNhXFSGMg/UnHZ5ol01UJra1/C7X9zko3a3M8Sc7WfAydhzfdk/suFyRQ
         h4W8cAhgqt+WflVk4Od2vbWy6ucNtRF/NRUMeDF82qoK6iLyiPdYR5DMNGkrpvaKxXnQ
         0GiuLgTyhk0XLKzo+tMPnJlY7jWAXrdXSy5yWLc45gGdaDQa+zS8Zm+EbtiDb1sfmTY4
         kZ/SrJlXuBavZrC+Ocu9gg32Ekgz6fYxkf5CTuWkIWZl0iVScZYGjw7ueDna8EQwK71E
         2ZNQ==
X-Gm-Message-State: ALoCoQnJZVWjWIUec3gIO0+L0a1IYXHl6uQOXvlleUd4pmoVP7gTaelXY7Q/Tetlv0LUEqV194m2lFws01fErCMopUgbF0drlRgP+t5C+hGgBdn7rrTK9+r5bZid7gGKew4SdAdrO3nHHAOI1tPLhIHPJ74GVKvuOl/MGtt2aCuoql2yxBaC86WcqDIhuoEdT1OcIdgCJjxn
X-Received: by 10.60.119.73 with SMTP id ks9mr2470813oeb.45.1392316806820;
 Thu, 13 Feb 2014 10:40:06 -0800 (PST)
Received: by 10.182.233.201 with HTTP; Thu, 13 Feb 2014 10:40:06 -0800 (PST)
In-Reply-To: <52FC820F.3030707@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242071>

On Thu, Feb 13, 2014 at 12:27 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 2/12/2014 20:30, schrieb Stefan Zager:
>> On Wed, Feb 12, 2014 at 11:22 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
>>> Am 12.02.2014 19:37, schrieb Erik Faye-Lund:
>>>> ReOpenFile, that's fantastic. Thanks a lot!
>>>
>>> ...but should be loaded dynamically via GetProcAddress, or are we ready to drop XP support?
>>
>> Right, that is an issue.  From our perspective, it's well past time to
>> drop XP support.
>
> Not from mine.

All this really means is that the build config will test WIN_VER, and
there will need to be an additional binary distribution of msysgit for
newer Windows.
