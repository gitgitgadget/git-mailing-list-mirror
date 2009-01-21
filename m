From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: An idea: maybe Git should use a lock/unlock file mode for 
	problematic files? [Was: Re: after first git clone of linux kernel repository 
	there are changed files in working dir]
Date: Wed, 21 Jan 2009 08:25:00 +0100
Message-ID: <81b0412b0901202325y7a468374i4b1b3da0c7bd48dc@mail.gmail.com>
References: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com>
	 <d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com>
	 <83ocy3fmez.fsf@kalahari.s2.org>
	 <20090120105228.xbo3gyc0odwcgcsc@webmail.fussycoder.id.au>
	 <alpine.LNX.1.00.0901201441480.19665@iabervon.org>
	 <1232486929.4179.7.camel@therock.nsw.bigpond.net.au>
	 <alpine.LNX.1.00.0901201651050.19665@iabervon.org>
	 <81b0412b0901201525w22513418p57acc19457908a3@mail.gmail.com>
	 <alpine.LNX.1.00.0901201833400.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Chapman <thestar@fussycoder.id.au>,
	Hannu Koivisto <azure@iki.fi>, rdkrsr <rdkrsr@googlemail.com>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 08:26:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPXTn-0001Cd-04
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 08:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbZAUHZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 02:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754276AbZAUHZE
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 02:25:04 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:58867 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbZAUHZB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 02:25:01 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3499726rvb.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 23:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3xTfTBMeMqSE96ns6+T3kZpzwx5AtpCZ5wDydGtU+Y0=;
        b=aWtj3k7KNvcZDylEpq7ZnXiwyIfdEQDRRen+bRg3prA3VftycLEkeD82X0GiTBEdnW
         gVA/gaSa97kKr2M4CCxJxBkyZL+bDQVsnoqZKP1jy/6VIYXjQ/3Y7Dg6y5O/6yzt2gWE
         PNMErDI1wrD9KcOuXtEHykBaCRJaZQkYkZPvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WRvS3UYq/ahx04qLKPly7goAKwUv6R99J0+Nn4XC9OMHBKfsPAwXpVtI+84uRO4ymx
         XazLWIcRzgl09lQWnqhcWGX7kqSMlUb+AQD5XN01nAfBpJ15Q/NAMFZdZsIcfK3S1iht
         RV0GsHYiybWm1fInLKOBqO+QcISwCffX45xAo=
Received: by 10.114.192.3 with SMTP id p3mr5529403waf.166.1232522700440; Tue, 
	20 Jan 2009 23:25:00 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0901201833400.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106573>

2009/1/21 Daniel Barkalow <barkalow@iabervon.org>:
> On Wed, 21 Jan 2009, Alex Riesen wrote:
>
>> 2009/1/20 Daniel Barkalow <barkalow@iabervon.org>:
>> > My impression was that this didn't happen in practice, because teams
>> > would tend to not have two people create the same file at the same time,
>> > but with different cases, and people interacting with the same file at
>> > different times would use whatever case it was introduced with.
>>
>> It will and does happen in practice (annoingly too often even). Not with Git
>> yet (with Perforce), where people do "branching" by simply copying things
>> in another directory (perforce world does not know real branches),
>> renaming files randomly, and putting the new directory back in the
>> system (or maybe it is the strange tools here which do that - often
>> it is the first character of a directory or file which gets down- or up-cased).
>
> How does the resulting code work at all? ...

Sometimes it does not. Sometimes it does. Depends on that particular
checkout order perforce (or user?) selected to use this time.

> ... With a case-sensitive filesystem,
> most of the files you're using don't have the expected names any more, and
> most systems will therefore not actually build or run.

Except that there is no case-sensitive file systems on development machines.
So a botched case wont be noticed by a standard build procedure unless
the content of the files causes an error.

>> As Perforce itself is case sensitive (like Git), using of such branches
>> is a nightmare: the files get overwritten in checkout order which is
>> not always sorted in predictable order. Combined with case-stupidity
>> of the file system the working directories sometimes cause "interesting
>> time" for unlucky users.
>> Luckily (sadly) it is all-opening-in-a-wall shop, so the problem with "fanthom"
>> files is rare (it is hard to notice) for most. Which actually makes it more
>> frustrating when the real shit happens.
>>
>> And it will happen to Git as well, especially if development go crossplatform.
>> It is not that hard to accidentally rename a file on case-sensitive file system,
>> "git add *" it and commit without thinking (that's how most of software
>> development happens, come to think of it).
>
> People can accidentally rename files?

Aside from tools (and in my own experience - I did) - they can and do.

> And still have things work when they do it on a case-sensitive filesystem?

Shameless luck, I'd say. That and "no file systems permitted, but the one
from finance dept".
