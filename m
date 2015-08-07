From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: implement `module_name` as a builtin helper
Date: Fri, 7 Aug 2015 16:19:25 -0700
Message-ID: <CAGZ79kaGe59=z4Eeuno8DRuWWRD12OyLETi7NA+utfoLsJ4+=A@mail.gmail.com>
References: <CAGZ79kY=jQSjJUxkznkwwupo527-nT05P_bKXy=GO=E4QjC8tQ@mail.gmail.com>
	<1438808880-9080-1-git-send-email-sbeller@google.com>
	<55C3BA5C.3030404@web.de>
	<xmqqlhdmyhtt.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYtCgYRHuMcxNoi6f9+GYYYCq6aRTdvx4ZKELSuQErkVQ@mail.gmail.com>
	<xmqqa8u2yf6e.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYjaXtGurWgPk47FauLhC=k-gBjLYhepuz4gJE6Rm_8DA@mail.gmail.com>
	<xmqqpp2ywwj1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 01:19:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNqvP-0000I9-0W
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 01:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946386AbbHGXT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 19:19:27 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33228 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946357AbbHGXT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 19:19:26 -0400
Received: by ykoo205 with SMTP id o205so100601630yko.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 16:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7mWGsBxU1nrwzqPNzFROxiYirwauflqWxZXcGDCavpU=;
        b=d4c0Mi999iZ33EM50KUQLArmXQXsvpY8F9AdGsEuEgG7ZWO8RVIlgIDwKyqJcbOy0O
         Re+f7wxOhMaiKxmlsdVSs973LyiOqSAOLo5uc4PsRb7S7tbIkVufYD/B6W+0wsfWBYsE
         UdblRAM4g/+UVpqtO1I42i7gPMiQkWosRBQ9m0+mgg4FPF41n/Qjh7VHeiIyRAUlc7a9
         FhK4NbAWs+Qs4XrYiGScNBTggsUpiZLGLEaUnuXjsX62QfBupO29kLie2P1e33qw9oLf
         3EsMXUfKwiRh8SuFpWQqhBm9yaUeOUqu1ethq9PzByvvHDb2zWPTxHY23JZCE9+o+Ema
         qddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7mWGsBxU1nrwzqPNzFROxiYirwauflqWxZXcGDCavpU=;
        b=mX34fV62KsV8l1UHaXulNlrSgmNw5MQFFH2IYqQIm/6tWRzgM/nNohW4z7m4CfRCOz
         8DlOmgiHkNIXf0UWh5KKO6egKVy0e8WC2v6AY+TgJRT8QSZ6fonv1zygVqsjEE/wx2SS
         Ewi7+hTDDgOUgqwksiRpSZ0qx3BgBY6mmYpiUxuST9EJhH4/gZu/HGRt8b9CHJGhai7g
         9TH57bwMjPYVz+POjJzHRokTsLEqMI9Z34kQ5Qw/wQOJriChc/rUQff/wtCvxf4E+DCU
         OZL6h8l4ZLDB0X5C8L5yS1J0M/msnif96/zd5/DIqnIEkxf2k0SqS4pY98hwf9ywj9of
         YdZw==
X-Gm-Message-State: ALoCoQmAQp+hEZS+LDpQHZuJFEOIGoLR1uO1JzGtTKDGvbOGfqnzCS5j0W/d0cpCgynKEKSpqs2J
X-Received: by 10.13.198.2 with SMTP id i2mr10560466ywd.123.1438989565921;
 Fri, 07 Aug 2015 16:19:25 -0700 (PDT)
Received: by 10.37.27.6 with HTTP; Fri, 7 Aug 2015 16:19:25 -0700 (PDT)
In-Reply-To: <xmqqpp2ywwj1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275500>

On Fri, Aug 7, 2015 at 3:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> That's why I want to be a bit more generic and have this thread pool API
>> done in C, such that "any for loop" in git can be easily replaced by using
>> the thread pool. I think of "git fetch --all" specially.
>
> One more thing, as I didn't notice that you kept repeating "thread"
> pool API.

Yeah I intended to use both threads and processes for the heavy submodule
operations.

Each thread in the thread pool would setup the right argument lists
and environment
and then spawn a process for heavy weight operations, wait for the process,
maybe process its output.

Maybe I should omit the whole thread pool and only use select from a single
threaded main program.

>
> While I doubt that you would gain much by using threads in place of
> processes to perform parallel "submodule update", "submodule clone",
> "fetch all", etc., all of which are fairly well isolated and heavy
> weight operations themselves, and I suspect that the implementation
> simplicity of using separate processes would probably be huge plus
> compared to any possible upside you may gain from using threads, if
> you really want to go the "thread" route, the first thing to try
> would be to see if a few places we already use threads for
> parallelism (namely, "grep", "pack-objects", "preload-index" and
> "index-pack") can be factored out and model your new API around the
> commonality among them.
