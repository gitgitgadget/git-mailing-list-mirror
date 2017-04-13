Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EE1920960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755810AbdDMTnW (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:43:22 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34876 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755589AbdDMTnU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:43:20 -0400
Received: by mail-pg0-f47.google.com with SMTP id 72so26461159pge.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 12:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nBO5CM8+CdN4jkznBS1jHi+VLRQQUd7lIASRP0unXcg=;
        b=UMiQjWNxNr+SR/qlgAJDU97G8t4ZdHljCh+b96Bw+rzZiJH8VmjB22KjZF6Xt/Jwuk
         2mVFF2zLz6v7dbfrvezEtUWCw2XAw7dwbrODCPpHd3zCHIt+Iu9Ors0DvdtSGQjS4g2M
         w9xdcGeoU/mII32neJbzi57ZUwbfCjWIx/tkklc0W/HRS8DercMyJzTc0E85oapPm/bj
         IFElT6dyGIapD3rZiRQtontF/fQos0iXop9Rg4G1/N7eQgjzEXigfjw94OFCg1E4KajT
         mQMMTQDGq90ecT5cenqq8jiHndfAfP4WNxd4tG/Pql4Fi/ZrRGypZ15pFQ1YjPIsVUfm
         Bx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nBO5CM8+CdN4jkznBS1jHi+VLRQQUd7lIASRP0unXcg=;
        b=o6fxuAgQyke45ERjlQxTL1fZ8KjV6ilqdlnzTG1BtycN8ZMTwfCyVKDUnt5UomRH+i
         V6LY4kqpSwF+a87afbhyItkG5O9PvL1D+CUIPnA+d6HRmgbMNMOJH5rTzCZZLhIXAZ39
         41oeGwOQJvPUGvE8AZq0T48ix6YfSA1jdYzyF7zZTCn986ocQtIRDKdB4/JS4zIymy1R
         AgasS8IX0ZQC53Uz7khHWOCF57GWnu1glTiFUdsVo+8B6en6X4Ee0N3fW+Z2lNMDT32P
         YxqHn0Cwz4DbB6/+bitqjogVzVNcZ5mKJgoF799n17RKSakOEtgK1CZcTy11k3UwWz1H
         NITw==
X-Gm-Message-State: AN3rC/6cPWZCFXhIc+DhbUEC6XQvXti+AzTB1YUdP4hG7Vebtl9qip/Q
        /LBZb1aBJqgjWrjW
X-Received: by 10.99.97.85 with SMTP id v82mr4304234pgb.186.1492112599845;
        Thu, 13 Apr 2017 12:43:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:1426:66e2:260b:9db9])
        by smtp.gmail.com with ESMTPSA id p2sm8321596pfj.93.2017.04.13.12.43.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 12:43:18 -0700 (PDT)
Date:   Thu, 13 Apr 2017 12:43:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 4/6] run-command: don't die in child when duping
 /dev/null
Message-ID: <20170413194317.GG96917@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
 <20170413183252.4713-5-bmwill@google.com>
 <20170413192928.GA6129@whir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413192928.GA6129@whir>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/13, Eric Wong wrote:
> Brandon Williams <bmwill@google.com> wrote:
> > @@ -487,7 +483,7 @@ int start_command(struct child_process *cmd)
> >  		atexit(notify_parent);
> >  
> >  		if (cmd->no_stdin)
> > -			dup_devnull(0);
> > +			dup2(null_fd, 0);
> 
> I prefer we keep error checking for dup2 failures,
> and also add more error checking for unchecked dup2 calls.
> Can be a separate patch, I suppose.
> 
> Ditto for other dup2 changes

I simply figured that since we weren't doing the checks on the other
dup2 calls that I would keep it consistent.  But if we wanted to add in
more error checking then we can can in another patch.

> 
> > @@ -558,6 +554,8 @@ int start_command(struct child_process *cmd)
> >  	}
> >  	close(notify_pipe[0]);
> >  
> > +	if (null_fd > 0)
> > +		close(null_fd);
> 
> I would prefer:
> 
> 	if (null_fd >= 0)
> 
> here, even if we currently do not release stdin.

K will do.

> 
> >  	argv_array_clear(&argv);
> >  	free(childenv);

-- 
Brandon Williams
