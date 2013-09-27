From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Question about "git log --cherry"
Date: Fri, 27 Sep 2013 07:09:03 +0200
Message-ID: <CAC9WiBjykt5qj2sRtTK=VHp0B5x===7oqVP7VRC6BOdCMTn9yg@mail.gmail.com>
References: <CAC9WiBjLqdqSKgLv_M6FPx3a2J-+ZKAQnk9OGn3h5SfqSpiT3g@mail.gmail.com>
	<20130926202153.GC27238@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Sep 27 07:09:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPQIu-0007uj-Qe
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 07:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820Ab3I0FJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 01:09:05 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:47251 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab3I0FJD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 01:09:03 -0400
Received: by mail-vc0-f175.google.com with SMTP id ia10so1502862vcb.20
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 22:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kMcFyPyxtTBBWGNyuj95ZiQJ9WP5YJ5fi6S/CCZarPk=;
        b=rpkPVO7Eqtq265uEPZsRAkQ+hakVJ6Qt5w3ddRH30jGrJCBm7KVTqH1Jq4RylJff0c
         ggqcL3Z2l/3ozBqkTSMRH0A58aTCsCAENxS8L34kgZ2APQBhguqjAo8tc0F71ack7PuW
         9JustYNJJ4vCDX2jCaehuD6m3Ui4c0rmMBm3ILTW4LASNguis3PkMpUXsl5gigcVTHWV
         3hWLs9kns5TNyg/WAbIMx1RyMpvYEJ3uTo9O4DjqXKmgLs3X64SccaGBwgyVLoEGkca8
         VXdM4Wj3k7cypF592R9Q/26+u3rYOkF8Z/W4poSMa+fYkHVT5vlk9HbI/RWdpPdHpQRB
         lE6g==
X-Received: by 10.58.235.193 with SMTP id uo1mr4406311vec.6.1380258543090;
 Thu, 26 Sep 2013 22:09:03 -0700 (PDT)
Received: by 10.58.8.169 with HTTP; Thu, 26 Sep 2013 22:09:03 -0700 (PDT)
In-Reply-To: <20130926202153.GC27238@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235442>

Hi,

On Thu, Sep 26, 2013 at 10:21 PM, John Keeping <john@keeping.me.uk> wrote:
> On Thu, Sep 26, 2013 at 06:35:57PM +0200, Francis Moreau wrote:
>> I'm trying to use "git log --cherry ..." in order to display new, kept
>> and removed commits between two branches A and B.
>>
>> So commits which are only in B are considered new and should be marked
>> with '+'. Commits which are in both branches are marked with '=' but
>> only commit in branch B are shown. Eventually commits which are in A
>> but not in B anymore should be marked with '-'.
>>
>> So far I found this solution:
>>
>>   $ git log --cherry-mark --right-only A...B
>>   $ git log --cherry-pick  --left-only   A...B
>>
>> but I have to call twice git-log. This can be annoying since depending
>> on A and B, calling git-log can take time.
>>
>> Is there another option that I'm missing which would do the job but
>> with only one call to git-log ?
>
> Does this do what you want?
>
>     git log --cherry-mark --left-right A...B |
>     sed -e '/^commit / {
>         y/<>/-+/
>     }'

Nope because --left-right shows common commits (with '=' mark) that
belong to A *and* B, and I'd like to have only the ones in B.

Thanks
-- 
Francis
