From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Refactoring hardcoded SHA-1 constants
Date: Sat, 19 Apr 2014 08:12:33 +0700
Message-ID: <CACsJy8AKQwZ__DdkMQ4jnZ5kDBBVD651wXvQ=8u9TN2oVk17UQ@mail.gmail.com>
References: <20140418221841.GC57656@vauxhall.crustytoothpaste.net>
 <20140418224049.GA15516@google.com> <5351BE03.2070604@alum.mit.edu>
 <CACsJy8BMuj8jcsODGLPYxakh2pMV83AqsiMb7XFNkNwdGc7NLg@mail.gmail.com> <xmqqy4z29lg0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 03:13:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbJqB-0004m3-7M
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 03:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbaDSBNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 21:13:06 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:59619 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbaDSBNE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 21:13:04 -0400
Received: by mail-qg0-f49.google.com with SMTP id j5so1473233qga.36
        for <git@vger.kernel.org>; Fri, 18 Apr 2014 18:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UIY/QlYFfdOYMQzLwu8Vpy7t6KH8160Le/ew6Np/WPQ=;
        b=PrsOUR9ztO2A4vcgRIrc/yNjCsNvsIRxwhVsiOhSZmBMAY9cztbtpu1zwhR5MUS50A
         8Fa11HZITgTAF0lchQDgpFyI0pZU9EG55zU16il0uiJg0hbhsPWKW6CIp0IQzVdf/IdE
         hyz4MLdalhorzVXG31rFD3hnT2M0U8uYdkdpIC7Hp9Tl2CyD6gR1WNo409SWrW8zJfv9
         ZHjIEJ2siqRTVT2IQDxPWw/GiB7lAzFjX2I7socvXjAW0YZTlIDdWJLnvFPW+BLY5T4i
         eqjlci65YOPgpvl3PmhaElaJaAO/lQrCF7aKtum9n4qG6buQehRWjmIXVPbOEx6e2vrr
         ym+g==
X-Received: by 10.224.66.4 with SMTP id l4mr22688554qai.70.1397869983368; Fri,
 18 Apr 2014 18:13:03 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Fri, 18 Apr 2014 18:12:33 -0700 (PDT)
In-Reply-To: <xmqqy4z29lg0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246497>

On Sat, Apr 19, 2014 at 8:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sat, Apr 19, 2014 at 7:06 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> Let the brainstorming (and bikeshedding) begin!
>>>
>>> 1. GIT_OID_RAWSZ / GIT_OID_HEXSZ
>>>
>>> 2. OID_RAWSZ / OID_HEXSZ
>>>
>>> 3. OID_BINARY_LEN / OID_ASCII_LEN
>>>
>>> 4. BINARY_OID_LEN / ASCII_OID_LEN
>>
>> 5. sizeof(oid) / ASCII_OID_LEN
>
> Can we safely assume sizeof(struct { uchar oid[20]; }) is 20, or on
> some 64-bit platforms do we have to worry about 8-byte alignment?

That's an interesting point. sizeof(that struct) on x86-64 returns 20.
I haven't checked about other platforms.

We have some ondisk structures around that contain unsigned char [20]
if I remember correctly. Those would need to be handled with care
during the conversion if this becomes a real issue.
-- 
Duy
