From: Dave Borowitz <dborowitz@google.com>
Subject: Re: Bug: send-pack does not respect http.signingkey
Date: Thu, 16 Jul 2015 15:08:48 -0700
Message-ID: <CAD0k6qSq8+JMFZgvQuVptCxUknYtMa7xrojABEDYLQAw015qvg@mail.gmail.com>
References: <CAD0k6qQ=ovEBZn_wje-exBhvW8brRbTgULDr68rmeiw-ZdsozQ@mail.gmail.com>
 <xmqqlhef50kz.fsf@gitster.dls.corp.google.com> <CAD0k6qS_uQk5KZVJYA7BVZ9sRPRj=cZ3rbYRfJ3vhgSh2drEMA@mail.gmail.com>
 <xmqqh9p350ad.fsf@gitster.dls.corp.google.com> <CAD0k6qSZtZN60ExQQfH0mq_rZrOA4Fw0ZeWfX_gr=2btbSYHQw@mail.gmail.com>
 <xmqq8uaf4xmo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 00:09:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFrL8-0007F4-FR
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 00:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbbGPWJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 18:09:09 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:32945 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008AbbGPWJI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 18:09:08 -0400
Received: by ietj16 with SMTP id j16so65697364iet.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 15:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NCpJSMvS6g+4I40rpUiPdOaOUBWHJqhblCVXa8FPleM=;
        b=Hp4jkB8MAu2o0JFQcgGNzJLWxzuLeS7hNsKc3unNqffUySa9rCYGb47cYif51q1w8T
         sIKRhkOwGVMKdkmDdpw6mYZyV9tCggZSiF2K5ZnSCYH2kNt1aB+P/5aeZz1Q6XSYLcz6
         E09UfZ+XJKXkFYwp2spFXBoMNmAY8gxwsWENsRAmFwXgORg9amZarsaqgxrBMTsUpMDN
         IB0Zv7SPeiBBqpFOEzq2DVXFdV840wp5XlgIgYxCzVAhcHuty4rQ6h3iuuOM6usQDVUQ
         o9VAK0g5FsChE4OyDSuZnbl9sdh9GIGPzR2StLcjpviHoLR6sc1uNvb7Eku92pkVocyV
         ic0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=NCpJSMvS6g+4I40rpUiPdOaOUBWHJqhblCVXa8FPleM=;
        b=FPdqC7xMp/V0h8FIFTfxTfeGNTXW4XPXIlQSmBF9WuW/f02WCZKqVZv56JpgR3gJHn
         0/8gH8WX/WfGhzylhZpQYYWpgwfwCmoYQp45OEF8JqjdbU3rCIuO8654waFu1kJdYdNH
         NzVV7T9XmJ0us1cMC592/EM0S7Xu2xLJuiOOQvxuGlUxWShOOFBToUe3LC9Es8P+YXGi
         ktyJVA8ZIGT1rOHjnc3EombtxHUiEdpVOTFC50Uf2EU2gGBB9KNU/PSKTti4t4b+Flmi
         dFoIqTgTKJUFdzgTn0Zrrwrvq6dRGBwZSc872TdkT86i9wb+Zn/kwlTMAdGObE5yGkF5
         Xkhw==
X-Gm-Message-State: ALoCoQn6gcK0m2OL44bm+H5ofni/Mqbi7BGy8Wv6Z7kLBB2grg6WwWrGjInstVLOFcD4nupNo54F
X-Received: by 10.50.43.131 with SMTP id w3mr6928590igl.8.1437084547607; Thu,
 16 Jul 2015 15:09:07 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Thu, 16 Jul 2015 15:08:48 -0700 (PDT)
In-Reply-To: <xmqq8uaf4xmo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274047>

On Thu, Jul 16, 2015 at 2:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> On Thu, Jul 16, 2015 at 1:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Dave Borowitz <dborowitz@google.com> writes:
>>>
>>>> On Thu, Jul 16, 2015 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>
>>>>> Perhaps something like this?
>>>>
>>>> Seems like it should work.
>>>>
>>>> Jonathan had suggested there might be some principled reason why
>>>> send-pack does not respect config options, and suggested passing it in
>>>> as a flag. But that would be more work, certainly, as it would also
>>>> have to get passed through git-remote-http somehow.
>>>
>>> I actually was wondering about exactly the same thing as Jonathan,
>>> and that is where my "Perhaps" came from.
>>
>> I will say, though, as the maintainer of a handful of custom remote
>> helpers, I would prefer a solution that does not involve changing the
>> implementation of those just to pass this configuration through.
>
> That is not a controversial part ;-)
>
>> So my
>> vote would be for send-pack to respect the normal config options.
>
> The thing is what should be included in the "normal" config options.
>
> The "something like this?" patch was deliberately narrow, including
> only the GPG thing and nothing else.  But anticipating that the ref
> backend would be per repo configuration, and send-pack would want to
> read from refs (and possibly write back tracking?), we may want to
> prepare ourselves by reading a bit wider than "GPG thing and nothing
> else", e.g. git_default_config() or something like that.

Ah, now I understand the question. I have no opinion other than that
we shouldn't let discussion about future features prevent us from
fixing this obvious signed push bug :)
