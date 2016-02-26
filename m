From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [GSoC] Microproject :- Teaching git pull --rebase the
 --no-autostash flag
Date: Fri, 26 Feb 2016 19:51:42 +0800
Message-ID: <CACRoPnSoJvyvm4npw40AsgvPaviwb07akpiWtYWX3wTEME6wRA@mail.gmail.com>
References: <1456485825-21309-1-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 12:51:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZGw0-0003pj-KD
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 12:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbcBZLvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 06:51:44 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36833 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbcBZLvo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 06:51:44 -0500
Received: by mail-lb0-f179.google.com with SMTP id x1so45230304lbj.3
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 03:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=9AdMO7BPZMDrxKGhlL9rSJGYeNBnsUvNVArxLl+5lfE=;
        b=PGh80YCsvGc6ut4hvUb93U3VgpKDPTF+Dp+1HyF89LtwxOyNc0l+7XhJpAHWhu8cDa
         8rIUw7k9QeWWBkmcbyWvT8GU9ySnNhLFIpwRNN81OJXg6nYCm2kqnKQNLAaFvXzjAegR
         XfZtoo1PCP0Lv7dOZlh1gBp7ai0O2vonMPpXf2w3pV+MQa6T648aM4bpg9EK0XXUEZ6R
         Tmf/l6kh5ANfu4bMKTWPBje9/vMwMf4iHf5e1/hLoGCTfu1qYsUKCrnLT1B1uQTsvQik
         lN7CrJMc81ywewpHF041dzQ+1kjl2AqwUn2Ue6ay9j1f3aaHkvWL1NyfK7EfBlVUm+Ud
         56gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=9AdMO7BPZMDrxKGhlL9rSJGYeNBnsUvNVArxLl+5lfE=;
        b=S1X+jMIqkmHWEMidfyj04Fqrwo0J1jTRAeE446iOSGBJ3ul8ilqCCP1uDyE1amMExe
         L21FfD51UVyQSfiFKlzyjLeJn6PjyUQxn9R+6ODv0HVjX3/66payUffQc8rU0nabFxSt
         VAVnSFRUIVVZnMmhy+C8pkPfGPGIkCmN0KwZYKL/qiWoJ5JNtL5zaw2+e5j1vKBl7K7k
         TV7jIM9V4ZUBdOt//06SNqBm/1iLX8bCa4SqStySNCJ93IstgbaIObLByoF+erLwT1Mq
         LAygSTsTE1Ze4x+cAfZm1rdKLzFilsQrw7NMZMXfc+JUxFmhtH9viMvzdeeeAK25FhgR
         PrQg==
X-Gm-Message-State: AD7BkJL4F/6Zn1oH4JG+B3Addc7xt3TrpyG9DJjpzOMXyK16kdedhfK2uPuVr9mPgTAD0EdEu5k87Z2GqaSzrg==
X-Received: by 10.112.128.225 with SMTP id nr1mr450888lbb.101.1456487502307;
 Fri, 26 Feb 2016 03:51:42 -0800 (PST)
Received: by 10.112.207.68 with HTTP; Fri, 26 Feb 2016 03:51:42 -0800 (PST)
In-Reply-To: <1456485825-21309-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287571>

On Fri, Feb 26, 2016 at 7:23 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> With this patch, git pull --rebase will understand --no-autostash command line flag.
> This flag will override "rebase.autostash" configuration(if set) and leads to a
> failure if current working directory is dirty. If "rebase.autostash" is not configured
> and no flag is passed then by default command will die if directory is to be dirty, before
> even calling rebase.
>
> I am also thinking of adding a "--autostash" flag for git pull --rebase, which will
> override "rebase.autostash" configuration(if set false) and will pass --autostash to
> git rebase. I would like to know your opinion on this option.

That was the point of the microproject ;-). --[no-]autostash means
both --autostash and --no-autostash.

Thanks,
Paul
