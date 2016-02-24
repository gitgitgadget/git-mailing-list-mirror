From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv15 2/5] run_processes_parallel: add LF when caller is sloppy
Date: Wed, 24 Feb 2016 13:19:53 -0800
Message-ID: <CAGZ79kYv-dKMnON=Hj2fUNEbUXz=8ti3x3tNG2WxWmdr5CA2tA@mail.gmail.com>
References: <1456284017-26141-1-git-send-email-sbeller@google.com>
	<1456284017-26141-3-git-send-email-sbeller@google.com>
	<xmqqa8mpub1y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 22:20:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYgqq-0007DS-Jk
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 22:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbcBXVTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 16:19:55 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:33712 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbcBXVTy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 16:19:54 -0500
Received: by mail-io0-f171.google.com with SMTP id z135so68241008iof.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 13:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TmotLzy4NU2USa0IEgjxZOrquQqnEefgodtWswIhLSI=;
        b=btpwNo2Lay9btpB+0gp389ZkpHiHwUQS0d7F1DhIdQeConZiZfPxq2rpD1KrLYIpaB
         pf3j69ww9xVq1TdQ35C+EQlOO0WwizHOVaPMm5c7gF9LbaSFf0l/a/ZVvPmYfgyT0XY6
         OIdB47clis920uOwkauDFdjARs/rTP/1JVAZIbTZnMDvNgS854RBDxapAP1lmPjqEqc9
         6ZOGwgCbO2ZtmZKElLYyVCpd8/5scUaIKt/qOX2hsM93vPHalgsabuqjgUMWFRSnALIr
         aU9MfTGUmT5lvlQLrk4QRXxcpQ5J2UaSaKoTsHHKGENTp1lbuyE+Ev9NXZpT60zC9j3+
         QVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TmotLzy4NU2USa0IEgjxZOrquQqnEefgodtWswIhLSI=;
        b=Nr2RmWjXDzJzH/an6E/RIeWxeHV/p3nrTkClr6ENdKeo45u0JrTNV1eb/7kyOU74Oc
         5l473Cg1fEhtHTxrfbI0EG2I+lsBIeANPLYbLvARaiidL/G0ZVS0NSDb1KLvD1+t3lmn
         UPlWKKSaKBLOaDOfGuUf912RlT8rzJTblsOdRl+BBBl5J8qKWRXTZZ6kCIpIkmU0cntY
         AVzqkgSSUOraoLS9kz3xDBhuRWFx7C84M6uH1W67iz9m1rRDj/zY0M2p2AKXM22+dWhJ
         mkiyIq82wNX1Cct6DyCqQpRLvTlPitm9evmGEwBDs9y1t6wAn/5bjDY0usCeHZ64aIU7
         Mi/Q==
X-Gm-Message-State: AG10YOQHS312DR98kLLMf34Loqeia9oi/d4goDAAqS6we5UECSd2s4vfeGpD3elASNU3htt0EJskLqpPB4bF4L5x
X-Received: by 10.107.158.138 with SMTP id h132mr21171268ioe.174.1456348793862;
 Wed, 24 Feb 2016 13:19:53 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Wed, 24 Feb 2016 13:19:53 -0800 (PST)
In-Reply-To: <xmqqa8mpub1y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287230>

On Wed, Feb 24, 2016 at 12:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> @@ -1095,9 +1098,11 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>>  static void pp_output(struct parallel_processes *pp)
>>  {
>>       int i = pp->output_owner;
>> -     if (pp->children[i].state == GIT_CP_WORKING &&
>> -         pp->children[i].err.len) {
>> +     size_t len = pp->children[i].err.len;
>> +     if (pp->children[i].state == GIT_CP_WORKING && len) {
>>               fputs(pp->children[i].err.buf, stderr);
>> +             pp->ended_with_newline =
>> +                     (pp->children[i].err.buf[len - 1] == '\n');
>>               strbuf_reset(&pp->children[i].err);
>>       }
>>  }
>
> The child->err thing is treated as a counted byte array when the
> code determines where the end of the buffer is, but is treated as a
> nul-terminated string when it is output with fputs().
>
> The inconsistency may not hurt as long as (1) the producers of the
> message will never stuff a NUL in the middle, and (2) strbuf always
> has the guard NUL after its contents.  Even though we know that the
> latter will hold true for the foreseeable future, it also is easy to
> do the right thing here, too, so why not?

What is the right thing? I asked myself and obviously it is treating the
child->err the same in both cases of checking for a trailing LF and
when outputting.

But what is the right way to look at child->err? I would argue that
we should allow for children to have a NUL in its output stream and
replay their output as literal as possible.

i.e. my conclusion is to replace the fputs by fwrite as opposed to
using strlen to determine the length of string output.

Thanks,
Stefan
