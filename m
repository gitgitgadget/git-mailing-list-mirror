From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Thu, 22 Aug 2013 17:35:19 -0400
Message-ID: <CAPig+cSEQLk2M+X5QP7mkm846wqqHRCjPHgO7O3URvNcsYO6+w@mail.gmail.com>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	<xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
	<CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
	<xmqqbo4pqvde.fsf@gitster.dls.corp.google.com>
	<CAPig+cQmvRDDc3BHbta_UhCQe9QvbtAm0RJgt6HbtgFAKgo0Vg@mail.gmail.com>
	<xmqq7gfdqumd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 23:35:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCcXM-0001eD-WC
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 23:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330Ab3HVVfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 17:35:20 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:64196 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158Ab3HVVfT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 17:35:19 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so4576776obp.8
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 14:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=crzK/8Wdi8YFaz55tkR5t8WRk85o5un6tsabiimVQ3w=;
        b=Zl9Je8hsVoXC57tjjno1+MhHotMWnRGWly4+pk+9eh0M3fmpokgtwWLB4mVN//ONoR
         it/9RoOMCSk2JdIdKglvDDgWLrhxmO4VdrB+VcRzlENgZZqeLqDXVs1w8Pn8hrwS59Vx
         51fQtE/jxtM7/7B68eLsYrzbeMgeofWUj96OGsx8tVuVV8HB7F0ACr6OLv9SphnQZIp6
         op/ADgWVoBiYmKwizkbhz9OthTlAZxglJtqwDHP7aJYQEQRyCBB9l3/rBbUWDN0oZ4SS
         eborHIulPSxajGYasS0lnxdflCPhfissCZmNWFaVmCxIdqQhbUoJZaMoOgq5sKc/wsFF
         ya/w==
X-Received: by 10.182.113.195 with SMTP id ja3mr16977136obb.46.1377207319199;
 Thu, 22 Aug 2013 14:35:19 -0700 (PDT)
Received: by 10.182.224.167 with HTTP; Thu, 22 Aug 2013 14:35:19 -0700 (PDT)
In-Reply-To: <xmqq7gfdqumd.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: sUNiMgMlF7-5pUSwtTuG6qTk79o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232781>

On Thu, Aug 22, 2013 at 5:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Thu, Aug 22, 2013 at 5:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>
>>>> I can confirm this failure on OS X, however,...
>>
>> Thanks for the explanation.
>
> Now, I am curious how it breaks on OS X.
>
> My suspition is that "ignore_case" may have something to do with it,
> but what 2eac2a4c (ls-files -k: a directory only can be killed if
> the index has a non-directory, 2013-08-15) uses are the bog-standard
> cache_name_exists() and directory_exists_in_index(), so one of these
> internal API implementation has trouble on case insensitive
> filesystems, perhaps?  I dunno.

That's exactly my suspicion at the moment. It's an obvious difference
between Linux and OS X. I'm just in the process of trying to compare
between the two platforms.
