Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB536202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 18:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbdGESBJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 14:01:09 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36069 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbdGESBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 14:01:09 -0400
Received: by mail-pf0-f171.google.com with SMTP id q86so133263307pfl.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 11:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1cbq04pAK9p7WNFmrdIIcqgrv62KVwt7rhnwXOS6OyU=;
        b=D9aT0x3bXpSipn1a1HvZtUNMOZDpUdlmoiEGxMg1QFnk6fqav8YXo8xzN+MODYGPEx
         uij4arXeKU6zIpabRPD/kQboE/5cxXFWhw8V4LomuRy+xud01ix0cJn1j7xwBsgORInn
         HCjk0sy03UfSORJTsGc1LisoU/e6bMzVrh4SD+WnyoM3+i1jtUzCB1szWVAyV3tdolZT
         gBj4IIHicu9hXiu2br9OTZipuzrC/tTUBef8MNUmiIVL8dkJ9vIBJLamp3RvKEGlqXM3
         LYuXhH3PGLgYwsw8hmb9op9XhmcNPyS78AQwIY/vE/G0hICF+47hQTs9RSo2ogml+hQp
         1TJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1cbq04pAK9p7WNFmrdIIcqgrv62KVwt7rhnwXOS6OyU=;
        b=SseeD0Vd+SMoakYDvN5zLpDUKob4dgX56CBZUhELGXUKW2eOIZ7MNg1RhJnDg/exUW
         ZUHmbOQ5bQ/bBz5YzspYuedFKDp3DueLCqVnGeKDu7ruN5gkdtkHwELjrphL0qmxZSDO
         xYPr25IsDQV24MPq457L8bNs+FWifYtlzk2i7ZXVNSKhNMqgBl8YxBJcZDK0L1Covg6L
         bn8kOibufjDBkH5zDV9iNp0+O2VIkRfMz6kFIFlSgHuulQJRNuFgJ/mZEcORmw6lh1Ff
         QtdrDqL4CXVJPhsSXgZd2IIC3EREsl3PsiBQ48MYNjb9s5qQ1We2xGHfnTYkEL9BACUX
         vs1w==
X-Gm-Message-State: AIVw113ItMZoMUMYS9ZpBMYSl8Ca/jA8STU1oXRSVsDuHb76BfCvOo3a
        3pTJtIfcMXw/LlZRroK6V6CwXmhfrvAM/xZ73g==
X-Received: by 10.98.69.76 with SMTP id s73mr21287107pfa.94.1499277668337;
 Wed, 05 Jul 2017 11:01:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Wed, 5 Jul 2017 11:01:07 -0700 (PDT)
In-Reply-To: <20170703185533.51530-12-sandals@crustytoothpaste.net>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net> <20170703185533.51530-12-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 5 Jul 2017 11:01:07 -0700
Message-ID: <CAGZ79kYWKUPhfMvg2N+1h6b49d3Bqw_3Moes9XscjkmXAumz8Q@mail.gmail.com>
Subject: Re: [PATCH 11/12] sha1_name: convert get_sha1* to get_oid*
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -496,8 +496,8 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
>                 return 40;
>         exists = has_sha1_file(sha1);
>         while (len < 40) {

Here are two prime candidates for GIT_SHA1_HEXSZ, too.

> @@ -636,7 +636,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
>                 int detached;
>
>                 if (interpret_nth_prior_checkout(str, len, &buf) > 0) {
> -                       detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
> +                       detached = (!get_oid_hex(buf.buf, oid));

omitting the length check here?
