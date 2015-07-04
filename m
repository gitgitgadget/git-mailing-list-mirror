From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 18/23] checkout: retire --to option
Date: Sat, 4 Jul 2015 10:04:50 +0700
Message-ID: <CACsJy8Cog302k+-tFVJqneh3ShWYL57qhHQk8cFqvYX9Qc9q8Q@mail.gmail.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com> <1435969052-540-19-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 05:06:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBDmL-0000mr-0E
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 05:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326AbbGDDFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 23:05:51 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34274 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462AbbGDDFT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 23:05:19 -0400
Received: by iebmu5 with SMTP id mu5so85312543ieb.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 20:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=z7dP9QIMc3oJzJgsgCAi8izg44gP8kxpmRl/QhSVei4=;
        b=N+XHUiI9CoiGR5curkceseLe5DdmQMSaT+KtGnhpNqmAmq/kpLpj+1enhzFt7QO/uR
         JCrN0du7gtwPA7uiPsebgG3SBrMVLPpXHRRF6lgfi32F2eCXcOw4b/VeYnWkj21RKK7q
         wZTEUr949see08jhO3rxISAwzUusu4d2QPAl8c2juDOyTAPDK4R5yUv6IxlPWarbV22c
         FKjYYv9BGhlw8m78MhkL20Pe/+YlfKB7KGMV+Tf6ZtvpQr3PsR1Dv/sXcJtlNemogVQh
         CN4aJJQf/uIjcXESR5JupwcsuPsm7pOqLdCgsrU3k8dArQR6qO5IYsAI8SJHjTMljeLQ
         yRHA==
X-Received: by 10.43.172.68 with SMTP id nx4mr20611857icc.48.1435979119336;
 Fri, 03 Jul 2015 20:05:19 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Fri, 3 Jul 2015 20:04:50 -0700 (PDT)
In-Reply-To: <1435969052-540-19-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273349>

On Sat, Jul 4, 2015 at 7:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Now that "git worktree add" has achieved user-facing feature-parity with
> "git checkout --to", retire the latter.
>
> Move the actual linked worktree creation functionality,
> prepare_linked_checkout() and its helpers, verbatim from checkout.c to
> worktree.c.
>
> This effectively reverts changes to checkout.c by 529fef2 (checkout:
> support checking out into a new working directory, 2014-11-30) with the
> exception of merge_working_tree() and switch_branches() which still
> require specialized knowledge that a the checkout is occurring in a
> newly-created linked worktree (signaled to them by the private
> GIT_CHECKOUT_NEW_WORKTREE environment variable).
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  builtin/checkout.c | 156 +----------------------------------------------------
>  builtin/worktree.c | 138 ++++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 133 insertions(+), 161 deletions(-)

If I didn't lose track of changes, "--to" is still described in
git-checkout.txt?
-- 
Duy
