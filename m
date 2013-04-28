From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: allow cloning local paths with colons in them
Date: Sun, 28 Apr 2013 09:15:04 +0700
Message-ID: <CACsJy8Brw8h6uL91NpE8S6o2K0HWQfWE0ghBEWg-QbfAZOT-FQ@mail.gmail.com>
References: <20130422153516.GB11886@sigill.intra.peff.net> <1367033778-13923-1-git-send-email-pclouds@gmail.com>
 <7vip37u11a.fsf@alter.siamese.dyndns.org> <CACsJy8DEMrv08D3wGvebV+W73TA8eTH58KHybXpQQbsSJ5NKZA@mail.gmail.com>
 <CAPig+cQ+XQYyg2ihvfbZeSApBfWqpLYtq58Jv3iagS5w_iHXbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Niedier <jrnieder@gmail.com>,
	William Giokas <1007380@gmail.com>, fsckdaemon@gmail.com,
	Daniel Barkalow <barkalow@iabervon.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 04:15:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWH9a-0006K2-IU
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 04:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738Ab3D1CPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 22:15:35 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:50447 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758Ab3D1CPe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 22:15:34 -0400
Received: by mail-oa0-f53.google.com with SMTP id m6so5004270oag.40
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 19:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=s2Il1r6zmdeTsVSyOXkBW92MB21Kfg2fncni3Mb7KAU=;
        b=ms86z1RnvbNKYXHv35VSbMHdWvoOOs0ZTBZYs1l6Uh506LvonxtPkZrnw3SHux45Hv
         OqXvRdzUTEU11yqthIUUaeL+qtDSYkjssXKfvtnFj8voIbZU8OgcqEwG4/kkl2NNjCbQ
         IqXiroj12pMjDEQ7lXWLdykuKi70IkZ5v3HaVZORMShQWYeY2DSflb4S6xfA2Lk854PX
         yBhwsz6BBvBFxZ7zPmJIQXMVK6nCQSq7ni9R6+SZXNoclejWeXU/IKTkn1HThsqXZ2Cw
         Q9JmlRmDcTIB4paaNdmmrm9LUfmDG++Hc3O5uspDB6ufrP+VPoh4orH+0Zlfb1wNVb75
         mh5A==
X-Received: by 10.60.65.68 with SMTP id v4mr21625326oes.13.1367115334445; Sat,
 27 Apr 2013 19:15:34 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Sat, 27 Apr 2013 19:15:04 -0700 (PDT)
In-Reply-To: <CAPig+cQ+XQYyg2ihvfbZeSApBfWqpLYtq58Jv3iagS5w_iHXbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222725>

On Sun, Apr 28, 2013 at 8:48 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Apr 27, 2013 at 8:19 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, Apr 28, 2013 at 4:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> That was fairly hard to grok. Is that equivalent to this?
>>>
>>>                 if (c == ':' && path < strchrnul(host, '/')) {
>>>                         /* is the first slash past the colon? */
>>>                         protocol = PROTO_SSH;
>>>                         *path++ = '\0';
>>>                 } else {
>>>                         path = end;
>>>                 }
>>>
>>
>> The original code is already hard to grok so I may be mistaken here.
>> But I think it's not the same. For the case when c == '/', it will do
>> "path = end;", which is unintended. It should keep the current "path"
>> value (i.e. == strchr(end, '/')). The use of "strchrnul(host, '/')" is
>> good though.
>
> Do you want to take Windows '\' into account also?

Windows path does not allow ':' so it's a non-issue in the first place.
--
Duy
