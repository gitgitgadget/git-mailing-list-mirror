Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32CE1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 23:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755002AbeCGXe1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 18:34:27 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34495 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754998AbeCGXe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 18:34:26 -0500
Received: by mail-wr0-f196.google.com with SMTP id o8so3901592wra.1
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 15:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b9TWXpt8uheipExRqV6MNV7EeQjjkEOAz/MMKoIM7pE=;
        b=BMR5C7MjVsyWAHkM9NfV0OWKaofhNNuVuJ8nL4LKwDqHNXyDj0WjQGZBwbV2gt4kN2
         Ot8UzbEKVIGrgcC5iinC4OUNiJUJ4sKtighibx7KO1olFpVtAEBEYDCwuTbXE3JFQIqA
         xeEArqFZVsXHXuL/M13yW+jdof/ORQ5NSrA6o4vxq4cOQpMIIcBF02cba9GWpxzP0u2j
         thDODGaiZ1zYLCrCMDQH1qlcyoKROtM3pOAHblh1rCW1prkgG6f3K+moyRWH4iBJQQCL
         FXj9tws/gr/cmEtROJsX7frzuvV4mpkjjZsKO6vyRq8SZ5+QWXWthnTgsh9p5ZxUbFVL
         d85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b9TWXpt8uheipExRqV6MNV7EeQjjkEOAz/MMKoIM7pE=;
        b=uRL8Jnqyrr8g2/JbMtaZKGo28aNa4pNC2WkKgDzx8NO95BD1fFawkEJN00/OQ6qxwf
         xCA4K7Kj1i9BYYMIPetVPC9iUR8upHq09wAs2K8wVM8NaAHi/tO0Ddj0sZo9U5phv68H
         sE/4nmxBV2pn2JpXHBh4i6rei5HMODRjefS8xgXgtUKJyhS79ZYGO7a6CbYpEkziUKE+
         Rx8lAsoVy5S2RQgD5by34d489/7uQ++Fbd+WUruambAVzpEFAzV25rsNE6MwoQ0s4dpv
         VSELME9V1ll1IUHqx+gpIl5j56kDQXxsIz2muqAvLvGYeSuKfGln/SF6w4VF7hAo/E8I
         JlHw==
X-Gm-Message-State: APf1xPCVVGD8sjNpS4r+1QG1J8rz+FPGTnumrH605G32nJQIb2AWj0EW
        rn/5p4kF9NZJK0Qo0+Cgb28=
X-Google-Smtp-Source: AG47ELtYh3mXm2+7f37fBLkXNCARsu6psaqgGyCbWj7WnHt3VoOIeQEXlgP3+RalcLAe3pb35VvnrA==
X-Received: by 10.223.154.165 with SMTP id a34mr22715140wrc.85.1520465664436;
        Wed, 07 Mar 2018 15:34:24 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r70sm20983996wmg.40.2018.03.07.15.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Mar 2018 15:34:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, sunshine@sunshineco.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v10 7/9] convert: check for detectable errors in UTF encodings
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
        <20180307173026.30058-8-lars.schneider@autodesk.com>
        <xmqqr2ovzmwo.fsf@gitster-ct.c.googlers.com>
        <B001E8E2-9C98-4136-87A3-4425C50E90DB@gmail.com>
        <xmqqa7vjzfcp.fsf@gitster-ct.c.googlers.com>
        <766B302C-446B-4730-A5D9-909C6FCF6A84@gmail.com>
        <xmqqvae7xznk.fsf@gitster-ct.c.googlers.com>
        <4465AF18-EBE8-4BA3-8F95-B51630A41B86@gmail.com>
Date:   Wed, 07 Mar 2018 15:34:23 -0800
In-Reply-To: <4465AF18-EBE8-4BA3-8F95-B51630A41B86@gmail.com> (Lars
        Schneider's message of "Thu, 8 Mar 2018 00:19:44 +0100")
Message-ID: <xmqqmuzjxxxc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> I would like to advise the dashed form as this seems to be the
> canonical form and it avoids cross platform issues. My macOS
> iconv does not support the form without dashes.

Sure, that is why I said canonicalization without inserting dash
does not make much sense, hence an interim step with only upcasing
is not a good idea.  A possible interim solution would be to do
nothing (no dash insertion, no upcasing) and fixing both in a later
follow-up patch, but as I said, I do not care too strongly either
way.

> Would this approach work for you?
>
> 			const char *advise_msg = _(
> 				"The file '%s' contains a byte order "
> 				"mark (BOM). Please use UTF-%s as "
> 				"working-tree-encoding.");
> 			const char *stripped;
> 			char *upper = xstrdup_toupper(enc);
> 			upper[strlen(upper)-2] = '\0';
> 			skip_prefix(upper, "UTF-", &stripped) ||
> 			skip_prefix(stripped, "UTF", &stripped);
> 			advise(advise_msg, path, stripped);

Are you now interested in not having any interim step and jump
directly to the endgame solution?  If so, that is fine by me, too,
but as I already said earlier (i.e. not doing this BOM check for an
encoding that is not spelled in your canonical upcase-with-dash form
might be a feature that leaves an escape hatch), I am not all that
interested in enforcing policy at this point in the codepath to
begin with, so...

