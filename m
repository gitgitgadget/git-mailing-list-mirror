From: "Peter Waller" <peter.waller@gmail.com>
Subject: Re: Merging repositories and their histories
Date: Mon, 18 Aug 2008 16:25:54 -0500
Message-ID: <d3d284ca0808181425v4e0eadbcn9f00f5a15191576@mail.gmail.com>
References: <19035412.post@talk.nabble.com> <20080818173511.GC6014@blimp.local>
	 <d3d284ca0808181115j2c9ab5ecufb66780f45d28207@mail.gmail.com>
	 <20080818194021.GA3262@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 23:28:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVCGZ-0005K1-Nd
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 23:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbYHRVZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 17:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755025AbYHRVZ6
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 17:25:58 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:51071 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010AbYHRVZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 17:25:56 -0400
Received: by gxk9 with SMTP id 9so4288310gxk.13
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 14:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WGwxXVbQvNTq6RQKejahFbCPwkswSivS5ysejNjKE2E=;
        b=rJn//xMkN7yFlTfckrMjxgFR6jfRtU2Mh9gDnKC0WYSEihZsUwtxxKItiCvtwUHGmZ
         o61atCEVEcvbLU7IrFWwgk7pkHZQbOzR2MmLAu02nmYf4XBMCR3th4xJATmpVuTYFbDc
         vwkG18VsfrZmj96j2F2UV5SlSCGTV1LghBokU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=H0QlvrUS5aQE4v0fqCBPvd0VPHC0Bj4WNg5oI3SpJGFBTQc7EzzE5ZZ+VduZ0yBaFE
         COHhYtAAzxQlbcaw2xYKwQBoneaV6MdNvz4weM4daMw2vO+BZLrjuT3P+yBMP3Txm5xW
         RErQuMAIYxqdjhnpkUQcCb+ICNt05CzbnUck0=
Received: by 10.151.48.15 with SMTP id a15mr10424337ybk.58.1219094754572;
        Mon, 18 Aug 2008 14:25:54 -0700 (PDT)
Received: by 10.151.101.8 with HTTP; Mon, 18 Aug 2008 14:25:54 -0700 (PDT)
In-Reply-To: <20080818194021.GA3262@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92742>

Thanks, it worked.

2008/8/18 Alex Riesen <raa.lkml@gmail.com>:
> Peter Waller, Mon, Aug 18, 2008 20:15:52 +0200:
>> 2008/8/18 Alex Riesen <raa.lkml@gmail.com>
>>
>> > Peter Waller, Mon, Aug 18, 2008 18:46:14 +0200:
>> > >
>> > > I have three repositories, A, B and C. I wish to bring them
>> > > together to only one repository (.), where they are in a
>> > > directory called ./Archive, so..  ./Archive/{A,B,C}. Then I plan
>> > > at a later date to move files arbitrarily from
>> > > ./Archive/{A/B/C}/Something and into ./Something{A/B/C}. (A lame
>> > > example, but illustrates what I want to do).
>> >
>> > If this transition is meant to be persistent (IOW, the A, B and C stop
>> > existing as repos on their own) you can rewrite their histories to be
>> > in the directories (with git filter-branch) and just merge them in
>> > one. Then the histories will look like as if they have never grown
>> > separately.
>> >
>> I don't quite understand what you are suggesting I do.
>>
>> I have looked over the filter-branch manpage.
>>
>> What would I first do? Copy all three repositories to ./Archive/{A,B,C}?
>
> Fetch, actually.
>
>    $ mkdir combined && cd combined
>    $ git init
>    $ git fetch ../A master:A
>    $ git fetch ../B master:B
>    $ git fetch ../C master:C
>
>> Then rewrite their histories?
>
> There is an example at the end of git-filter-branch manpage. Search
> for "To move the whole tree into a subdirectory". Just use A, B and C
> instead of HEAD as last argument.
>
> Then checkout one of the new, the rewritten, branches, and merge the
> two others into it:
>
>    $ git checkout A
>    $ git merge B
>    $ git merge C
>
> That's it.
>
