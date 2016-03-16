From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Thu, 17 Mar 2016 02:36:51 +0530
Message-ID: <CAFZEwPMa3GZS6pvFwr8PLVDqKm5xmMd307nbjhpZSC_ndpw8vw@mail.gmail.com>
References: <CAFZEwPPd2wFqFq2LFEzN2CzhTV6C420SLPcXi1SWE=z2epOYLw@mail.gmail.com>
	<20160316204912.GA1890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:06:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agIef-0000Ek-3N
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546AbcCPVGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:06:53 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:34612 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbcCPVGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:06:52 -0400
Received: by mail-yw0-f174.google.com with SMTP id h129so77499052ywb.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 14:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=JbNee8U+vkEZRoJKLdFz4aNu29jSXV5vVBZ+r8heR30=;
        b=BNMZ3Fq2Odt2IAlFn2hYF7umciq1T+KUFntj+V/W31m/b2tLYYh8CH3Yuiv4rAObZz
         7oFzMfi4bkg9QOF6fZBYtCOqx160aQCXQdM49bZfnWz9rOJzPFN944ui9zPXQc53fcTH
         2cN7yaVLzG5OJQMruLTdOnRx1E7HaGrz24HePou0e/u2a4qCuvde4w3PKwzpxE5Th3tm
         kmBueU26nr2Wm2kRsK5sEc2KqmVsbfGXu4wYgs/lESlbxj9x5w9f4UWm+HD3o6+iCX8L
         o4C7II7S6Q59CeYwXfYAsuimGNEXGRGTFbwF8sZtEb4qcIzbKsMS2YW1YYpD3OMvZ6O7
         yndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JbNee8U+vkEZRoJKLdFz4aNu29jSXV5vVBZ+r8heR30=;
        b=EwykTcgafXVY1zCxl/142Ipas3mbwDLJHpwv91Wv/t4fR4NjM38zKiX+tLSf5MadtE
         1fsOcWbf0yNKYzR3x7QUXX+MgcP7KVD4NoGe1sUphHF36PyVDj01pCFgGY0as6/muR+n
         EMKxX4u0KAurYhCTWt5rBqP9q3f3HAE3vgPh8uFgTa7IkxvvHtquUBUiseuN2sD5kS8T
         FUCmJ3hDxVBWeqtVirOG+mh0Cws0MroWySBrpfx4fqvUii/FPPqHTF76xJixPkp/nKIY
         xhZQSgrMcVDHOz399GjOvfWppsTiTNMaUD8WHlhSp0qC+lIdzPPDxIBI2PKY8/y/bc6b
         QxMw==
X-Gm-Message-State: AD7BkJLhJAfhUeLbiH4q3JSimiDFgIX5dc7gj2OZn0UkhxNXAyWpkDOCEahdXKtXd0Yi1JQ9mB7TdnQyuCNqJw==
X-Received: by 10.129.37.3 with SMTP id l3mr2800656ywl.128.1458162411553; Wed,
 16 Mar 2016 14:06:51 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Wed, 16 Mar 2016 14:06:51 -0700 (PDT)
In-Reply-To: <20160316204912.GA1890@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289035>

On Thu, Mar 17, 2016 at 2:19 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 17, 2016 at 01:21:49AM +0530, Pranit Bauva wrote:
>
>> I noticed that parse-options does not recognize the variable which is
>> set to -1 so as to denote the "unspecified" value.
>
> Right. Like all of the stock parse-options handlers, it does not ever
> read or understand the value passed to it by the caller. It only
> increments or decrements.
>
>> I did the following changes in builtin/commit.c (in master branch not
>> the patch I am working on) :
>>  - static int verbose = -1
>>  - introduced a printf statement after parsing the options to print
>> the value of verbose.
>>
>> When I ran `git commit` :
>>  I get the output that verbose is set to -1.
>>
>> When I ran `git commit -v` :
>> I get the output that verbose is set to 0.
>>
>> When I ran `git commit -v -v` :
>> I get the output that verbose is set to 1.
>>
>> When I ran `git commit --no-verbose` :
>> I get the out that verbose is set to 0.
>> [...]
>> It seems that parse-options just increments the value without
>> considering the -1 flag to denote "unspecified value".
>>
>> Is this a bug?
>
> Not in parse-options, though I think setting verbose to "-1" in the
> first place is wrong.
>
> In general, parse-options does not know or care about the default values
> that callers assign to variables; it just writes to them based on the
> option-type specified by the caller. So the behavior for "commit",
> "commit -v", and "commit -v -v" you show are perfectly reasonable.
>
> But the one for "--no-verbose" is wrong. Parse-options has to write some
> "reset" value, and it does not know what the initial default was. So it
> writes 0. This is the same for options like OPT_SET_INT, and similar for
> string options (where we set it to NULL).
>
> So I think the caller choosing "-1" here as the "not set" value is the
> bug.
>
> -Peff

I agree to you on the point that parse-options should not care about
the value passed to it. But I think plainly incrementing the value of
the variable is not a very nice way. I have an another approach to it.
The parse-options will first store a temporary structure. If there is
some changes (not the "--no-" ones) then it sets the respective
variable in temporary structure to the set value. If "--no-" is passed
then it writes the "reset" value to the respective variable in
temporary structure. If nothing about that options is specified then
it copies the respective variable from original to temporary. After
completing the entire process, it can copy temporary structure to the
original structure.

What are your opinions about this?
