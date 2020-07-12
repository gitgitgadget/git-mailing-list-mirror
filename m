Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27529C433E0
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 23:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09DC3206F0
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 23:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgGLXHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 19:07:22 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:54678 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgGLXHW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 19:07:22 -0400
Received: from [178.112.81.104] (helo=isticktoit.net)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <tobi@isticktoit.net>)
        id 1jul1x-0004H0-SK; Mon, 13 Jul 2020 01:05:09 +0200
Date:   Mon, 13 Jul 2020 01:05:08 +0200
From:   Tobias Girstmair <tobi@isticktoit.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] gitweb: Replace <base> tag with full URLs (when using
 PATH_INFO)
Message-ID: <20200712230508.GA1000433@isticktoit.net>
References: <20200711203947.23520-1-tobi@isticktoit.net>
 <20200712183329.3358-1-tobi@isticktoit.net>
 <xmqqmu44phym.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqmu44phym.fsf@gitster.c.googlers.com>
X-Df-Sender: dC5naXJzdG1haXJAaXN0aWNrdG9pdC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 12, 2020 at 02:00:01PM -0700, Junio C Hamano wrote:
>Sorry, but I am not sure the description is understandable to the
>intended readers of this sentence.
>
>Where does this README.html come from?

gitweb reads a README.html from each repository to display on the 
summary page. 'man 1 gitweb' has a paragraph on it under "Per-repository 
gitweb configuration".

>Is it stored in the history of the repository as a blob, and sent to
>the browser with a call to git_blob_plain() sub?  Wouldn't that

No, it's a plain file in a bare repository, placed there either manually 
or by a post-update hook.

>codepath send the untrusted end-user data as an attachment, in which
>case relative links in the blob do not get resolved relative to the
>base URL anyway, no?

I'm not exactly sure what you're saying. gitweb includes the README.html 
as-is (i.e. without escaping). If the user wanted to include an image, 
they'd write <img src="blob_plain/HEAD:/image.png"> (assuming this patch 
landed). In practise, these URLs will be rewritten by the 
markdown-to-html converter.
