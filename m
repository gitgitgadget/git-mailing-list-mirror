From: Gaurav Chhabra <varuag.chhabra@gmail.com>
Subject: Re: Error pushing new branch: value too great for base (error token is...
Date: Tue, 11 Aug 2015 12:00:23 +0530
Message-ID: <CAGDgvc3kA4oC=gp7XoPZJNrQ=p6HoUiXgcECG_xdRR=uJ03+aQ@mail.gmail.com>
References: <CAGDgvc3Gxn=pKBfYC+yrUhCmL9X6bqjPVwVokF0qPsXmhx_EaQ@mail.gmail.com>
	<CAPig+cTXO3699MdqSFVDBcnKcHAT=Mkp=c=r3C8F5nT8tfr6gw@mail.gmail.com>
	<CAGDgvc2hc+f5CuPXc2pr5uYd9kniVpuffrb6z416CicxBgVxJQ@mail.gmail.com>
	<CAGDgvc1FJ0K+OLQBj8iXPCnqMFyBD3mp32k0aTztQkKKuxNxtQ@mail.gmail.com>
	<CA+P7+xpKHw8xkpMSjCftmAnMh=J_R9HxhYD48O2-P2WKUH1diw@mail.gmail.com>
	<CAPig+cTB0VU6rmLT1H7sPMNBPE0zKvWmMp_obS5VpZBAi2nYLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 08:30:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP34v-0007Nw-5V
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 08:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047AbbHKGaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 02:30:25 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35611 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928AbbHKGaY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 02:30:24 -0400
Received: by iodt126 with SMTP id t126so1397480iod.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 23:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=ipzIQeoKztpOBxxkTOPRvUQ0ial0fuS8HGUmk7yFWac=;
        b=wP+ZvI32kOUsCko22IzmVExwGIgfHkPHmC1djzeNNGcjJG5ZP8BjeW42QI3Z7tnNTP
         qW5cRrZHPu86F/oXxRDkjbERIvDLaFIjWQ3dcVqAdlOqMJ8/cuLzC4ytNDd/ZbtZEuYe
         PEXXfDF6G+fX3nYkCZXEKqcDtKAfkudupPDl2Y9FCQbfUss14XZ8aFDI+j4CcFiaVzSF
         pRH3qeU6NLDhaauCWBYf2s5ujdvMXklr8diF6URQtRrSj7uTDmOHRr45rNSwaOk7j+Kb
         z36GrLdRvona/9Ja/wOSAzaMpeRcwXwl5o7SM6LYuHaXh52AsuNkgYIs5EgXByUUWK+q
         HEIA==
X-Received: by 10.107.137.96 with SMTP id l93mr26476187iod.60.1439274623698;
 Mon, 10 Aug 2015 23:30:23 -0700 (PDT)
Received: by 10.79.105.2 with HTTP; Mon, 10 Aug 2015 23:30:23 -0700 (PDT)
In-Reply-To: <CAPig+cTB0VU6rmLT1H7sPMNBPE0zKvWmMp_obS5VpZBAi2nYLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275674>

Thanks for the detailed explanation Eric! That really helped clear my
doubts. Also tried with "0x" and it's working fine however, as
suggested by you, i will use '='

Thanks again! :)

On Tue, Aug 11, 2015 at 4:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Aug 10, 2015 at 6:29 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Mon, Aug 10, 2015 at 2:54 AM, Gaurav Chhabra
>> <varuag.chhabra@gmail.com> wrote:
>>> Apologies for the delay in reply! I tried your suggestion and it
>>> works. Thanks! :)
>>>
>>> I'm curious why integer comparison is throwing error. Shouldn't i be
>>> comparing numbers with numeric operator?
>>
>> Yes, but shell doesn't treat hex numbers as numbers. So it will work
>> only if the string is a decimal number.
>
> This particular case deserves a bit more explanation. The expression
> in question was this:
>
>     if [[ "$new_sha" -eq "$NULL" ]]; then
>
> where 'new_sha' was 9226289d2416af4cb7365d7aaa5e382bdb3d9a89.
>
> In Bash, inside the [[ .. ]], it did attempt evaluating the SHA1 as a
> *decimal* number, however, when it encountered the "d", it complained
> that it was outside the allowed range of decimal digits ("0"..."9").
> Had the SHA1 been prefixed by a "0x", the [[...]] context would have
> dealt with it just fine.
>
> Outside the [[...]] context, arguments to -eq do need to be base-10 integers.
>
> Nevertheless, a SHA1 is effective an opaque value. There's little, if
> anything, to be gained by treating it as a numeric quantity, hence
> string '=' makes more sense than numeric '-eq'.
