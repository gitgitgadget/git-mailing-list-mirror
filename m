Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02AF91F404
	for <e@80x24.org>; Mon, 26 Feb 2018 18:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeBZSTa (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 13:19:30 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36282 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeBZSTa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 13:19:30 -0500
Received: by mail-pf0-f195.google.com with SMTP id 68so6851360pfx.3
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 10:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3g9+6VyB0tiuQmowTSPszwrXzel71ejMcS+KWHNdGM=;
        b=wMUFTtzuGrwB9kWHbeHNxzOW6RsNSi7XieHICErCJ4ouUvhXPfphjNQ2+b/dNxZCX/
         NC8JZAk1QPXLwKpU4ujIp67mD9tVwPKnYinjcN0GElTfGhs3FBTijX9uWf4RxrN09Wt9
         tTjj3qKLQ8WVzssPL7yHN4kKk7rKHZyWgfYcLRlEAiK7ier9pviNHZMN7vdRtwpSMt3o
         1ccV2S1bjjcDmcT1/d15lSeU+H/GVQ2yohKjqpbdUPK3crSVYaGNr7trzx15ifST/zEV
         Tcxf87FymiHqxCEnecxp5wEh3w0IDsyrex0hdf4CSDeoeY7HXcW9XZoEW4EVSJC4Uklw
         keVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3g9+6VyB0tiuQmowTSPszwrXzel71ejMcS+KWHNdGM=;
        b=PfVoBkyGeOaYJU/HL1Zcagc86QXvS4I5ZzJoNiMdIJCpDiiJaZv4dJCNZbNWc4ZL3n
         yzeySkeesOdYv7Y1Sfy0Kh9zDq4XB9Xje57t4B5nwfWXhaXjFWs35kUNyU9/e2YcgJtv
         5hmCRGHDvgvOyHGKaWu2kqXnvq6g3kHmoJALwh6bspep2Vx4LwdkJk04zT3G6dUqhhks
         O4dsXNGb2dLeZEkD7ECaiZwCArL2Qk38Dr7N4gRdsvxW+gPHRxYztf7Zg+f82ldau93r
         9YsbJOthXYPdIncPBx7cjFXMNS3bKB1SKy0eFp75LWKhkm7LIUOgwa8S4mgIHisQ+a7P
         1Eqg==
X-Gm-Message-State: APf1xPDIkjtXrgje/wcpeu2dOqcuGSLajSzTHYORIiglh5Hzi06Wqnhw
        JmlRU4mZmcfIMrreXXKFOiHQh9UVdXM=
X-Google-Smtp-Source: AH8x226kzWYm4p9+cfFTTCpzkyuMqdpESximzJag4Pxt46B/qQchJkquM08z7n05Gr6d6q8S6FVGKg==
X-Received: by 10.98.60.15 with SMTP id j15mr11478968pfa.7.1519669169426;
        Mon, 26 Feb 2018 10:19:29 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id p1sm7063528pgr.67.2018.02.26.10.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 10:19:28 -0800 (PST)
Date:   Mon, 26 Feb 2018 10:19:26 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        sunshine@sunshineco.com, bmwill@google.com
Subject: Re: [PATCHv4 00/27] Moving global state into the repository object
 (part 1)
Message-Id: <20180226101926.0ceafa4d7ef611ce142593fe@google.com>
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
        <20180224004754.129721-1-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 23 Feb 2018 16:47:27 -0800
Stefan Beller <sbeller@google.com> wrote:

> v4:
> * addressed feedback from the single patches (mostly nits)
> * rebased on latest master

The patches I looked at previously (patches 7, 15, 19, 22, and 24) look
good to me.
