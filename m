Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 899C81F424
	for <e@80x24.org>; Tue, 10 Apr 2018 09:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeDJJoh (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 05:44:37 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:51146 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbeDJJog (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 05:44:36 -0400
Received: by mail-wm0-f52.google.com with SMTP id t67so24931348wmt.0
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HpHwL/B5wY4aaUom1kQ1/F0Yn+9aOoA1OCIntwVfLss=;
        b=TujtpvjzKO12dPv1N4J5D9BeJ7EHsAMX9U5CiQ/KFgYJGbNXWf7Xu1xqMApkgYxgEP
         cx9LVabhlTXVmgeaq8kEiRRMGla7ZNrZcSoAtcG7RLQLE3fnrBIraIteNWtisfZB/EYl
         9uRe2laHfKf0LIK/TcviszHy2ShQaPoZn71g/hUDpQTDZg2hQyhN2P9s0F/NB0nZG0aj
         99AKYW/2TwNp/7ceI4jm/DCpjOe6CYdmy23QM5SjgCSY0PCeEy4Iug5k6WAoZl7tQj/Z
         68LQfKVY8VO4qnMTZuFKxvseGXN0liza/OD/p5YW1F2ByV/b6PUGjdpaUuXVguoxrtmJ
         cUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HpHwL/B5wY4aaUom1kQ1/F0Yn+9aOoA1OCIntwVfLss=;
        b=pTstXvgkfyKjclfZq+GE9ed1tfLrYbCHox2uq1rCJx8C21yA3cb03g1oXkynrizl68
         6wy+87PaaptbXYv5A0S8A3cXEQr+G6ppGmDcDHPUWiwKCIjSgBC55wyWQbSVeL1aGP6L
         FKOmZ7JfqnRIkwK/vFTn1Kai8qry031gnGGv1RoE53Drl27fUVcwzICxS4OrkD8rLsbr
         wAQ3tHGIFHdM8XijEcLzFl2qZmGvdRBwDDb0Bm3V2WkuX+Lu+WhojyExrCM08gJQvGAR
         d6HBSEvVArIbwMZ99Pxkp2sZmMIM9LSWd6g7W5E1hAkTg2Ovmqbn+tEpINYcxSpEMKx5
         9SZw==
X-Gm-Message-State: ALQs6tDgVSxFq9CjqGqmKEMPEhfVf/RwJ/OqqMxEqCzrC8vhlBVL9j/9
        tm2WL1jkoa5eb5JqOEMwK7U=
X-Google-Smtp-Source: AIpwx48MQgTzgjZU6MZGmFU3d70Qk9gkhwLfUtbW4hkndg8R+2z3lttyriXW8RMiAWksPW8AI20DTQ==
X-Received: by 10.28.213.139 with SMTP id m133mr1024558wmg.144.1523353474960;
        Tue, 10 Apr 2018 02:44:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t69sm3443760wrc.87.2018.04.10.02.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 02:44:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Toews <mastahyeti@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Subject: Re: [PATCH 6/8] gpg-interface: find the last gpg signature line
References: <20180409204129.43537-1-mastahyeti@gmail.com>
        <20180409204129.43537-7-mastahyeti@gmail.com>
Date:   Tue, 10 Apr 2018 18:44:33 +0900
In-Reply-To: <20180409204129.43537-7-mastahyeti@gmail.com> (Ben Toews's
        message of "Mon, 9 Apr 2018 14:41:27 -0600")
Message-ID: <xmqqlgdv2y66.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Toews <mastahyeti@gmail.com> writes:

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index ee093b393d..e3f1e014aa 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1059,6 +1059,17 @@ test_expect_success GPG \
>  	git tag -v blanknonlfile-signed-tag
>  '
>  
> +test_expect_success GPG 'signed tag with embedded PGP message' '
> +	cat >msg <<-\EOF &&
> +	-----BEGIN PGP MESSAGE-----
> +
> +	this is not a real PGP message
> +	-----END PGP MESSAGE-----
> +	EOF
> +	git tag -s -F msg confusing-pgp-message &&
> +	git tag -v confusing-pgp-message
> +'
> +
>  # messages with commented lines for signed tags:
>  
>  cat >sigcommentsfile <<EOF

Hmmmm, what vintage of our codebase is this patch based on?  Did I
miss a patch that removes these lines


    printf '      ' >sigblanknonlfile
    get_tag_header blanknonlfile-signed-tag $commit commit $time >expect
    echo '-----BEGIN PGP SIGNATURE-----' >>expect
    test_expect_success GPG \
            'creating a signed tag with spaces and no newline should succeed' '
            git tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
            get_tag_msg blanknonlfile-signed-tag >actual &&
            test_cmp expect actual &&
            git tag -v signed-tag
    '

which appear between the pre- and post- context of the lines you are
inserting?  They date back to 2007-2009.

