From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git pull & git gc
Date: Thu, 19 Mar 2015 16:47:50 +0700
Message-ID: <CACsJy8C9RF-PoJNs4PTOg_A0O=RVxZQRDp_UGxtJ_vQ-7h-L3A@mail.gmail.com>
References: <5509836D.2020304@aegee.org> <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org> <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
 <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com> <20150318145815.GN1369@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>, Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Mar 19 10:48:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYX3z-0005sk-JZ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 10:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbbCSJsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 05:48:23 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33839 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbbCSJsV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 05:48:21 -0400
Received: by igcau2 with SMTP id au2so7521547igc.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2015 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kmgg3mY/Ae39BJJBF13UdE6PVZYoPJsADvFsTXlmc9k=;
        b=bzq/e7tFv8lzSSGNUz/IzUYgIA4DUAui8WAG4fs1jk6LRvtq8xTk85c41YqhxaL64P
         mXS4vXtMrDuwEbBXBmetGvik4mLO3CZ5ciZJ9W8cGDPWVIYRHCgD6n8R3Se9u6JC6/UC
         G4elgOLvp5fXXQjC7lTgg5IkrVWYa5aiJwUC2EGEqYZi+V4nFPkCVy8rSARAh17ZBf74
         SIwW329EtBxDfEZ9IaDKxSmp+5CV2VMDdSroIFcdgLVOab5s4nbxXOPcD/XyBS4lStl4
         nfgw0sK1v8iOxmZwbQTVsD6SBKrfxHOfIiHVB2ycAVOYd2ugyw1hjSvRCqh6wo/HasM9
         nzww==
X-Received: by 10.107.167.145 with SMTP id q139mr138000751ioe.16.1426758500673;
 Thu, 19 Mar 2015 02:48:20 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Thu, 19 Mar 2015 02:47:50 -0700 (PDT)
In-Reply-To: <20150318145815.GN1369@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265796>

On Wed, Mar 18, 2015 at 9:58 PM, John Keeping <john@keeping.me.uk> wrote:
> On Wed, Mar 18, 2015 at 09:41:59PM +0700, Duy Nguyen wrote:
>> On Wed, Mar 18, 2015 at 9:33 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> > If not, I made some mistake in analyzing this and we'll start again.
>>
>> I did make one mistake, the first "gc" should have reduced the number
>> of loose objects to zero. Why didn't it.?  I'll come back to this
>> tomorrow if nobody finds out first :)
>
> Most likely they are not referenced by anything but are younger than 2
> weeks.
>
> I saw a similar issue with automatic gc triggering after every operation
> when I did something equivalent to:
>
>         git add <lots of files>
>         git commit
>         git reset --hard HEAD^
>
> which creates a log of unreachable objects which are not old enough to
> be pruned.

And there's another problem caused by background gc. If it's not run
in background, it should print this

warning: There are too many unreachable loose objects; run 'git prune'
to remove them.

but because background gc does not have access to stdout/stderr
anymore, this is lost.
-- 
Duy
