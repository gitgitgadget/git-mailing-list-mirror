From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/6] Fix checkout-dash to work with rebase
Date: Tue, 18 Jun 2013 15:20:36 +0530
Message-ID: <CALkWK0nO6fVh2jg9WC_4zN1rKtXRQCsMbfOgmw-g3pvrwBfTZw@mail.gmail.com>
References: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
 <7v1u81ibjp.fsf@alter.siamese.dyndns.org> <7vk3lsei4i.fsf@alter.siamese.dyndns.org>
 <CALkWK0nGeyna_vxnN0RMULRj3sEj3v=Q61cXrHDYDHYv-nZ4sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 11:51:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UosZN-00017X-U6
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 11:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627Ab3FRJvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 05:51:18 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:63275 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab3FRJvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 05:51:17 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so9679284ied.28
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aWqnf3E6Ci+LOlec3ab90+8B+XhebmiSqU5zBrw44u8=;
        b=RvVs++E7czBmZa8w4SliqviI0ND+/S3GzRZJhHn/PEHKpLsPuSjO9aiesByJDlv9UB
         Kg/6JT2UVcnvMIYC+4CH9Txp/wdGn6NXeKkq1EcqDO+QzIL2I7H37szfXTQSiUqt5sGZ
         9dtBmtSGGEobMjhplWQOUajuydHiC44MKZmmPSrQcOnDLYz95rXHl9AcVTvMCg6Ar43q
         2QyoQ8cq6mukE5VEasdBRPn7RLRJVxdWACiX9lCWrHwNOpcUc7RYPJbePSonI+VSIpzx
         8XOfcImyhX5WR3KSDi9h6bxfsuiLtNcFNfJ5V3a5is7LqARHc0fsow9gWuVgaeEHfJ5o
         HllA==
X-Received: by 10.42.73.138 with SMTP id s10mr924358icj.10.1371549077036; Tue,
 18 Jun 2013 02:51:17 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 02:50:36 -0700 (PDT)
In-Reply-To: <CALkWK0nGeyna_vxnN0RMULRj3sEj3v=Q61cXrHDYDHYv-nZ4sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228181>

Ramkumar Ramachandra wrote:
> Thanks for the reorder and commit message tweaks.  I'm working on the
> series you put up on `pu` now.

That said, I do not agree with one of your commit message updates:

    checkout: respect GIT_REFLOG_ACTION

    GIT_REFLOG_ACTION is an environment variable specifying the reflog
    message to write after an action is completed.  Several other commands
    including merge, reset, and commit respect it.

    Fix the failing tests in t/checkout-last by making checkout respect it
    too.  You can now expect

      $ git checkout -

    to work as expected after any operation that internally uses "checkout"
    as its implementation detail, e.g. "rebase".

After the patch you _cannot_ expect checkout-dash to work after any
operation that internally uses checkout; it's limited to rebase.  Many
other scripts (eg. bisect) do _not_ set GIT_REFLOG_ACTION at all.
