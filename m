Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 357811FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 18:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbcFUSFo (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 14:05:44 -0400
Received: from mail-lb0-f195.google.com ([209.85.217.195]:34371 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbcFUSFm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 14:05:42 -0400
Received: by mail-lb0-f195.google.com with SMTP id w10so2704464lbo.1
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 11:05:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6rNtKsNAmUhlxc5PqvFBzyOsSEiD9/zFTc/kdjPT13w=;
        b=CuZws00kCKvpI6m5dwLF70wggVjkf6x7O9o+hRqGYJLPI4rl7pDPzFacH1GElNgvsi
         DSPI9G4AkeEX294ZVc4isAlecKpKtfC0hcc4sKJVEq7DgUDGFNCxnCyrHiCkPoZZn0nz
         K1d98scBTChRXbFF9iH7Sa4fg93e9PBs2pMZsQLRP1FWt2Chis8TyCriLwshUaMKCAP9
         rE03fLPtcDYPuaYhG990doz7+hMqMZlkF3gm2SoXdGWJ6ZzH1WEbMt6q/3q4IRdNidlq
         izANULAKQouwzQ9Odt1xVO9CSYc4JoUM1hzeA8wzztj3euklE6Cu0NXtQpz8t0hui7ig
         HmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6rNtKsNAmUhlxc5PqvFBzyOsSEiD9/zFTc/kdjPT13w=;
        b=XAv6KPCPC0r2BMRuMVdkCgxXfo2neBwzNmuYi/tM0OMgo7NHntV/XJH9RvIutZwQmK
         574vBFzHIr0zO66xeWgh0uDWESJgTTtRGN01HPwwTFM8xL2wMUgVwpEh4uWNicAVbwPW
         2K53k6ldw32zDKhCoZpOP1wnwLiAk733JVCpaXkwbW7ZmNqaFFzt8iQ6CbB9IE3tieCd
         8p89lwip6SgJT+MiiIFZ0UX6xs6wkykdOVYIr994m1L/63WdJ9gLhs8qUKFIYCX/NAU/
         sU16fCI3ZiHsTHNcciw/LVOHZCM2Y5KCuMrJs3ZHk+JKcbgl1KzIAh0T2zq5akque0Xd
         RvLA==
X-Gm-Message-State: ALyK8tLwHeD2qHR+cqhxQoxXF/uQoOc2JXVEwQHKYXz2M+nICIqQz8n8pozT9OO6kH152A==
X-Received: by 10.195.11.40 with SMTP id ef8mr20534142wjd.137.1466532340738;
        Tue, 21 Jun 2016 11:05:40 -0700 (PDT)
Received: from par3bztk12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id hf7sm50892246wjc.48.2016.06.21.11.05.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jun 2016 11:05:40 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/1] git-p4: correct hasBranchPrefix verbose output
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <1466517222-12600-1-git-send-email-aoakley@roku.com>
Date:	Tue, 21 Jun 2016 20:05:39 +0200
Cc:	git@vger.kernel.org, luke@diamand.org
Content-Transfer-Encoding: 7bit
Message-Id: <C471957C-3FEE-4CEB-8940-624F73784355@gmail.com>
References: <1466517222-12600-1-git-send-email-aoakley@roku.com>
To:	Andrew Oakley <aoakley@roku.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 21 Jun 2016, at 15:53, Andrew Oakley <aoakley@roku.com> wrote:
> 
> The logic here was inverted, you got a message saying the file is
> ignored for each file that is not ignored.
> ---
> git-p4.py | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index b6593cf..b123aa2 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2674,7 +2674,7 @@ class P4Sync(Command, P4UserMap):
>             return True
>         hasPrefix = [p for p in self.branchPrefixes
>                         if p4PathStartsWith(path, p)]
> -        if hasPrefix and self.verbose:
> +        if not hasPrefix and self.verbose:

Thanks Andrew! Your fix is correct.

- Lars

>             print('Ignoring file outside of prefix: {0}'.format(path))
>         return hasPrefix
> 
> -- 
> 2.7.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

