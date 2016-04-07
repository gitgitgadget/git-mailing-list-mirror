From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] format-patch: allow --no-patch to disable patch output
Date: Thu, 7 Apr 2016 17:30:58 -0400
Message-ID: <CAPig+cRNCwFmGW-Zo+osjceA6nb=6t3+rJ2uEbnyYxGfSWQ-Uw@mail.gmail.com>
References: <1460047599-9267-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 23:31:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoHW5-0001xz-Qw
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 23:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757553AbcDGVbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 17:31:00 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36894 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757461AbcDGVa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 17:30:59 -0400
Received: by mail-ig0-f170.google.com with SMTP id g8so82304003igr.0
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 14:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=kRFmlloI93ywu7LaoxddentaPiwg1ZjFiiKYzZewmqc=;
        b=ZAVuvr/i0DZD1OXPJ6Tq0RK+DDgMiIkBlWmziyT5Jo74Tuj+3COpJkYdGYoDg1jNsm
         +AQ4HU6P5odi+3y3LbS2X2FjLcYZIu3hieZj204LiZtinYFOHLN5QfG1bez0Rot5w7P+
         Ij9hTriGG9r+Plt2p+pV6zUzedx0+UgbmIBk5lE6RTk+LTDE2Gk2QhKplHC75nU/BEMo
         0etAVDTkfIfnwPkdqRUlZZ5wJk5UGVgpLwG9sdj68A6UOJasjWXl0Aw7le3+JPdv+vi0
         JS8TTxLM+nqLXBMhmKh+vHAFfaszWyU5uIgqQsEhOxvmBN0TRtKkCIgAYttBFubv744y
         nS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kRFmlloI93ywu7LaoxddentaPiwg1ZjFiiKYzZewmqc=;
        b=AjFJr7N7nJhDy5EERzeh8g7EQhcQC4Z1cQy3auQltkVzh+tqSrdvf2fgsHwUYz3Lrm
         sC9VXBGW+URDZh60gwTw2ukx23DqoO1OqTeXrbaECvzM2X5SjumgXMaHgaroPcw1sMd5
         bq4xoG52RukDhrrS99CA1djAgpbuPU40KvccV7YjHpzySN1Mm9/u2SqCqifKFAgZy5iq
         R9xUdpnhwsJmLgVQ92EbsjzS/CsGOCzyGaTDHPqwtjktFV5e7I6NXtfQjcZCLDjtbiLZ
         uwRju7VWaZyRiGlSYQYos15D+AN7t3Q9680Cs6MgBGv0/9fTW/238YzgPbnxQt2gHV1O
         Vc7w==
X-Gm-Message-State: AD7BkJI62sZXTW7D0p4Bd9JAcOhJV9TIhpb1NnVjBebc7nkOHs1AGgJrLcbcHM7l2WahGj6FGEF2irBM30aBgA==
X-Received: by 10.50.92.37 with SMTP id cj5mr32131462igb.91.1460064658719;
 Thu, 07 Apr 2016 14:30:58 -0700 (PDT)
Received: by 10.79.139.2 with HTTP; Thu, 7 Apr 2016 14:30:58 -0700 (PDT)
In-Reply-To: <1460047599-9267-1-git-send-email-jacob.e.keller@intel.com>
X-Google-Sender-Auth: EJXC3dk8--jV9--wdEQFS-X1w1g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290990>

On Thu, Apr 7, 2016 at 12:46 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> The documentation for format-patch indicates that --no-patch wilL
> suppress patch output. It also incorrectly mentions that -s will also
> suppress the patch output, but this is incorrect because -s is used to
> add the sign-off line first. Fix the documentation to remove the
> indication about -s. Fix builtin format-patch to prevent always adding
> the patch incase --no-patch is given. An alternative approach would be
> to remove --no-patch from the documentation for git-format-patch, and
> add an error check to indicate that --no-patch is not supported.

See [1] and [2].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/290023
[2]: b73a1bc (git-format-patch.txt: don't show -s as shorthand for
multiple options, 2016-03-27)

> Add a test for --no-patch to ensure it functions as expected.
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
