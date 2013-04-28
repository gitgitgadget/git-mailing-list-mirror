From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] clone: allow cloning local paths with colons in them
Date: Sat, 27 Apr 2013 21:48:33 -0400
Message-ID: <CAPig+cQ+XQYyg2ihvfbZeSApBfWqpLYtq58Jv3iagS5w_iHXbQ@mail.gmail.com>
References: <20130422153516.GB11886@sigill.intra.peff.net>
	<1367033778-13923-1-git-send-email-pclouds@gmail.com>
	<7vip37u11a.fsf@alter.siamese.dyndns.org>
	<CACsJy8DEMrv08D3wGvebV+W73TA8eTH58KHybXpQQbsSJ5NKZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Niedier <jrnieder@gmail.com>,
	William Giokas <1007380@gmail.com>, fsckdaemon@gmail.com,
	Daniel Barkalow <barkalow@iabervon.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 03:48:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWGjH-0003fI-0t
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 03:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750Ab3D1Bsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 21:48:35 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:62181 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758Ab3D1Bse (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 21:48:34 -0400
Received: by mail-la0-f44.google.com with SMTP id ed20so4548014lab.3
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 18:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=O28c+5DxcWUMNaCIwad9YqBSoP6PjbqvgA4/QIS4VlM=;
        b=a47wQtsOJG2JhMwsIcf5WmSgS5MAo6tNUI4HVx6QxYJCBfYEsNXGuFlYBeGV9IXqtT
         +o7RBGlCOjV++S87oWh/0GcDOZ2GYW/YvalfSCVJ/LPblEeXuA5toPaOvchQdvwXBoUA
         10ks6azWKQ3xZlS0neOklaZ9DAqepU3Foc+khbqfQMLP1QYT4nQ9IZdGD6PX91T67k8C
         1sVUOc+icpXi6kAl6b77x55DsDXDv+WcABYWMqKHFsa64y6FO1C8soRfwcHdVYDyDtXc
         HnMxAo3Gemr+gokSyE8OJ29Jhtp/QYKY3HW8NJGu/HpBgCdbwAijx2pAZil+zq9oSago
         aqrA==
X-Received: by 10.112.130.196 with SMTP id og4mr645139lbb.52.1367113713089;
 Sat, 27 Apr 2013 18:48:33 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Sat, 27 Apr 2013 18:48:33 -0700 (PDT)
In-Reply-To: <CACsJy8DEMrv08D3wGvebV+W73TA8eTH58KHybXpQQbsSJ5NKZA@mail.gmail.com>
X-Google-Sender-Auth: jdbhrUdJ06SMeFUFnOehgDfP0vo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222722>

On Sat, Apr 27, 2013 at 8:19 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Apr 28, 2013 at 4:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> That was fairly hard to grok. Is that equivalent to this?
>>
>>                 if (c == ':' && path < strchrnul(host, '/')) {
>>                         /* is the first slash past the colon? */
>>                         protocol = PROTO_SSH;
>>                         *path++ = '\0';
>>                 } else {
>>                         path = end;
>>                 }
>>
>
> The original code is already hard to grok so I may be mistaken here.
> But I think it's not the same. For the case when c == '/', it will do
> "path = end;", which is unintended. It should keep the current "path"
> value (i.e. == strchr(end, '/')). The use of "strchrnul(host, '/')" is
> good though.

Do you want to take Windows '\' into account also?
