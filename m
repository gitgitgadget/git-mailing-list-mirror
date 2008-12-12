From: "James Youngman" <jay@gnu.org>
Subject: Re: Clarifying "invalid tag signature file" error message from git filter-branch (and others)
Date: Fri, 12 Dec 2008 16:05:19 +0000
Message-ID: <c5df85930812120805q43b96faal31fa93e7d317fcc4@mail.gmail.com>
References: <c5df85930812110214k2e12d926m60856fb630d45e80@mail.gmail.com>
	 <P7E-5meNX4tXFurN9mnRguFHdJG1jaZYTn6WxFFpECSJ68KyYT3wqQ@cipher.nrlssc.navy.mil>
	 <c5df85930812111434m879f1faq80c64286714c3a1f@mail.gmail.com>
	 <LhfS_uc2B_Gje7rXd1882RMsQfSRjOEsBT24Z1Yza_bWhgl9lI-ZhQ@cipher.nrlssc.navy.mil>
	 <c5df85930812111559p287ea6afk54a9759302288d5e@mail.gmail.com>
	 <87zlj1hd0r.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: "Jim Meyering" <jim@meyering.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 17:07:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBAXH-0001J6-Gc
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 17:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757576AbYLLQFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 11:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757573AbYLLQFW
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 11:05:22 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:23713 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757314AbYLLQFV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 11:05:21 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1379416wfd.4
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 08:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=65xmaZoNYuvlbdQkM2ED18DywmtJGzVRHKJWnbPpH/0=;
        b=n74hIbOVliMH4tDy622EuSZytlhZV5rHlIQu8vBUi2ISMWCvHDHUSTzOybC4Rme1CS
         qxoNFWuYjYAwi9toawbS9y1M8FmcrsHW0lOa/rhnDKAM++j6+VnEfRTiIAWT5QqCC+Ut
         1Gqne+pNxrBJWNrBqYUFa/EilZmZ3rObIoozM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=LAuZC3Giy0V7CMKM39LojlxMmA+/zvvas4597j0mYnUbSWd/zDA13ol4ndbk3o2lPw
         lHDtMIKRhcPDeN/5QkQIjjTBvM45ddXMunaW7Z1rKTVhP1j5qxsQhWfDRxbeujZE54z2
         UhPEBn2bNiiY6kloKB2oJEycYMvXiUGvN4YxA=
Received: by 10.142.165.14 with SMTP id n14mr1421846wfe.58.1229097919891;
        Fri, 12 Dec 2008 08:05:19 -0800 (PST)
Received: by 10.143.168.8 with HTTP; Fri, 12 Dec 2008 08:05:19 -0800 (PST)
In-Reply-To: <87zlj1hd0r.fsf@rho.meyering.net>
Content-Disposition: inline
X-Google-Sender-Auth: 68ce1776eaf8f8a8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102909>

On Fri, Dec 12, 2008 at 11:02 AM, Jim Meyering <jim@meyering.net> wrote:
> "James Youngman" <jay@gnu.org> wrote:
>> On Thu, Dec 11, 2008 at 11:13 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>>
>>>> Before conversion:
>>>> $ git cat-file tag FINDUTILS-4_1-10
>>>> object ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
>>>> type commit
>>>> tag FINDUTILS-4_1-10
>>>> tagger Kevin Dalley
>>>
>>> The tagger field is missing an email address, a timestamp, and a timezone. It
>>> should look something like:
>>>
>>>  tagger Kevin Dalley <kevin.dalley@somewhere.com> 1229036026 -0800
>>>
>>> git-mktag prevents improperly formatted tags from being created by checking
>>> that these fields exist and are well formed.
>>>
>>> If you know the correct values for the missing fields, then you could
>>
>> Yes for the email address.      But as for the timestamp, it's not in
>> the tag file; that only contains the sha1.
>> There is a timestamp in the object being tagged, is that the timestamp
>> you are talking about?
>>
>> $ git show --pretty=raw  ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
>> commit ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
>> tree 752cca144d39bc55d05fbe304752b274ba22641c
>> parent 9a998755249b0c8c47e8657cff712fa506aa30fc
>> author Kevin Dalley <kevin@seti.org> 830638152 +0000
>> committer Kevin Dalley <kevin@seti.org> 830638152 +0000
>>
>>     *** empty log message ***
>>
>> diff --git a/debian.Changelog b/debian.Changelog
>> index e3541eb..d0cd295 100644
>> --- a/debian.Changelog
>> +++ b/debian.Changelog
>> @@ -1,5 +1,7 @@
>>  Sat Apr 27 12:29:06 1996  Kevin Dalley
>> <kevin@aplysia.iway.aimnet.com (Kevin Dalley)>
>>
>> +       * find.info, find.info-1, find.info-2: updated to match find.texi
>> +
>>         * debian.rules (debian): update debian revision to 10
>>
>>         * getline.c (getstr): verify that nchars_avail is *really* greater
>>
>>
>>
>>
>>
>>> recreate the tags before doing the filter-branch. If they are unknown, it
>>> seems valid enough to use the values from the commit that the tag points
>>> to.
>>>
>>> i.e.
>>>
>>>  tagger Kevin Dalley <kevin@seti.org> 830638152 -0000
>>>
>>> What tool was used to convert this repository to git? It should be corrected
>>> to produce valid annotated tags. Especially if it is a tool within git.
>>
>> I don't know, Jim Meyering will know though, so I CC'ed him.
>
> I used parsecvs, probably with git-master from the date of
> the initial conversion (check the archives for actual date).
> That was long enough ago that it was almost certainly before
> git-mktag learned to be more strict about its inputs.
>
> James, since you're about to rewrite the history, you may want to
> start that process from a freshly-cvs-to-git-converted repository.

Maybe, but then afaik CVS tags don't have timestamps, so some of the
data that git-mktag seems to want doesn't exist anyway.

But until we know the answer to the next question, I don't think we
know how we would generate such a freshly-converted repository.

> I'm not very happy about using cvsparse (considering it's not
> really being maintained, afaik), so if the git crowd
> can recommend something better, I'm all ears.

Thanks,
James.
