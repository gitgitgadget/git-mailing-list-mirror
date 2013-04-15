From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] branch: colour upstream branches
Date: Mon, 15 Apr 2013 10:55:02 +1000
Message-ID: <CACsJy8CTmh2eMDqBpr0agiTGcHkP_AQBLLg2A4HM203u9G1v9g@mail.gmail.com>
References: <1365903985-24920-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8DdBkPDXORxv08cFi+i5Q4WiBjjbNf9GyB4hv+t-K=wRQ@mail.gmail.com>
 <CAMP44s2j-Cqksu29fJRTqDNGBNi1tZkE0gfgj69K-ckFwVgnRg@mail.gmail.com>
 <CACsJy8AGFEEkS2qQygnbZOorGv=DKc2OgC-nZ47+k2oYGBBD2Q@mail.gmail.com> <CAMP44s38e4n_jKC-f973JJUXuxkD2dqP+ECwzxvUMWxit2P2PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 02:55:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URXhq-0002Zv-Dy
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 02:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767Ab3DOAze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 20:55:34 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:60444 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab3DOAze (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 20:55:34 -0400
Received: by mail-ob0-f176.google.com with SMTP id wd20so736592obb.7
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 17:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=06YqAzufbbCjx5TIsMhCBrg5vUG08TgRsReSM2GXV9I=;
        b=Lt3FEbw+0Dx6Ee1BQ/wTk4YjjrogCfS0he4Gy9KhuN+w2mGmjVCAMa9K+sB8ASxYXe
         PC5ijk0f77iSziPTfoQbjLBiQQ2Kf4KFTiMcazDvM6an9jWhHxI5g57W2sdjNV0Ss/a5
         0Cd/cFNkZILG5gjgAXYiLVlXOBYF5EjrNm6evP29JqfSfBf/fpLlSZiyrSegdsMDOL+E
         TUNWb4Lx6Y88eG1GjLaBJUws+/VWr+51z2Fm1TPB1lQJJ1Fp/VhbSjhMYYOzUk5EztBk
         cb4mZSs/HhOidNb6VZwFeyLikVxDKMGPPw5Gss4w9eajt/ylkioNy1VHLIgz+5sOAzyd
         2MIw==
X-Received: by 10.60.117.35 with SMTP id kb3mr7040334oeb.16.1365987333207;
 Sun, 14 Apr 2013 17:55:33 -0700 (PDT)
Received: by 10.76.122.163 with HTTP; Sun, 14 Apr 2013 17:55:02 -0700 (PDT)
In-Reply-To: <CAMP44s38e4n_jKC-f973JJUXuxkD2dqP+ECwzxvUMWxit2P2PA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221171>

On Mon, Apr 15, 2013 at 9:54 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sun, Apr 14, 2013 at 6:46 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, Apr 15, 2013 at 9:22 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Sun, Apr 14, 2013 at 5:31 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>> On Sun, Apr 14, 2013 at 11:46 AM, Felipe Contreras
>>>> <felipe.contreras@gmail.com> wrote:
>>>>> +       char fancy[80];
>>>>>
>>>>> -       if (show_upstream_ref)
>>>>> +       if (show_upstream_ref) {
>>>>>                 ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
>>>>> +               if (want_color(branch_use_color))
>>>>> +                       snprintf(fancy, sizeof(fancy), "%s%s%s",
>>>>> +                                       GIT_COLOR_BLUE, ref, GIT_COLOR_RESET);
>>>>> +               else
>>>>> +                       strncpy(fancy, ref, sizeof(fancy));
>>>>> +       }
>>>>> +
>>>>
>>>> Please use strbuf for "fancy".
>>>
>>> Why? We would need to initialize and free it. What's the advantage?
>>
>> From a quick glance, I don't see any gurantee that "ref" (plus ansi
>> codes) will always fit in 80 bytes.
>
> Would changing it to 1024 (MAXREFLEN) fix it?

You still need to take ansi codes into account. I think it's easier to
just use strbuf.
--
Duy
