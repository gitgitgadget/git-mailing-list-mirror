From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 23/23] checkout: retire --ignore-other-worktrees in
 favor of --force
Date: Tue, 7 Jul 2015 05:41:43 -0400
Message-ID: <CAPig+cSz3xS-pdtsiw14A80m7UqdwfGLy6kRdguHSUyAjfnWSQ@mail.gmail.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
	<1436203860-846-24-git-send-email-sunshine@sunshineco.com>
	<xmqqlhetyszz.fsf@gitster.dls.corp.google.com>
	<CAPig+cSSooqUcR_gW6vQP5Ws5v9p47bt7JWX4HgAyD6mFZynDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 11:41:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCPNt-0004S9-En
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 11:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbbGGJlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 05:41:45 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34500 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbbGGJlo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 05:41:44 -0400
Received: by ykfy125 with SMTP id y125so172973298ykf.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 02:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=i/IascPrkkGb7HhhdN3+aM88OjQfQcrYyxN26hv596s=;
        b=dRHLdd3r6CwdYvZwbJ4lFvVA/sxhecURb0/9ScAj2/INyvfJ0//Hqye4w6e1rK8BaU
         sw9+d+WIefsv5caoB4YGqUznwRAEn0ZVy1mU2vCC3L+gXXkH7APsFxecVfLCsChmix81
         xplf7/jBAgZYS/+YPjIAchF9era4r8ArVYEfU5JAhXFlsrDKktcczlgMaXY2DmsGLms4
         zXcOSiHw8Nj6cbuGizIW+EzECdJRy4UxOZ6YTTiE1uaKhHd88eXMOGOdCuhRw9a6tFX3
         Q23sr+uw273K+vj2hmozNvw+Aqrg35dHRVKHcoN39ecu3TemQWQomswYYzUx0DwHP5bE
         IFuQ==
X-Received: by 10.129.91.135 with SMTP id p129mr3906831ywb.95.1436262103656;
 Tue, 07 Jul 2015 02:41:43 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 7 Jul 2015 02:41:43 -0700 (PDT)
In-Reply-To: <CAPig+cSSooqUcR_gW6vQP5Ws5v9p47bt7JWX4HgAyD6mFZynDA@mail.gmail.com>
X-Google-Sender-Auth: dv8RK3bnak1Ri07yU_4FY0c7Sl0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273495>

On Tue, Jul 7, 2015 at 4:24 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jul 6, 2015 at 3:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> If you are extending the history of some branch, then you would want
>> to be on that branch.  Why would you want to have another worktree
>> that will get into a confusing state once you create that commit on
>> the checked out branch in this newly created worktree?
>>
>> Wasn't the whole point of making the primary repository aware of the
>> secondary worktrees via the "linked checkout" mechanism because that
>> confusion was the biggest sore point of the old contrib/workdir
>> implementation?
>
> I [...] probably lack understanding of the finer points to make a
> cogent argument for or against.

Is receive.denyCurrentBranch worth mentioning as an argument? Although
pushing a branch into a non-bare repo where that branch is already
checked out is normally disallowed, receive.denyCurrentBranch
overrides the safeguard. Presumably, the user has experience and
knowledge to know that "git reset --hard" will be required to sync
things up.

Using --force or --ignore-other-worktrees (or whatever) to override
git-checkout's normal safeguard against checking out a branch into
more than one linked-worktree parallels receive.denyCurrentBranch,
doesn't it? There is a certain amount of precedent elsewhere in Git
for allowing a person to shoot himself in the foot.
