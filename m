Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5BF20A26
	for <e@80x24.org>; Tue, 26 Sep 2017 00:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936577AbdIZAWv (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 20:22:51 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38416 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935041AbdIZAWu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 20:22:50 -0400
Received: by mail-pg0-f67.google.com with SMTP id m30so5751212pgn.5
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 17:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kE8K3Iv5oZDqTF+6Ba/1MjaHFVgWv0uCU/bpAmw3y+E=;
        b=ruGDuYXAXhQbJHGtuKsHCYmJJSYU6waYQLbMGVNJ/nn6zbOY9xJp3F8RLtK/Dwg9BB
         1nTATmEoM+kykrsdf2/peq94N2U0mxYmp1qKOD0IN9Yi2pOaZun4CjOyyDQ6iQu9ZPvV
         Ed6/jZwe8ofkIsXtmF1OFYLzE1SpSkYA20VksR8mIhM3Pv3agtCMIQt2XPk+Y3Y9ZDS6
         EqE1ogOWRduRVX8NPJYwzyUMiYPNzc/VbZV6KPjU5dRrSAMUEizbqMr12Cbzi2R/WXWo
         ZaodJh29H4cJaBWcHjUIzohGyUt+DbfcdfnabiMW6y75VsDjovpUD5bWi1kfAsRN7g6H
         yCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kE8K3Iv5oZDqTF+6Ba/1MjaHFVgWv0uCU/bpAmw3y+E=;
        b=XcrBQ+g6Lc2RY9tZNLkC4VTf4G/aoqKHvOph5Mshtq+w1Zeivfq8AwCUPeVgWDdIzQ
         qm//hNHa2TR356Fizk8etG96++c2e2yOL6z8WDKcvxiF71lI5nvG8NNsbR9iqVqSVG3e
         ckfScpuPgis0brq0znU5QFVyWVpxq4ohLR5BKtOq081R0LycFKvbneth8WfF0uZe7tyj
         zBvt6NpK8GPuX4Zc+oPKz+8bu7xchhXTCojSeBtSUvZNMnEUkkuIH+cpd7sbeX1mZXDQ
         iOlrBjCWvATUNC16itob4KHKIVyrRJmdWXUQfIx9WDiYhfSG2pkgH+tvhtBYAe6QoSi3
         zrNw==
X-Gm-Message-State: AHPjjUijbUmzlgMfUYDHuQCvBtIt1vhI1u7njSzm/20D1kvVUMo/Caf0
        Vo4LLQGKI+dQHnQ5XvhuNAM=
X-Google-Smtp-Source: AOwi7QBWZRxJRPW8aGU2+PSwJg/RE/bZEPV4hW9Ma8JfEV0eDpVvJqRhNCt1bNu33jm2+cyi5+agSw==
X-Received: by 10.84.133.111 with SMTP id 102mr9217650plf.204.1506385370091;
        Mon, 25 Sep 2017 17:22:50 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id d124sm12601651pfc.42.2017.09.25.17.22.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 17:22:49 -0700 (PDT)
Date:   Mon, 25 Sep 2017 17:22:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170926002246.GR27425@aiede.mtv.corp.google.com>
References: <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
 <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
 <20170925235510.GL27425@aiede.mtv.corp.google.com>
 <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
 <CAGZ79kZwc8bNWJfH_36soy75EpyHAMbJGhQd4rV5f-0RMjiwHQ@mail.gmail.com>
 <20170926000913.6x7qhj2vw73tldxe@sigill.intra.peff.net>
 <20170926001602.GO27425@aiede.mtv.corp.google.com>
 <20170926001732.GP27425@aiede.mtv.corp.google.com>
 <20170926001956.hgtdeklogvkirdxa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926001956.hgtdeklogvkirdxa@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Sep 25, 2017 at 05:17:32PM -0700, Jonathan Nieder wrote:

>> #ifndef EUNDERFLOW
>> # ifdef ENODATA
>> #  define EUNDERFLOW ENODATA
>> # else
>> #  define EUNDERFLOW ESPIPE
>> # endif
>> #endif
>
> Right, I think our mails just crossed but I'm leaning in this direction.
> I'd prefer to call it SHORT_READ_ERRNO or something, though. Your
> "#ifndef EUNDERFLOW" had me thinking that this was something that a real
> platform might have, but AFAICT you just made it up.

Agreed.  Two of the risks of replying too quickly. :)

Jonathan
