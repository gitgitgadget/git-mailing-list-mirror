From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 4/4] pathspec: record labels
Date: Thu, 12 May 2016 22:26:00 -0700
Message-ID: <CAGZ79kaqDzrJDDdrr4OmH0nO4nSnB3ZLKC3FU-sLt5doHAhmhQ@mail.gmail.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<20160513001936.7623-5-sbeller@google.com>
	<xmqqfutmbmsv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 07:26:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b15bx-0005b1-DQ
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 07:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbcEMF0C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 01:26:02 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34354 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbcEMF0B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 01:26:01 -0400
Received: by mail-io0-f179.google.com with SMTP id 190so120338722iow.1
        for <git@vger.kernel.org>; Thu, 12 May 2016 22:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=7XXXxEpmszgMBllfxeURMstonBupyUFs9yj6lFwz6rA=;
        b=MMk+tNcza2lRzjy5Vhb+5RNALaoPjV+kz7vRjeNKiwzBGWWLGf3poHQ+IvUIXYEkJI
         dH6bHh++Ukt5q/mLgT0OoUXNSRnFqEeu+lxElCYxWpx2ma+jfuVjHIdWYVvgRB8pXml1
         1WI5GsDga1hwTX3yodJ+aGZTGmDpR/0LkhKNsIQmz7475SfYpa/yTlcIg1gjNyopLZcI
         e42Y/cLSVXPvBoKBJldJ4wknJmoVaJSaAWMU0IOnQyblktEf5YkIssH/1/i9jXEe5re7
         WS2HqNv2NAEtnnqI0tum44Izpq12OgLOcUT7FiVOLvnWKaL1QToiPUAm6F253hn2g3nA
         tEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=7XXXxEpmszgMBllfxeURMstonBupyUFs9yj6lFwz6rA=;
        b=HErbmyAyavRFMI0WK1XoUXMyiaFnc8hC8P2RTx/iTASdgTP2RmgVJiNY2kdUP0GDfY
         qXhjeIyg9FgIX9RCn5YTD/pybZJSPgNzw0VdFeLdVIlR/0Ib2JhDBadRWamOY2DMberc
         +/Hfxg9bq90zHecU58HVW95+fJe5T36nGVeYlAwYtf0lh9XFEjiOpsrKbtwZ6bzy9dka
         Echu3cpoeCCFo3sVS9Fzq0V8uwaVqeznrSto+peelrTdpI7Ze08yzhmlnSzIL3jLH0LF
         0m43xsgrrZQEBIvF9vgCAVDeMUmT1F/PmkP2A9cQ6HiSEzgTgVPcRkQqwu7RDuwZCrxS
         xu1Q==
X-Gm-Message-State: AOPr4FWftrJNQLrpbcnUeiea7uTQKpS22TR1EJ/qpeecrnCDNmdPC7EMNDPfdPmJcncqUFrtEgIEo6srh7fm8Tvw
X-Received: by 10.36.253.9 with SMTP id m9mr602340ith.52.1463117160354; Thu,
 12 May 2016 22:26:00 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 12 May 2016 22:26:00 -0700 (PDT)
In-Reply-To: <xmqqfutmbmsv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294502>

On Thu, May 12, 2016 at 9:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
>> index 8ad29e6..a1fc9e0 100644
>> --- a/Documentation/glossary-content.txt
>> +++ b/Documentation/glossary-content.txt
>> @@ -362,6 +362,11 @@ glob;;
>>       For example, "Documentation/{asterisk}.html" matches
>>       "Documentation/git.html" but not "Documentation/ppc/ppc.html"
>>       or "tools/perf/Documentation/perf.html".
>> +
>> +label:<white space separated list>;;
>> +     Labels can be assigned to pathspecs in the .gitattributes file.
>> +     By specifying a list of labels the pattern will match only
>> +     files which have all of the listed labels.
>>  +
>>  Two consecutive asterisks ("`**`") in patterns matched against
>>  full pathname may have special meaning:
>
> I think the new text is stuffed in the middle of the "glob;;" entry.

It is. Will fix in a reroll.

Thanks,
Stefan
