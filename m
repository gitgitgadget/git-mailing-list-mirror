Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2D001FC19
	for <e@80x24.org>; Sat, 25 Mar 2017 00:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965258AbdCYAU2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 20:20:28 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35994 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965201AbdCYAU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 20:20:26 -0400
Received: by mail-pf0-f182.google.com with SMTP id o126so2196085pfb.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 17:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AiIbX9922rD4EI2w3gcaQcH6RmxsGOlQh99WAmXMuOI=;
        b=H+4Sg1SEatD4XE7PukIoQaScmgo3C7oU0mXs5sG7Tb7obkM2Cbk9E0K9bFJfwi9ub/
         IM9kM+mpMG1VB1EikcSTe9adcu5WIqK3Io8B0twbXUKAEyisBOktbaenCqjrbekY0bz4
         5Z3LOAYSKGEnEtgtk6K034wJG+78PE0P5enrp/ywnxoT8h3hybgqSxbXHxVkIwbH0HNr
         hi30JT8zU20sa8g4WrScFFbU9VDvwzzjdJ80XfTlnALXRf4We+fX6S8+odBpncnNw5rQ
         njP3+gmy7UaUhLevRQ2w1KCGB2i+wyc75TzhTerGPpderANdaxqi2err+DtgNxbG9Lv9
         Tdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AiIbX9922rD4EI2w3gcaQcH6RmxsGOlQh99WAmXMuOI=;
        b=aich3WA27LMNbSw6JhCGCzf1EYaEURFxIpBvHTYe7HnRtS9QO7v6T7+1VO57fmDCuQ
         8YlpGksje63CfgWubmKoVND6qC9VfSYOkRZI7Vr76goA5inHjfHs97iq+mLgBnlGjS4f
         VpxoXCQP0utpm2T54pdDiDWMHwYPFQj+/N4lrCMZ+QKyLG55UHrYW7c6rwsF7lGzH7Zy
         SCU9hJjfJoUlZTczzNuhknND3BQhUDpn1z8EYHHj+N3puZuw8cHD0we1ioxJ1qgnkSE2
         KBWQn0kNIs/Nnko4wCEFL6RSWa22ZDZnHtDYlwoDhx1aGULzdf0P64or0vxsY4yp1d7h
         2wsg==
X-Gm-Message-State: AFeK/H0Lt72MFCSP47zfMYg817GRSfJPgQ5BsNJVnejZn50ZQ9TIyciE9akyPmksJVggWEkuwiVwt7QObjoeZoRA
X-Received: by 10.84.241.139 with SMTP id b11mr7351014pll.107.1490400720824;
 Fri, 24 Mar 2017 17:12:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Fri, 24 Mar 2017 17:12:00 -0700 (PDT)
In-Reply-To: <20170324223848.GH31294@aiede.mtv.corp.google.com>
References: <20170323223338.32274-7-sbeller@google.com> <20170324182902.19280-1-sbeller@google.com>
 <20170324182902.19280-4-sbeller@google.com> <20170324223848.GH31294@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 24 Mar 2017 17:12:00 -0700
Message-ID: <CAGZ79kYQNqz0BKRU+Sc9XRbuw5N-0stt0Um2h4YEyKNQPLyHUw@mail.gmail.com>
Subject: Re: [PATCH 3/7] submodule.c: convert is_submodule_modified to use strbuf_getwholeline
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 3:38 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> It also overlaps work a little better.

mentioned

>> Once we know all information that we care about, we can terminate
>> the child early. In that case we do not care about its exit code as well.
>
> Should this say something about SIGPIPE?

done

> language nit: s/, no output/: neither output/

done

> wait_or_whine(cp->pid, cp->argv[0], 1) doesn't do that but is meant for
> signal handling.  Maybe we should rely on SIGPIPE instead (which
> wait_or_whine always silences) and avoid the kill() call.

done

> Can there be a test for this case (i.e. having lots of untracked files
> in the submodule so the child process fills its pipe buffer and has to
> exit early)?

done
