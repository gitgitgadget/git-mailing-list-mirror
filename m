From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 01/16] Modify cache_header to prepare for other index formats
Date: Thu, 2 Aug 2012 19:15:08 +0700
Message-ID: <CACsJy8C4D=nmcLmX_mahrx9TMCjzzqWdEsGU9W=gmhJVAqdk4A@mail.gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com> <1343905326-23790-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 14:15:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwuJc-00076g-Hq
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 14:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171Ab2HBMPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 08:15:40 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63174 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab2HBMPj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 08:15:39 -0400
Received: by yenl2 with SMTP id l2so8605136yen.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 05:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=653OT0rdUmO9yIbloHaH3s4JJpopfyFDAohGuH0Xyjk=;
        b=TSoHmk3nrFZwaTv/ZXn14HVRlMeJ2UBSExsqobDqwfn8VTyHrG0/bKp1PbpGrWwtS2
         4GtJzgC3goOpbpBUNczW8YRZ45Kiqf9pW3hM6zQ/FzbzTugqb0eqcbKiFQrlvkAnzBIh
         xcaxt9cQe66yju509uDLl7Z64Q+sBBQ2f90sjtnFRO7wspE0aBK94ud66HSeIPwSlCGh
         FpMk71isQiu/tK0iGwvugVRValIxnpCwSWf/Ynu+tpnK0NbwNMxkFLdFappe/DKoBxL1
         jAr/QIC1iSgqZ/ObREIxi1hq8/bJK2AKqoqgNjg5YrJCLUi+dMD2pK5eIw9nN1SqTObs
         LVZw==
Received: by 10.50.100.129 with SMTP id ey1mr3221000igb.35.1343909738655; Thu,
 02 Aug 2012 05:15:38 -0700 (PDT)
Received: by 10.64.90.2 with HTTP; Thu, 2 Aug 2012 05:15:08 -0700 (PDT)
In-Reply-To: <1343905326-23790-2-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202770>

On Thu, Aug 2, 2012 at 6:01 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> diff --git a/cache.h b/cache.h
> index 6e9a243..d4028ef 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -99,9 +99,12 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
>   */
>
>  #define CACHE_SIGNATURE 0x44495243     /* "DIRC" */
> -struct cache_header {
> +struct cache_version_header {
>         unsigned int hdr_signature;
>         unsigned int hdr_version;
> +};
> +
> +struct cache_header_v2 {
>         unsigned int hdr_entries;
>  };
>

These structs should probably be moved to read-cache.c. We can
redeclare cache_version_header again in test-index-version.c (it does
not look too bad to me).
-- 
Duy
