From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 33/83] builtin/apply: move 'root' global into 'struct apply_state'
Date: Tue, 26 Apr 2016 22:13:47 +0200
Message-ID: <CAP8UFD0r-1yNwfxtU0jEK_QgCf4szCV1w_KWxqjBOCNDD42vdg@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-34-git-send-email-chriscool@tuxfamily.org>
	<CAGZ79kaaATDzOHFOmCAANcZmrF_5JGAUYW3Ub1WJ7vSLODVP_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 22:13:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9Mp-000701-KP
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbcDZUNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:13:49 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35530 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbcDZUNs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:13:48 -0400
Received: by mail-wm0-f48.google.com with SMTP id e201so10722560wme.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=WAdTi+twhZVl0LKBsnpNZxZHuLN+8wTDoIFyjTxD0hs=;
        b=qy/Sc0FX/3QaUDzV1bA+jTcUQg87I192nekdQy9GA70+3Wt6UW8wAPfbo1ePG20/xz
         CKsh6JBAyawy6O0L4+FlmQR3dZWFXRVG274bhJ5y9nAbQwkQg8lBEoCh4nogbJvMsPF2
         9NQipgAplcGeLKaA8lh6rwd42UbI2VHQnto0h6z974bCxjNsyQNLL0vgXrgckkquHHgT
         KV/kdNubeNrFLb5KsRLd0nCMJ9XeFFTky5WCSSJCj7Qi2NVSskiMlZ50n0K6y7cVW23L
         FKs+6SsAg3NWs98lSQtdkv/du3rxvXvjAQdVWq69afMLnQkv03IM8zfK6Z88Nb7g+J9P
         mrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=WAdTi+twhZVl0LKBsnpNZxZHuLN+8wTDoIFyjTxD0hs=;
        b=evovmiDJ/JO1R+N57FZHE+81eX7Prddhc0hqzUorUKliZQngWWFU83JsH91IBbzFj0
         s603dkKWvZtsFuFF0S34qs5uWxx6+61SzcYnaEFY1Dxj95WTdQ9NUisSpV7lK6kxCfBU
         TA5ovpleRMHObUKaHoNAOEDTJKNOeh2R/AddL0rm+n2vUhHzkYjabnqlw/PJIFznNheJ
         JhsPiGnbh0y9yo66GfvI8rYGqkGgMnVTjw3jfr14n8Yy2JYS3CunFniBHVUGo5CDzYu+
         7NwjXFd6nROoZ03vc/vQ6IUc1ML1D0sSHkuCBvytt2n0vIiV03oXO/40mUfdqbDkr60z
         EOmw==
X-Gm-Message-State: AOPr4FWDKm3w8SKrzyvbcCoTQd4+9+fu39yEuBvaL97iYW9PQ0SD2z2qVjjZKDI9aE1hEMXVSKpxgwIWxivMWw==
X-Received: by 10.194.235.39 with SMTP id uj7mr5110793wjc.78.1461701627238;
 Tue, 26 Apr 2016 13:13:47 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Tue, 26 Apr 2016 13:13:47 -0700 (PDT)
In-Reply-To: <CAGZ79kaaATDzOHFOmCAANcZmrF_5JGAUYW3Ub1WJ7vSLODVP_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292658>

On Mon, Apr 25, 2016 at 11:50 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Apr 24, 2016 at 6:33 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>
>> @@ -4630,9 +4644,10 @@ static int option_parse_whitespace(const struct option *opt,
>>  static int option_parse_directory(const struct option *opt,
>>                                   const char *arg, int unset)
>>  {
>> -       strbuf_reset(&root);
>> -       strbuf_addstr(&root, arg);
>> -       strbuf_complete(&root, '/');
>> +       struct apply_state *state = opt->value;
>
> Or even
>
>     struct strbuf root = ((state*)opt->value)->root;
>
> and then keep the next lines as is?

I found it more coherent to have all the option_parse_*() functions do:

    struct apply_state *state = opt->value;

as their first instruction.
