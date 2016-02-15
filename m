From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] remote: use skip_prefix
Date: Mon, 15 Feb 2016 13:35:03 -0500
Message-ID: <CAPig+cSkfEwa8TTJPg5B9W8FCqPXD9Uz6_EuFQeriwYHhP99gg@mail.gmail.com>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
	<1455558150-30267-2-git-send-email-t.gummerer@gmail.com>
	<20160215181837.GE26443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 19:35:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNzL-0000Lc-K0
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 19:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbcBOSfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 13:35:05 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36004 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbcBOSfE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 13:35:04 -0500
Received: by mail-vk0-f66.google.com with SMTP id k196so8456672vka.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 10:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=afJjqB2pZWfI2rVBBR1DkOVVcUpkDnKZEfPm7emZ7jM=;
        b=GFncDEmJOLp5HcjngJfX14Mu+PkHrd4TnQ6HgtcCL0zhXuXjMZlY16Xjmk0dv7zQwr
         EQtVAWo7YkskUagwRJGE91w6LeCgexg5cZCsw7cYme8n+ZQ9s/OT/1IliYXGd6be1aLu
         ACMZG0u9IuHWqm55oZkKdEsHltdeNHiQaajIc6uMf7BOIsOg++cQvRTaq7jcwQIGYaqI
         gS+pSel1S0uLMxLQebB0Cxb0bhyWakdrh95CTYLlDpNeXdJsN0URkw7QWBS7Yo+7trDX
         O/BCeltcntvURElyzQF5Kr08XLZJ32AKpsP9KBWAZNO7sTt0UGvj+Oprn/ATPxjMXU3y
         HZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=afJjqB2pZWfI2rVBBR1DkOVVcUpkDnKZEfPm7emZ7jM=;
        b=B8XnhXuK4PzMHxvsch1UD1lNCkatkClxj9U1kedYO2mKaBaG3CNOFFZvY9hXF1upHM
         cJk6+8f4/q2MDB6jdaGQxuBMVk8+ZJkA02+1Ie1TG2lwfE1+OOuhoLuY2LpC5u34rdaa
         pH7El+ebbalWj6GYD7UAJcYVIK7UMCojsn2pw+khkzEe8X8/OgK9VWjChgYZ6n5KKdOD
         +cLtK3CXL/cMDBI9qe0id/HrXcM6ssU7aVSYF15AnVB0tQgvWM4WWj9oaGAqdaWY91B6
         MNrewGy4rW489T7bbZrJRGvK18Tq9IeYNnlGsrQNAQZoo8Q/SV0CRyaoBu9ROx5V64hE
         azeQ==
X-Gm-Message-State: AG10YOTazXpK/o2ZrJjFapo8qOHllUMlyLuYOv/nHiiqNiFyBuWOOSm61YWe2NpIn+PHIyvTrxBj9z7587acYg==
X-Received: by 10.31.41.14 with SMTP id p14mr14756801vkp.151.1455561303393;
 Mon, 15 Feb 2016 10:35:03 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 10:35:03 -0800 (PST)
In-Reply-To: <20160215181837.GE26443@sigill.intra.peff.net>
X-Google-Sender-Auth: umJ3YZgBRTkuBpUMutMEWOrEWOk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286227>

On Mon, Feb 15, 2016 at 1:18 PM, Jeff King <peff@peff.net> wrote:
> This is definitely an improvement, but I think we can actually go a step
> further here, and use parse_config_key. Like:
>
> -       if (starts_with(key, "branch.")) {
> -               name = key + 7;
> -               subkey = strrchr(name, '.');
> -               if (!subkey)
> +       if (starts_with(key, "branch", &name, &namelen, &subkey)) {

I guess you meant: s/starts_with/parse_config_key/

> +               if (!name)
>                         return 0;
> -               branch = make_branch(name, subkey - name);
> +               branch = make_branch(name, namelen);
>                 if (!strcmp(subkey, ".remote")) {
>                         return git_config_string(&branch->remote_name, key, value);
>                 } else if (!strcmp(subkey, ".pushremote")) {
