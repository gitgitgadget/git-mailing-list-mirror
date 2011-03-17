From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Sharing a massive distributed merge
Date: Thu, 17 Mar 2011 13:58:20 -0400
Message-ID: <AANLkTinQYjq=NiHK6MK0tA5AEE7=NCg8kthJT9Xz=xNk@mail.gmail.com>
References: <4D8119BE.2090208@workspacewhiz.com> <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com>
 <20110317063816.GD11931@sigill.intra.peff.net> <AANLkTimTKbKWmf80u-kgnvQ2gT8hx2KTm6HGbWejt3eg@mail.gmail.com>
 <AANLkTi=25=99Gh9hGUxEuvB9Xvv=f8uJxThaMxaAQKbq@mail.gmail.com> <AANLkTikfp_d00zrtU8kuvyUk81gGMkOXEVDNXr-hRhBU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 18:58:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0HTO-0006xS-AK
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 18:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967Ab1CQR6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 13:58:52 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62840 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975Ab1CQR6u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 13:58:50 -0400
Received: by iyb26 with SMTP id 26so3070840iyb.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=8HrERyHMBKTNPbFtO6hBu3JNwxxs/zewEMqor2FCVMs=;
        b=uDHhYwmUV84PEPorbZF2J7afU6OHleM3MxtD9Ss/hzopbpUY01B/+Iz20bGr4BHDIC
         RHu8l79MJHPBbfL4gs3yb9DKfHvTrldwoht1jElWD/pIywOO62pf9ei2Iqjs8ekavmkq
         56ZnhglBOnNbzBb9T6r+y2eRoge+t4CURpZRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=BEWUNDYbcCBSbeGNFYRUbfzZ7zR6Ds1JlGBBha9Evfx/psJnZZAB1FJHfWPWvXk1Wp
         KpezHpTsVA5K1VHbbK9f24bH03BlzE8B7Dh2Z8OA/Tc6cWuileTyadka2plLaWwx5p4V
         R4EcIeq6wW2fwaIXjYGIKLfUn32K6jEgQGyf4=
Received: by 10.231.141.20 with SMTP id k20mr40358ibu.132.1300384730156; Thu,
 17 Mar 2011 10:58:50 -0700 (PDT)
Received: by 10.231.34.7 with HTTP; Thu, 17 Mar 2011 10:58:20 -0700 (PDT)
In-Reply-To: <AANLkTikfp_d00zrtU8kuvyUk81gGMkOXEVDNXr-hRhBU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169251>

On Thu, Mar 17, 2011 at 10:54 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> On Thu, Mar 17, 2011 at 15:10, Jay Soffian <jaysoffian@gmail.com> wrote:
>> On Thu, Mar 17, 2011 at 4:53 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
>>> What if they just revert the rest? Reset the files to their states before
>>> merge.
>>
>> That's the same as checkout --ours which is sometimes a valid
>> resolution for a file. So I think "I resolved this file" needs to be
>> recorded either way.
>
> But it is recorded: the file is different now!

Let's say we have:

  a---b---c
   \
    d---e

$ git checkout c
$ git merge e  # files "foo" and "bar" conflict
$ git checkout --ours foo  # correct resolution for foo
$ git checkout HEAD bar    # "revert" bar to its pre-merge state
$ git add foo
$ git commit

In the merge commit, both "foo" and "bar" are identical to their
pre-merge state. There's no effective difference between the "checkout
--ours" and "reset the files to their states before the merge".

So again, how do you tell the difference here?

j.
