From: =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH] --count feature for git shortlog
Date: Tue, 21 Jul 2015 20:27:28 +0200
Message-ID: <55AE8F10.8080905@gmail.com>
References: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
 <xmqq1tgvdt9u.fsf@gitster.dls.corp.google.com>
 <CAKDoJU4HcGoOS83MKwsQBXztYrDomMd9N-2SKc6iRyNhQQM5Eg@mail.gmail.com>
 <CAKDoJU4MHGa-c=F0m17rgWUCS2xFwiSb1pmDnYztoDnzRaRKCw@mail.gmail.com>
 <19801032cd7af95bc8030f54d740bf48@www.dscho.org>
 <20150630122323.GY18226@serenity.lan>
 <xmqqfv555es7.fsf@gitster.dls.corp.google.com>
 <CAKDoJU7om3DBVYMD_yYet_cGep12RCUePtvFS7=TdW_1rkuE+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	John Keeping <john@keeping.me.uk>
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 20:28:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHcGm-0004sS-D0
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 20:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933421AbbGUS14 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2015 14:27:56 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34037 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932970AbbGUS1z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 14:27:55 -0400
Received: by wibud3 with SMTP id ud3so123389578wib.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 11:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=3eMzAyuiHyqQzxL9JyujdcJoQeYNtOdUzwQUOBs6RHk=;
        b=kUhYhVBMPPYVHn3uo7ss3+q37YmhKSiRU5jp81Ad4nlvmGNYLU0OvLdTgkwahS44Pe
         cpfDN2x8yHPRnzFvErWQlbWQRXVh1jU2qm85RF/9dtfM8/x1ZT3qurr/z/sFSzBDdfcA
         QuiXUVKIt3eQGdE+atOP3Wn1c0oOCYHPTDcOwnxlSFSh+v/VCq3PMvwHG426fGuXDVWy
         vEUdJsPTnIEJXO/CbLSy01wqO7OeZSqrAsioYO1DpEfgWicwG6Y136wX5555uYHnVhtu
         hsY2DyQ2Koq25PjpHHTHlgPUlI3iqaCC1s6bOL2DETwvs+h9ja/HqyY/tBwDTEQLEnq/
         tDGg==
X-Received: by 10.180.83.101 with SMTP id p5mr34571923wiy.52.1437503274590;
        Tue, 21 Jul 2015 11:27:54 -0700 (PDT)
Received: from [192.168.1.53] (eln240.neoplus.adsl.tpnet.pl. [83.21.207.240])
        by smtp.googlemail.com with ESMTPSA id dl10sm38232246wjb.42.2015.07.21.11.27.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2015 11:27:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CAKDoJU7om3DBVYMD_yYet_cGep12RCUePtvFS7=TdW_1rkuE+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274392>

Lawrence Siebert wrote:
> On Fri, Jul 3, 2015 at 10:31 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> John Keeping <john@keeping.me.uk> writes:

>>> Or even `git rev-list --count HEAD -- "$FILENAME"`.
>>
>> Ahh, OK.  I didn't know we already had "rev-list --count".
>>
>> Then please disregard the suggestion to add the option to "log"; it
>> still holds true that the option does not belong to "shortlog", but
>> I do think "how many changes were made to this path" statistics
>> driven by a script should use "rev-list" plumbing, and if it already
>> has "--count" option, that is perfect ;-)
>>
> Junio,
>=20
> I think, respectfully, there is still a benefit to adding it as a
> feature to "log", in that more Git users know of and use "log" than
> "rev-list". I hadn't heard of "rev-list" before joining this mailing
> list.
>=20
> That means "log --count" will get used more. That also means that mor=
e
> eyeballs will hit --count with bug reports and better tests; I've
> already seen 2-3 suggestions for "log --count" tests that "rev-list
> --count" also doesn't have tests for.
>=20
> I would like to keep working on implementing "log --count", sharing
> code with rev-list where possible so they both are improved, unless
> you are saying you won't merge.

Lawrence,

As git-rev-list is (mainly) plumbing for git-log porcelain, I think
what you would need to do to add "--count" support to "git log" is
just parse option, exclude nonsense combinations, and pass down to
the revision parsing machinery.

HTH
--=20
Jakub Nar=C4=99bski
