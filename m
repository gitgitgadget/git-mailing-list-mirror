From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/5] read-cache: add watchman 'WAMA' extension
Date: Tue, 3 Nov 2015 20:17:38 +0100
Message-ID: <CACsJy8Bb0BVsCdgDQe9JWPUOR9Hw+963Zph3HMZA6Zmzr2THMA@mail.gmail.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
 <1446386146-10438-2-git-send-email-pclouds@gmail.com> <1446501799.4131.24.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 20:18:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zth5z-00040a-EA
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 20:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755808AbbKCTSL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2015 14:18:11 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34748 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbbKCTSK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 14:18:10 -0500
Received: by lfgh9 with SMTP id h9so29795360lfg.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 11:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BiKLc0e6UEJpN2sq4JV9Nm/PY9lgSev/BIyBxfBcnYY=;
        b=DKldTIermEnTQ5zRhXkO9GVsjTDzJBfRS7tdO0pJhINeASdqhxzNKS7BqyyplB5CpH
         qMCYZ9COJzZ3oyZZoT4TQTtS5k5RDHqvEDLXj/n6Elth1w3BjdDE2w4fNuKq/s/6HxvZ
         QkWv+tASFFzZzbJSwlvS8DqEXPripXjm6Zi1MRb7sX8IlkPvhPYYfQho3ZWqvLo7dKYL
         C3o8DB1siWoYCb1AdrdGxWJzqX/QTZitmd1cmXWSKa8CDL0YHvVSeAmSPX53hYwN7Umk
         J6/j3SrxwvFmBnmkVvoJc/9N4Yz49F66tC2es9PmWL2b10Kbm50ePgMC8xKdI8V4bZ17
         yApQ==
X-Received: by 10.112.63.71 with SMTP id e7mr6837903lbs.115.1446578288751;
 Tue, 03 Nov 2015 11:18:08 -0800 (PST)
Received: by 10.112.255.229 with HTTP; Tue, 3 Nov 2015 11:17:38 -0800 (PST)
In-Reply-To: <1446501799.4131.24.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280809>

On Mon, Nov 2, 2015 at 11:03 PM, David Turner <dturner@twopensource.com=
> wrote:
> On Sun, 2015-11-01 at 14:55 +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy wrote:
>>
>>+#define CE_NO_WATCH  (0x0001)
>
> This name seems very confusing to me.  CE_NO_WATCHMAN_STAT?
> CE_UNKNOWN_TO_WATCHMAN?

=46iles that are known updated. Maybe CE_WATCHMAN_DIRTY?

> (one reason it may seem more confusing to me than to others is that
> Twitter's code has a concept of files that we don't watch at all e.g.
> Intellij's .idea dir).
>
>> @@ -322,6 +325,7 @@ struct index_state {
>>       struct untracked_cache *untracked;
>>       void *mmap;
>>       size_t mmap_size;
>> +     char *last_update;
>
> Might be worth a comment explaining what this is.

It's the clock value from watchman when we query file status. Will
make a note. Or maybe I should just rename it to watchman_clock.
--=20
Duy
