From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 0/4] ls-remote: introduce symref argument
Date: Sun, 17 Jan 2016 12:14:33 +0100
Message-ID: <20160117111433.GA7100@hank>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bturner@atlassian.com, gitster@pobox.com, pedrorijo91@gmail.com,
	git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Sun Jan 17 12:14:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKlHm-0003ls-A1
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 12:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbcAQLOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 06:14:09 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32829 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbcAQLOH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 06:14:07 -0500
Received: by mail-wm0-f65.google.com with SMTP id u188so11145993wmu.0
        for <git@vger.kernel.org>; Sun, 17 Jan 2016 03:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6yt+ImjbYAO1sqMo1eT4qTNvCeaibbNFW5GQgZL1AtE=;
        b=R+7T8f6ZoRi+riRbwV/Q1MOvRpY6vtiHSHIkg2kjFutHE3nd7DZM3bbn41bXSFj7TV
         YorXdFMrJsnVZ+4lXhaAW8Q8O8ulvWrjpFW+7NQ7gyozGcOiA0S3+fVrmWbKqAolKzz0
         +8prXTHtou1ZpOXHKJ2snVqWbM2w1nWsjKSxn0iP8vpt5pjEU1kvP1n/bHODB80Z5egR
         9/eRLUrY+2r77EeG3+JiMMsjJRiOXi/u5bpHX0bhfQBh6NDa3DCNYhHJ/jm380+5oCVp
         P2OFRAuxAOVui3xRu/ItTPaici6z6fZakcerkbV2HtyPORG/XbvZLYyn8yWraXjh9p69
         1Vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6yt+ImjbYAO1sqMo1eT4qTNvCeaibbNFW5GQgZL1AtE=;
        b=bGxIdWEbTilxSauwpg1xMptKm0H3mf6fYCLjbJewkGr4hzDTFGigumvbjfDCb4PUNN
         xCUG9EncWGELdMf5PVXhpgVpTgWEXRHF56JE0Q2xax6vxSgNCCol0dn1dpf6tWPEKrDA
         ZWYFti9YbEoMGm6AR03Ndze9Ph6TYK0XErjQo7vhsAjml2UO2E+wdf1jhfmieRNNXqYH
         RGpU6i+MweZRCo3ws8gadGphI5CuN6ti+L2Zow0+d9x5pXk0Fi7PG6hP7DSl4nKdVghF
         VES+X/aUXva6Fz3VZCbrM9VrvwlTtKtYz7R9sACXh1qECBV6Yxsu0BL+HcR073ErqpU/
         Ntcg==
X-Gm-Message-State: AG10YOTY9IT+f3oO8T7+QXoNAlkmlRUNI0065bS/GZFiQ6GJlAAdLq2M3nB8qzkmIdmMaA==
X-Received: by 10.28.150.215 with SMTP id y206mr7353259wmd.8.1453029246724;
        Sun, 17 Jan 2016 03:14:06 -0800 (PST)
Received: from localhost ([95.233.44.41])
        by smtp.gmail.com with ESMTPSA id jo6sm18947995wjb.48.2016.01.17.03.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 03:14:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284254>

On 01/17, Thomas Gummerer wrote:
> > I thought it might be nice for any porcelain which tries to wrap
> > `ls-remote`, make some decision based on the capabilities, and then
> > invoke another plumbing command. But I guess that is probably slightly
> > crazy, and nobody is doing it.
> >
> > Something like `ls-remote --symrefs` probably would be a better place to
> > start.
>
> Turns out adding this is pretty simple.
>
> The first two patches are documentation, which I noticed when reading
> up about the command.  Patch three is a cleanup patch, which makes
> ls-remote use the parse-options api instead of the hand-rolled option
> parser.  Patch four is actually adding the option.

Sorry, I forgot to add --in-reply-to to git-send email.  For
reference, the thread that got me to do this patch series is at
http://thread.gmane.org/gmane.comp.version-control.git/284075.

> Thomas Gummerer (4):
>   ls-remote: document --quiet option
>   ls-remote: fix synopsis
>   ls-remote: use parse-options api
>   ls-remote: add support for showing symrefs
>
>  Documentation/git-ls-remote.txt | 12 +++++-
>  builtin/ls-remote.c             | 90 +++++++++++++++++------------------------
>  t/t5512-ls-remote.sh            | 20 +++++++++
>  3 files changed, 68 insertions(+), 54 deletions(-)
>
> --
> 2.7.0.14.g2b6d3d6
>
