Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43BA11FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 18:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbdBNSsl (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 13:48:41 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35151 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbdBNSsj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 13:48:39 -0500
Received: by mail-oi0-f46.google.com with SMTP id j15so75491589oih.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 10:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y5YEmvsLrrPhaFuTzLAnCrtCS+hvJqMqGvRIn5Kivts=;
        b=Voe2rA3v8nlfFiShH58BQfb9/AxaXiwJ7kHgglisxWxT5IG4HUBSlnxv3UAlOgfd2h
         VaaoKlBCqrZbrtSoC6LcrE9skJVhYfv5I9kKbUbH3DPxIhcKs+Ul9buk9+eIrIDzjNeG
         9ZHdvu8aFAr7IjIu5iwlFL6thNvFMFsZ80NzNd2zbQ9UE0y1A+QVh4AjbpAQodkZ/BOm
         WufUzP8FKhNQDrrhdrKsvXzV+jhgEZSaTMa3Lq5bXQHU6ViZi1tcXIirq42omfIG61t0
         Y6HW5ahiTQkV3bd5h2oN5KhYj8mwdyokD3r4ODSOF8n1xfcbdKyWJ9zof1Hz953vcgCf
         KsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y5YEmvsLrrPhaFuTzLAnCrtCS+hvJqMqGvRIn5Kivts=;
        b=p4hJBQLPjRWxRkcM62Ob3DEcyJCv7O74mLQe4bS1ku64forrBo7xIw7CQ5gb5kBSIw
         klCBVYOS/riYhMjizDbdEL5NV6GoLC5tmUZDNDhmdmK5zy4M5uo3RZ6qzseOcjg1F5Qn
         OYq7uSs5Sq2k7ON4ylnbR/li6bv02AQVjMz2NVFSD/gN6+ZI/BeuKIaLXch6AwZkMD4D
         Q7BKSh9WphYTiQrk7jHPh8zF9iYo2AS4DQJW5tORqNnO5yilbF8jIM4VwsGVyBSk1GtF
         N8hMXfIvbvlnQgn0ruhzqwfQsHXnkb83UE0nT6fCq4bPOckFr5WK0TyDw659RSNHPkuR
         +/vg==
X-Gm-Message-State: AMke39l6vVcEZvAHJMzfU653cvBDi11yxqaOz1vO6W8Tn8yaOxQyln9xosyAP0TPEDMgp3pp
X-Received: by 10.84.192.137 with SMTP id c9mr37975493pld.7.1487098118512;
        Tue, 14 Feb 2017 10:48:38 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:35a2:93b7:75dd:e184])
        by smtp.gmail.com with ESMTPSA id g85sm2713318pfe.38.2017.02.14.10.48.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 10:48:37 -0800 (PST)
Date:   Tue, 14 Feb 2017 10:48:36 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 4/7] grep: re-order rev-parsing loop
Message-ID: <20170214184836.GB44208@google.com>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
 <20170214060417.yq27zdcgmrckjmua@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170214060417.yq27zdcgmrckjmua@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14, Jeff King wrote:
> -		/* Is it a rev? */
> -		if (!get_sha1_with_context(arg, 0, sha1, &oc)) {
> -			struct object *object = parse_object_or_die(sha1, arg);
> -			if (!seen_dashdash)
> -				verify_non_filename(prefix, arg);
> -			add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
> -			continue;
> -		}
> -		break;
> +
> +		/* Stop at the first non-rev */
> +		if (get_sha1_with_context(arg, 0, sha1, &oc))
> +			break;
> +
> +		object = parse_object_or_die(sha1, arg);
> +		if (!seen_dashdash)
> +			verify_non_filename(prefix, arg);
> +		add_object_array_with_path(object, arg, &list, oc.mode, oc.path);

This is much more readable!

-- 
Brandon Williams
