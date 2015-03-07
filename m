From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Sat, 7 Mar 2015 07:00:14 +0700
Message-ID: <CACsJy8B5jdKt0h8pTn8hVrbEw3o-gRLmoP+MBMMpm-reKtBOvQ@mail.gmail.com>
References: <20150302092136.GA30278@lanh> <1425685087-21633-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 01:00:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU2Ak-0005pr-AF
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 01:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628AbbCGAAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 19:00:46 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36082 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbbCGAAp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 19:00:45 -0500
Received: by ierx19 with SMTP id x19so89888381ier.3
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 16:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OHiDgXzAvvo56RJh1i6sbx/WnPHVHi3ggS1o7hk4BsY=;
        b=SUzyGqsL+CiK6VG3v07IeZY79kqM9Kdp5d1udWSd5KGqMOa82KN3j0Ys8++00YX8aF
         CgIccZGDzFs7o/rSrZR3ZdqlrXrAxJoBecczhvpkUO7lwyA1o6X56uFC2y4ACpgp4mQR
         MPR+wbSYXDR4gvsGclIHgiPU76ac5mdRwotl0iCVpowQ1gLsNJAzYz5k7+oqrot70ufQ
         jk5CypbO78VXvA+0OT8PkUiQqQs6DVIsLv0ghEH3XlmIQBej1cDow7urUFtK6WLM8J83
         sE3iUOCOdkpvFGcKVZaz9cGnYSVWaz2L+O1e1ilelZpJ4brdJKkZmIoEqj8BOS8hIDoh
         Ousw==
X-Received: by 10.43.13.200 with SMTP id pn8mr13686763icb.0.1425686444718;
 Fri, 06 Mar 2015 16:00:44 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Fri, 6 Mar 2015 16:00:14 -0800 (PST)
In-Reply-To: <1425685087-21633-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264978>

On Sat, Mar 7, 2015 at 6:38 AM, Stefan Beller <sbeller@google.com> wrote:
> +Reference Discovery (v2)
> +------------------------
> +
> +In version 2, reference discovery is initiated by the client with
> +"want-refs" line. The client may skip reference discovery phase
> +entirely by not sending "want-refs" (e.g. the client has another way
> +to retrieve ref list).
> +
> +----
> +  want-refs  =  PKT-LINE("want-refs" SP mode *argument)
> +  mode       =  "all"
> +  argument   =  SP arg
> +  arg        =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")
> +----

On the same line with capabilities, we would not want to run into a
situation where we have too many arguments to send and exceed pkt-line
limit. So perhaps do one argument per pkt-line too, ending with a
pkt-flush.
-- 
Duy
