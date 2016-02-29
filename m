From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v5 3/3] git: submodule honor -c credential.* from command line
Date: Mon, 29 Feb 2016 11:37:33 -0800
Message-ID: <CA+P7+xoNdsDH0jBz6bcikpeMa-qMR6795U+hKqGDSfu52dJFSw@mail.gmail.com>
References: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
 <1456532000-22971-4-git-send-email-jacob.e.keller@intel.com> <xmqqmvqjcr95.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 20:38:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTdn-0001eV-8m
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbcB2Thy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:37:54 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:34417 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbcB2Thx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:37:53 -0500
Received: by mail-io0-f182.google.com with SMTP id 9so194411234iom.1
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 11:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TcTUwpvzYjyMVonSDCTcswo53YO24nD/QqbZMbn1hm8=;
        b=O45E3SiQZVWpx8JHgjUfFNzzA2QSK4BDkkBNECOquXyvsbhaC2caDwXemqgVLOTF4S
         wCDC5b46qlY87th34daf7l3jok9mnG0MZl9ZNeouyWAQ97K/0U0a14UKffGeuH75kdUy
         ioBQODZojpAvqpoy0EEBLFoQCpGgGQIGCaTSlqpm0St4+FcGnOvaQW7CpHfn5O2n6B1l
         zBBcwWLerUWYm4ekjECQ9UIcr9A4o9I+NiV2sJQftIO4X7A8y0sJ3MoB1wT8etYFJwtO
         qViu3S4q9Dk8Tvs6wz2lvxMwQp4NBiEq8LrwxpTmiDM6TE3C8xFVHwqy5IqHmk8oZrmo
         VTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TcTUwpvzYjyMVonSDCTcswo53YO24nD/QqbZMbn1hm8=;
        b=LPGY5n++RAtD863fTiJdEFerMrWoD3wqkJUjwwbYxEh4oIbiLGv8rboHPFnJzMXH1a
         bAUrRpYOe1Js4q8a5sWKk7/XjZkG9mdXiOxdgaN9OII+NWd4pUyrWaCkiVU3Lp0Zt54M
         7GEg9nyYG9VOknN7pzeGxsswwTc+4lHzSXNV/4XK/C8kTs+Dz9wRDX10s2WpFwqQI3vA
         iwaUn04VoqLiDEFtWgm9HaxVYRfb8+iTLVVbtJX8I8JZccmSmIETU2LhFFLWDpFje2LZ
         oprmVcIe52lH8N6z3Nt3qV5cm3IYWDbXatRz6osGVO812SM5RVfxrVwB2UUFayrdAkzO
         SUMw==
X-Gm-Message-State: AG10YOTub1QEJejNuF8C1FRKto3PjIUofJbzLBPASmDePt0aQshWvlAdmL/LbK/7YauaSKz898Zo2lGhJH+zPA==
X-Received: by 10.107.170.79 with SMTP id t76mr26237547ioe.71.1456774673007;
 Mon, 29 Feb 2016 11:37:53 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Mon, 29 Feb 2016 11:37:33 -0800 (PST)
In-Reply-To: <xmqqmvqjcr95.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287891>

On Mon, Feb 29, 2016 at 10:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> +static int sanitize_submodule_config(const char *var, const char *value, void *data)
>> +{
>> +     struct strbuf quoted = STRBUF_INIT;
>> +     struct strbuf *out = data;
>> +
>> +     if (submodule_config_ok(var)) {
>> +             if (out->len)
>> +                     strbuf_addch(out, ' ');
>> +
>> +             sq_quotef(out, "%s=%s", var, value);
>
> Can a configuration variable that comes from the original command
> line be a boolean true that is spelled without "=true", i.e. can
> value be NULL here?
>

Wouldn't it just be the empty string? I'm not sure. I suppose I can do:

sq_quotef(out, "%s=%s, var, value ? value : "")

Or something?

Thanks
Jake
