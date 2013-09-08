From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 17:38:50 -0500
Message-ID: <CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908172605.GF5359@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 00:39:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIndO-0002YC-9F
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 00:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806Ab3IHWix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 18:38:53 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:56717 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab3IHWiw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 18:38:52 -0400
Received: by mail-lb0-f172.google.com with SMTP id x18so4476448lbi.3
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 15:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AF8q9go2SbwziGpjxoWBp9+/PVqpXMZ9GB46ttW0V2Q=;
        b=BAURzgONwJ+AZIb+7bB4YgYAQrlguTZvJBTEG65+KOwACLN/VD5eGCJlzVsAo0RTf+
         P/tNEGJXA4oh4TVmsAWOy0asRTqsxJKwZz/VQ/P44Wd7GPAz+k7zOn6XTxyk4VlL6l6/
         SKJmva/wXTMVjrIvd1f48HPOA9pejXsAl/Pb263UGmnGLgrt97HfQM3f8fn/O2VDuGJx
         YSBoUduoi9bwq6z4mNhVW8d02EkEjnwJv31hljVI1RlHVSdgkZ8/wNkiNX3n0xSe4t1Z
         gMTJtHDOqU2kwFH3PCCVulIxgynrMSe4fYa/3ihKU8nJS9SDZGDGFUOQZ5xKVKgaaSfo
         tWcA==
X-Received: by 10.152.9.37 with SMTP id w5mr3816951laa.23.1378679931056; Sun,
 08 Sep 2013 15:38:51 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 8 Sep 2013 15:38:50 -0700 (PDT)
In-Reply-To: <20130908172605.GF5359@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234272>

On Sun, Sep 8, 2013 at 12:26 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Sat, Sep 07, 2013 at 11:37:13PM -0500, Felipe Contreras wrote:
>> On Sat, Sep 7, 2013 at 11:18 PM, Jeff King <peff@peff.net> wrote:

>> >   $ hack hack hack
>> >   $ svn commit ;# oops, somebody else committed in the meantime
>> >   $ svn update
>> >   $ svn commit
>> >
>> > Those people would now have to learn enough to choose between merge and
>> > rebase when running the "git pull".
>>
>> But that's only if they don't care about the shape of history. In my
>> experience the people that cling more to centralized VCS do not like
>> merges, so they rebase everything to make it a straight line. That is
>> much more "svn-like".
>>
>> So chances are they are already doing 'git pull --rebase' (or
>> similar), so their workflow wouldn't be affected.
>
> We end up squashing each project branch into one commit (usually using
> git reset --soft), so we don't care about the shape of history.  Over
> the course of a project branch, in fact, there may be many merges from
> the main release branches (including other projects), so history is
> going to be very messy otherwise.

Yeah, but the key question at hand in this discussion is; what happens
when 'git pull' stops working for them, and they don't know what to
do, will they choose 'git pull --rebase' by mistake?

I say the answer is no, because:

1) As you say in your scenario, somebody is telling these guys what to
do, so when 'git pull' fails, somebody will figure out that they were
doing a merge, so 'git pull --merge' is what they want to type from
now on.

2) Git itself would be warning them for months that a 'non
fast-forward was found, and a merge will be done for them', so when
the warning turns to an error, they'll know they want a merge, so
they'll do 'git pull --merge', either because the warning told them
that's git was doing all along, or because they figured that out by
googling, or reading the man page, or whatever.

Either way, it would not be a big deal for these people, their
user-experience wouldn't be totally broken by this proposed change,
and that is the important conclusion.

-- 
Felipe Contreras
