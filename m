From: Josh Hagins <hagins.josh@gmail.com>
Subject: Re: [BUG] git commit --allow-empty-message -m '' fails
Date: Fri, 1 May 2015 22:44:56 -0400
Message-ID: <CANuW5x3oHmjAk=Ju6j+sxYnVp8mSs_V6t7YHm2S9=+0GgHnkDg@mail.gmail.com>
References: <CANuW5x0eKVAToG76rJr6+n-Fdg7E5c8mHb8NvnQUT2PBzxjjPQ@mail.gmail.com>
 <20150502010605.GA5634@peff.net> <CANuW5x1jeAY4KrOQez30mNp864abaYFyDDrdfM=NHCSosTSzkQ@mail.gmail.com>
 <20150502022924.GA587@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 02 04:45:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoNQr-0005mR-DO
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 04:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbbEBCp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 22:45:28 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36433 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbbEBCp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 22:45:27 -0400
Received: by ykep21 with SMTP id p21so21858206yke.3
        for <git@vger.kernel.org>; Fri, 01 May 2015 19:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=k3KU+8FUXDoNcOQXfL8tFUQwKEDMU+vMsDLSN4YkWoo=;
        b=0VGbjzwodCEaRvz0h2juz7+xmQlnxf4yY49GjP4jnyQO3BUedTRmljmDYEzNNIa0xf
         xLwxHBbpndXaepvbbXjnetUxunhUiOrsvsFkzd86wFTlMIZAXZ91o6AULz15BgnvXtp9
         Qu5tYFtsLF3vP6ba/Y9os8akDXp0cKQb+jq6QSGDqlnkWGB/Gd7ffrMTc61T61IVM2VM
         ageZI/kTX8hWgIgiU7vB9YT6txITnuGGczp6D8MH8K3hzWBNpJeeyUbHxahfmzTh4bII
         clKi7d6pSUHsXgyUxvn7MVbePOcB0pau3Vz4TElAl3CShgBzmzwCRnpnzmA7U1m7v6bc
         Oi1g==
X-Received: by 10.170.161.85 with SMTP id c82mr11677040ykd.122.1430534726939;
 Fri, 01 May 2015 19:45:26 -0700 (PDT)
Received: by 10.13.245.129 with HTTP; Fri, 1 May 2015 19:44:56 -0700 (PDT)
In-Reply-To: <20150502022924.GA587@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268212>

Turns out it was actually scm_breeze. It defines a git() bash function
and takes care of expanding arguments itself:

  https://github.com/ndbroadbent/scm_breeze/blob/master/lib/git/aliases.sh#L26

I'll open an issue there.

On Fri, May 1, 2015 at 10:29 PM, Jeff King <peff@peff.net> wrote:
> On Sat, May 02, 2015 at 01:25:45AM +0000, Josh Hagins wrote:
>
>> I have git aliased to hub, which must do some preprocessing before handing
>> the command off to git.
>>
>> That's likely the culprit, but I'm using iTerm as my terminal emulator,
>> which might be doing something tricky, but I doubt it. I'll open an issue
>> on hub's GitHub repo and see what I can find out.
>
> Ah, yeah, it's probably hub. Looks like it's fixed already there:
>
>   https://github.com/github/hub/pull/727
>
> -Peff



-- 
Josh Hagins
College of Engineering
Cornell University '14
(843) 847-6008
