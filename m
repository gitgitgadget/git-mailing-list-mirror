From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] send-email: add series-cc-cmd option
Date: Tue, 13 Nov 2012 00:37:38 +0100
Message-ID: <CAMP44s2EyMcYHYGvxZnj90qD5ms2YZ5O6gXv_TTES0H72vUm0g@mail.gmail.com>
References: <1352653463-1923-1-git-send-email-felipe.contreras@gmail.com>
	<1352653463-1923-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mRKznNN7750h=k6aE3OJ7hBLVC-G51gEYi2+NuYjPWrQ@mail.gmail.com>
	<1352760759.18715.7.camel@joe-AO722>
	<CAMP44s0B42yt8eugYSjYweoX8WOXXF1f-0N-5FuUyrY5rgCiow@mail.gmail.com>
	<1352761982.18715.20.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Pascal Obry <pascal@obry.net>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 00:37:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY3Zh-0005nW-SP
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 00:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292Ab2KLXhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 18:37:40 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:61457 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab2KLXhj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 18:37:39 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so6848361oag.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 15:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=d0o6T/UrwD18zQULcHPYo7ziL1m15SWXXV2/HCHBGfQ=;
        b=srtCfsr5aESai43qNUfGdSlUIqNSnsHRUT6LmEnC67pGekR7Oml/n+rOMssMPwaSyp
         K/ZaRAr472XS+qm205Usfo+DvPL/KkbJPuI+oexMZGVy0gEORacqXlLpZ/8sM8PscHS8
         hs+XFK74Lx9/d4opS6YiWEJUVfiG9d+lDLkzWkPOUui8dfLcUrs9rsHyunbgZ50POUJ5
         tDWyD8lJbyQTXR7kD+VuDhKLR0X7hoPBK8aCkL9FKWd2Tp/1b58QIce9igbn0792yTtK
         ixzUUe6TatE+9eZ4dYJsiEPnKdWIrvfgBkbpJr0/iJcePJoRDZS/f9sVynz+Hum4h7f4
         RMsQ==
Received: by 10.182.245.20 with SMTP id xk20mr16615796obc.89.1352763458599;
 Mon, 12 Nov 2012 15:37:38 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 15:37:38 -0800 (PST)
In-Reply-To: <1352761982.18715.20.camel@joe-AO722>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209547>

On Tue, Nov 13, 2012 at 12:13 AM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2012-11-13 at 00:03 +0100, Felipe Contreras wrote:
>> On Mon, Nov 12, 2012 at 11:52 PM, Joe Perches <joe@perches.com> wrote:
>> > On Tue, 2012-11-13 at 03:21 +0530, Ramkumar Ramachandra wrote:
>> >> Felipe Contreras wrote:
>> >> > cc-cmd is only per-file, and many times receipients get lost without
>> >> > seing the full patch series.
>> >>
>> >> s/seing/seeing
>> >>
>> >> > [...]
>> >>
>> >> Looks good otherwise.
>> >
>> > s/receipients/recipients/ too
>> >
>> > Practically this is ok but I think it's unnecessary.
>> >
>> > Output from git format-patch is always in a single
>> > directory.
>>
>> A temporary directory.
>>
>> > My work flow is to use a script for --to and --cc
>> > lines that can be set to emit the same addresses for
>> > all files in a patch series or generate different
>> > addresses per patch file.
>>
>> For --to-cmd and --cc-cmd? So basically you check the dirname of the
>> argument passed?
>
> yes. basename and dirname

Well, the basename is irrelevant, because you don't care witch
particular patch is being sent, you are going to process all of them
every time.

>> While that works, it means you have to run the same command multiple
>> times, one for each mail.
>
> Shrug.  it's not a generally significant cost.

It is when you use 'git blame' and there's a lot of history:

% time git cc-cmd -1 1266686
Peter Krefting <peter@softwolves.pp.se>
junio
Tran Ngoc Quan <vnwildman@gmail.com>
Jiang Xin <worldhello.net@gmail.com>
git cc-cmd -1 1266686  0.23s user 0.16s system 1% cpu 19.991 total

> The script could also output the addresses to yet another file.

Which would be even more hacky.

>> If the command is using something expensive such as 'git blame' and
>> you have many patches, this is particularly bad. Also, it's not
>> elegant :)
>
> Elegant is a beholder viewpoint.

You think a solution that runs the same instructions multiple times
unnecessarily is elegant? All right.

-- 
Felipe Contreras
