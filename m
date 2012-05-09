From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Seeing high CPU usage during git-upload-pack
Date: Wed, 9 May 2012 22:11:07 +0700
Message-ID: <CACsJy8CbaM6UNCT3ZP0=VZE9GhH2eJpgKe-dnGU5ubn_4gS=Pw@mail.gmail.com>
References: <CAPeUw3EsFCxki6obAAeVBb0g4MKNWBteL3VueG5djbajkFiv3A@mail.gmail.com>
 <CACsJy8DMm0ZNiQYQ1CvOfDJu5ogP42Y06792iA_xyzeHDGLJaw@mail.gmail.com> <CAPeUw3HCkKKBP6RnZzR0TYOO0hHtJ4_ma-Je4a-xKhPpNPJhHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Ebbo <david.ebbo@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 17:11:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS8YO-0001I1-AG
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 17:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759962Ab2EIPLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 11:11:41 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:38496 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759865Ab2EIPLi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 11:11:38 -0400
Received: by werb10 with SMTP id b10so274304wer.19
        for <git@vger.kernel.org>; Wed, 09 May 2012 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iqIb0pfsGfPneZ9wd1BCDZ5cFwacEcBUWR4FDlknzpk=;
        b=gQPkrMYJtn0SOzgndgm50rpIdHS4PePUDhZtDcqN6eAaYztze1E2eadriToI3AmfIV
         Xzs8Ru0N8omZwtUo+FjqXgIg6rbXOXo+hsay+32ZGGuz+bIOqw7vrwTgWATY1PO6/cx/
         zlnv92A8TuUk2Qdsg2PtUc8qBQX6V1D05v0ty30sa0EI/cG4x5dSZlPjGd9QvIcuBUeh
         60WjiYHji2ERlURcxhREJeZvkR9nAP8Bn6FfEfc1WIFaJNnKSk7uw0lowyj+0KDIHJWp
         688/zBgunMXaUOdVKOi2xHvDzxkjSZAT0mrn3XMU6oqGX2GrsSQtnI16ww+Ec9uzU52X
         H6nA==
Received: by 10.180.98.137 with SMTP id ei9mr1265777wib.0.1336576297453; Wed,
 09 May 2012 08:11:37 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Wed, 9 May 2012 08:11:07 -0700 (PDT)
In-Reply-To: <CAPeUw3HCkKKBP6RnZzR0TYOO0hHtJ4_ma-Je4a-xKhPpNPJhHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197476>

Hi,

I don't see anything private in the mail, so I CC git@vger again. It's
a good thing to keep git@vger in the loop because there will be more
(experienced) people to help you out.

On Wed, May 9, 2012 at 9:37 PM, David Ebbo <david.ebbo@gmail.com> wrote:
> Thanks Duy for your looking at this.
>
> On Wed, May 9, 2012 at 3:37 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>
>> What OS is it run on? What git version?
>>
>
> This is using 1.7.9 on Windows (msysgit).

Ah... msysgit reimplements poll() function, in compat/win32/poll.c. If
it goes rouge, you could get an active loop. But this is just my
suspicion. I don't know anything about msysgit's poll implementation
so I can be completely wrong here.

>> How about stopping upload-pack and see where it stops? There's a main
>> loop in upload-pack.c, create_pack_file() that is only active when
>> data comes. I looked but failed to see how it becomes a busywait loop.
>> Maybe you can put some debugging there.
>>
>> Setting env var GIT_TRACE_PACKET and GIT_DEBUG_SEND_PACK before
>> running upload-pack might also help.
>>
>
> I'll try those env vars, and will debug as needed (I haven't done that
> yet, so I'll need to get set up <g>)
>
> Thanks for the pointers!
-- 
Duy
