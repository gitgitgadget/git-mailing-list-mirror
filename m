Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6AFC20288
	for <e@80x24.org>; Thu, 20 Jul 2017 00:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932252AbdGTAzT (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 20:55:19 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:37736 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932164AbdGTAzR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 20:55:17 -0400
Received: by mail-pg0-f47.google.com with SMTP id y129so7145618pgy.4
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 17:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yFb56RfHfAHmL+odJV3UWFUVBESHkbNgdzJvbJ8d2VY=;
        b=bvBUYHLhEGyd5Ody6z0xfc6NBv1GDyGmn/ypIxjJRY3bUjuBqhm+i1V81pxJRtI0R2
         dO6gM6zNiieTckH9Iied7dqsaGE1MAP3TpXotlbarRiAPy78TU440QL2JsWy/I5rftNo
         e+Yw5hSRFDGeqIVp1yJ/i65dB3C+zyzax04TFwAyPLdO/78BKjSqPsYuLSraXAYAkr7g
         MEdVdSy3WL8usOivPGZVFMUwq0egOrXNp0LLK/T2JMgxjHzvl1SVXeinAH8AbSvivfQT
         Ws86feDofytbx0DWWEVT6rJMDFlsBf5Tsj4/B5NagBgv2Z/fO8d72hNwa6Xp9cI3iflO
         kzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yFb56RfHfAHmL+odJV3UWFUVBESHkbNgdzJvbJ8d2VY=;
        b=IyyvCuq7S1V/JD77e6TTGCspo4tI+t7Sfp73H0qXgFf+BlQ+L4Dbayp+3cj3JDDHay
         k8aPAv5B4mnu92dviZx6dBZ86a5mejFSqu3MObmNlnDHJorHz5CIH4SZJ1J7+YOtUKsY
         mkaiiWOOMoG+yFQqDHTiY2zJtKAtC3Ag3GumLRpARzaAPSI+FTr7ZcpOscIWGoUKnq0E
         I17/Nt24ONDkwoIZtG5arl7Hbt25Wi1Y5gG/8/VR+6sxcp0c3dD49T+iKzAMEWoyl7Zv
         bFLhP94as8IyD/4lU0AH2+DCQhJGrxSoUbNdPhOEEGyEyMVALm/xgK1a6cyL6EHJqCQp
         JU+w==
X-Gm-Message-State: AIVw1107zu9vhCkkKLOzagvMne98fUWM4A6t5C50s4rOX9L8WkBl0m5V
        +rTEAqg2rZtUSG8/
X-Received: by 10.99.121.75 with SMTP id u72mr1913381pgc.53.1500512117241;
        Wed, 19 Jul 2017 17:55:17 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:f109:8044:bbc9:49ff])
        by smtp.gmail.com with ESMTPSA id y6sm1575073pgq.41.2017.07.19.17.55.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 19 Jul 2017 17:55:16 -0700 (PDT)
Date:   Wed, 19 Jul 2017 17:55:12 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [RFC PATCH v2 1/4] object: remove "used" field from struct
 object
Message-ID: <20170719175512.4974d1a2@twelve2.svl.corp.google.com>
In-Reply-To: <CAGZ79kbYebKkSBtiFOMO5+uknbNMnhyT6P6uu=MMhmFyOZRE+w@mail.gmail.com>
References: <cover.1499800530.git.jonathantanmy@google.com>
        <cover.1500508695.git.jonathantanmy@google.com>
        <0eb270f40095f132bf9383f230506e45d895e5e1.1500508695.git.jonathantanmy@google.com>
        <CAGZ79kbYebKkSBtiFOMO5+uknbNMnhyT6P6uu=MMhmFyOZRE+w@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 19 Jul 2017 17:36:39 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Wed, Jul 19, 2017 at 5:21 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> > The "used" field in struct object is only used by builtin/fsck. Remove
> > that field and modify builtin/fsck to use a flag instead.
> 
> The patch looks good to me (I would even claim this could
> go in as an independent cleanup, not tied to the RFCish nature
> of the later patches), though I have a question:
> How did you select 0x0008 for USED, i.e. does it
> collide with other flags (theoretically?), and if so
> how do we make sure to avoid the collusion in
> the future?

Thanks. 0x0008 was the next one in the series (as you can see in the
context). As for whether it collides with other flags, that is what the
chart in object.h is for (which I have added to in this patch), I
presume. As far as I can tell, each component must make sure not to
overlap with any other component running concurrently.
