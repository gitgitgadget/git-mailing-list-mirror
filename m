Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A173C433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 02:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238232AbiBGCPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 21:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348600AbiBGCPS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 21:15:18 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D7BC061A73
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 18:15:17 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id s11so10109509ybl.7
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 18:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xEOGINRNIWut8In+43EHxMQeUJBKB6B4qd4rUh7k8fw=;
        b=Ug0WQntfI7fshl2nQheV6ATVbQuMRhcoubebgs6BLruURQGODlkQ9oZGxHitgoLE37
         S3V7yUcnM09XeIZvmgMky5S7zc1++358+jsUyMSB6wfTYN7a74Sj4G6Ye5Ag9s3vwWJ6
         YkZy9/dSBIYkd7CRzPsqaBEKprzCItvrG+/NxvjvbBKQMzv5zvzFRK4nQ2HYjXQcqrjN
         9VvAjWXnHI8dsSLD2BjgPM0mEqIFnx2q7p++MX6nbGc1zJaa4MFfVHiJ+ItoZDKxJFtw
         YEFq3nrzAMXruTM1d1hz9adMaw+sEdb4ETFVITavpRIKKoj0oCUmZlF9Up7rlsGCThGn
         k9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xEOGINRNIWut8In+43EHxMQeUJBKB6B4qd4rUh7k8fw=;
        b=FRIINPwTq+f1210CgFcPkqzWNt4I++UzvD8nhL9K2a3UxC/7MBfN23P77xL+GLe5Ng
         Sixbfm1qapjOM4QbbFZuKQffemhQPZW6gkEt8+GEZhbolonYzuZQc7/tFiVEaX9NY60z
         FpKxbTttByRAEgczHnS+7kVYWWFVGCS94QCyFOGXa1+14kkOKB5lTxty0SucUX9cz0oI
         b8ml42dmKczgDvsBFKvZC+2V+V2dHg//KN0qZEDtECRwJpb3fkMgXU7YRWhrDNhtyNL8
         pmCEhAZkDjZN0NgXq2VReQM8pzH+t22sIDh72sVhb/017+YDXDpGKJvTTn3xB1bR6xe5
         4dKA==
X-Gm-Message-State: AOAM530Ryg4Fqcw0SLdbeizT4rOPKb99jzcz1rhUcyXxq6WHzc727xX/
        PaYgJE7NWJSqQqxV0sxktjGf0Jp6zyWFiXXITeiUOX0iEqqKUw==
X-Google-Smtp-Source: ABdhPJwU2VMr19y8qyXb2heRaqLU5vsLukEgEUM7dyJ8U7JF7Q0JBcJYk35ROZZJpm8n59QSzo+kE/Xes1zZ1W4C5vo=
X-Received: by 2002:a81:ce08:: with SMTP id t8mr2752161ywi.145.1644200116938;
 Sun, 06 Feb 2022 18:15:16 -0800 (PST)
MIME-Version: 1.0
References: <CAPQu=HaH+E5-t4A671GFFLMbiHo=LWP=pucxBG=tT6QjhUXv=w@mail.gmail.com>
In-Reply-To: <CAPQu=HaH+E5-t4A671GFFLMbiHo=LWP=pucxBG=tT6QjhUXv=w@mail.gmail.com>
From:   Paolo Benvenuto <paolobenve@gmail.com>
Date:   Sun, 6 Feb 2022 21:14:41 -0500
Message-ID: <CAPQu=HZu0bq0fdnhDN-r5xeQ_caEfSBe5_xAp52LA4sFGXqbQw@mail.gmail.com>
Subject: feature request: add a way to debug ssh connection
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm using git (2.25.1 on xubuntu 20.04), and I access to my remote via
ssh in order to authenticate with ssh key and not to have to use the
username/password pair.

Now, mi internet connection is very slow and unstable, and possibly
has other problems - I'm in Cuba.

Doing "git push" I often cannot connect to remote, sometimes it
connects, sometimes it doesn't.

"git push -v" adds verbosity only with reference to git

I think a "--ssh-verbose" options would be very useful and very simple
to implement. The only thing it must do is adding the -v option to the
ssh command (when it is used).

Also, if the user repeats it, it would add a repeated -v option to ssh command.

Thank you for your work on git!

don Paolo Benvenuto
