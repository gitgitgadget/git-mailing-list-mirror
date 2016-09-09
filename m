Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189FD1F859
	for <e@80x24.org>; Fri,  9 Sep 2016 10:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753960AbcIIKhM (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 06:37:12 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:37182 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753460AbcIIKhL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 06:37:11 -0400
Received: by mail-it0-f47.google.com with SMTP id i184so9150561itf.0
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 03:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uIGObJghHJcAcS719jHudNWCTkhtjLrVrzO46owfwdg=;
        b=0G30FQ5xaM2IF/oK2disQaCn9xILnT+jP+8OEAdrsvG0qoi5G8xaxrYZ0rQ6yB64Eq
         I60avbwEYWM21MYwnLHqeCK5Q/UtkfdL1RnsKHqikqNZnclgvOh6+r6LaNxEqdI2148b
         kbOdBlfwOItYs8H3c6CBfKF+v7g8JEsvJgMNGtQUV+m5gw4KzIakMpHQwI7TOR4aQTyL
         5HLYYb51GpjsYYY1a7cezREjyp+zIRMlGNefw0/ow+Z23wfPycgEV+L18OzZx9F7qf/3
         xh3pD4Kw1Hm1C8EnYsa9jKgvmfgxyKZx5FyBt26qC4iEh6xItKesYCRMWnt6n2PA7L6A
         nDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uIGObJghHJcAcS719jHudNWCTkhtjLrVrzO46owfwdg=;
        b=Z3YMp6V8OzzA2Kzn2OAOQL1BB4aTIMUdBXWVBVDNaI+0VAbnlEOm/oRBXdxtjKp1tW
         qBDrm7OnJGXKgmkdkptmd2uySfC3hUFf0Gv7wsz8SZDBx5ammFohNAjuLNsaJBC5ULSw
         wJC5kd6paES9yri3tikoAoTH7SFs13r45wz07BtVuE/OSykLrkA4fZTIG/4LmpfKMGpY
         /y/4PE7QjH/2Ha0UpARCDrMk7YKmiPAzxYhtxmuOdF+xx70ZQHM4uWSlPOj41hYGRXCW
         Z6/OLnpoI/MUWU5rVrhZmfAKO65WzBRqszPXB5dZMgMxIxhLy4yTVPI2qM+wRSgIe+ov
         AmlQ==
X-Gm-Message-State: AE9vXwPa3qFqBf9jRVjXSKXB+E4C9t8kQi0Q6T9r5mw3lmHCBuLj89qotJo0Obe/0R5VRrHuF5pw0ZLoet4Rjg==
X-Received: by 10.157.26.90 with SMTP id u26mr4090149otu.117.1473417430357;
 Fri, 09 Sep 2016 03:37:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.40 with HTTP; Fri, 9 Sep 2016 03:36:39 -0700 (PDT)
In-Reply-To: <xmqqk2emgp2m.fsf@gitster.mtv.corp.google.com>
References: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
 <20160908134719.27955-1-pclouds@gmail.com> <20160908134719.27955-2-pclouds@gmail.com>
 <xmqqk2emgp2m.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Sep 2016 17:36:39 +0700
Message-ID: <CACsJy8B7-K+WryPcY3u0qeza_mNOgjN0R9NNEvUpbo4YTch3Qg@mail.gmail.com>
Subject: Re: [PATCH 1/3] init: correct re-initialization from a linked worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Max Nordlund <max.nordlund@sqore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 9, 2016 at 2:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> When 'git init' is called from a linked worktree, '.git' dir as the main
>> '.git' (i.e. $GIT_COMMON_DIR) and populate the whole repository skeleton
>> in there. It does not harm anything (*) but it is still wrong.
>
> -ECANNOTPARSE.  Did you mean "... worktree, we treat '.git' dir as
> if it is the main '.git' ..."

Yep I accidentally a couple words there. Will add them back.

> or something entirely different?
--=20
Duy
