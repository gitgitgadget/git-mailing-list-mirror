From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCHv8 0/5] pathspec magic extension to search for attributes
Date: Tue, 24 May 2016 09:00:14 +0700
Message-ID: <CACsJy8CqxYVJt=311xmm3+js_1vx01by4=SH5_0fNw0t2bEzvw@mail.gmail.com>
References: <20160519010935.27856-1-sbeller@google.com> <xmqqiny9j2sc.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZvZQxPUkECupvqk0KRbq-pRK6y=GksOiYn_zz+TM=dBA@mail.gmail.com>
 <xmqqshxdhi76.fsf@gitster.mtv.corp.google.com> <CAGZ79kYx_pX81bmpyXCvJSVsZW=t3VpBizUPQ90Wz9=HdG42UA@mail.gmail.com>
 <CACsJy8CpYmp9t01RSeVY_UAw=zPmhGTY1TZ_p2E2zLuu7LpXhA@mail.gmail.com> <CAGZ79kZPPdUK1=GB6fnHP0cJyoM_VYmDj3wizApN5iHdCQCUyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 24 04:00:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b51eR-0007K4-Tk
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 04:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbcEXCAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 22:00:46 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37939 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbcEXCAp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 22:00:45 -0400
Received: by mail-ig0-f175.google.com with SMTP id fh2so3252630igd.1
        for <git@vger.kernel.org>; Mon, 23 May 2016 19:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WYuaRVh5IxOYX/JHk2gD3kgDasixWJPHVLReLZTPEwQ=;
        b=MuRu1qOIZyRqt4R6p+aFHdL5PHMeHoKVHM5G9+uwtLy2u5E+VG0s2fvYhaovwr469g
         U0mY6rY4v2GYzQEkugsykE6+YBIfL2JIbvcKhSqsE0IGJkYP/LRueu9wmFLAUo5ce6AC
         HJfQ8HqgziWJEw0g6ivrodQiKPuc33dCCei4b/zac//Vdo4kOwHb5uK6koQhQz0qqSJt
         9AgIniOKBihs1eS9VVP/v8oOPvkysF+lgt0OBWA8FIVH5/gahAcJrjkid/bYkMZSNurY
         wtme/mnHvaw1BS/jLTnDAvbD7oIpr9cbXPFtq0pdBRerOAOmRgnusTLXp+WD3k4S9faw
         0ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WYuaRVh5IxOYX/JHk2gD3kgDasixWJPHVLReLZTPEwQ=;
        b=aAw2FrlDH4vwVVtAgIPxgCVWmnpIhb7f8QyKvGm94Nh8OHuug8r3FSoAaCXg3S32xc
         PRtdqdI+b/QeeLjyJ0qlo0T/oOr6FIrbGMlASULDlQIvdPsjKpDHK7Iozw19ojonDSzO
         Y4wUIv5HA8q9MJgTfPm682V89z1nV+gqf/RW9aOaC0BCfHCv+hFmTGOH4K0m+oHVIbD7
         7pJ1GfJD4q3Shu8kSkvlzvqfVI+3PZmJwstwxtxQ2qCtws/JDdWQDedbGA//yU9rZI9T
         e4p9MyYDNl/55fCTG7ZBkxF/AYfIOCiaiIzpTOLDPmHhbRsbfiQJE2REyUvNVSl6D9T4
         7LTA==
X-Gm-Message-State: ALyK8tIFEmO/jW8qmRnZfw3MGbXq7Zn1GuTvb+VQGWVsgjJW/2dvBKP9Aa03HxNBj3rmmsMtVrTo+05R6n+xfQ==
X-Received: by 10.50.60.228 with SMTP id k4mr7080247igr.27.1464055244446; Mon,
 23 May 2016 19:00:44 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Mon, 23 May 2016 19:00:14 -0700 (PDT)
In-Reply-To: <CAGZ79kZPPdUK1=GB6fnHP0cJyoM_VYmDj3wizApN5iHdCQCUyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295411>

On Tue, May 24, 2016 at 1:49 AM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, May 22, 2016 at 4:45 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Fri, May 20, 2016 at 4:25 AM, Stefan Beller <sbeller@google.com> wrote:
>>>> My take is to pretend sparse checkout does not exist at all and then
>>>> go from there ;-)
>>
>> Hehe.. shameless plug, narrow checkout [1] should be its great
>> successor where everything is done right (famous last words). Maybe I
>> can convince Stefan to finish that off then I'll finally bring narrow
>> clone!
>
> I started reviewing that (see separate email).
>
> So conceptually the narrow checkout is "sparse checkout just for
> directories" IIUC.

Yep.

> A submodule is treated as a files (sometimes, e.g. diff) and sometimes
> as a directory (e.g. in the working tree)

It's the same here. Submodules have a special mode in the index
(S_IFDIR + S_IF<something>) while dirs just have S_IFDIR. It's up to
the index user to treat it as a "file" or a directory (maybe only
unpack-trees)

>>> Using these pathspec attrs are a good example for why we would
>>> want to make it more generic. Imagine a future, where more attributes
>>> can be codified into pathspecs and this is one of the possibilities:
>>>
>>>     git clone --sparse=":(exclude,size>5MB,binary)
>>>
>>> which would not checkout files that are large binary files. We could
>>> also extend the protocol (v2 with the capabilities in client speaks first)
>>> to transmit such a requirement to the server.
>>
>> I think you need narrow clone there ;-) It's the first step to have a
>> clone with missing directories. I think then we can extend it further
>> to exclude (large) files.
>
> But if we only exclude some files we are not having a binary
> decision for a directory, so narrow checkout doesn't work here?
>
>     git clone --sparse=":(exclude,size>5MB,binary)
>
> would maybe lead to have
>   dir/path.c #included
>   dir/binary-asset.img # excluded
>
> so it is more a sparse thing than a narrow thing?

I wrote two paragraphs, only to realized that you were right. In the
end we just need a way to exchange "sparse" (not narrow) information
about this. Narrow clone may need to exchange more side information
(for git-replace) but I don't see how sparse files fit exactly in this
whole exchange yet.

>>> Why is sparseness considered bad?
>>
>> It does not scale well when the worktree gets bigger. It can be slow
>> (but this is just a technical problem I haven't spent time on fixing).
>> And it does not enable narrow clone (not with lots of hacks, I think I
>> did just that in some early iterations).
>>
>>> If I wanted to just do the submodule only thing, this would be a smaller
>>> series, I would guess.
>>
>> No no no. Do more. Start with narrow checkout. I'll help ;-)
>
> Thanks for the encouragement!
> How is the interface going to look like for the narrow checkout/clone ?
> If the UI is supposed to be very similar, we can merge the two concepts
> and make it one thing.
>
> But if the UI is different enough, we may want to keep it separate as
> it is not as confusing to the user as we'd think?

For narrow clone, I imagine you need to specify what directories, say
with --narrow-path option or simply --path, to clone, and that's it.
In future you may add --path-filter option that does
"exclude,size>5MB,binary" above.

For narrow checkout, we have two more operations: fold and unfold
directories. At plumbing level, maybe update-index can support these
operations explicitly. At porcelain level, checkout probably learns
about --narrow-path and submodule can make use of it if it wants.

> What I imagine UI-wise, see
> http://thread.gmane.org/gmane.comp.version-control.git/295221
>
>
> Thanks,
> Stefan
>
>> --
>> Duy



-- 
Duy
