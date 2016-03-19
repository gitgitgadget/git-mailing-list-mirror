From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [PATCH/GSoC] pull: implement --[no-]autostash for usage when
 rebasing
Date: Sat, 19 Mar 2016 19:53:57 +0530
Message-ID: <56ED60FD.1030005@gmail.com>
References: <1458395862-5113-1-git-send-email-chirayudesai1@gmail.com>
 <CAJj6+1ECzKw9jnO1wGZqSyrJ0V=G3TzzE5YKhSKzVO1kqXpXPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Chirayu Desai <chirayudesai1@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 15:24:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahHnW-00077c-JI
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 15:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbcCSOYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 10:24:05 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34370 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbcCSOYC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 10:24:02 -0400
Received: by mail-pf0-f175.google.com with SMTP id x3so206610368pfb.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=xvv0pBXXZ51K+C/dv1Wtnoa27meWSpcNuS5tIhe2QQU=;
        b=UlgRchI2cuwAfJ8S5RUyNnU2mnuQsUMLACAjW35/4JrkR1OzUM3neCEwwO25JjSf5a
         XnjZ+MCe2YsdhvJyNPd1p3pl33Uitji1KR0bFMkQOf5GIpyvyZ4HlR3ue4ZWZFmRXDYA
         tYsvwo6U/aOIQrnYsGuVFjvgp84RlqHuBBGO3Zqb3yBZhhuHdSk5Fd/B0P2vqWOB09AS
         1+PftOGrNMDVmbidEED9KovuGp68iZtXJ5+YoqXXB/xItoWmx4fGxRq4zMyG9KaJ7zu6
         XQZgUkfsFIa8zJhX9jORwiSHSMM++jNOg+gIY6ixyG3ONfnb8agjP6X9lA6nseEBAwoq
         aIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=xvv0pBXXZ51K+C/dv1Wtnoa27meWSpcNuS5tIhe2QQU=;
        b=UCzg0rXsuod1izSd8ce15VNPaJIHAinW9HpNJNuOvxLJdTnJ1zQHMuwQyvu1x29y7s
         VO+i5ueI+NMZyRy+IldLkL1qYRR3WdcOVE1aahPHoPuLMXwBOY+u7BxolA9IyAwOAVOw
         EzlHM1RIghY8q4XR1e+L4PokddGhqA2zWb92LuqgBY3H6WVxqnWP8Trx/CyBHnrPThen
         eEbBR48tCF+rDc4DOpjiesPOOJo19rfqWW8pG9d0N8Jxn/+CsJa3bkc/8fzlTnbLOh7H
         GAuGmsg06y8Uq/SMTb0TYcoC+ryw0ptfkul+xkqV3+wK/7Fjq/VdSQa2d0XfmR/W+x2U
         DA5g==
X-Gm-Message-State: AD7BkJI3O2Tr9XVvJgGmkxKoGHPmy5K69ALrcYUHLdTCp+h6NDbaVo1CI7Y+ubzaD0jlSQ==
X-Received: by 10.98.93.155 with SMTP id n27mr31715076pfj.88.1458397441335;
        Sat, 19 Mar 2016 07:24:01 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.159.75])
        by smtp.gmail.com with ESMTPSA id r68sm28553113pfb.51.2016.03.19.07.23.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Mar 2016 07:24:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CAJj6+1ECzKw9jnO1wGZqSyrJ0V=G3TzzE5YKhSKzVO1kqXpXPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289308>


On Saturday 19 March 2016 07:38 PM, Chirayu Desai wrote:
> Hello everyone,
>
> I want to participate in GSoC, and this is my microproject to get familiar
> with git development.
>
> I am a first year student, enrolled in the Computer Engineering program at
> Silver Oak College of Engineering and Technology, Ahmedabad, India.
> I have worked on open source software in the past, and have used git quite
> a bit during that time. I'll include more details in my proposal, which
> I'll send here when done.
> I understand that this might be a bit late to get started, and I'll try my
> best to get this patch in a good state and get the proposal ready ASAP.
>
> As for the change, I spent a lot more time trying to get the test right
> than doing the actual change, most of it trying to get familiar with the
> test framework and figuring out what to use. It didn't take much time
> though, overall.
>
> I'm adding a few inline comments as I have a few questions.
Hi,

Thanks for the patch. I believe there already is work in progress on this (See
[1] and [2]). You may want to try another microproject. It may also be a good
idea to mention which GSoC project idea you would like to work on, as there
already may be other proposals on their way.


Thanks and regards,
Sidhant Sharma

[1] http://thread.gmane.org/gmane.comp.version-control.git/287568/focus=287569
[2] http://thread.gmane.org/gmane.comp.version-control.git/289127/focus=289222
