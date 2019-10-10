Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D57E81F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 23:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfJJXQs (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 19:16:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36562 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfJJXQs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 19:16:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id j11so3541414plk.3
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 16:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=rrFBczgQPC3NzbNl+EKm+6RK3M0Gxx/CieEQitI8eCU=;
        b=TujChAqSA5YgdXZ4BUCF1rBQR4JbKJfduvY+B/HVQx6HAgpZ5o5sOlbMvKLc/fmeop
         Kr7cbmqGQZVilSMI4n3YDpXPKoOB+fZSez/Pmm3RkVU9HFCSgI0/xKg6Vg5osRgp410N
         2EjyGyH5bBj8OjH09Z4XZDO9b+PtqqdTmfbLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rrFBczgQPC3NzbNl+EKm+6RK3M0Gxx/CieEQitI8eCU=;
        b=dQ+ZdYBL+IW/ONpUWkCfCMe9jr88Ow1tCq/CHNMk6Cmv0RKh7XTDl6Kna0oJSHU7Jo
         OtRzCtRAZr++cOaX7Q0qpK+158dd7xiYOQ5CjLJrAay+YVehQYqNJsjkaXANOv/FGtLc
         YTGnY9agt1lbq4PR7xI+Dl+CS3WCV/vnXdTb++pqQAfjWzAULKhsL8TlGxey1YmbPhTa
         FfII1BliAymYofUsxzoQtQl4SgL5AjLJQAdvYJxTG2+8RuoXRTA3GhvuqQ6j3lMOoZl0
         rV4359R4YX4GyvbSZn7qyIJbJyX+3Ul63Rk11C//+aPHwbGDL26BUVgzRGzWxry+ZOoh
         ZEHw==
X-Gm-Message-State: APjAAAXfUmqt9SUt/CFomMGtGjxV/aqbFSGhu+OQerIa2nuJV7pf43DD
        f3W8RzSjgXwnccOLnGZMWLtUJw==
X-Google-Smtp-Source: APXvYqxFwfYTJHHkdoxyOHTyhrmAAPeW4drQjvJugO+H+ZMov3/Io8gTZMHxYqL2UaA1zzh87FKPxA==
X-Received: by 2002:a17:902:8606:: with SMTP id f6mr455573plo.226.1570749405923;
        Thu, 10 Oct 2019 16:16:45 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id m4sm5962371pjs.8.2019.10.10.16.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 16:16:45 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     patchwork@lists.ozlabs.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        git@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] parser: Unmangle From: headers that have been mangled for DMARC purposes
In-Reply-To: <236b9c32-b501-79a7-8366-26d64ceac24f@linux.ibm.com>
References: <20191010062047.21549-1-ajd@linux.ibm.com> <20191010194132.GA191800@google.com> <236b9c32-b501-79a7-8366-26d64ceac24f@linux.ibm.com>
Date:   Fri, 11 Oct 2019 10:16:40 +1100
Message-ID: <87y2xstcmf.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrew Donnellan <ajd@linux.ibm.com> writes:

> On 11/10/19 6:41 am, Jonathan Nieder wrote:
>> Interesting!  I'm cc-ing the Git mailing list in case "git am" might
>> wnat to learn the same support.
> Argh, that reminds me... this patch only rewrites the name and email 
> that is recorded as the Patchwork submitter, it doesn't actually rewrite 
> the From: header when you fetch the mbox off Patchwork.
>
> Part of me would really like to keep Patchwork mboxes as close as 
> possible to the mbox we ingested, but on the other hand it means the 
> mangled address is still going to land in the git repo at the end... so 
> I should probably just change it?

Yes, I think change it. If you're worried, stash the original one in the
headers.

>
> -- 
> Andrew Donnellan              OzLabs, ADL Canberra
> ajd@linux.ibm.com             IBM Australia Limited
>
> _______________________________________________
> Patchwork mailing list
> Patchwork@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/patchwork
