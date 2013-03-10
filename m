From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/6] match_basename: use strncmp instead of strcmp
Date: Sun, 10 Mar 2013 19:14:25 +0700
Message-ID: <CACsJy8C+29ebL37kFC21S-b670-ct2yCOjghLPErjwXz1BoQBA@mail.gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com> <1362896070-17456-4-git-send-email-pclouds@gmail.com>
 <7vy5dvd7yq.fsf@alter.siamese.dyndns.org> <CACsJy8A_4SqLu5L6P0PJ78Lwy12fjL7T2p-KbVEVLJmKNqhyRw@mail.gmail.com>
 <CALWbr2wEJy0p2hcFK_rLtA98koeacE8rS2T=9P130GUFjWKc0Q@mail.gmail.com>
 <CALWbr2x6V6TB9g_nQCgG2r9L__a2wxG28Qi5KTXChHxj5JSQ8w@mail.gmail.com>
 <CACsJy8A4+2t=PMJ+iSFFz-fafkAHYGvm6G4M-qpiO9674sanEQ@mail.gmail.com> <CALWbr2w+HdsOJAXF3974=vx+BtxgCC=bKHetE=ptXTwv7_L0pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 13:15:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEfA3-00087G-E4
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 13:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213Ab3CJMPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 08:15:03 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:37002 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab3CJMPB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 08:15:01 -0400
Received: by mail-ob0-f177.google.com with SMTP id eh20so2485099obb.8
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=kMjhml+kXj3qCkm1VLKSW1DftyzCDB+i0/Bqe5zwzAY=;
        b=Ehmw8dQ01LMRLQB3chQQSIzHVjJhBGDd2LHaVmWe9Be1sxHoXnaR8HJsLf8zwLG0nU
         eiW0k9Svb6ncEQYH1qNNVEV8kwDCXQNEWgbnayqSyE5YgZcfWBWB0Gb4yWqm2hrKEg5y
         Au/eh+bYKZRBdek/40fsEwBVYfBUS/jHiPlQ9Ly5dgrCHLp2qEUlQn5xys+UcDU/9h5h
         dS2Pj8IZY2UlBt6jBgX8NhZyUR8vXaWhkdL2de/D3cv+TYepbP1osp4TBVqSLT4WGWUu
         14/X8X9IEtijHytn6aPfyO/hxyJfk4ZVQQc+ReMj72sT2GKZ5oUmGrZcBAVMDArKsvE0
         1lyg==
X-Received: by 10.182.118.104 with SMTP id kl8mr6136477obb.54.1362917696004;
 Sun, 10 Mar 2013 05:14:56 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Sun, 10 Mar 2013 05:14:25 -0700 (PDT)
In-Reply-To: <CALWbr2w+HdsOJAXF3974=vx+BtxgCC=bKHetE=ptXTwv7_L0pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217805>

On Sun, Mar 10, 2013 at 7:11 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>>> By the way, if we know the length of the string, we could use memcmp.
>>> This one is allowed to compare 4-bytes at a time (he doesn't care
>>> about end of string). This is true because the value of the length
>>> parameter is no longer "at most".
>>
>> We still need to worry about access violation after NUL when two
>> strings have different lengths. That could be avoided in this
>> particular case, but I think it's too fragile.
>
> Why would we need to compare if the strings don't have the same length
> ? We already do that in combine-diff.c:append_lost().

Watching movie and replying to git@ don't mix. You're right we don't
need to compare if lengths are different. What was I thinking..
-- 
Duy
