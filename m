From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: Re: [PATCH][GSoC] parse-options: Add OPT_SET_INT_NONEG.
Date: Thu, 13 Mar 2014 01:25:26 +0800
Message-ID: <CAGqt0zxmRkz4Yjahof5QPAdUoG8M4wszk2UDPDJebZs-UDx_qQ@mail.gmail.com>
References: <1394535016-9424-1-git-send-email-yshuiv7@gmail.com>
	<CACsJy8Dq5QyZdzCtew0qF37qThH8+05iTrD-ZOeBgbEukmCY5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 18:25:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNmuN-0003PL-7m
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 18:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbaCLRZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 13:25:29 -0400
Received: from mail-vc0-f181.google.com ([209.85.220.181]:58755 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829AbaCLRZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 13:25:27 -0400
Received: by mail-vc0-f181.google.com with SMTP id id10so4087408vcb.26
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ep9FLTWKBcYWypiis3iKRTBm1Ku6n2nw6cTIwqC50ms=;
        b=Pn3jvaeroov5WL59zy9kNY357t9Rcrxix+DJDNMD881EpycskQtRlsBSvRn8vSSOzO
         zHj9ABFYz5hk0Zr37ivMGTGPuIQUixsbaa8CyMxWT9onP4eEmq5GuDLw3ca8RuQPgp5I
         CKjiKAuYFF+0gIZa6228p63Qlh8AVXUd6rUvribTofMx9GFMkV/FqovIOmt+qJdLwlMi
         vSLN5tne9vyWb2N6dWddCiLa7KriAPc8Yop+uQxpLQr+KxShzHeiMDfykz153nn/FxpG
         /xPPDSDZTGq1fGNhmPag94yxpPZZOfhjW1ogEkilwXKi5j4WCZ6ZP71pa6Aws2IIG0oW
         uuzA==
X-Received: by 10.220.11.141 with SMTP id t13mr1057684vct.30.1394645126576;
 Wed, 12 Mar 2014 10:25:26 -0700 (PDT)
Received: by 10.220.89.209 with HTTP; Wed, 12 Mar 2014 10:25:26 -0700 (PDT)
In-Reply-To: <CACsJy8Dq5QyZdzCtew0qF37qThH8+05iTrD-ZOeBgbEukmCY5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243948>

On Wed, Mar 12, 2014 at 6:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> By convention, no full stop in the subject line. The subject should
> summarize your changes and "add ..NONEG" is just one part of it. The
> other is "convert to use ...NONEG". So I suggest "parse-options:
> convert to use new macro OPT_SET_INT_NONEG()" or something like that.
>
> You should also explain in the message body (before Signed-off-by:)
> why this is a good thing to do. My guess is better readability and
> harder to make mistakes in the future when you have to declare new
> options with noneg.

Thanks for pointing that out, I'll do as you suggested.

>
> On Tue, Mar 11, 2014 at 5:50 PM, Yuxuan Shui <yshuiv7@gmail.com> wrote:
>> Reference: http://git.github.io/SoC-2014-Microprojects.html
>
> I think this project is actually two: one is convert current
> {OPTION_SET_INT, ... _NONEG} to the new macro, which is truly a micro
> project. The other is to find OPT_...(..) that should have NONEG but
> does not. This one may need more time because you need to check what
> those options do and if it makes sense to have --no- form.

Hmm, this microproject has been striked from the ideas page, maybe I
should switch to another one...

>
> I think we can focus on the {OPTION_..., _NONEG} conversion, which
> should be enough get you familiar with git community.
>
>> diff --git a/parse-options.h b/parse-options.h
>> index d670cb9..7d20cf9 100644
>> --- a/parse-options.h
>> +++ b/parse-options.h
>> @@ -125,6 +125,10 @@ struct option {
>>                                       (h), PARSE_OPT_NOARG }
>>  #define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
>>                                       (h), PARSE_OPT_NOARG, NULL, (i) }
>> +#define OPT_SET_INT_NONEG(s, l, v, h, i)  \
>> +                                     { OPTION_SET_INT, (s), (l), (v), NULL, \
>> +                                     (h), PARSE_OPT_NOARG | PARSE_OPT_NONEG, \
>> +                                     NULL, (i) }
>>  #define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
>>  #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
>>                                       (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
>
> To avoid the proliferation of similar macros in future, I think we
> should make a macro that takes any flags, e.g.
>
> #define OPT_SET_INT_X(s, l, v, h, i, flags) {  ....., PARSE_OPT_NOARG
> | PARSE_OPT_ ## flags, NULL, (i) }
>
> and we can use it for NONEG like "OPT_SET_INT_X(...., NONEG)". We
> could even redefine OPT_SET_INT() to use OPT_SET_INT_X() to reduce
> duplication.

I could do that, but it seems only the NONEG flag is used in the code.

>
> While we're at NONEG, I see that builtin/grep.c has this construct "{
> OPTION_INTEGER...NONEG}" and builtin/read-tree.c has "{
> OPTION_STRING..NONEG}". It would be great if you could look at them
> and see if NONEG is really needed there, or simpler forms
> OPT_INTEGER(...) and OPT_STRING(...) are enough.

I've grep'd through the source code, and most of the manually filled
option structures don't seems to have a pattern. And I think writing a
overly generalized macro won't help much.

>
> You might need to read parse-options.c to understand these options.
> Documentation/technical/api-parse-options.txt should give you a good
> overview.
>
> You could also think if we could transform "{ OPTION_CALLBACK.... }"
> to OPT_CALLBACK(...). But if you do and decide to do it, please make
> it a separate patch (one patch deals with one thing).
>
> That remaining of your patch looks good.

Thanks for reviewing my patch.

> --
> Duy
-- 

Regards
Yuxuan Shui
