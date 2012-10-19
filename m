From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Unexpected directories from read-tree
Date: Fri, 19 Oct 2012 10:34:27 +0700
Message-ID: <CACsJy8BeMPwRtU9LQ9aS=0NY7vo_hXQs5Vxo9krXb+epqf=Fdw@mail.gmail.com>
References: <CAMJd5AQhcvWVwsZHPknAXvNpqnfqdCtx-xUv39Au1=x-1_ExMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Uri Moszkowicz <uri@4refs.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:35:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TP3Me-0000US-Sj
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 05:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368Ab2JSDe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 23:34:59 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:34467 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab2JSDe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 23:34:58 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so32146oag.19
        for <git@vger.kernel.org>; Thu, 18 Oct 2012 20:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0gis8RF2S8TCUR7Pc7/Yq/bYjpVbowvg74l+NvrUj84=;
        b=u1cJEKKU6pe4S3CKR+B/gF2tBOEaKp+4ETbtm4ZS8WRmUaq1P9iEv+vo3rWQjNJEYU
         Lw89nqkuuMSxKt7LFHP+iNO5jdQSfwAQe8+pHiJ4s1Dk4jGCgX0tbfvE2yhTfykA8ubQ
         8IHgAmQ47UgPCXezchBdU34W1QEPpmS2B4SmJiae8uJovmSSKc1Z++/8bZ5eQeQdaP9S
         QqMDycW4KM0w9NCBO/RbotiwoctpJRfJdQDu/onhDtZdzh2ClI+/Pa/alt6UwY14TqgA
         /bonZ367hn/C7WFWKXBPQMrkcto8OkPWJu9nVPFnrgBVuWCYVnlfsXmsT4jF8eQGBnh4
         JoJg==
Received: by 10.60.22.136 with SMTP id d8mr20768129oef.124.1350617697586; Thu,
 18 Oct 2012 20:34:57 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Thu, 18 Oct 2012 20:34:27 -0700 (PDT)
In-Reply-To: <CAMJd5AQhcvWVwsZHPknAXvNpqnfqdCtx-xUv39Au1=x-1_ExMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208037>

On Fri, Oct 19, 2012 at 6:10 AM, Uri Moszkowicz <uri@4refs.com> wrote:
> I'm testing out the sparse checkout feature of Git on my large (14GB)
> repository and am running into a problem. When I add "dir1/" to
> sparse-checkout and then run "git read-tree -mu HEAD" I see dir1 as
> expected. But when I add "dir2/" to sparse-checkout and read-tree
> again I see dir2 and dir3 appear and they're not nested. If I replace
> "dir2/" with "dir3/" in the sparse-checkout file, then I see dir1 and
> dir3 but not dir2 as expected again. How can I debug this problem?

Posting here is step 1. What version are you using? You can look at
unpack-trees.c The function that does the check is excluded_from_list.
You should check "ls-files -t", see if CE_SKIP_WORKTREE is set
correctly for all dir1/*, dir2/* and dir3/*. Can you recreate a
minimal test case for the problem?
-- 
Duy
