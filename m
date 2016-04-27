From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 39/83] builtin/apply: move 'ws_error_action' into 'struct apply_state'
Date: Wed, 27 Apr 2016 15:23:26 +0200
Message-ID: <CAP8UFD1nJXK1k2nv+i+Z-woUHFqcjf=u2_NdYyRxF7vTg26xgA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-40-git-send-email-chriscool@tuxfamily.org>
	<xmqqtwiods5n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 15:23:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avPRE-00036L-7R
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 15:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbcD0NX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 09:23:28 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36134 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbcD0NX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 09:23:27 -0400
Received: by mail-wm0-f49.google.com with SMTP id n129so27273008wmn.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=htXB/C1v/S80H/mnEnIWd5Zysz7U9IFeCFvwCqgjzXo=;
        b=i99Ta3UUAgtRz0Tm+Jo0hPDtnQT5OaEwoGt5AgWbqjJD3k9lQoJJXqTdPYr8DRp1Xs
         0wdd6ssAbSZMu/MN9KkiPNuFRJE57Usdntv9JyFTl19Ta6vuoV3QzEF0/zvf9/DE+Zkb
         hM8XF6P91nuh0k4ta5uvmRwhVqyfHgRcPGBVKFlcbdviKu+lTH0HmqUtMDxuLXVPnd75
         nzRe1PYro2Q/UM9jxxLPbUOIVd/VqRlStUobPfnsXtwa9UTk2uXDdub3kH+b5FQNCom5
         w3/E3dPmq51GD0Wp4K8ktp1CboytVA08RMELOsO2L/LYZ7MGIfB7Y4A063z3PKtAn6pG
         D1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=htXB/C1v/S80H/mnEnIWd5Zysz7U9IFeCFvwCqgjzXo=;
        b=BvuJdcmUkgla+9E5rhSUL+20AyTOse6cCb9hog8rxo4OmP8LCqTVNlN5sswimAoMeA
         rEoaRX+MeOTcWo/M7tdFrGKvy8O8Hl5eISHSkWEyb4+EXiq5YMQOGuvvKhXSzp9zQMus
         vgECsoSDi6amEghEuBB76gITtdZFiejvsCfUPz1OeZPXtH6wRdggLFQ5RJRIQcGU2QZv
         GKDC37gOjX0FGnUMGUbl3Dd6U65gtPok/6Yum0zitiKuX8xgNKhDcPkMY0NmYxokhoz1
         HpxP5YNY3tlB0tC4C8c/Nn363K+sIKQqWfN+67/MCunIAaSGumJDy9plVqZAZG+baTIQ
         Tj2Q==
X-Gm-Message-State: AOPr4FX6PpTvCXfDI1U8KayaPUC4X/NyvoSKa81sNRrfO5cx3WTAQW1yaW4VweuvcTPfKiCh25j8WRANkKJLVg==
X-Received: by 10.28.128.83 with SMTP id b80mr10416030wmd.89.1461763406540;
 Wed, 27 Apr 2016 06:23:26 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Wed, 27 Apr 2016 06:23:26 -0700 (PDT)
In-Reply-To: <xmqqtwiods5n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292724>

On Tue, Apr 26, 2016 at 10:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> +enum ws_error_action {
>> +     nowarn_ws_error,
>> +     warn_on_ws_error,
>> +     die_on_ws_error,
>> +     correct_ws_error
>> +};
>> +
>>  struct apply_state {
>>       const char *prefix;
>>       int prefix_length;
>> @@ -80,6 +87,8 @@ struct apply_state {
>>       int whitespace_error;
>>       int squelch_whitespace_errors;
>>       int applied_after_fixing_ws;
>> +
>> +     enum ws_error_action ws_error_action;
>>  };
>>
>>  static int newfd = -1;
>> @@ -89,12 +98,6 @@ static const char * const apply_usage[] = {
>>       NULL
>>  };
>>
>> -static enum ws_error_action {
>> -     nowarn_ws_error,
>> -     warn_on_ws_error,
>> -     die_on_ws_error,
>> -     correct_ws_error
>> -} ws_error_action = warn_on_ws_error;
>
> This is a good example of a variable that needs initialization,
> which is turned into a field in apply_state that needs
> initialization.  It is done here:
>
>> @@ -4738,6 +4743,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>>       state.p_value = 1;
>>       state.p_context = UINT_MAX;
>>       state.squelch_whitespace_errors = 5;
>> +     state.ws_error_action = warn_on_ws_error;
>>       strbuf_init(&state.root, 0);
>
> and we already have these random initial values described here.
>
> As I do not expect that cmd_apply() which is a moral equivalent of
> main() will stay to be the only one who wants to see a reasonably
> initialized apply_state(), I think the patch that introduced the
> very first version of "struct apply_state" should also introduce a
> helper function to initialize it, i.e.
>
>         static void init_apply_state(struct apply_state *s,
>                                      const char *prefix)
>         {
>                 memset(s, '\0', sizeof(*s));
>                 s->prefix = prefix;
>                 s->prefix_length = s->prefix ? strlen(s->prefix) : 0;
>         }
>
> in [PATCH 7/xx].

Yeah, Eric also made nearly the same comment, so in the next reroll
the init_apply_state() is introduced in the patch immediately after
the patch that creates 'struct apply_state' (rather than much later in
the series). I prefer to not introduce it in the same patch as the
patch that creates 'struct apply_state' is already quite big. (But if
you insist, yeah I will squash both patches together.)
