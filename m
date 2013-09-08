From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 03:16:06 -0500
Message-ID: <CAMP44s2pw2TZSZ6pL-kx_QQCkjKrprERyvddCT-HTeo7uRNENA@mail.gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
	<7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
	<xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
	<20130905080606.GE2582@serenity.lan>
	<CAMP44s1Rb2WKGD-QfNh055099R+9FHv9W8TA8Gfjp=qZh_7p7Q@mail.gmail.com>
	<8B7F235220624B259BB32B293BCB3E96@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Sep 08 10:16:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIaAK-0002iq-JQ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 10:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822Ab3IHIQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 04:16:11 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:60239 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab3IHIQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 04:16:07 -0400
Received: by mail-lb0-f175.google.com with SMTP id y6so4049892lbh.20
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CdadwRdhK8MLZBC1a5a0aNCfhnGnhfAZ72tkavgy1dY=;
        b=Kik3DA/v7+tBuH4CJdRHNL0n0z/w3dNbFn2l4ZkN+LhLMuLnvNApjdlOW6ULx6NDho
         kqg+5VzLcgucmLnII6rLX9pdn42UHwvn9XwJLKXsOx+odZDxtxA6FxZu46pOOL3uWsFP
         9EVCivq2Yy4nm8wAHIt7hnNXUvhNbcBATuaYBFvmW7DNCC3RD8ZBbttijE+m1smvIHSv
         8F7bTRw0bCKSi47usYYE4DrmNJvDzKUHaNWkTrjS+Vl71LH42ZDWlK29rqw0xR2pG3qx
         lwBzoG1z2b+QgylZ8rSCe8pN/gRoD9jZ5FPhBCIdWb9M1jTRak1Vt+Oni3/SOUmdV6OE
         QMGQ==
X-Received: by 10.152.115.176 with SMTP id jp16mr10671855lab.17.1378628166309;
 Sun, 08 Sep 2013 01:16:06 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 01:16:06 -0700 (PDT)
In-Reply-To: <8B7F235220624B259BB32B293BCB3E96@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234218>

On Sun, Sep 8, 2013 at 3:01 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Felipe Contreras" <felipe.contreras@gmail.com>
> Sent: Sunday, September 08, 2013 3:34 AM
>
>> On Thu, Sep 5, 2013 at 3:06 AM, John Keeping <john@keeping.me.uk> wrote:
>>>
>>> On Wed, Sep 04, 2013 at 03:59:18PM -0700, Junio C Hamano wrote:
>>>>
>>>> Are there cases where you do not want to either rebase nor merge?
>>>> If so what do you want to do after "git pull" fetches from the other
>>>> side?  Nothing?
>>>
>>>
>>> One other thing that I can see being useful occasionally is:
>>>
>>>     git rebase @{u}@{1} --onto @{u}
>>>
>>> which allows local commits to be replayed onto a rewritten upstream
>>> branch.
>>>
>>> Although I agree with your side note below that people doing this may be
>>> better off fetching and then updating their local branch, particularly
>>> if @{1} is not the correct reflog entry for the upstream when they
>>> created the branch.
>>
>>
>> That's why after recognizing the fact the you can't find the branch
>> point of a branch in Git, I decided to write patches to support the
>> @{tail} shorthand, which is basically the point where the branch was
>> created, or rebased to:
>>
>> https://github.com/felipec/git/commits/fc/base
>>
>> And if 'git rebase' was fixed to ignore the commits already in the
>> rebased onto branch, almost always what you would want to do is 'git
>> rebase @{tail} --onto @{upstream}'.
>>
> The use case that trips me up (i.e. doesn't fit the above) is when I have a
> branch that may need rebasing on (onto) pu, or may need rebasing on master,
> or next, depending on what others have been doing.

Yes, so you would do:

% git rebase --onto pu

Which would be translated to:

% git rebase @{tail} --onto pu

What's the problem?

> As a Distributed VCS (i.e. others doing work independently), a rebase always
> has the possibility that the world has moved on and one has to adapt to the
> new world order by moving location (--onto somewhere new), not just fixing
> up the house (patch conflicts). When the update order is unknown there is no
> guaranteed solution (IIUC).

Yeah, but almost always you want to rebase onto @{upstream}.

-- 
Felipe Contreras
