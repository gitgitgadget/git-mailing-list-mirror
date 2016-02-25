From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Thu, 25 Feb 2016 17:07:36 +0700
Message-ID: <CACsJy8CpCrHRGJojx7_kqghp7rEVis3eS790Y81L7vBNnBrtEQ@mail.gmail.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
 <1455772670-21142-26-git-send-email-dturner@twopensource.com>
 <20160218085023.GA30049@lanh> <1455922186.7528.97.camel@twopensource.com>
 <20160220025826.GA9338@lanh> <1456346620.18017.23.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 11:08:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYsqF-0008NA-Cv
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 11:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbcBYKIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 05:08:10 -0500
Received: from mail-lb0-f195.google.com ([209.85.217.195]:34204 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759483AbcBYKIH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 05:08:07 -0500
Received: by mail-lb0-f195.google.com with SMTP id vk4so676570lbb.1
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 02:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VWQT6RjNuAYluhzaH8OLNbxOhbXNmj8C87sfemfi2IA=;
        b=rPRGVxzK4US5EOuWObwNIDCYpLEmLveXYpWFxYSYuJq4f2YMXWeLne8ypGvHN2tGxu
         lx1tyVzy6hPA5dhazwrJezO4xHGeJhFaiRQz1LUPBon7Pt1n/BOfhRZGZPDy4yQA1u2j
         90rVmmbnrLMmyKXApXrnyYaJ5t2CnEfhGe7zYYHqXe4gr8yftKSuXoV9YnyCZg87QVWw
         Go1/JWDwr5X8UrAcouQGKkZQSdsXW4Ie7Pyddxdemf4ZAS9R1vO5V34Iu+D+ni0OkAM8
         OZmO2Nw8W9xMZwSBRo6Ufnjn4jYHIW0lMAinv+61VQuKpPFy40l9I1rgAy3iHOdn82Es
         +PWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=VWQT6RjNuAYluhzaH8OLNbxOhbXNmj8C87sfemfi2IA=;
        b=ViC+9KQft4z/+uFHtfYwJeJAR6cFGo1mE9QkU/wlZ7yGWIuCqTp+q4UEz5l0CJNY8e
         OS9LERI8QIv0ZZPN2OYmIjcvW2X7DNGRS8n9Fb+Eny7DRer03eQoUEOpA4pYeTf8gHQN
         yEPmcerjGCakw6JdSMeiluwsBVL4evlM2c+fCU6+Hv5aUCWWqgAuIXLbsMBOoujAejSt
         pm0m4Hf8bIdpjN4L3e7iGy01LgldvmAQz384phetJJTuFNooL4VbcdcXuC1dxJj6s8Z5
         PhTPxkHR54CgXcyahRZEKdyMXv+vJ9xKpHo6OSLzZDjnuWyLgVKv+pAcI8Cjjq4cJqPH
         N13A==
X-Gm-Message-State: AG10YOQ87xNjgZJn2Ey4NIerTBr4I9t3vSaMFp7futvtJbLOPjn0iQR+9stZllQeRP69BveDrZbSAofglLrFvg==
X-Received: by 10.112.150.133 with SMTP id ui5mr16099601lbb.12.1456394885830;
 Thu, 25 Feb 2016 02:08:05 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 25 Feb 2016 02:07:36 -0800 (PST)
In-Reply-To: <1456346620.18017.23.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287359>

On Thu, Feb 25, 2016 at 3:43 AM, David Turner <dturner@twopensource.com> wrote:
>> > > > > I'm not sure I get this comment. D/F conflicts are no longer
>> > > > > a
>> > > > > thing
>> > > > > for lmdb backend, right?
>> > > >
>> > > > I'm trying to avoid the lmdb backend creating a set of refs
>> > > > that
>> > > > the
>> > > > files backend can't handle.  This would make collaboration with
>> > > > other
>> > > > versions of git more difficult.
>> > >
>> > > It already is. If you create refs "foo" and "FOO" on case
>> > > sensitive
>> > > file system and clone it on a case-insensitive one, you face the
>> > > same
>> > > problem. We may have an optional configuration knob to prevent
>> > > incompatibilities with files backend, but I think that should be
>> > > done
>> > > (and enforced if necessary) outside backends.
>> >
>> > Sure, the current state isn't perfect, but why make it worse?
>>
>> I see it from a different angle. The current state isn't perfect, but
>> we will be moving to a better future where "files" backend may
>> eventually be deprecated. Why hold back?
>>
>> But this line of reasoning only works if we have a new backend
>> capable
>> of replacing "files" without regressions or introducing new
>> dependency. Which is why I suggest a new backend [1] (or implement
>> Shawn's RefTree if it's proven as good with small repos)
>>
>> I have no problem if you want to stay strictly compatible with
>> "files"
>> though.
>>
>> [1] http://thread.gmane.org/gmane.comp.version-control.git/285893/foc
>> us=286654
>
> Won't RefTree have the same d/f conflict issue?

It's trees all the way down if I understand it correctly, so yes
RefTree should have d/f conflict issue as well.
-- 
Duy
