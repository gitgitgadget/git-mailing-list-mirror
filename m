From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Tue, 10 Nov 2015 18:00:29 -0800
Message-ID: <CAGZ79kb1pDhcP+hN9+C0xK-VYKxfnhvj6a2Len6kOWgmv4+fmQ@mail.gmail.com>
References: <56428A6A.5010406@ramsayjones.plus.com>
	<CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 03:00:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwKiB-0002pt-LM
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 03:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbbKKCAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 21:00:31 -0500
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34562 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbbKKCAa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 21:00:30 -0500
Received: by ykfs79 with SMTP id s79so27812083ykf.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2015 18:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jGa6lP2OsP8P0tBhQCEZqTznXwXXbEuivlBokwiWjVI=;
        b=Hdx/UyhuHkqcsINZBWjvUYlEoSg07F+P/CPC2n+NelWgqS4RWmv31Xex0nrRFug2z/
         qQZD2VeH54vHqA5jFIx8980Ieo6syf1Oc4LWDu7lnEavjLVYvJceHBLNd6PgTi8ZoLxF
         K1slf6lAw6R+49vHoLXgE7gzvrNproZSdvV7E80umPYWZN+OjxIMg7WciHRmd08f0mdz
         tIZi7GPeHKjsXlT8sec/nLniiIYMpn2Npq/y6/oj3WAZnDSXn/R01MsHAmSqPTULVrch
         a8/QG5lt2UvGqL8DABPGOEzac3AlmrGpiR9//PtXv+JdIgC4lP4A2G3dec6/dDQ3Z3r8
         Vy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jGa6lP2OsP8P0tBhQCEZqTznXwXXbEuivlBokwiWjVI=;
        b=ICO07ciZtc6uOr9Y3+Y2B1PJAJ79cZWuuMdKdTbaUpfP/bRAc4F5O1VVhaz3VnBDGS
         bbVIGk6O3ZROGRuAmedIwzJ4U7GOF7OIeFICs0SEeWOpydniieVK3hGPfc/f88pf9Ozj
         8L45JpZsf1SK+b/0XqCN371rXJE6Yh5FnjOmG1JEuGNotTFOIUPWNpXsEISGxBc9URaQ
         NjCIei3YPvnCvWpg67D2giXK5oVhp7KkXi3uDQeCCVXTCUpCfW6FDzPtDqC0QpGY9cE4
         Q9AZbFTe9grNpgE7Ady5m9vaDrTyLSj2gnPTA0FRV08mk4p4n214yMHiiYWaCUU2tBLm
         TJeQ==
X-Gm-Message-State: ALoCoQmgU0bJ/bk4ALnAcTfgf8iNaaP11IYpXZt/ISxQi1ZgkbfiJ9eZfxwgGqoGCEr56lOCfgIE
X-Received: by 10.13.214.19 with SMTP id y19mr6615588ywd.63.1447207230017;
 Tue, 10 Nov 2015 18:00:30 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Tue, 10 Nov 2015 18:00:29 -0800 (PST)
In-Reply-To: <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281142>

On Tue, Nov 10, 2015 at 5:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Nov 10, 2015 at 7:23 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>> Commit f8117f55 ("http: use off_t to store partial file size",
>> 02-11-2015) changed the type of some variables from long to off_t.
>> The 32-bit build, which enables the large filesystem interface
>> (_FILE_OFFSET_BITS == 64), defines the off_t type as a 64-bit
>> integer, whereas long is a 32-bit integer. This results in a couple
>> of printf format warnings.
>>
>> In order to suppress the warnings, change the format specifier to use
>> the PRIuMAX macro and cast the off_t argument to uintmax_t. (See also
>> the http_opt_request_remainder() function, which uses the same
>> solution).
>
> I just ran across the problem when building 'next' on my Mac and was
> about to investigate, so am happy to find that the work has already
> been done. Thanks.
>
> My machine is 64-bit, though, so perhaps it's misleading to
> characterize this as a fix for 32-bit builds. In particular, off_t is
> 'long long' on this machine, so it complains about the "long" format
> specifier.

+Lars

I wonder if 32 bit compilation can be part of travis.
