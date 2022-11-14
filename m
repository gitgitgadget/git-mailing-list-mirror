Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A645FC43217
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 23:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbiKNXqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 18:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbiKNXp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 18:45:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5EEC4
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 15:45:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e189-20020a25e7c6000000b006e37f21e689so1584361ybh.10
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 15:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0/Z8InVU91lSSMRGwnDgl5bz1wjdM3awcjVPYdqXKfg=;
        b=BPsTQtrvm7Ksyl+Q1tuspMHeOvGZ5GWoH2WaIA5d5DcY8eDOb82XzL58tjqYOd6pOo
         KReDWddgXlGoRWovM2pVmHa9Ug8tL4aTRgDj7/1v4ZxQ8CH6a5hSLjvr0fsRY/hGfERL
         YBdkV/RhJxwauTxBSRk0SeA4ar9h50KQcYmiRXqtudEJCRqUFgDtFltEYStt/Um/hYPT
         3wgOREIUp38Bi8bk67uHuSwkh4ePhgzhCVtQ+Y1ljiyB0daNYsOYrMegU+SugV5C2fI+
         aEX4aoykIIA9ZweVxAwWVUc/M/l9R4DbiYI832mAv/EEJJCKXCN2rP++Skr01z5bkrb2
         jdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/Z8InVU91lSSMRGwnDgl5bz1wjdM3awcjVPYdqXKfg=;
        b=i+h8M23BG5UN9nnYYulB0eab3toazUQWo/CJ0EqSfkowjErUp+wZB8jxKXhxeNX71W
         RxQ0Lhn4WB9tCQRLAVHgGEQC9qlgvmaDqWnHzGzOf7Y4o4/fpHxJaO1s8h3R7l+435DV
         bmsKQBbDY4PEH+Y6/u97+HBjJfJXMXobRtr6+aNUIA5jC7GeAYSYNVnWRRl+DCbWL8Vo
         2oA9jfzHl6YJusEx45CkLIJ+pdwWkPHH0GL8hjQ6dQ6V+RqmozE5ulk9uk6LRIg6vSFM
         g5hB49NOVFPSL1XGS3Q5Csr/hHWtKkN5IOI8vcFIK8bvVF9uWy9LUugNIcDekryzwG5R
         lx0w==
X-Gm-Message-State: ANoB5pkOFd1FKsWMt3Pop9JtwxS0dbQgJLTeVibLuiynCKZ4ecPc6YB6
        wPqxC6F5LQIagG+0WP4v6oUZ5rl8ZKUMVzLA2jvF
X-Google-Smtp-Source: AA0mqf4377V7iugTIrUo/XBj2Vx1LnnwlAFdSfIK5jkXiNb5t4FD6+6p4V6HN7LTH1NfK7AxeYCWTCcFVsSjwNoCRX3w
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a81:16c9:0:b0:36b:c476:c27e with
 SMTP id 192-20020a8116c9000000b0036bc476c27emr14670426yww.320.1668469558241;
 Mon, 14 Nov 2022 15:45:58 -0800 (PST)
Date:   Mon, 14 Nov 2022 15:45:54 -0800
In-Reply-To: <4e402b67145c6e33c13826f1daf1883a66cd9cd4.1666988096.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221114234555.19060-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 7/8] submodule--helper: remove update_data.suboid
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rearranging the diffs...

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> @@ -2532,10 +2532,8 @@ static int update_submodule(struct update_data *update_data)
>  	if (ret)
>  		return ret;
>  
> -	if (update_data->just_cloned)
> -		oidcpy(&update_data->suboid, null_oid());
> -	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD",
> -				     &update_data->suboid, NULL))
> +	if (!update_data->just_cloned &&
> +	    resolve_gitlink_ref(update_data->sm_path, "HEAD", &suboid, NULL))
>  		return die_message(_("Unable to find current revision in submodule path '%s'"),
>  				   update_data->displaypath);
>  

Here, we only set suboid if !update_data->just_cloned...

> @@ -2570,7 +2568,8 @@ static int update_submodule(struct update_data *update_data)
>  		free(remote_ref);
>  	}
>  
> -	submodule_up_to_date = oideq(&update_data->oid, &update_data->suboid);
> +	submodule_up_to_date = !update_data->just_cloned &&
> +		oideq(&update_data->oid, &suboid);
>  	if (!submodule_up_to_date || update_data->force) {
>  		ret = run_update_procedure(update_data);
>  		if (ret)

...and here, we read suboid if !update_data->just_cloned.

> @@ -2523,6 +2522,7 @@ static int update_submodule(struct update_data *update_data)
>  {
>  	int submodule_up_to_date;
>  	int ret;
> +	struct object_id suboid;

And here we declare it with no initializer. This is safe for now since we only
read it when !update_data->just_cloned, which is also the condition for setting
it, but may be error-prone in the future. Probably best to initialize it to
something.
 
Other than that everything looks good up to and including this patch. This is
definitely an improvement over using a null OID to signal something, so thanks.
