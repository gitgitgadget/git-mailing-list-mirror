Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6643520969
	for <e@80x24.org>; Mon, 27 Mar 2017 19:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbdC0TAe (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 15:00:34 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36251 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbdC0TAc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 15:00:32 -0400
Received: by mail-pg0-f53.google.com with SMTP id g2so48358689pge.3
        for <git@vger.kernel.org>; Mon, 27 Mar 2017 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=A1hhZCS8sVkDUtTtwE55qglH90+oDUklMpATE8Sz/D8=;
        b=CC3H1DRs7NttAuHW0tivIKE2aMncen00P/UXPYiL81jVokpThDiMFP9RpX0bTrH+3u
         sg+ydpiJy0XJ7GUM4h4SqzE/jpRNnkzF6l6YLnjVHBPfKQa6oCHTcnBIr0RrK00dOkSL
         M0tlDh7UiQXoKzJuOG/0+vVBHCn7umC1zRzUdSvOAIVJSB3ys2+o3fx8Uc55Nq03N0sX
         0HXxsdCBTVPv2zIrCINLZfz+5wjqgm228on0Sc5pyR1BKeMg6IGUc/6BOn/JyWmYIMOF
         Ye+OEAOk4cxIgjSFo0SHLG1FIxYXAZ0j2jz01iAZANJlClIofoKEc1MoJLn0Y1ob0yFV
         7SSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=A1hhZCS8sVkDUtTtwE55qglH90+oDUklMpATE8Sz/D8=;
        b=WV0bWLtWY6eHPC2bp2ydqPQzueQRSB8PS7MhGpRTxMzYJw3aFtjVqJktYOE89nu975
         BEVsYCdtN5PuRDKFAwESikId0tWY6XNqcfzVU/J+uDnhs04gKwmkllVLRIeOUHWkZv/R
         g3/ujnJ1m6+2GKtnL0xIJXN8lOPIugiKjJTmZnSxGwD4iBVzrdsHqmI8CLGFTiEW8Hd1
         +2llhKjJTQQj9MxrlFQI8APEV+EB97IayBDxbJzY/iXbJDOleIkucjWyDbfGw9CSAGuJ
         wjumzSWz26MBmW8YI3YIbA2mC/CgLBAitm7sNQ/vtabsJovKkBjtZRlT8kxe8n1rq9aC
         UPSA==
X-Gm-Message-State: AFeK/H0ZEMUEO2w6oP4E9+XUJEzWmNeFu3Xk6JoWhw17+kRGdsOKuJLz1v4z6NnaDYjXNlJ4
X-Received: by 10.98.215.70 with SMTP id v6mr27239100pfl.121.1490641177719;
        Mon, 27 Mar 2017 11:59:37 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:1c51:79eb:e58f:d177])
        by smtp.gmail.com with ESMTPSA id v186sm2586074pgv.44.2017.03.27.11.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Mar 2017 11:59:36 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] sub-process: refactor the filter process code into
 a reusable module
To:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org
References: <20170324152726.14632-1-benpeart@microsoft.com>
 <20170324152726.14632-4-benpeart@microsoft.com>
Cc:     benpeart@microsoft.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <c8f85b4a-e69e-76ab-9a8d-66857968fb4d@google.com>
Date:   Mon, 27 Mar 2017 11:59:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170324152726.14632-4-benpeart@microsoft.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/24/2017 08:27 AM, Ben Peart wrote:
> Refactor the filter.<driver>.process code into a separate sub-process
> module that can be used to reduce the cost of starting up a sub-process
> for multiple commands.  It does this by keeping the external process
> running and processing all commands by communicating over standard input
> and standard output using the packet format (pkt-line) based protocol.
> Full documentation is in Documentation/technical/api-sub-process.txt.

Thanks - this looks like something useful to have.

When you create a "struct subprocess_entry" to be entered into the 
system, it is not a true "struct subprocess_entry" - it is a "struct 
subprocess_entry" plus some extra variables at the end. Since the 
sub-process hashmap is keyed solely on the command, what happens if 
another component uses the same trick (but with different extra 
variables) when using a sub-process with the same command?

I can think of at least two ways to solve this: (i) each component can 
have its own sub-process hashmap, or (ii) add a component key to the 
hashmap. (i) seems more elegant to me, but I'm not sure what the code 
will look like.

Also, I saw some minor code improvements possible (e.g. using 
"starts_with" when you're checking for the "status=<foo>" line) but I'll 
comment on those and look into the code more thoroughly once the 
questions in this e-mail are resolved.

> diff --git a/sub-process.h b/sub-process.h
> new file mode 100644
> index 0000000000..d1492f476d
> --- /dev/null
> +++ b/sub-process.h
> @@ -0,0 +1,46 @@
> +#ifndef SUBPROCESS_H
> +#define SUBPROCESS_H
> +
> +#include "git-compat-util.h"
> +#include "hashmap.h"
> +#include "run-command.h"
> +
> +/*
> + * Generic implementation of background process infrastructure.
> + * See Documentation/technical/api-background-process.txt.
> + */
> +
> + /* data structures */
> +
> +struct subprocess_entry {
> +	struct hashmap_entry ent; /* must be the first member! */
> +	struct child_process process;
> +	const char *cmd;
> +};

I notice from the documentation (and from "subprocess_get_child_process" 
below) that this is meant to be opaque, but I think this can be 
non-opaque (like "run-command").

Also, I would prefer adding a "util" pointer here instead of using it as 
an embedded struct. There is no clue here that it is embeddable or meant 
to be embedded.

> +
> +/* subprocess functions */
> +
> +typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
> +int subprocess_start(struct subprocess_entry *entry, const char *cmd,
> +		subprocess_start_fn startfn);

I'm not sure if it is useful to take a callback here - I think the 
caller of this function can just run whatever it wants after a 
successful subprocess_start.

Alternatively, if you add the "util" pointer (as I described above), 
then it makes sense to add a subprocess_get_or_start() function (and now 
it makes sense to take the callback). This way, the data structure will 
own, create, and destroy all the "struct subprocess_entry" that it 
needs, creating a nice separation of concerns.

> +
> +void subprocess_stop(struct subprocess_entry *entry);

(continued from above) And it would be clear that this would free 
"entry", for example.

> +
> +struct subprocess_entry *subprocess_find_entry(const char *cmd);
> +
> +/* subprocess helper functions */
> +
> +static inline struct child_process *subprocess_get_child_process(
> +		struct subprocess_entry *entry)
> +{
> +	return &entry->process;
> +}
> +
> +/*
> + * Helper function that will read packets looking for "status=<foo>"
> + * key/value pairs and return the value from the last "status" packet
> + */
> +
> +int subprocess_read_status(int fd, struct strbuf *status);
> +
> +#endif
>
