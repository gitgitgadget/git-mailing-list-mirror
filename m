From: Dave Borowitz <dborowitz@google.com>
Subject: Re: Bug: send-pack does not respect http.signingkey
Date: Thu, 16 Jul 2015 13:31:55 -0700
Message-ID: <CAD0k6qSZtZN60ExQQfH0mq_rZrOA4Fw0ZeWfX_gr=2btbSYHQw@mail.gmail.com>
References: <CAD0k6qQ=ovEBZn_wje-exBhvW8brRbTgULDr68rmeiw-ZdsozQ@mail.gmail.com>
 <xmqqlhef50kz.fsf@gitster.dls.corp.google.com> <CAD0k6qS_uQk5KZVJYA7BVZ9sRPRj=cZ3rbYRfJ3vhgSh2drEMA@mail.gmail.com>
 <xmqqh9p350ad.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 22:32:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFppM-0003jr-FH
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 22:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbbGPUcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 16:32:16 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37250 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbGPUcP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 16:32:15 -0400
Received: by igbpg9 with SMTP id pg9so22787092igb.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 13:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Wr41hNVaMGf2n62PuTTXkjcFfjxi1Q7QtNgGfNHhw+0=;
        b=lALTULPVAtFq5qY5LlTujUqPhx3VufAHrk/9oqCqWHtSz0raD1eBjEESw4DGao+4xT
         pYRTBncPgFfIOlsnNDpCjfpdcP6s+/RPk75+TMsibiiUR+Lb5me2FQVcoNkNzLkHthrc
         QuOXgp+aujVNWhukYd5LMhH0aSRpjHGuQ+J91j/dsQ52ztn9Q4Vz5LZn/WYPTaV5lCc9
         ecjlfEXf/Y0ccBDg/YtsDZjySFenZdBKzmcz3lOUke+O1EyBYDuNgJhY7RgtGlFxMg2O
         KbmL/Ng+H+KXrdy7iXf7C1xYgO9A3vFLqXJKO+YChunhZILroWdlY8x9ENh1OrVZ69tB
         4XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Wr41hNVaMGf2n62PuTTXkjcFfjxi1Q7QtNgGfNHhw+0=;
        b=CzyYHxfFfi7Cx7ReVh8oGt/xJdTdekfXJi8ONLtptOE4VqQvtfdBL2DmBuNvwCtfhb
         4arD92ud/jHBQOUYCo4jLzx74tt56kyNMBRTF3OI9NKZ/gfKp0j7+n75hDQlIqVgwmo0
         kHfC292/SnAvA65YwbTIn/dGfB/MKPFh0eJjDlf4CtzYntsotGSVIE8aQEqewGp+UVrB
         BUBKuiWg4dreBqLX6Zr+2DuKQB65coFhpUCDenlYqKNM+HS3KoFpFdvq30wGUWCd/e/8
         VFX0LA0vbadHudFPEac02T6UhAqQgF9YJzKjq49VmepOSno2gD8Ep5RUb7thwrUVGngu
         alJQ==
X-Gm-Message-State: ALoCoQl1W3IbqNl7WqMpO/2rP6jPXdBuxfyMwFWkhjiQcFUS5P66qI+bLSGKF5ONJ+1OlOfmfhPg
X-Received: by 10.107.39.83 with SMTP id n80mr13074118ion.129.1437078734901;
 Thu, 16 Jul 2015 13:32:14 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Thu, 16 Jul 2015 13:31:55 -0700 (PDT)
In-Reply-To: <xmqqh9p350ad.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274042>

On Thu, Jul 16, 2015 at 1:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> On Thu, Jul 16, 2015 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> Perhaps something like this?
>>
>> Seems like it should work.
>>
>> Jonathan had suggested there might be some principled reason why
>> send-pack does not respect config options, and suggested passing it in
>> as a flag. But that would be more work, certainly, as it would also
>> have to get passed through git-remote-http somehow.
>
> I actually was wondering about exactly the same thing as Jonathan,
> and that is where my "Perhaps" came from.

I will say, though, as the maintainer of a handful of custom remote
helpers, I would prefer a solution that does not involve changing the
implementation of those just to pass this configuration through. So my
vote would be for send-pack to respect the normal config options.

Not sure what that would mean for -c on the command line, though.
