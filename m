From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] branch: colour upstream branches
Date: Sun, 14 Apr 2013 20:24:38 -0500
Message-ID: <CAMP44s27Tj4x5U34ysdfQx8uzxAz=yJZ+rkWxLWtQHzAeoF8SA@mail.gmail.com>
References: <1365903985-24920-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DdBkPDXORxv08cFi+i5Q4WiBjjbNf9GyB4hv+t-K=wRQ@mail.gmail.com>
	<CAMP44s2j-Cqksu29fJRTqDNGBNi1tZkE0gfgj69K-ckFwVgnRg@mail.gmail.com>
	<CACsJy8AGFEEkS2qQygnbZOorGv=DKc2OgC-nZ47+k2oYGBBD2Q@mail.gmail.com>
	<CAMP44s38e4n_jKC-f973JJUXuxkD2dqP+ECwzxvUMWxit2P2PA@mail.gmail.com>
	<CACsJy8CTmh2eMDqBpr0agiTGcHkP_AQBLLg2A4HM203u9G1v9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 03:24:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URYA6-0007LG-K3
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 03:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752948Ab3DOBYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 21:24:41 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:39838 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab3DOBYk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 21:24:40 -0400
Received: by mail-lb0-f178.google.com with SMTP id q13so4011025lbi.23
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 18:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=lXN37Kr+K01RG1ka2ZF9Gf7EqXMjCSmsIEzHQgs4Xcs=;
        b=dslwSGOavGXz+L9tk2E97ZykLIuHtl7Z9y/bIQSZMR20yL5K5iGeFjrD8d9580FD2n
         UeTMTj1s7bC+GgdChZVqtbBqmrP7P8tSKDX2DNgWSH9p5nBjHgnI7pSWgtDdPUxiP5qa
         +nPtwepKqmMh3JhsudFD1Qxyrozix2bL/Q14cWvCYpNvSzjsyctHV7Hen3WEZ24/EZmN
         sNcGgqQSzjsaIHzRQjfMs0QdWUA+SPcoT6Jv3FQEM1T+4Vmc3xqTev7WEfBNRejLwuA1
         sDVSCy396aUkym4yc1QH6x61Cv9/fKMBVI+YYlblPj7DZtoI7LjSFXkAOPg9AmGZ7TWl
         v6Ow==
X-Received: by 10.152.113.34 with SMTP id iv2mr9454631lab.20.1365989078494;
 Sun, 14 Apr 2013 18:24:38 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Sun, 14 Apr 2013 18:24:38 -0700 (PDT)
In-Reply-To: <CACsJy8CTmh2eMDqBpr0agiTGcHkP_AQBLLg2A4HM203u9G1v9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221173>

On Sun, Apr 14, 2013 at 7:55 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Apr 15, 2013 at 9:54 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sun, Apr 14, 2013 at 6:46 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Mon, Apr 15, 2013 at 9:22 AM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> On Sun, Apr 14, 2013 at 5:31 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>>> On Sun, Apr 14, 2013 at 11:46 AM, Felipe Contreras
>>>>> <felipe.contreras@gmail.com> wrote:
>>>>>> +       char fancy[80];
>>>>>>
>>>>>> -       if (show_upstream_ref)
>>>>>> +       if (show_upstream_ref) {
>>>>>>                 ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
>>>>>> +               if (want_color(branch_use_color))
>>>>>> +                       snprintf(fancy, sizeof(fancy), "%s%s%s",
>>>>>> +                                       GIT_COLOR_BLUE, ref, GIT_COLOR_RESET);
>>>>>> +               else
>>>>>> +                       strncpy(fancy, ref, sizeof(fancy));
>>>>>> +       }
>>>>>> +
>>>>>
>>>>> Please use strbuf for "fancy".
>>>>
>>>> Why? We would need to initialize and free it. What's the advantage?
>>>
>>> From a quick glance, I don't see any gurantee that "ref" (plus ansi
>>> codes) will always fit in 80 bytes.
>>
>> Would changing it to 1024 (MAXREFLEN) fix it?
>
> You still need to take ansi codes into account. I think it's easier to
> just use strbuf.

I'm not sure what you mean. If there was an issue with snprintf, then
there would be with this in refs.c:

	if (recursion > MAXDEPTH || strlen(refname) > MAXREFLEN)

Cheers.

-- 
Felipe Contreras
