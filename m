Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA02E207D2
	for <e@80x24.org>; Tue, 27 Jun 2017 06:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbdF0GGi (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 02:06:38 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35309 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbdF0GGg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 02:06:36 -0400
Received: by mail-it0-f50.google.com with SMTP id v202so9123614itb.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 23:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hmVgp8djmvu8AKogpgHLIygPQX+cGW0BFbRIGOZMgoQ=;
        b=AQ3xhVTMZaalzAr1TkSKwFkzpf2sPD890FfhQt9VvpNkvg9v8D+cIiUv0XB3Si4tvK
         FDkis5P2Bj4VaadcRvywTgZT5FIHWhSosFpXZOOaccVkKLrCg81+oOxnyHCG8h3/uKRP
         77n6VGTuFDWHMQOMMgB++A1fahs7rBY4Hx3gywA/tu1j+9e1Jt3+R3Kjgkl3bOorGpX+
         qOQxKY3fI7AW883nyARTttzKGEFWHu8N7wEy2uNUPMTyDKrUERHMo/uCn5XXxlFdXSX6
         G49ymuy/usbTpLUs+fnLvTijrrtc3h0vP5miZlRFCc8uFTOCeEh2R4EqQEwtrFoDzWwm
         D1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hmVgp8djmvu8AKogpgHLIygPQX+cGW0BFbRIGOZMgoQ=;
        b=aH0YuSQU5euyoQYG6/mNOoym/c5PqSp+qsgRzF90o2L3hs9greQNT+moyrkxNmLJI7
         ASaP8OEa2SHcWhjgLoArCo0EgLTs400kc7/TJZP054tlLopvVoHvvhIr6KuypjWqs0YA
         q9o7nnakbO5C/h4rbgNAjkDffCFrIACr+QTjFD2zKFA40KeaQOofFaAejTnUuB/XDa/I
         zkRaOE/d3RzS3yw3p0EIc0O3I5kviRwYb9C4S+4EtrIF+dLneDGLXxbeJDO0VO1Q5BmK
         Bu4f8nmWM5U2D8u0cTattUNPFVFCw0ci7+2Rw6CLvYWhS5rANKo4RL4nYTfsaMzSEzMJ
         utJw==
X-Gm-Message-State: AKS2vOz49tWdcUgr7pSGuJj2+tEJKrZrMlPb5dBy88qgASJ3IkqRAnVw
        tt4DPNEUHAusJHBMmgMHua9r43oDLg==
X-Received: by 10.36.84.144 with SMTP id t138mr1765628ita.76.1498543595632;
 Mon, 26 Jun 2017 23:06:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.40.70 with HTTP; Mon, 26 Jun 2017 23:06:35 -0700 (PDT)
In-Reply-To: <20170626231108.23640-2-pc44800@gmail.com>
References: <CAME+mvUrr8EA-6jbCZdpB7dMZ5CN3RyY7yoRoUBoiZw=sH6Ysw@mail.gmail.com>
 <20170626231108.23640-1-pc44800@gmail.com> <20170626231108.23640-2-pc44800@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 27 Jun 2017 08:06:35 +0200
Message-ID: <CAP8UFD3WY4KptxphBnNVvOfh8XQYrn5jabzBegx5K07+9PnDtQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 2/6 v2] submodule: port subcommand foreach from
 shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2017 at 1:11 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> +
> +       if (!is_submodule_populated_gently(list_item->name, NULL))
> +               goto cleanup;
> +
> +       prepare_submodule_repo_env(&cp.env_array);
> +       /* For the purpose of executing <command> in the submodule,
> +        * separate shell is used for the purpose of running the
> +        * child process.
> +        */

As this comment spans over more than one line, it should be like:

/*
 * first line of comment
 * second line of comment
 * more stuff ...
 */

Also please explain WHY a shell is needed, we can see from the code
that we will use a shell.
So it should be something like:

/*
 * Use a shell because ...
 * and ...
 */

> +       cp.use_shell = 1;
> +       cp.dir = list_item->name;
