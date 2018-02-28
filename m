Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 570021F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeB1BWP (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:22:15 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35796 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbeB1BWL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:22:11 -0500
Received: by mail-pf0-f195.google.com with SMTP id y186so350814pfb.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/QhViwetgxoXKsFVVxCS+q4KmN3XPElcbWJ4ygHZ/JM=;
        b=Pfj1NpyagrrLvhS2YC16mhR1FgMbWFxNuXXgKhj6IHVU2eo359oQpKwKUWsBct3i7g
         e5/WubyNKCBB2gahzGi6ex9LcC37vZQQb1TX8T5buQs5w54HGV32K5EObcQZbjwJLgw4
         E5SE6bPVS3wO27eJGeWSqmQguSntk5ylECshq6FFUfXM9+FGJLAjVUZEZ0Fhf1g213gD
         z7dHZDJr0mkgZtUPaLdDHb9ODHzp97aQTl8ZMxzdNU39MeIQwdQvoSDkkoQIcCVflpIe
         qoBcXfafYjBsVnAxnzoLTiBGSU4jYMs3pJDH7iUPZll/q568YR2JqUQn3ODE4I8QUu7L
         wXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/QhViwetgxoXKsFVVxCS+q4KmN3XPElcbWJ4ygHZ/JM=;
        b=M2sKp7RCVk01QAbjPQsyoVytCBro+uyGBAUTS8vTJ6pCllUDGXL7+YBwvSIh2edx/O
         iAvMWFvVzxiJSOT2jjVUCgBtaIcmZtdfvYdsK1IXIZ9wjE+HKovBvJ0YbE5tPIgCVgn5
         DBURG5qCXjzhEJwhODb0MOO/KIsrZ5XwXCDrOJDugIrSJvIqvuwOtfx1Cosn3ww7FAhM
         rF/gDbmkrGxq0qXfyuq16oNGkOJ+l/lTeL8wX+XMDbiBeiYQhlFYSEj3oZ4Hv8XLA1jW
         IovyUgxSfNPQ11BCrp8qsiBVULWBbSlwYo3OVYVofFyKxEvZBuyg74VToMEEcfo+Yas5
         0UtQ==
X-Gm-Message-State: APf1xPD0XiWW6Xyvb1b2GL6+lAziAURH6eS87TWFESb0gcD0DyAuNpna
        sWqotMLsPsnQr/uH8BHvjv8=
X-Google-Smtp-Source: AG47ELv1W69i55wcVM6yPVbkevo64GpktfN+NQj2KHpy+BabyPIzBB+tK2JUjMeIglnuE+rTs9m7Ug==
X-Received: by 10.101.81.76 with SMTP id g12mr2583771pgq.88.1519780930219;
        Tue, 27 Feb 2018 17:22:10 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j64sm557186pfe.68.2018.02.27.17.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 17:22:09 -0800 (PST)
Date:   Tue, 27 Feb 2018 17:22:07 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] protocol: treat unrecognized protocol.version setting as
 0
Message-ID: <20180228012207.GB251290@aiede.svl.corp.google.com>
References: <20180228005059.GA251290@aiede.svl.corp.google.com>
 <20180228010233.GA45342@google.com>
 <CACsJy8Cn2hcodoR8ksRBY9qf7MmJaP+KAzYqv6seeR9s-Be8Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8Cn2hcodoR8ksRBY9qf7MmJaP+KAzYqv6seeR9s-Be8Hw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen wrote:
> On Wed, Feb 28, 2018 at 8:02 AM, Brandon Williams <bmwill@google.com> wrote:
>> On 02/27, Jonathan Nieder wrote:

>>> If I share my .gitconfig or .git/config file between multiple machines
>>> (or between multiple Git versions on a single machine) and set
>>>
>>>       [protocol]
>>>               version = 2
>>>
>>> then running "git fetch" with a Git version that does not support
>>> protocol v2 errors out with
>>>
>>>       fatal: unknown value for config 'protocol.version': 2
>>>
>>> In the spirit of v1.7.6-rc0~77^2~1 (Improve error handling when
>>> parsing dirstat parameters, 2011-04-29), it is better to (perhaps
>>> after warning the user) ignore the unrecognized protocol version.
>>> After all, future Git versions might add even more protocol versions,
>>> and using two different Git versions with the same Git repo, machine,
>>> or home directory should not cripple the older Git version just
>>> because of a parameter that is only understood by a more recent Git
>>> version.
>
> I wonder if it's better to specify multiple versions. If v2 is not
> recognized by this git but v0 is, then it can pick that up. But if you
> explicitly tell it to choose between v2 and v3 only and it does not
> understand either, then it dies. Not sure if this is a good idea
> though.

Interesting thought.  Something roughly like this (on top of the patch
this is a reply to)?

diff --git i/protocol.c w/protocol.c
index ce9c634a3a..6aa8857a11 100644
--- i/protocol.c
+++ w/protocol.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "string-list.h"
 #include "config.h"
 #include "protocol.h"
 
@@ -14,14 +15,18 @@ static enum protocol_version parse_protocol_version(const char *value)
 
 enum protocol_version get_protocol_version_config(void)
 {
-	const char *value;
-	if (!git_config_get_string_const("protocol.version", &value)) {
-		enum protocol_version version = parse_protocol_version(value);
-		if (version != protocol_unknown_version)
-			return version;
+	const struct string_list *values;
+	const struct string_list_item *value;
+	enum protocol_version result = protocol_v0;
+
+	values = git_config_get_value_multi("protocol.version");
+	for_each_string_list_item(value, values) {
+		enum protocol_version v = parse_protocol_version(value->string);
+		if (v != protocol_unknown_version)
+			result = v;
 	}
 
-	return protocol_v0;
+	return result;
 }
 
 enum protocol_version determine_protocol_version_server(void)
