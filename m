From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Thu, 22 Sep 2011 11:41:34 -0400
Message-ID: <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com>
References: <4E7A3BDE.3040301@alum.mit.edu>
	<7vy5xh1whq.fsf@alter.siamese.dyndns.org>
	<4E7AF1AE.5030005@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 22 17:41:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6lPA-0000Ei-Ud
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 17:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101Ab1IVPlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 11:41:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54014 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab1IVPlf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 11:41:35 -0400
Received: by ywb5 with SMTP id 5so2047049ywb.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UCxUeuDW8vXSA8AG8xYUML8lF/ztICC2xbzzahM5rPs=;
        b=RbWu1ln9MqPo1fhW/N8290OuHCV6HfISnvD2pXhkaOJ4XLxX9RlPiXohsBy0tWtjJl
         p0Gffw3SlPihGcr35WpVf9bc0CBqLXBMq0SRLWqkn5VZ6XlVIwLLQKJlIoTRI0CcQ2sR
         UdHKfAo38JSi7YGIWp3/WI8LlxC/FpcCFwgas=
Received: by 10.147.154.12 with SMTP id g12mr2209010yao.36.1316706094788; Thu,
 22 Sep 2011 08:41:34 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Thu, 22 Sep 2011 08:41:34 -0700 (PDT)
In-Reply-To: <4E7AF1AE.5030005@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181897>

On Thu, Sep 22, 2011 at 4:28 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Where does "git show --check" read its gitattributes (i.e.,
> "whitespace") from?

It looks like builtin_checkdiff (diff.c) calls whitespace_rule (ws.c)
which in turn calls git_check_attr (attr.c) which, in a bare repo,
considers $(prefix)/etc/gitattributes, core.attributesfile and
$GIT_DIR/info/attributes, falling back to the default whitespace rule
of trailing_space, space_before_tab, and tab-width of 8
(WS_DEFAULT_RULE in cache.h).

Thank you for this thread. I was under the illusion that diff-tree
--check considered in-tree .gitattributes, but the code seems to
indicate otherwise. :-(

j.
