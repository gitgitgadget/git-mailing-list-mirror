Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8663020248
	for <e@80x24.org>; Mon, 15 Apr 2019 02:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfDOC7G (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 22:59:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50191 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfDOC7G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 22:59:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so18677623wmi.0
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 19:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pTHRgTq56Cocv3JIeO4AMQpgpZF+s1ABlPQNt0DtnQc=;
        b=YCZMOT9khhN+RcuZYgYv8HnPdrfHHNEzOIHtWvOLhk4mDc2E3p3AgALrn119lZyjTJ
         M5yoELwd5abF4ovBnr7IbCqZJp8D1y7/EQ1V1WxoQg3cJoXZg6DW9D0EmMwbHCW31qqd
         du46A8iooIfEJb31F844QadOM0a0mUWxW5knYem4fzoZmQGos5Ti2v2f7cexYrDnztSe
         wqwC2/4/6GDlckJIxeK5xXQTOP8NokKG8varskShZvMypz7JH5Vz38EyjKpWkGHsjseH
         UqvldWIN1rJ0yZp1bajICwLSI/Dlb7r/Mf67suZdYl6DotPwiq1dxtGryEqlMOeEDrt8
         bl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pTHRgTq56Cocv3JIeO4AMQpgpZF+s1ABlPQNt0DtnQc=;
        b=VaXDWBhJw2xeHSpK7fkVy4yfKfiCVPxbabgZwRbWK6IbU0ihqHwxv0VYvW1u88RiDC
         UJ09fZMP25AUgTrCas2oZGzNMXpIEjzvd9CnKXD0Pm7SN6cXZ19ZAy28f8wzG8ru6LOJ
         Ff0wtD0NbIscunk8wJZ9mlNA6rhin6/OFDTn/36k6iDmuT/kasMmqS9+xXquz7DrUQJj
         qZvd+8ujoVPt3xAJ9tRB8XI/BSM1T93OWmjwqUwoknmmsjerj2TTnn9FJxijVrv3ipNe
         i0yUXuwWzmSPcRQvPM25Nzv2P+Wh6zi1VN0mYlRKff4oF4JWwaAwCVuTV7HIUojCLZLH
         KrQw==
X-Gm-Message-State: APjAAAXnhR9t2jfsPIb/ekXBpWCQSOFaGEX6X52I4NSuPY/V/oKjp2VC
        klztg9I5tAGu4gLrzLhy/Wc=
X-Google-Smtp-Source: APXvYqyOj2V98YLEwA+qg59cnaOM8cvpnYQhjPNcwaorAzBr7EYH8UO3LYVVXwHveHHgRO6zsQdppg==
X-Received: by 2002:a1c:6309:: with SMTP id x9mr19954673wmb.101.1555297144377;
        Sun, 14 Apr 2019 19:59:04 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id u8sm48155139wrt.69.2019.04.14.19.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 19:59:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] submodule foreach: fix "<command> --quiet" not being respected
References: <robbat2-20190410T062730-540884809Z@orbis-terrarum.net>
        <20190412100819.24863-1-pclouds@gmail.com>
        <robbat2-20190412T172121-535310801Z@orbis-terrarum.net>
Date:   Mon, 15 Apr 2019 11:59:03 +0900
In-Reply-To: <robbat2-20190412T172121-535310801Z@orbis-terrarum.net> (Robin
        H. Johnson's message of "Fri, 12 Apr 2019 17:22:15 +0000")
Message-ID: <xmqqtvf0ug7c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> On Fri, Apr 12, 2019 at 05:08:19PM +0700, Nguyễn Thái Ngọc Duy wrote:
>> @@ -2096,7 +2096,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
>>  	};
>>  
>>  	const char *const git_submodule_helper_usage[] = {
>> -		N_("git submodule--helper embed-git-dir [<path>...]"),
>> +		N_("git submodule--helper asorb-git-dirs [<options>] [<path>...]"),
> Nit typo here: s/asorb/absorb/

Will locally tweak while queueing.  Thanks, both.
