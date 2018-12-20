Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9111F405
	for <e@80x24.org>; Thu, 20 Dec 2018 17:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbeLTRdy (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 12:33:54 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:42350 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbeLTRdy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 12:33:54 -0500
Received: by mail-qt1-f175.google.com with SMTP id d19so2681092qtq.9
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 09:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tA+eQxKPCGPbfBBcBYgFmQpxfrJ4nRka/6pvBK+2g1Q=;
        b=suHckr/TJo/M2pdNn9fwgAyydCxWbofT+X+zw5dy4qyhO/+grA0pyGMj0E04PwpNTe
         jeKT6cF3ZZhmR2MNQQqCm77kz4iOvPnzJoeTup0Up+phO9NlYaTzxVB93fdU6Xp3axKX
         Te0niczH9ud0JqGoz5U3TugFxf2oFd2knoOeGIcC7j2qZxNglbKwcZslx19aORKsqQoA
         XtlpLAdxKhkARSbbWcIcy/EYbZ7hj60P2agImM7fZnbWVa+yVTfOGxKr2nzdEl+n4dsT
         y7Yn0o2ox9odtdUE831/cpJd/zZf9iyOaeQYAjuPyg+ykw+d9rMmR846c3IDsEgEz6kY
         WQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tA+eQxKPCGPbfBBcBYgFmQpxfrJ4nRka/6pvBK+2g1Q=;
        b=ti+pOfIaz5qw3w6PRGvhAVF1ctOIX1/mEQG9kCqZ0YPH0049GHdx8YVxCye0zznZVN
         oqX82FyGnU6mvdy43v7c31x+8dQMT7QuyN+68/vxSatcH7iTppVtPn9xAT5jboZ63Xjr
         5kJWH8oF8w713urBE1y6sEgHiE8FaZZzbrOLW0tz50AqbKtzggwrDyT0h2WDRYk20Ypw
         gxEDHxms2hNadScXlfMVcbPSXniduvKro3qQSeW67Ak7XM9A258EW/hv8+oyVZkWjetQ
         mwMGgAPD9oRHt2vhrf8giiMBSVa/4jMtUQo4DW5lrSJFV0tE5nRzNQ666e94nuE6wG4S
         oEHQ==
X-Gm-Message-State: AA+aEWZP+k7SSdVFhrmLu3Jie2cy2lXuXRa1dEXhY8k6k6M54Xdm3qz5
        ByHV/S8Crp1OL3QcBB+KV2Ic78xA
X-Google-Smtp-Source: AFSGD/X6nX4ameqmuttxgEm54lpLYL+DQ5LIkAu3FhzKvTgy7+fTzsPTXGXfyaIcuSr/FeKhefy1dg==
X-Received: by 2002:a0c:b5c8:: with SMTP id o8mr27557582qvf.213.1545327233187;
        Thu, 20 Dec 2018 09:33:53 -0800 (PST)
Received: from localhost.localdomain ([187.183.221.211])
        by smtp.gmail.com with ESMTPSA id x24sm4897378qtk.70.2018.12.20.09.33.51
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:33:52 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:33:48 -0200
From:   Ricardo Biehl Pasquali <pasqualirb@gmail.com>
To:     git@vger.kernel.org
Subject: rebase: Ask before doing anything not undoable
Message-ID: <20181220173348.GA5203@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was the second time I've typed "git rebase --co",
hit tab (for completion) and enter, and the result was
--committer-date-is-author-date instead of --continue .

Please do ask user before run actions like these! I have
not found a way to undo that. I had to perform a reset in
the repository.

PS: Notice I was expecting a command of interactive rebase,
    and I got a bunch of commits's date (and hash) changed.

Cheers!

	pasquali
