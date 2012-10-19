From: Uri Moszkowicz <uri@4refs.com>
Subject: Re: Unexpected directories from read-tree
Date: Fri, 19 Oct 2012 11:10:12 -0500
Message-ID: <CAMJd5ATF7LzhnpEpcoHcimsmgbYUVrXHwUnrURSJiBtQA8a68A@mail.gmail.com>
References: <CAMJd5AQhcvWVwsZHPknAXvNpqnfqdCtx-xUv39Au1=x-1_ExMg@mail.gmail.com>
 <CACsJy8BeMPwRtU9LQ9aS=0NY7vo_hXQs5Vxo9krXb+epqf=Fdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 18:10:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPF9q-0004D8-C1
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 18:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290Ab2JSQKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 12:10:34 -0400
Received: from mx71.nozonenet.com ([204.14.89.24]:59834 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751332Ab2JSQKd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 12:10:33 -0400
Received: (qmail 17414 invoked by uid 399); 19 Oct 2012 12:10:33 -0400
Received: from mail-vc0-f174.google.com (smtp@4refs.com@209.85.220.174)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 19 Oct 2012 12:10:33 -0400
X-Originating-IP: 209.85.220.174
X-Sender: smtp@4refs.com
Received: by mail-vc0-f174.google.com with SMTP id fk26so641990vcb.19
        for <git@vger.kernel.org>; Fri, 19 Oct 2012 09:10:32 -0700 (PDT)
Received: by 10.52.37.103 with SMTP id x7mr1786526vdj.61.1350663032599; Fri,
 19 Oct 2012 09:10:32 -0700 (PDT)
Received: by 10.58.226.164 with HTTP; Fri, 19 Oct 2012 09:10:12 -0700 (PDT)
In-Reply-To: <CACsJy8BeMPwRtU9LQ9aS=0NY7vo_hXQs5Vxo9krXb+epqf=Fdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208050>

I am using 1.8.0-rc2 but also tried 1.7.8.4. Thanks for the suggestion
to use "ls-files -t" - that's exactly what I was looking for. With
that I was easily able to tell what the problem is: missing "/" from
the sparse-checkout file.

On Thu, Oct 18, 2012 at 10:34 PM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> On Fri, Oct 19, 2012 at 6:10 AM, Uri Moszkowicz <uri@4refs.com> wrote:
>> I'm testing out the sparse checkout feature of Git on my large (14GB)
>> repository and am running into a problem. When I add "dir1/" to
>> sparse-checkout and then run "git read-tree -mu HEAD" I see dir1 as
>> expected. But when I add "dir2/" to sparse-checkout and read-tree
>> again I see dir2 and dir3 appear and they're not nested. If I replace
>> "dir2/" with "dir3/" in the sparse-checkout file, then I see dir1 and
>> dir3 but not dir2 as expected again. How can I debug this problem?
>
> Posting here is step 1. What version are you using? You can look at
> unpack-trees.c The function that does the check is excluded_from_list.
> You should check "ls-files -t", see if CE_SKIP_WORKTREE is set
> correctly for all dir1/*, dir2/* and dir3/*. Can you recreate a
> minimal test case for the problem?
> --
> Duy
