From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/6] t1500: avoid setting environment variables outside of tests
Date: Tue, 10 May 2016 15:12:23 -0400
Message-ID: <CAPig+cRR49iJOkaLfynkvch4zUHVkpcJwVah0rvaEOeR7aY2Nw@mail.gmail.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
	<20160510052055.32924-6-sunshine@sunshineco.com>
	<20160510183955.GA16211@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 21:12:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0D53-0003Iz-Vp
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 21:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbcEJTM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 15:12:27 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:36688 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbcEJTMY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 15:12:24 -0400
Received: by mail-ig0-f194.google.com with SMTP id c3so2137557igl.3
        for <git@vger.kernel.org>; Tue, 10 May 2016 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=4hPxCq72Am9j6ko3rdjBPFRCoUVmj3zD+/d8wSUtYRw=;
        b=ZohvhxjgWJbWnPYBO/VVJuJ9NG1d9kB2fjlqFvXtzF43HXXLOT1koePFS7CneNBPWw
         tFAVIgkbUTKNOWXwvhCg27F4KZW5SfbX/7Vz88/hM+arcY4XEZifyTSXDvfxjnBPwm4h
         hvXUCEwlHDZCbkn1lav4pKsfNFFQhGl0FFG/gxIlcN/Y8oAIS3g0iZdXs1SN+tUnWp7K
         k/DTWHAk3Kert5AxmJMIxAH80pG0aB1orQySzMc2+yCPrM2XqvqzMujJiPuyfOtMfbYO
         o89xSpu54nKotsa9MAcbnneA6QVpXwL3hxC03Ejld1lOBaeDVP7YIOHTTFEdXZ83okMa
         LHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4hPxCq72Am9j6ko3rdjBPFRCoUVmj3zD+/d8wSUtYRw=;
        b=fcJXzcSLH2PBZPxmrmBXoTSvpdDEIjatbNflceKTcstFIB4cD5KWibQsJNbp33sMt+
         W8MBZKh4rUNo/SydwuGSirrfoc4jDZ9PDJxa5//SYfwsLjxmLzG8m9J7n/tnqv6MK8yO
         uKZ8o7TcwAK08n2skpdGoJo972u/pPK/04qPxbHZQ1I48PKdT5t5iEnRaiPm+dCKYxt7
         ElpnWPeYMB+1CDIykGkylJT/9hSgouNcfMDoTRPRu0zBp1vkG7Ho67GcrUFKdFAvoyL5
         SpNo57YrjcJiw6/r4QArcapn/ZJYeLRSh3e/rLU6JH6qvBi5rwRAUsu6bGaM/bKxVuja
         Vjqw==
X-Gm-Message-State: AOPr4FVvVYHwKb+YwJVGKzCKFtKVgHIqmUfUfIgckRT/0simlByawuHJfMeWl9T6RhymR5w183nt9rbS/5zd+w==
X-Received: by 10.50.36.9 with SMTP id m9mr19560557igj.91.1462907543744; Tue,
 10 May 2016 12:12:23 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 10 May 2016 12:12:23 -0700 (PDT)
In-Reply-To: <20160510183955.GA16211@sigill.intra.peff.net>
X-Google-Sender-Auth: cyr8gWGJ_f5UhK-SAbTUNPW9tGs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294175>

On Tue, May 10, 2016 at 2:39 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 10, 2016 at 01:20:54AM -0400, Eric Sunshine wrote:
>> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
>> @@ -7,11 +7,13 @@ test_description='test git rev-parse'
>>       while :
>>       do
>>               case "$1" in
>>               -C) dir="-C $2"; shift; shift ;;
>>               -b) bare="$2"; shift; shift ;;
>> +             -g) env="GIT_DIR=$2; export GIT_DIR"; shift; shift ;;
>
> This will expand $2 inside $env, which is later eval'd. So funny things
> happen if there are spaces or metacharacters. It looks like you only use
> it with short relative paths ("../repo.git", etc), which is OK, but this
> would probably break badly if we ever used absolute paths.
>
> I don't know if it's worth worrying about or not. The usual solution is
> something like:
>
>   env_git_dir=$2
>   env='GIT_DIR=$env_git_dir; export GIT_DIR'
>   ...
>   eval "$env"

Makes sense; I wasn't quite happy with having $2 interpolated
unquoted. Like you, though, I don't know if it's worth worrying
about...

>> @@ -36,6 +38,8 @@ test_rev_parse () {
>>       do
>>               expect="$1"
>>               test_expect_success "$name: $o" '
>> +                     test_when_finished "sane_unset GIT_DIR" &&
>> +                     eval $env &&
>
> I was surprised not to see quoting around $env here, but it probably
> doesn't matter (I think it may affect how some whitespace is treated,
> but the contents of $env are pretty tame).

I flip-flopped on this one several times, quoting, and not quoting.
Documentation for 'eval' says:

    The args are read and concatenated together into a single
    command.

so, I ultimately left it unquoted, but don't feel strongly about it.

> This will set up the sane_unset regardless of whether $env does
> anything. Would it make more sense to stick the test_when_finished
> inside $env? You could use regular unset then, too, since you know the
> variable would be set.

I didn't worry about it too much because the end result is effectively
the same and, with all the 'case' arms being short one-liners, I think
the code is a bit easier to read as-is; bundling 'test_when_finished'
into the 'env' assignment line would probably require wrapping the
line. I do like the improved encapsulation of your suggestion but
don't otherwise feel strongly about it.

Nevertheless, I can re-roll with these changes if you feel more
strongly than I about it.
