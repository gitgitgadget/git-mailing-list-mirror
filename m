From: David Michael Barr <davidbarr@google.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 27 Sep 2011 09:37:59 +1000
Message-ID: <CAFfmPPNCCCo=40CVvjRebXvkR7H_wh9+cz=tGxHZ1LtarE+w+A@mail.gmail.com>
References: <4DF6A8B6.9030301@op5.se>
	<9ae990f15489d7b51a172d08e63ca458@quantumfyre.co.uk>
	<201109261539.33437.mfick@codeaurora.org>
	<201109261552.04946.mfick@codeaurora.org>
	<ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:38:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Kkg-0007lV-Pi
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 01:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058Ab1IZXiS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 19:38:18 -0400
Received: from smtp-out.google.com ([74.125.121.67]:58864 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab1IZXiR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 19:38:17 -0400
Received: from hpaq14.eem.corp.google.com (hpaq14.eem.corp.google.com [172.25.149.14])
	by smtp-out.google.com with ESMTP id p8QNcGdH024885
	for <git@vger.kernel.org>; Mon, 26 Sep 2011 16:38:16 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1317080296; bh=Rre2IqHSyfQygAMLM2aZdNYcO5c=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=M4/NKMm7lHXoOaOr0/LqhrFTzWgTo/SUAxy+EnuAM0l2+Z/4Y/7ORECOpeeMtCXaM
	 TYOt3IJ7eKC5ElSCw7WRg==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:mime-version:in-reply-to:references:date:
	message-id:subject:from:to:cc:content-type:
	content-transfer-encoding:x-system-of-record;
	b=DMQmXOsL13442F89koLbO6Az/Wt5LL39h2DCuH+ZVZdn5YlH3IWhPN/OnNMAwAgO1
	9JP8YsBh8gCbPw7kRshsw==
Received: from yib25 (yib25.prod.google.com [10.243.65.89])
	by hpaq14.eem.corp.google.com with ESMTP id p8QNbq2h022456
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 26 Sep 2011 16:38:14 -0700
Received: by yib25 with SMTP id 25so6409100yib.23
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 16:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Oy8iRG6tcm24FE3FKwyJ4kZIUVEA7zXk5XtVTOIkA7g=;
        b=ypRZi7S1uSAiVeCVoyfSTy9WIXeImzkFW6CJX4BptaydXsf1nHwQssmVFMf+UYJUNF
         Zu4f+PxtPXItTLu6QnHg==
Received: by 10.101.72.1 with SMTP id z1mr5992285ank.95.1317080294458;
        Mon, 26 Sep 2011 16:38:14 -0700 (PDT)
Received: by 10.101.72.1 with SMTP id z1mr5992280ank.95.1317080294180; Mon, 26
 Sep 2011 16:38:14 -0700 (PDT)
Received: by 10.100.24.25 with HTTP; Mon, 26 Sep 2011 16:37:59 -0700 (PDT)
In-Reply-To: <ece30e6a1b74bcddde5634003408f61f@quantumfyre.co.uk>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182191>

On Tue, Sep 27, 2011 at 9:26 AM, Julian Phillips
<julian@quantumfyre.co.uk> wrote:
>
> On Mon, 26 Sep 2011 15:52:04 -0600, Martin Fick wrote:
>>
>> On Monday, September 26, 2011 03:39:33 pm Martin Fick wrote:
>>>
>>> On Monday, September 26, 2011 02:28:53 pm Julian Phillips
>>> wrote:
>>> > >> Random thought. =A0What happens to the with
>>> > >> compression case if you leave the commit in, but
>>> > >> add a sleep(15) to the end of sort_refs_list?
>>> > >
>>> > > Why, what are you thinking? =A0Hmm, I am trying this on
>>> > > the non gced repo and it doesn't seem to be
>>> > > completing (no cpu usage)! =A0It appears that perhaps
>>> > > it is being called many times (the sleeping would
>>> > > explain no cpu usage)?!? =A0This could be a real
>>> > > problem, this should only get called once right?
>>> >
>>> > I was just wondering if the time taken to get the refs
>>> > was changing the interaction with something else. =A0Not
>>> > very likely, but ...
>>> >
>>> > I added a print statement, and it was called four times
>>> > when I had unpacked refs, and once with packed. =A0So,
>>> > maybe you are hitting some nasty case with unpacked
>>> > refs. =A0If you use a print statement instead of a sleep,
>>> > how many times does sort_refs_lists get called in your
>>> > unpacked case? =A0It may well also be worth calculating
>>> > the time taken to do the sort.
>>>
>>> In my case it was called 18785 times! =A0Any other tests I
>>> should run?
>>
>> Gerrit stores the changes in directories under refs/changes
>> named after the last 2 digits of the change. =A0Then under
>> each change it stores each patchset. =A0So it looks like this:
>> refs/changes/dd/change_num/ps_num
>>
>> I noticed that:
>>
>> =A0ls refs/changes/* | wc -l
>> =A0-> 18876
>>
>> somewhat close, but not super close to 18785, =A0I am not sure
>> if that is a clue. =A0It's almost like each change is causing
>> a re-sort,
>
> basically, it is ...
>
> Back when I made that change, I failed to notice that get_ref_dir was=
 recursive for subdirectories ... sorry ...
>
> Hopefully this should speed things up. =A0My test repo went from ~17m=
 user time, to ~2.5s.
> Packing still make things much faster of course.
>
> diff --git a/refs.c b/refs.c
> index a615043..212e7ec 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -319,7 +319,7 @@ static struct ref_list *get_ref_dir(const char *s=
ubmodule, c
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free(ref);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0closedir(dir);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 return sort_ref_list(list);
> + =A0 =A0 =A0 return list;
> =A0}
>
> =A0struct warn_if_dangling_data {
> @@ -361,11 +361,13 @@ static struct ref_list *get_loose_refs(const ch=
ar *submodu
> =A0 =A0 =A0 =A0if (submodule) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_ref_list(submodule_refs.loose);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0submodule_refs.loose =3D get_ref_dir(s=
ubmodule, "refs", NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 submodule_refs.loose =3D sort_refs_list=
(submodule_refs.loose);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return submodule_refs.loose;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!cached_refs.did_loose) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cached_refs.loose =3D get_ref_dir(NULL=
, "refs", NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cached_refs.loose =3D sort_refs_list(ca=
ched_refs.loose);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cached_refs.did_loose =3D 1;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return cached_refs.loose;
>
>
>
>>
>>
>> -Martin
>
> --
> Julian
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

Well done! I'll try to compose a patch attributed to Julian with the
information from this thread.

--
David Barr
