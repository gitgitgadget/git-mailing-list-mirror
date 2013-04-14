From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] branch: colour upstream branches
Date: Sun, 14 Apr 2013 18:54:21 -0500
Message-ID: <CAMP44s38e4n_jKC-f973JJUXuxkD2dqP+ECwzxvUMWxit2P2PA@mail.gmail.com>
References: <1365903985-24920-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DdBkPDXORxv08cFi+i5Q4WiBjjbNf9GyB4hv+t-K=wRQ@mail.gmail.com>
	<CAMP44s2j-Cqksu29fJRTqDNGBNi1tZkE0gfgj69K-ckFwVgnRg@mail.gmail.com>
	<CACsJy8AGFEEkS2qQygnbZOorGv=DKc2OgC-nZ47+k2oYGBBD2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 01:54:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URWko-0000nX-Dl
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 01:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab3DNXyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 19:54:24 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:47286 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394Ab3DNXyY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 19:54:24 -0400
Received: by mail-la0-f47.google.com with SMTP id eh20so2859574lab.34
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 16:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=7PIsHWeXqW2WzZgETBwoKZ0mb5JWp7UV9MYzH/h+RVw=;
        b=BZfUHDY7K25Fa0gG3Pnlf2AZw00eSSkBct3BVe0XHFvP+vHldKBelAgJxaZIZ267Cw
         I1Ny8KDJ73NIeCQeVPewUk2JifHPlMt8f54Mj/KuhrFQZPOgyvvINLwhmYliFU073obs
         2paOivYiewTJBHlPdxGYe5KsvmJEUI0MfBp2hoi2pLLxBltPM4YIsM+dAyrK8cJq6LX4
         j89kMjZPTG+nZyh8Fw0AGYikFzNmjKf7TsuYwKMnP+zzigkgp1pfd03Gwf35xImNht5D
         mh/72CRHyXjmtk4G0TXxUh33N+C7rxIL92VCZZ+ASNC++No6hV/DHgJSpKmWFMrNBxCN
         w2EQ==
X-Received: by 10.112.146.133 with SMTP id tc5mr9218693lbb.88.1365983661308;
 Sun, 14 Apr 2013 16:54:21 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Sun, 14 Apr 2013 16:54:21 -0700 (PDT)
In-Reply-To: <CACsJy8AGFEEkS2qQygnbZOorGv=DKc2OgC-nZ47+k2oYGBBD2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221169>

On Sun, Apr 14, 2013 at 6:46 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Apr 15, 2013 at 9:22 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Sun, Apr 14, 2013 at 5:31 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Sun, Apr 14, 2013 at 11:46 AM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> +       char fancy[80];
>>>>
>>>> -       if (show_upstream_ref)
>>>> +       if (show_upstream_ref) {
>>>>                 ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
>>>> +               if (want_color(branch_use_color))
>>>> +                       snprintf(fancy, sizeof(fancy), "%s%s%s",
>>>> +                                       GIT_COLOR_BLUE, ref, GIT_COLOR_RESET);
>>>> +               else
>>>> +                       strncpy(fancy, ref, sizeof(fancy));
>>>> +       }
>>>> +
>>>
>>> Please use strbuf for "fancy".
>>
>> Why? We would need to initialize and free it. What's the advantage?
>
> From a quick glance, I don't see any gurantee that "ref" (plus ansi
> codes) will always fit in 80 bytes.

Would changing it to 1024 (MAXREFLEN) fix it?

-- 
Felipe Contreras
