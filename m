Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E087D20281
	for <e@80x24.org>; Mon, 22 May 2017 11:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757383AbdEVL34 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 07:29:56 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32848 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757372AbdEVL3z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 07:29:55 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so19479535pfe.0
        for <git@vger.kernel.org>; Mon, 22 May 2017 04:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hR0ohgn3qKitF2sZG4SWnKv0VTuugtl3GdaelgLI3Jc=;
        b=BRjhs/e3eniuL0NpX8/FaxhSM9BdI2DrekkLb4CnSlshCJQuE9OMwAbcrcuOWPCvfE
         SdCO7cHA4Joa6n2OFEgjaOBFuZYY2Stqz2JTqwNpkeouOxM2n/ypfOinjDxbE8tiNcN+
         gHV5UNiVV2+HNgIO7iRS9zWmrc/MwkL3SiihA3F9zNvyFqB1ht+tvTf+wQvVz1jLB+QX
         R0MsuQmfwEzl3NjhISiSjU1ALo1MZuhKFikeSntr46uMQAVsg9OklS4rcKFTRHBjQhvs
         LWVrQjGTFH/eg9ctFPZemZKUXiyI33emoMU8GbRR64nXGpgQbHqCye7hdzG5MCw5B/dZ
         cY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hR0ohgn3qKitF2sZG4SWnKv0VTuugtl3GdaelgLI3Jc=;
        b=jdgU5MLnXHzIerQpgdv10DKjZ1YSKkeLT1qprE/PimKRToileAtQgAFlkk0BKfWxau
         i3RXesopwS0hiDckNNMtWe1/YTice+uuzlqSimVXR4DtkJkZG0IA04T4sCeJ3b07SfYM
         Nc34k8vdTyOWSNJhhC8X9UhvXCMr/6vNJvgWXN/W+N82jGlv9soyUFvb+QZ3mGHnz/kh
         YvmqLlIFTatMYQ9o2tF+UknD0lTBfV24hZQxps5od8q8mySlEXytCWWkdC0qzb0e4kic
         CdlIBvZ493PaAGi+aIkaRCls7l8enqwrRxK+6EpUEa2IUybV+GHTK++A+1TbSj5JM5rd
         WESw==
X-Gm-Message-State: AODbwcAmGXFvWZq6qpLheIvQtn4c8b7wsXYs9fCGgtoGhYmk30/jm6mv
        DlpPgvCGENOrzA==
X-Received: by 10.84.236.4 with SMTP id q4mr22807746plk.10.1495452594572;
        Mon, 22 May 2017 04:29:54 -0700 (PDT)
Received: from localhost.localdomain ([116.87.142.169])
        by smtp.gmail.com with ESMTPSA id f86sm30376788pfj.128.2017.05.22.04.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 May 2017 04:29:53 -0700 (PDT)
Subject: Re: [PATCH] ref-filter: treat CRLF as same as LF in find_subpos
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, animi.vulpis@gmail.com, j6t@kdbg.org,
        Karthik Nayak <karthik.188@gmail.com>
References: <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com>
 <20170521134209.25659-1-congdanhqx@gmail.com>
 <xmqqy3tppu13.fsf@gitster.mtv.corp.google.com>
From:   DOAN Tran Cong Danh <congdanhqx@gmail.com>
Message-ID: <9d42e133-75aa-d20a-0d38-bfbdc64d46fa@gmail.com>
Date:   Mon, 22 May 2017 19:29:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3tppu13.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/22/2017 09:19 AM, Junio C Hamano wrote:
> If you look at how `git branch -v` before that problematic change
> removed the extra CR, you would notice that pretty_print_commit()
> was used for that, which eventually called format_subject() with
> "one\r\n\r\nline3...", got one line "one\r\n" by calling
> get_one_line(), adjusted the line length from 5 to 3 by calling
> is_blank_line() which as a side effect trims all whitespaces (not
> just LF and CR), and emitted "one".  The reason why the next \r\n
> was not mistaken as a non-empty line is the same---is_blank_line()
> call onthe next line said that "\r\n" is an all-white space line.
> 
> So, while I think the realization that we have a problem, and the
> analysis above i.e. "emptiness of the line matters", are both good,
> but I do not think this is suffucient to get back the old behaviour.
> 
> The thing is, we never treated CRLF as line separator in this code.
> What we did was to treat LF as line separator, but trimmed trailing
> bytes that are isspace().  That is what the analysis you quoted from
> J6t says.

If I understand correctly, we should trim all whitespaces at the end of
subject line, and we should treat lines contain only whitespaces as
empty lines, right?

> Here is your test addition:
> If you change this test to
> 
>> +	git branch branch-two $(printf "%s\n" one " " line3_long line4 |
>> +	     git commit-tree HEAD:)
> 
> then the old code before the problematic change will only show the
> first line i.e. "one" in "branch -v" output.  I think with or
> without your code change, the new code would still show line3_long
> and line4 in the output.

Agree!

If you could confirm my understand, I would happily provide new patch
to trim all trailing whitespaces at the end of subject line
and treat next all-whitespace-line as empty line.
