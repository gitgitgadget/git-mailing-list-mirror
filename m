Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436061F404
	for <e@80x24.org>; Fri,  9 Feb 2018 23:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeBIXPu (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 18:15:50 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52762 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbeBIXPs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 18:15:48 -0500
Received: by mail-wm0-f65.google.com with SMTP id g1so248253wmg.2
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 15:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l//BzxFunUPpPVX4+aDuzzGbu+5MGTBeVfe4D+wpvyo=;
        b=gr88u6XQQB1FQd+d5nLYSP8+FETC+G3EPAsDFoyrcPEPF1gXmRt4gIOE3F7PLvEV2k
         8rvIyxFrnr8UvhNB5Tf6aAl3W7Oc7VClhQ1uh4bf6RF76NGwlOOmFdmiP1bRFvpF9M6G
         3GokSebcLhlyRW7PbKYeXSQgxu2PBg0wBMCeM7z+0qLnrJFHyizyM9B0env9UWaFam9F
         UBJ0QGuDSVT6yLsQKSTIu/hgjz6YYG6aW+Eb1/XUvYGNrQmtZ2IGlnbjgSaILxHxZkFv
         /84GuUsFZDjxK2I7oL0nlRh9TRzYlTdzDHzGwTdeSwRAdqSclzGQReVjVQoLdFLVSJjg
         HO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l//BzxFunUPpPVX4+aDuzzGbu+5MGTBeVfe4D+wpvyo=;
        b=BtNgqvwrRpTH2iU/hmOe81rNd+0rQEzPE1yUzSTqeeHA/J0Xso6BGGYGgu2UfSHt2J
         M6WD5EhbT8l/oo77CJSTeLmOOm/4F5dirMyaP9rAJK3UDJG6ctbank5KIYnu5qtsZXUB
         dnLHAPMVfnPjh6VBA3/zrfyECDakJizfg9WtbuGK4mFhd3PsILpbRXyPRQFOFyMvEIVp
         4MToBKCQR7i7TP3+Q2ExPgiHl2andDcVtWOKwERNN0xXzt5GI4AYj9QPCzTMtgE44HQR
         fdGJnwWrQ/vsqs5nPAZMEa+bIwnwQV1BOn27Mc3VhhnT9ou4ZyQGVHeLpGrxyhSwq3ki
         1nDA==
X-Gm-Message-State: APf1xPARvRH7AZSLD3LFrc9QaedFBYzoKKyQqX479eCO6lTFtwb1g656
        K8iavcbjTQGLZ2rdkRnjDtk=
X-Google-Smtp-Source: AH8x224dZGPCK4v8eLL4mjXmchcAb10JyP5uyQnWRQThL/APOXc7qY0/9RldK7NIle/6e+Rw6lIthA==
X-Received: by 10.28.238.202 with SMTP id j71mr3220376wmi.34.1518218147408;
        Fri, 09 Feb 2018 15:15:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n24sm156517wmi.21.2018.02.09.15.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 15:15:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 046/194] object-store: move replace_objects back to object-store
References: <20180205235508.216277-1-sbeller@google.com>
        <20180205235735.216710-1-sbeller@google.com>
        <20180205235735.216710-26-sbeller@google.com>
Date:   Fri, 09 Feb 2018 15:15:46 -0800
In-Reply-To: <20180205235735.216710-26-sbeller@google.com> (Stefan Beller's
        message of "Mon, 5 Feb 2018 15:55:07 -0800")
Message-ID: <xmqqzi4hu53x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> @@ -32,7 +31,15 @@ struct object_store {
>  	 * Objects that should be substituted by other objects
>  	 * (see git-replace(1)).
>  	 */
> -	struct replace_objects replacements;
> +	struct replace_objects {
> +		/*
> +		 * An array of replacements.  The array is kept sorted by the original
> +		 * sha1.
> +		 */
> +		struct replace_object **items;
> +
> +		int alloc, nr;
> +	} replacements;
>  
>  	/*
>  	 * A fast, rough count of the number of objects in the repository.
> @@ -49,7 +56,7 @@ struct object_store {
>  	unsigned packed_git_initialized : 1;
>  };
>  #define OBJECT_STORE_INIT \
> -	{ NULL, MRU_INIT, ALTERNATES_INIT, REPLACE_OBJECTS_INIT, 0, 0, 0 }
> +	{ NULL, MRU_INIT, ALTERNATES_INIT, { NULL, 0, 0 }, 0, 0, 0 }

Not the primary thrust of this topic, but we may want to convert
these to use designated initializers after this series is done.
