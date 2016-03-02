From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [PATCH v2] builtin/receive-pack.c: use parse_options API
Date: Wed, 2 Mar 2016 19:23:40 +0530
Message-ID: <56D6F064.20307@gmail.com>
References: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
 <1456863661-22783-1-git-send-email-tigerkid001@gmail.com>
 <CACsJy8Dc38BrAHJ2t3HRdrk=A7VR7SFqc03wyajKrydsiCfoNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 14:54:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab7EH-0002A3-Tx
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 14:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861AbcCBNxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 08:53:47 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33516 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbcCBNxp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 08:53:45 -0500
Received: by mail-pa0-f67.google.com with SMTP id y7so12303847paa.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 05:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=MCYJLvz0uJE+X6iRLhKfLSqBKpRxh+FH5VUM1spcmX0=;
        b=tG+7X6uUNsRjXt8B5WX3WHJSDDnpb9C9cebhWxiICz5cWnZ/r/WhkY59n5YyJWt/42
         NyspclxfRDxRVUgWppX/4wW7ShXORCZ6jFpUDWB921QN/RPpQ53R7tWQY3cpVyARLf3w
         ALAxT2gkw2A9op+DKsMcUIG5MNbeD2vGQDYnvjsnvWX6EqCl8SjSYUpTdic4OQ/vYHje
         9SNjS2DY/PZsM6jq4zXbUEf0r+AeCBk3VUvMp9UgelpvoLlKqEOmH/kSddhhbpLqnTmA
         DnWohGu2QTxBlpxbOtE+3d3HSExV3G1TW7ZJpDqo8M3DKSQ26X69SClv1KYNgHmkVyHY
         sXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=MCYJLvz0uJE+X6iRLhKfLSqBKpRxh+FH5VUM1spcmX0=;
        b=RBjX4nCRzRiqeWqRVkPlVmi7y5TGLzmI6FA43ITU+63SCJtIKmqlHaHCjsDdQ0szd6
         utun6nnuN7bJLHgccdMLexMx7+d8mLUnLtp78aM07y5VE+jNf/7o0pre3t8TcdN2tReh
         vx3qQoX3nUaMNy2Gp5qIycnW9aYTbgeyZ9iZuAbFdSvM4oa8o6VjLEoorB0fFFTiEKhR
         d+oMck/O9c2e4S6FdIWV7sUjw7g9ZGI2JgoMC0kAHLj0i+9LvhKiFMz/wCYkgFz4HIf0
         OY7134M62+F+KaCLAErMcz8TGCMJNNMQpJx9ITBZMuZpDxhaGollIjTZ4qll+MjU1ryo
         IKyg==
X-Gm-Message-State: AD7BkJLDTwoLeb/7q5mwBWvHm0P4nlDMe093GgWGYXVHjTVki86WHK3wHncLpdTlk9QDAw==
X-Received: by 10.66.102.37 with SMTP id fl5mr39031947pab.32.1456926824920;
        Wed, 02 Mar 2016 05:53:44 -0800 (PST)
Received: from [192.168.1.10] ([182.68.185.50])
        by smtp.gmail.com with ESMTPSA id i13sm53319893pfi.95.2016.03.02.05.53.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Mar 2016 05:53:44 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <CACsJy8Dc38BrAHJ2t3HRdrk=A7VR7SFqc03wyajKrydsiCfoNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288125>


> On Wed, Mar 2, 2016 at 3:21 AM, Sidhant Sharma [:tk]
> <tigerkid001@gmail.com> wrote:
>> +       struct option options[] = {
>> +               OPT__QUIET(&quiet, N_("quiet")),
>> +               OPT_HIDDEN_BOOL(0, "stateless-rpc", &stateless_rpc, NULL),
>> +               OPT_HIDDEN_BOOL(0, "advertise-refs", &advertise_refs, NULL),
>> +               OPT_HIDDEN_BOOL(0, "reject-thin-pack-for-testing", &reject_thin, NULL),
>> +               OPT_END()
>> +       };
> If the patch is already final, don't bother. If not, I think I prefer
> to keep all these options visible (except the "...-for-testing"). This
> command is never executed directly by mere mortals. The ones that run
> it need to know all about these hidden tricks because they're
> implementing new transports.
>
> Another side note. I'm not so sure if we should N_() and _() strings
> in this command (same reasoning, the command's user is very likely
> developers, not true users). But it does not harm to i18n-ize the
> command either. Slightly more work for translators, of course.
I can make a patch with the changes, but I think the patch has been finalized.
Should I make one?


Regards,
Sidhant Sharma [:tk]
