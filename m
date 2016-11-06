Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BC342021E
	for <e@80x24.org>; Sun,  6 Nov 2016 20:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbcKFUmR (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 15:42:17 -0500
Received: from mail-yb0-f174.google.com ([209.85.213.174]:34374 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751237AbcKFUmP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 15:42:15 -0500
Received: by mail-yb0-f174.google.com with SMTP id d59so10965483ybi.1
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 12:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mTfRbE8V7gQdmAJMW4YKlcgjpX98uGNDlCmYuuxIPTE=;
        b=HCtVfSSFze14zVTUQxkxnNRkM/Dq47YdZ8LQ++k0yEUOmv9BwKi9obEZodKe+30tTw
         yFsXXupP/6Kslh4NsMS81SaWPBMTR26XMwpNThu6MLy6a2sJg9s66qXAs6u+guys7uDu
         GRenL7E6MPUEPIkqyee/TCdcYHxW80vCwqdUSSaLoEapn5yfIEoTkWLLvkCDyoX/OAv4
         kkKUT1I2JYTQ4t/zi83c07pulkS65U2QIb4xgfZX8OkOY0AZ7gKO44a4QUR35IkjXoct
         usbE7gl/AwOPAGVKXgJElN3rktzO7sKw5e7ivQpDqj/vS9QVWYYh88TI4fz1eHnFyNN8
         6uIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mTfRbE8V7gQdmAJMW4YKlcgjpX98uGNDlCmYuuxIPTE=;
        b=aOmgs3mNR8aI4oiO7dqVy8CUyT+kPZhBDN/ZaQm+h1bpRcaVbm1hThjSYUin2uiKzi
         C8pnYB5YQOqiAvvhByPL/Qy6BM5Zrf5AV0+ffaYo3pD6L55OkPPpaEmGgyZ02MW57Q67
         U+ndd+2+MwvM8RZYX6FE+1JyKJmfprfcxeedQKbfNkkaxA9SH4U2rc5GNGIHRy3MHccL
         qA7NGoQMKAm2J5FEw/colJ1nGBXQC2hhl5qeHLsU2dNinaeDg646JtNtrGAzLuRa6ZoQ
         na1c5JkHOnSSn5E8KbdEG7lKAh0rEpxqjK/MAaG+BNEJqQA+1QWcxFxLDYc3QoGFmjWL
         1hTA==
X-Gm-Message-State: ABUngve86syFoHCya7JiOENgN4iC0EL1EX65KCvZ9fpM9VeGSj9p50IyZBnhx4KBtbZCPciAFr5O2vLqhysnFw==
X-Received: by 10.37.220.141 with SMTP id y135mr3080042ybe.132.1478464419455;
 Sun, 06 Nov 2016 12:33:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Sun, 6 Nov 2016 12:33:19 -0800 (PST)
In-Reply-To: <ff5bb36b-e30c-3998-100d-789b4b5e7249@jump-ing.de>
References: <47c374cf-e6b9-8cd3-ee0d-d877e9e96a62@jump-ing.de>
 <CAGZ79kbavzGJ2sAcz5heg+BO+tZ=TgtrhxMH1-kqeJUpNNavyw@mail.gmail.com>
 <20161105110845.GA4039@fergus.ozlabs.ibm.com> <ff5bb36b-e30c-3998-100d-789b4b5e7249@jump-ing.de>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 6 Nov 2016 12:33:19 -0800
Message-ID: <CA+P7+xo6qTjf3R1WTjyRUAn0-2pyKXRpf=v_aMJGPXQg39SweA@mail.gmail.com>
Subject: Re: gitk: avoid obscene memory consumption
To:     Markus Hitter <mah@jump-ing.de>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 6, 2016 at 2:28 AM, Markus Hitter <mah@jump-ing.de> wrote:
> - Storing only the actually viewed diff. It's an interactive tool, so there's no advantage in displaying the diff in 0.001 seconds over viewing it in 0.1 seconds. As far as I can see, Gitk currently stores every diff it gets a hold of forever.
>

This seems like the right solution. Store only what we need to view as
we need to view it. (IE: lazily generate the diff and don't keep it
long term, possibly by generating each file separately when that file
is viewed)?

> - View the diff sparsely. Like rendering only the actually visible portion.
>

This also would be valuable, as part of the solution above.

> - Enhancing ctext. This reference diff has 28 million characters, so there should be a way to store this with color information in, let's say, 29 MB of memory.
>

I think all three suggestions here are a better solution that what
you've outlined already as you explain the problems caused by cutting
off the diff.

Thanks,
Jake
