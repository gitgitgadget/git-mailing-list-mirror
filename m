From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/4] attribute regression fix for maint-1.8.1 and upward
Date: Wed, 27 Mar 2013 11:01:14 +0700
Message-ID: <CACsJy8BtmyPvU1Zrhdm9mEWTwk9GBuMEs-8ycpBHM79dGyCrMw@mail.gmail.com>
References: <20130323083927.GA25600@sigill.intra.peff.net> <1364323171-20299-1-git-send-email-gitster@pobox.com>
 <20130327011309.GA10946@duynguyen-vnpc.dek-tpc.internal> <7vmwtpqyui.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, peff@peff.net, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 05:02:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKhZ0-0004Vd-Np
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 05:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809Ab3C0EBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 00:01:46 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:50361 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab3C0EBp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 00:01:45 -0400
Received: by mail-ob0-f182.google.com with SMTP id ef5so5197436obb.13
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 21:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=FhkYmx8WkPdg5T45e1BJM1aIuLBzp/xhhPd4UeSvBI0=;
        b=g8vBO7xcxIq7F5SFrwvBo5DMDkX6O57OLIS7Y9q38DQsvAsDvua38Mgnps/xajlJ5+
         jrU5YpZwjxorvl+mHM7Qo4FBEAlyw+afJuAAZVv8mbkv2mxqhBA9g6/8P0my8RBTVREO
         cpJq64u0kbzfMNP/LCL+vKTSgIOA9PY+3XFfeOmJRcT1w0ShhgksS6m2S/bM5qqizvD3
         4XrCurZbxfw4mn+TAMiy+Ic4Fm2+mU2eoJdRdUPxdppF51qxOAP7TBVhSK6TzO0fe2BA
         98/3Z3WYPWNWmWqBfhcah1rYULwRL1s7VPYN9capO2Fkw7BP33io2CTbh4mDYcnM1g0d
         w/6g==
X-Received: by 10.60.12.202 with SMTP id a10mr15222862oec.16.1364356904907;
 Tue, 26 Mar 2013 21:01:44 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Tue, 26 Mar 2013 21:01:14 -0700 (PDT)
In-Reply-To: <7vmwtpqyui.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219238>

On Wed, Mar 27, 2013 at 10:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> How about this? git_check_attr() now takes dtype as an argument
>> and the caller must not add the trailing slash.  This could be
>> split into two patches, one for git_check_attr prototype change,
>> and the other the real meat.
>
> "git check-attr" fundamentally cannot know, but aside from that do
> all the callsites know if the path in question is a directory or
> not?  My impression was that there are some cases you do not
> necessarily know.
>
> "Add slash when you _know_ it is a directory, but otherwise pass the
> path without trailing slash." is easier to understand than "Pass
> 040000 if you know it is a directory, but otherwise pass 100644",
> exactly because "otherwise" in both of these instructions include
> the case where the path in question _is_ a directory (you just do
> not know what it is).
>
> I do not particularly like the "trailing slash on the basename"
> approach, but it feels less bad than passing dtype down.

Fair enough. I'll rebase my changes on top of yours as long term
cleanup. Maybe I can make nwildmatch take patternlen too.
-- 
Duy
