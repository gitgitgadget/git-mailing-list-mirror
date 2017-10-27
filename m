Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63467202A0
	for <e@80x24.org>; Fri, 27 Oct 2017 06:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbdJ0GS1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 02:18:27 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:48095 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdJ0GS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 02:18:26 -0400
Received: by mail-pg0-f66.google.com with SMTP id r25so4548204pgn.4
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 23:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IxZNCVX7eut3Doo3RS9RjGTYMLeH50hIRgSNe/Jz2sY=;
        b=EsE0FAr8f4xBObHTYbUh4UC+Htc5pDCCL6MSayA03XFOiCNbxmNNOFd5DEEZ0MLlBj
         XWhLIJVpfzdknXKwmSoeMpco2C02lwFB5L3d67XFId3+B9XlBRqFGrB1TTcg3OlfV8ux
         Hj0rkYgMEAb6WwTXoTo7bvKONJJMwM+9AwlWveN+NmeQCLFh4Fxw7tsiu9TFS9aU3qT1
         GNWIJO5qOgpn07bqmp7U0qyUAJW54KburMFrFCC2S32SaZcgXE1VOstT4k7sgO1mGK2d
         vfYiQnB6vnALhm75+wyO7YQZOfkCHkrpPGQQUOPjVnNnuP2scZvcZtCGX0iyf8N86p2A
         EmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IxZNCVX7eut3Doo3RS9RjGTYMLeH50hIRgSNe/Jz2sY=;
        b=qu+dLGFD/lVM3DioYsG3d3eQmRHQjJN3whl4OfohDE/ugxWMuSfCBiFLZQ+62Y0Vje
         Way1y/ZLTu6SE+VjGwOlN3hCJdThfp1QTsPhCu3xoGUvex17QgFa3nBT0uAGZzD55nZg
         FQC4E2373FKfOnhpZDavqBHNUYqiYi+/5guVbI/f+HTj/KKLbAN3OlD/0zqtZ/C4rsRL
         CvgzKIwFEpgnQMSpvABZwQtL8VmK/ElmvrMOfPoYhpHmUAWcpunSJttFSRi+WmAPCFG+
         WPtesiZNTCJgSa0s1RdwRbwmH7IG3CuAfEn0gtM5txKFl6xPL73DS57QgUCXd+77UJC5
         bTOw==
X-Gm-Message-State: AMCzsaXX9TttoGAhy1ysDsau6NidbXyDb8n7ikro2SQVwRsQVEB7N3FS
        6znveILmoF5H8cRd0ZSEyB+S/g==
X-Google-Smtp-Source: ABhQp+QoV4EPyvfTcELuBLvqaPw39mKJWrl8TjsfQgFBfErGwnVaJHuUelREK6DPvCPaGOhsfBBwPQ==
X-Received: by 10.99.2.214 with SMTP id 205mr6990061pgc.375.1509085105903;
        Thu, 26 Oct 2017 23:18:25 -0700 (PDT)
Received: from [172.22.44.87] ([103.233.242.9])
        by smtp.gmail.com with ESMTPSA id f2sm11993884pgt.75.2017.10.26.23.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Oct 2017 23:18:25 -0700 (PDT)
Subject: Re: [PATCH v3] blame: prevent error if range ends past end of file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     szeder.dev@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        peff@peff.net, bturner@atlassian.com, jacob.keller@gmail.com
References: <20171026153111.21813-1-szeder.dev@gmail.com>
 <20171027005652.7796-1-istephens@atlassian.com>
 <xmqqzi8dcpx1.fsf@gitster.mtv.corp.google.com>
From:   Isabella Stephens <istephens@atlassian.com>
Message-ID: <926900b8-1aad-b02a-b3c6-2bc4930233fd@atlassian.com>
Date:   Fri, 27 Oct 2017 17:18:20 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqzi8dcpx1.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/10/17 12:58 pm, Junio C Hamano wrote:
> Isabella Stephens <istephens@atlassian.com> writes:
> 
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index 67adaef4d..b5b9db147 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -878,13 +878,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>>  				    nth_line_cb, &sb, lno, anchor,
>>  				    &bottom, &top, sb.path))
>>  			usage(blame_usage);
>> -		if (lno < top || ((lno || bottom) && lno < bottom))
>> +		if ((lno || bottom) && lno < bottom)
>>  			die(Q_("file %s has only %lu line",
>>  			       "file %s has only %lu lines",
>>  			       lno), path, lno);
>>  		if (bottom < 1)
>>  			bottom = 1;
>> -		if (top < 1)
>> +		if (top < 1 || lno < top)
>>  			top = lno;
> 
> This section sanity-checks first and then tweaks the values it
> allowed to pass the check.  Because it wants to later fix up an
> overly large "top" by capping to "lno" (i.e. total line number), the
> patch needs to loosen the early sanity-check.  And the "fixed up"
> values are never checked if they are sane.
> 
> For example, with an empty file (i.e. lno == 0), you can ask "git
> blame -L1,-4 ("i.e. "at most four lines, ending at line #1") and the
> code silently accepts the input without noticing that the request is
> an utter nonsense; "file X has only 0 lines" error is given a chance
> to kick in.
> 
> There should be an "is the range sensible?" check after all the
> tweaking to bottom and top are done, I think.

My mistake. I missed that case. I think this section of code is a little
hard to read because it avoids treating an empty file as a special case. 
Why not do something like this:

  for (range_i = 0; range_i < range_list.nr; ++range_i) {
          long bottom, top;
          if (!lno)
                  die(_("file is empty"));
          if (parse_range_arg(range_list.items[range_i].string,
                              nth_line_cb, &sb, lno, anchor,
                              &bottom, &top, sb.path))
                  usage(blame_usage);
          if (bottom < 1)
                  bottom = 1;
          if (lno < top)
                  top = lno;
          if (top < 0 || lno < bottom)
                   die(Q_("file %s has only %lu line",
                         "file %s has only %lu lines",
                         lno), path, lno);
          bottom--;
          range_set_append_unsafe(&ranges, bottom, top);
          anchor = top + 1;

We'd also need to change parse_range_arg to always make bottom less than top:

-       if (*begin && *end && *end < *begin) {
+       if (*end < *begin) {
                SWAP(*end, *begin);
        }

This also fixes the case where the given range is n,-(n+1) (e.g. -L1,-2). At
the moment that will blame from n to the end of the file. My suggested change
would instead blame the first n lines, which makes a lot more sense IMO.

Happy to leave as is if you aren't happy with this suggestion, however.
