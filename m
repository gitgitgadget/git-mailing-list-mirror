Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761A31F453
	for <e@80x24.org>; Thu, 25 Oct 2018 08:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeJYRbp (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 13:31:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39971 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeJYRbp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 13:31:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id b203-v6so670789wme.5
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 01:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AzllIumKy9+sa/vw+5Hh38Vj1fh+ed0vyg46h+JFZJo=;
        b=PTU1VOWtB8ub18UnM1LAjzadRsMfbPBsgdyDO6J3Jw2FjJOd0a6Q5X4RTuCDv3wX9Y
         XZAcNFudsO9BfkjUSoFFFREUMHO3JnugHWaCkX3e5tz6RRJ42iiGp2/r0c8U/I2N9Pka
         omV1pbrJP1/SPzUAVqOhfkGtK8FxANTKr6Helql/kL+m/wL+KQLm53fadsjiMFZEZowb
         pTfxBQ/m8MMYcTdI+hNMMZwtC6KGWsp8qe31084GGcl8YNQSDFxRt/AhfI38VfTn/QzZ
         9qhcMhrY4GP01L8SuoTdttnSUeCvckBRiEcXCXwykSt6Ee0iv4P1/s/+a9gNPuS9UMVH
         vpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AzllIumKy9+sa/vw+5Hh38Vj1fh+ed0vyg46h+JFZJo=;
        b=Y0DlMjqGviOTwFU1FzI8JtzmsdaymTYLK7Za5ha+cepNR6h8QLGmtaoJPNV00f8a+V
         lOO6orn4A3CqwAdNAdWM/04GmQL3X4he95gCWjsIyGggCtavJLYM2L6YbvinicaNBX/N
         YeXMuZcjKOL3KpdnRF2AXGBjOrHgBuHUC0QqE78QaigWMz9kVu1yLw9ihukhpzCmzswX
         WfpCcKXWqOqeotyZUrhzDKNALatkWvfwJQSjv0qNPn92DaS6ykkJOVsQtFliNi2FtjFC
         ML+YWudZoOWuelJooFAI7TuX7jZkI/YspU5i8ylMQCafgn/F6qQqKJROLGdp/q6fkzD7
         K5gg==
X-Gm-Message-State: AGRZ1gKV2GpDVLkbS5z2qaxriayI4iduP1nKvhTcaKWN1sCPegt/EcPm
        ql4HtyyUyXbk3Z79HRyEmHg=
X-Google-Smtp-Source: AJdET5dyBHke8i3nH4faynHuZ+ABCIIzelnIXQRTyV6B9WQudncQtnJ5OkSA2pr+eviS+hd+RRiong==
X-Received: by 2002:a1c:9a11:: with SMTP id c17-v6mr924469wme.101.1540457994947;
        Thu, 25 Oct 2018 01:59:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o13-v6sm4610164wrw.93.2018.10.25.01.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 01:59:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/5]  am/rebase: share read_author_script()
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
        <20181018100023.7327-1-phillip.wood@talktalk.net>
Date:   Thu, 25 Oct 2018 17:59:53 +0900
In-Reply-To: <20181018100023.7327-1-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Thu, 18 Oct 2018 11:00:18 +0100")
Message-ID: <xmqqtvlah052.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Thanks to Eric for his feedback on v1. I've rerolled based on
> that. Patches 1 & 2 are new and try to address some of the concerns
> Eric raised, particularly the error handling for a badly edited author
> script. See the notes on patches 4 & 5 for the changes to those (they
> were previously 2 & 3).

I spotted a weird corner case buglet, but it seems that this one is
ready for 'next' even without fixing that "give it three times and
we will happily continue" thing.

Do we know of any other issues?  Can we now move it forward?

Thanks.
