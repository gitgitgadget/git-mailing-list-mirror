From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Unexpected cherry-pick behaviour
Date: Sat, 14 Dec 2013 10:40:14 +0100
Message-ID: <CALWbr2y1YDX0dzjpZoF8WL4+ND+8drurH+Wrf1wBs_-=0datOA@mail.gmail.com>
References: <118044938ad8ebf6b069bcc1d220a986@matos-sorge.com>
	<xmqqvbywts9d.fsf@gitster.dls.corp.google.com>
	<7050e7272bb83d083a56a2c391228ed8@matos-sorge.com>
	<CALWbr2zPPnDiv7oVBhnM9dSW=pfz2jUA_A5u_gk2ttgXTStvkw@mail.gmail.com>
	<beee32a53ece8b839578703deb851eaa@matos-sorge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	git-owner@vger.kernel.org
To: Paulo Matos <paulo@matos-sorge.com>
X-From: git-owner@vger.kernel.org Sat Dec 14 10:40:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vrlhy-0002yE-Kk
	for gcvg-git-2@plane.gmane.org; Sat, 14 Dec 2013 10:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372Ab3LNJkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Dec 2013 04:40:17 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:44680 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab3LNJkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Dec 2013 04:40:15 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so3444274pdj.12
        for <multiple recipients>; Sat, 14 Dec 2013 01:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=U3YKuybtc0o0xvfUSfdytOiqH8Y+t0GBTXOzECaEdxA=;
        b=MQM4T9mPFrjzzEVUdWnAasU3XaChIIZ3fsG+mf2T153hgl+WrafnKBS6Xh6phGjhPE
         fa6g2N7isqT52OHCltpgAkDIr7V6rSvVGNy80SaV+YDxvKwZ7TefGUeFPBxdNE9yxLnv
         pS9lBDFGvPhtMfSy2PI1h5BS2GzawkwUY5ClcNCHZ3vy0EwO8Uo0G0k3gOgPzxMQRWkD
         d9DZ0Bf02R3EzwbFU2qQ36RYAQI7gr/dMQW1f5rR9azJN+FKGml6n5wpkPPTa4tvfXcw
         nVSAx/rxOw9zRgPOTYfp5PjF311Icl+LpNhWsMLB6saJh6Iu1KIIQX5jsHawCIP4dMHo
         JIZQ==
X-Received: by 10.66.149.135 with SMTP id ua7mr8629204pab.124.1387014014845;
 Sat, 14 Dec 2013 01:40:14 -0800 (PST)
Received: by 10.70.124.228 with HTTP; Sat, 14 Dec 2013 01:40:14 -0800 (PST)
In-Reply-To: <beee32a53ece8b839578703deb851eaa@matos-sorge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239280>

On Wed, Dec 11, 2013 at 12:19 PM, Paulo Matos <paulo@matos-sorge.com> wrote:
> On 11/12/2013 11:09, Antoine Pelisse wrote:
>>>
>>>
>>> I don't know how to interpret the fact that the line you sent (with the
>>> obvious --conflicts being --conflict) outputs nothing...
>>
>>
>> That is expected. git-checkout with this option [1] will reset the
>> conflict on gcc/tree-ssa-threadedge.c file to the initial conflict
>> state, and use the diff3 markers. You should have a new look at that
>> file as you will now be able to see the "ancestor" in the conflict.
>>
>> [1] You can have a look either at git-checkout manpage or here:
>> http://git-scm.com/docs/git-checkout, especially --merge and
>> --conflict options.
>> --
>
>
> Got it, but still not helpful as git is still modifying code out of the
> conflicting zone.

Actually it didn't modify out of the conflicting zone.
This is because you are having a look at a combine-diff which tries to
show both how it changed master *and* the cherry-picked patch at the
same time. If you only want to see the diff applied to master, you
should run:

    $ git diff --ours

You can also have a look at what is currently being applied:

    $ git diff :1:gcc/tree-ssa-threadedge.c :3:gcc/tree-ssa-threadedge.c

By the way, does anybody know a better way to do that ? I happen to do
that quite a lot when fixing complex conflicts and the command is
quite inconvenient (I always end-up forgetting which numbers to use,
etc..).

Hope that helps,
Antoine
