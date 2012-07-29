From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 19:55:36 +0530
Message-ID: <CAMK1S_iFqQvU+USYf+wcsLFS1QtsytLnPfEhjcAVZa9Vwj8d1w@mail.gmail.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
	<CAMK1S_i7WjrZ=L_LVoTQriW8kKMPd+ABrgowpFCY3ks43E6K7A@mail.gmail.com>
	<20120729141354.GA16223@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 16:25:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvURD-0001w8-Bm
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 16:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab2G2OZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 10:25:39 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38049 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753162Ab2G2OZi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2012 10:25:38 -0400
Received: by lahd3 with SMTP id d3so2997941lah.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=02MlcMHIGEkl49P6GLQJTr5tAr+/SmIns6H6sc5kHcY=;
        b=w/CRKSyPnX1AvycDHUmakHqDzCB79Oy5dRNcbh+8AjPGMCnM+dw4Pq+036Be9/6UQ9
         rWaYXVAm7KXUXYHwC0ha2TeEam0Jn235+M1WulT2EGAD7i8+WUM/ytCCr8sA5i90but3
         JknJYrHR2vA4Imz0KIsmw2xfAdQEw2CeYvPMR4uRabIuMfHgBsWDVAZ4TFfyh/cQ8yUp
         U5yasQdTyKJ/FYEaABvQVaKSpXsx17uVrN7gMV9XJyyEIuWWV5N5iZ9ZwAfdM2oghlgN
         6kJiksp1zrOt0uewuPtdPd1xIyehIPOT0RtdonNba5TYUcBlSrzOeoxRFe8ubIOKTkNk
         v1JA==
Received: by 10.112.102.136 with SMTP id fo8mr4052423lbb.106.1343571936897;
 Sun, 29 Jul 2012 07:25:36 -0700 (PDT)
Received: by 10.112.60.194 with HTTP; Sun, 29 Jul 2012 07:25:36 -0700 (PDT)
In-Reply-To: <20120729141354.GA16223@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202479>

On Sun, Jul 29, 2012 at 7:43 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Sun, Jul 29, 2012 at 04:07:13PM +0530, Sitaram Chamarty wrote:
>> On Sun, Jul 29, 2012 at 3:11 AM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
>> > Hi,
>> > sometimes git communicates with something that's not git on the other
>> > side (gitolite and github for example).
>> >
>> > Sometimes the server wants to communicate directly to the git user.
>> >
>> > git isn't really designed for this. gitolite solves this by do user
>> > interaction on STDERR instead. The bad thing about this is that it can
>> > only be one-direction communication, for example error messages.
>> >
>> > If git would allow for the user to interact direct with the server, a
>> > lot of cool and and userfriendly features could be developed.
>> >
>> > For example:
>> > gitolite has something called wild repos[1]. The management is
>> > cumbersome and if you misspell when you clone a repo you might instead
>> > create a new repo.
>>
>> For the record, although it cannot do the yes/no part, if you want to
>> disable auto-creation on a fetch/clone (read operation) it's trivial
>> to add a "PRE_CREATE" trigger to do that.
>
> Thanks, however I think auto-creation is a great feature for some cases
> and I think there can be even more useable functions if we could get
> user interaction.

For the record, I don't think I agree.  There's a place to create a
human-conversation, and there's a place not to.

If you want a dialog with the server, there should be *other* commands
that do that, instead of overloading git's own protocol.

Since you mentioned gitolite, consider copying the fork command
(src/commands/fork) and munging the code into an explicit wild repo
create.
