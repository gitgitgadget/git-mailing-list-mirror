Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 491A7207B3
	for <e@80x24.org>; Sat,  6 May 2017 00:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbdEFAUM (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 20:20:12 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36522 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbdEFAUL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 20:20:11 -0400
Received: by mail-pg0-f67.google.com with SMTP id 12so2512988pgc.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 17:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ARvlP8Pxo89DvMMR2iweTAdGCBbSbKbLXt16sOPmXpc=;
        b=pM3jS1b+QKVOr7gpyk0LLy7lJRA8c/TWt6AJX2zsQhXYObWgHg00mqzxaZ+kjaBwaW
         DfJw+Ps8+L09BxCiF5w2xQYz3e4mlZClPwjmCK+72cnoB8X+VhEXJ/dBcIA0yOekoPCx
         qx3OkwavaSAuJazPiQRPlpAeNKqgFdhR/Kxa9caftpJ6HG8Mq+HiDnqggrB25r4d7q9w
         dV++ufW2aCIKqOggaSIgiPX8Uyf3qiOuLik6cy5ls8h/UfctuSgQC4XmShYPd973q8cb
         a9htfBnREDPDY9hV8PfwczcZnBWdttNoMJ1zaqh99S7aGRYfYVj4L7EfSlH96iWjaUb3
         guBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ARvlP8Pxo89DvMMR2iweTAdGCBbSbKbLXt16sOPmXpc=;
        b=kR5DSsO8V4XHSzRLjj7hNdcd7Yl6FbnN8kyq7HFM24/84SBSwnc9qhUXSTd41Tx6eH
         MCJ7tvMgvtHeqdD6YdbDMiGlHlx8brR0MnsWNwbCjjJEE4HoYrAg0/UZhOZ89aZOgblN
         E5Z9ZjI1StcjuTthlVGKcuVRSSk+jiIX+u5BpvrSnMncl9TxgBnhA47ry1XEM3ToNRrI
         aKV02Jty1DFOTQhLPUPPHgroEGxrcfgsxCdpZUngFWOm902N1cyMMDvEuwK5+uxQ1zam
         ogseyRrUuBPdQAji1BB2xTNoNrxJlh1Jc2LLquW7x9RGZ3SCJsV+a1KTsCZ9n8aTATqD
         Nb0w==
X-Gm-Message-State: AN3rC/5ej+SGVBjvXxSWrlodrlmQvirlowqt+/yh8OCgUN4mb2eNbgP/
        te03/7+bjMDKrg==
X-Received: by 10.99.39.194 with SMTP id n185mr6534894pgn.15.1494030010388;
        Fri, 05 May 2017 17:20:10 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:5d98:2d3c:6099:849])
        by smtp.gmail.com with ESMTPSA id 29sm11767032pfo.9.2017.05.05.17.20.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 17:20:09 -0700 (PDT)
Date:   Fri, 5 May 2017 17:20:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] receive-pack: verify push options in cert
Message-ID: <20170506002007.GL28740@aiede.svl.corp.google.com>
References: <cover.1494027001.git.jonathantanmy@google.com>
 <01e098de2da2e5f0b341ab6d967d032d840c365e.1494027001.git.jonathantanmy@google.com>
 <CAGZ79ka4vG1yd1JtK9bDBjWPUG0UCPMvw2XQUsfX_e_xFCpVLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79ka4vG1yd1JtK9bDBjWPUG0UCPMvw2XQUsfX_e_xFCpVLA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> On Fri, May 5, 2017 at 4:46 PM, Jonathan Tan <jonathantanmy@google.com> wrote:

>> This sets in stone the requirement that send-pack redundantly send its
>> push options in 2 places, but I think that this is better than the
>> alternatives. Sending push options only within the cert is
>> backwards-incompatible with existing Git servers (which read push
>> options only from outside the cert), and sending push options only
>> outside the cert means that the push options are not signed for.
>
> As the combination of push certs and push options are broken
> (at least when using JGit as well, which are used in Gerrit
> installations), I would not feel too bad about actually going
> the backwards-incompatible way.

Per offline discussion, what you're proposing is to omit the second
copy of push options from the client request, so the server does not
have to see two copies.  I agree that that would be a better protocol,
but I think that ship has sailed.

Current versions of git the client and git the server are able to
interoperate without trouble (though the server-side bug is ugly in
terms of what the push certs mean).

Current versions of JGit the server *require* that the push options be
omitted from the push certificate.  I don't think there exists a
sensible way to interoperate with that, so we can ignore that JGit
server behavior as a bug (like you've said).

If we want to omit the second copy of the push certs (which sounds
like a reasonable thing to want), that would require a new capability
to be added to the protocol to do so.  That way, interoperability with
existing versions of git the client wouldn't be broken.  That could
happen on top of this series --- it is not needed for fixing the bug
that this series fixes.

To summarize:

 1. I agree that we shouldn't feel bad about breaking compatibility
    with the JGit server behavior at issue, since there is no
    reasonable way to be compatible with it.  And that's what this
    series does --- it breaks compatibility with the broken versions
    of JGit server and picks what the Git client has been doing
    instead.

 2. I don't think we should break new versions of Git's ability to
    interoperate with current versions of the server, even though I
    consider the current server behavior to be broken.

 3. If someone is interested in getting rid of the redundant second
    copy of push options, we have a way to do so, by introducing a
    new capability

Thanks,
Jonathan
