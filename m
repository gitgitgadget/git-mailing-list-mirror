From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] git diff/diff-index/diff-files: call setup_work_tree()
Date: Mon, 25 Aug 2008 21:46:37 +0700
Message-ID: <fcaeb9bf0808250746q3366b9cap78c45718287fba80@mail.gmail.com>
References: <fcaeb9bf0808250652p3d0f483dt714cd68d3122d7c9@mail.gmail.com>
	 <1219675383-1717-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Karl Chen" <quarl@cs.berkeley.edu>, git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 16:49:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXdM8-0005T9-Tn
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 16:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbYHYOqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 10:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbYHYOqj
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 10:46:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:53294 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbYHYOqi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 10:46:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so992961fgg.17
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=d0Z+zZqSAi1kNtFDWYCmTh/XPzVJeBmPnZ2VtcdFFIw=;
        b=MKsFouU1ko8wZcH3ZRkV/oDGrX8ouxynaxOCYLI7UnPQsli66/0xl9IrM//Fd47Lm2
         aJPt3jLYJmxp0jIOAwaPN00ftSgtYdYPxVwHMhxECjbY3hlUuySncbdi69VDmkUdjJpg
         fiR30z7kj5AIy+lgVoLcB0/F0vzzEr4tO1tFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iBwJM6k++16txO0u9cxmoDNp9GTDpCPVDVX8Dj8jBInIcXy72hJZ+yuOcJqNE8UnxX
         Fwq2J9ysMZynm8ZBwX2iqwM1U/I1mjsTnOk94m/2vL0UTXGH1Xeagznj7vCOVMxHxYcw
         RzCB0udX/l+MWtrevMkr3dJl1OXFglQxYSOGU=
Received: by 10.86.31.18 with SMTP id e18mr3408767fge.52.1219675597422;
        Mon, 25 Aug 2008 07:46:37 -0700 (PDT)
Received: by 10.86.93.13 with HTTP; Mon, 25 Aug 2008 07:46:37 -0700 (PDT)
In-Reply-To: <1219675383-1717-1-git-send-email-vmiklos@frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93632>

On 8/25/08, Miklos Vajna <vmiklos@frugalware.org> wrote:
>  diff --git a/builtin-diff-index.c b/builtin-diff-index.c
>  index 17d851b..b8e0656 100644
>  --- a/builtin-diff-index.c
>  +++ b/builtin-diff-index.c
>  @@ -16,6 +16,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
>         int i;
>         int result;
>
>  +       setup_work_tree();
>         init_revisions(&rev, prefix);
>         git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
>         rev.abbrev = 0;

I think this is only needed when cached == 0

>  diff --git a/builtin-diff.c b/builtin-diff.c
>  index 7ffea97..86f9255 100644
>  --- a/builtin-diff.c
>  +++ b/builtin-diff.c
>  @@ -244,6 +244,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>         int nongit;
>         int result = 0;
>
>  +       setup_work_tree();
>         /*
>          * We could get N tree-ish in the rev.pending_objects list.
>          * Also there could be M blobs there, and P pathspecs.
>

No. git-diff has too many modes, some does not need worktree. This
forces worktree on all modes.
-- 
Duy
