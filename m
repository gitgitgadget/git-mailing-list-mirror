From: Sergey Sharybin <sergey.vfx@gmail.com>
Subject: Re: Git issues with submodules
Date: Fri, 22 Nov 2013 21:42:20 +0600
Message-ID: <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
References: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com>
	<CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com>
	<CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
	<CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
	<20131122151120.GA32361@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 22 16:42:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjssD-0007XY-LS
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 16:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755654Ab3KVPmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 10:42:22 -0500
Received: from mail-vc0-f170.google.com ([209.85.220.170]:33959 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521Ab3KVPmV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 10:42:21 -0500
Received: by mail-vc0-f170.google.com with SMTP id ht10so965718vcb.15
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 07:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YzNrTe4Q2e6lIbgRsp2y9Icm+y0LRO8+B+EzsDlzJuc=;
        b=iRjz/6JE6Dc4zi+CU+vDzzrOCm7DItXsBJDR4dRNVOV+89ac0gA6IvvesPXG0ukkLh
         GyoBFXILo/D2Uzgl2abhU99EDfMe8kbQZqK9yFx8AvtwwVDhcsc835eqsN3CbhEkeJyv
         CnWVtKTvoK7NxjdDzUmT1VaqGdQaBHweFt6aYsXe0LPMMAd3V7gfCXKYEDJetSeCvzea
         QUm4sqjDF1SmaNhWbdBzL3Z7/1RK9+lN6XugLb78Ieb60jkOKk9+qgbLSHriTLQQeGOs
         mskavbFSIebLpLd8uRYu2EvhSo8IrUYkptbF0nEekPTCyugwJxD7pDEKAUJ65vjxSTIl
         2tBg==
X-Received: by 10.52.33.44 with SMTP id o12mr10033044vdi.7.1385134940493; Fri,
 22 Nov 2013 07:42:20 -0800 (PST)
Received: by 10.52.169.2 with HTTP; Fri, 22 Nov 2013 07:42:20 -0800 (PST)
In-Reply-To: <20131122151120.GA32361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238191>

Ramkumar, not actually sure what you mean?

For me `git diff --name-only HEAD --` ignores changes to submodules
hash changes. Also apparently it became a known TODO for phabricator
developers [1].

Jeff, kinda trying to match yes. Just don't want changes to submodules
hash to be included.

So, after all is it expected behavior of ls-files or not and if not
shall i report it as a separate thread? :)

[1] https://secure.phabricator.com/rARCe62b23e67deacc24469525cc5dea2b297a5073fb


On Fri, Nov 22, 2013 at 9:11 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 22, 2013 at 06:38:47PM +0530, Ramkumar Ramachandra wrote:
>
>> >> Does Arcanist use `git ls-files -m` to check?
>> >
>> > Yes, Arcanist uses `git ls-files -m` to check whether there're local
>> > modifications. We might also contact phab developers asking to change
>> > it to `git diff --name-only HEAD --`.  Is there a preferable way to
>> > get list of modified files and are this command intended to output the
>> > same results?
>>
>> I just checked it out: it uses `git ls-files -m` to get the list of
>> unstaged changes; `git diff --name-only HEAD --` will list staged
>> changes as well.
>
> That diff command compares the working tree and HEAD; if you are trying
> to match `ls-files -m`, you probably wanted just `git diff --name-only`
> to compare the working tree and the index. Although in a script you'd
> probably want to use the plumbing `git diff-files` instead.
>
> -Peff



-- 
With best regards, Sergey Sharybin
