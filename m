From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 1/2] imap-send.c: implements the GIT_CURL_DEBUG
 environment variable
Date: Mon, 4 Apr 2016 18:08:38 +0200
Message-ID: <CA+EOSBkY-Tsz3ZAfK3uAXJsrE585cOhyxjsU4FhgDMFC-ypkUg@mail.gmail.com>
References: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
	<xmqqtwjljq97.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 18:08:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an73U-0005Mg-Cu
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 18:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbcDDQIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 12:08:40 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:35691 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbcDDQIj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 12:08:39 -0400
Received: by mail-vk0-f65.google.com with SMTP id e185so21166029vkb.2
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=nVqNauEsvryCPhL6uXYUZpYCWtx75KutuH+tKk+XiUE=;
        b=Y0wS3tP8duTyU9mJEYQ8ptwLdLFY4Es/gA76539oDU2CT5ZjrV2OcuTyhktRMDshV1
         KNOMsG9V1WQQQ2HOZVeNTkCX+f/pkDihkeu9JTRRRZmFuauFeXabD0AObKfVeh+7Kql/
         DLWRabLaTtMuvazxCXdwpH42KCgmxpYzyMatbyXXlQ3bJHP7qanmYN0jlhL3pT8bfHF9
         Eo658oHHvvHzMVPy72iIV9ynORLdv5c16lhoiQSreMMgv0ZIGjWYl/edrFfMbRVf8iMi
         GZJ8qCeT3bAb85Nj2l95BdK7DhGXityPWRuEw9QPwlTYyemGFX4J+aw2pg3Tc3P2tWKZ
         jMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=nVqNauEsvryCPhL6uXYUZpYCWtx75KutuH+tKk+XiUE=;
        b=gr9uI11HibREKpiXlrfIshbRDDMwJz+o4dzugwdhk8harKJ2KGauadpwpfrfkIawFW
         8El5CEvGyF4Vdrw7egoPwRebGVXkjf4iW3I0iDzll0taufnacujGFwIkS+f2aLp3A8Xs
         LF26oJqmfDhCjrDADsssljxQ/kCSC1EYZigz7oR1xIIrs/30Bl/Rt9j2H3GQQpsOKa5Q
         XLF1XZPVk71D6JIkUoNKR7L0t1dACZPRHVstMN8rZBCxrRGTPvVWwiTFiNqPZvieQl7p
         vSdMWcDvRuL8rxfh0XxGK07Oe/mtjIaJM7bJbW2b1gTO8QKMau7cgTMji4jJjbS522dT
         Zauw==
X-Gm-Message-State: AD7BkJIQeS4fxKVCz3Oaou/m4e9j+w8cqMF8YOOtr59gIhvKKyaOCapJ6gxuXnMd5ws8orw0We8/X5b6oPEioQ==
X-Received: by 10.31.4.208 with SMTP id 199mr5854026vke.110.1459786118842;
 Mon, 04 Apr 2016 09:08:38 -0700 (PDT)
Received: by 10.31.56.10 with HTTP; Mon, 4 Apr 2016 09:08:38 -0700 (PDT)
In-Reply-To: <xmqqtwjljq97.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290693>

2016-04-01 17:35 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> Implements the GIT_CURL_DEBUG environment variable to allow a greater
>> degree of detail of GIT_CURL_VERBOSE, in particular the complete
>> transport header and all the data payload exchanged.
>> It might be useful if a particular situation could require a more
>> thorough debugging analysis.
>
> My impression is that using GIT_TRACE_* is the more mainstream
> trend, and it may be beneficial to work any new debugging aid like
> this one to fit within that mechanism.

I thought about it, and I agree with you. The idea could be

- Call the variable GIT_TRACE_CURL_DEBUG instead
- Add the new GIT_TRACE_CURL_VERBOSE variable, keeping
GIT_CURL_VERBOSE for compatibility
- Documenting these GIT_TRACE_CURL_XXX variables (GIT_CURL_VERBOSE
it is not even documented i think)
- perhaps use the git trace api in doing these new patches

Look reasonable? It seems reasonable? I'd like your own opinion

Thank you for your suggestion
>
> I am not saying new GIT_*_DEBUG is wrong.  I just wanted to make
> sure you have considered doing this as a new trace in GIT_TRACE_*
> family and rejected that apporach with a very good reason, in
> which case that rationale deserves to be in the log message.
