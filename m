Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AFF4207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 23:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755524AbcIPXEc (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 19:04:32 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33063 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755267AbcIPXEa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 19:04:30 -0400
Received: by mail-io0-f179.google.com with SMTP id r145so41001808ior.0
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 16:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Vuwir7aHWoF9M3y0fbz3q6PYP83lP9duAJrFAxxqz78=;
        b=mt7HP2u24stF/AKrRbPj09tO9EHZnCQOQ0ptostgrPjNOsgGLDOoZYsos23A2VCMvC
         HV2iOtWHqxqX9Kt5V3U1IhdSraIqcSOoej8k5La/JdaBlFP+YT587yda32i0I8xGi6JZ
         mqN1gkdBMs+zpb4eNelApH4gNpvheR2H/0ghyX9u89uRmj8LFsWZMKQHwtt6FmKs/3fg
         9iFFjnAZnZ3NKH5AveF77iCb1oKhie7dpDditWeGRdx81GK/xVbbXoQLfyDgPfT321I8
         Z7ivrwfK6dr0sY03XIEwOxV/7tBUbzZAXsy3xR1Sq8XyqOueJQ3F0mFx0yjAtNslhE/b
         Xr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Vuwir7aHWoF9M3y0fbz3q6PYP83lP9duAJrFAxxqz78=;
        b=QdMGHdyU1UVmw2xbK0TQoh6tE47ozhUPU0/sf4euDH6k3fnKSv0T3wXS0rW1msTJC6
         N3DBtAzB2Y14PbtgMVdbC16sn8TbHGAm6W2L+MKNI/nQOWZ9IkuqWVW1jnHWZ6PNZcK/
         ENS0thw4atfC+pZ95MOLm9l3xfYJv2y3a7tI6CUbxGt2ZL/smBZOSguZ1jjcj3m0CAOh
         gFJssTV3ooC0gSk4pv227DRJvLUAqdjhJO6sm6xw+DTB6dXkgXhoFzFNVcjOa9BsvCZK
         8/7uKnPATwJTCYW5U+FdvNIb6Zo+4mYGRg7v5Go6LY9vIntp3gliTsQA+vMzd2WBmUTx
         WCQQ==
X-Gm-Message-State: AE9vXwPfXQdMEqYvDvAttfuuWrblj1hqGxRtHBdG6zRLkXRV8ZGfddX6vxDVC5GDW2Pfy8oo6r1JPwzJD2Di0QRS
X-Received: by 10.107.153.129 with SMTP id b123mr26176538ioe.160.1474067069624;
 Fri, 16 Sep 2016 16:04:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Fri, 16 Sep 2016 16:04:29 -0700 (PDT)
In-Reply-To: <xmqq1t0oy8t8.fsf@gitster.mtv.corp.google.com>
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
 <1473572530-25764-4-git-send-email-stefanbeller@gmail.com> <xmqq1t0oy8t8.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 16 Sep 2016 16:04:29 -0700
Message-ID: <CAGZ79kbRBqEMib=ym9xE2E_Tw4r_nA+wvU9NDfjnJRLKXk8ZzQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] diff.c: drop tautologous condition in emit_line_0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2016 at 4:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <stefanbeller@gmail.com> writes:
>
>> diff --git a/diff.c b/diff.c
>> index 156c2aa..9d2e704 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -460,8 +460,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
>>
>>       if (len == 0) {
>>               has_trailing_newline = (first == '\n');
>> -             has_trailing_carriage_return = (!has_trailing_newline &&
>> -                                             (first == '\r'));
>> +             has_trailing_carriage_return = (first == '\r');
>>               nofirst = has_trailing_newline || has_trailing_carriage_return;
>>       } else {
>>               has_trailing_newline = (len > 0 && line[len-1] == '\n');
>
> Interesting.
>
> This may be a mis-conversion at 250f7993 ("diff.c: split emit_line()
> from the first char and the rest of the line", 2009-09-14), I
> suspect.  The original took line[] with length and peeked for '\n',
> and when it saw one, it decremented length before checking
> line[len-1] for '\r'.
>
> But of course if there is only one byte on the line (i.e. len == 0
> after first is stripped off), it cannot be both '\n' or '\r' at the
> same time.
>
> Thanks for spotting.

Oh, right, it used to be possible to remove \r\n completely and that information
was then kept as has_trailing_newline = has_trailing_carriage_return = 1;
and the resulting line is kept completely without ending line.

After some thought I don't think I can use this mis-conversion
to trigger a bug though, because the len=0 can only ever happen
if first is '\n' alone essentially.

Another thing I noticed when playing around with diffs:

    $ printf "\r\n" >crlf
    $ git commit crlf -m "add file crlf, empty line"
    $ printf "non zero length\r\n" >crlf
    $ diff --git a/crlf b/crlf
    $ index d3f5a12..ece7140 100644
    --- a/crlf
    +++ b/crlf
    @@ -1 +1 @@
    -
    +non zero length^M
    $ # The - line is missing a ^M ?
