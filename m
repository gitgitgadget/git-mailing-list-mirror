From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] refs: loosen restriction on wildcard "*" refspecs
Date: Thu, 23 Jul 2015 18:00:55 -0400
Message-ID: <CAPig+cRS0NcNcw-0wG4mThN_PW0RoN3b09Yu2GzCr=UFPLYd6A@mail.gmail.com>
References: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
	<1437599133-13012-3-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 00:01:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIOY0-0007em-Rb
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 00:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbbGWWA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 18:00:56 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:36282 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbbGWWA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 18:00:56 -0400
Received: by ykay190 with SMTP id y190so5135134yka.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TLN0rnCCPfO+LL5yAs7RHpWNGTac91jmcs2j6ejB9NY=;
        b=Ra6vtepyZUVa7pMRGV8kN34YJJ1z+09okkw9hW7A/UgOIsEBnWdhhSjiwkSdTRJBhb
         y7AkIulPyYS3bzKIlsKzPVMrhY5OmgOgCyVtwh9XwGtnreTGuLqIFLERWVwNq457xU/j
         VTOYDUD34E3wcEv/qvoYHNu1ZXVlGE5s+yRyADUxq583iHRXlDMvNWnywPOwNL0YSLvN
         7MicVsK2j0SCYrnk1LNyHvhE198IZOXvUyYjxRlK+oqweF3be1p9R3VpF6JnxaVimBAV
         i4lo5EvvIjWfv7zr8zZXThLsj8HGuRG7gx0885a2QcZLJBocstnpzBjYH2Pq2NbNPhfk
         WA5w==
X-Received: by 10.129.76.140 with SMTP id z134mr11672759ywa.17.1437688855540;
 Thu, 23 Jul 2015 15:00:55 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 23 Jul 2015 15:00:55 -0700 (PDT)
In-Reply-To: <1437599133-13012-3-git-send-email-jacob.e.keller@intel.com>
X-Google-Sender-Auth: 104_wy4kAE5DfVxVMdnA3uXhu9I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274527>

On Wed, Jul 22, 2015 at 5:05 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Modify logic of check_refname_component and add a new disposition
> regarding "*". Allow refspecs that contain a single "*" if
> REFNAME_REFSPEC_PATTERN is set. Change the function to pass the flags as
> a pointer, and clear REFNAME_REFSPEC_PATTERN after the first "*" so that
> only a single "*" is accepted.
>
> This loosens restrictions on refspecs by allowing patterns that have
> a "*" within a component instead of only as the whole component. Also
> remove the code that hangled refspec patterns in check_refname_format

s/hangled/handled/

> since it is now handled via the check_refname_component logic.
>
> Now refs such as `for/bar*:foo/bar*` and even `foo/bar*:foo/baz*` will
> be accepted. This allows users more control over what is fetched where.
> Since users must modify the default by hand to make use of this
> functionality it is not considered a large risk. Any refspec which
> functioned before shall continue functioning with the new logic.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
