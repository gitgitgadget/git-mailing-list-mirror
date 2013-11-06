From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH] Add interpret-trailers builtin
Date: Wed, 6 Nov 2013 10:23:24 +0100
Message-ID: <CAP8UFD0STna++2StV1RcT2bB83Lh_hFQU94A0y4ziovs61Z==A@mail.gmail.com>
References: <20131103211731.15716.95056.chriscool@tuxfamily.org>
	<xmqqli14yoqi.fsf@gitster.dls.corp.google.com>
	<20131106.074355.225932577498673677.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Nov 06 10:23:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdzKm-00081u-NT
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 10:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066Ab3KFJX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 04:23:28 -0500
Received: from mail-ve0-f181.google.com ([209.85.128.181]:60122 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab3KFJXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 04:23:25 -0500
Received: by mail-ve0-f181.google.com with SMTP id jz11so3429337veb.12
        for <git@vger.kernel.org>; Wed, 06 Nov 2013 01:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wOiKKfq+drKIwkg4vuNEoE/Lf7OxU3KV+9+mvkhwLZ0=;
        b=wK+qp2MbzzDJoV8GjLOtIGfFfaLbPDDaZhe07bzOoNTwST+jtXiXurK2kK0AiPLr3d
         aiicfKnwPWM+msLKkHzXH5qK4HeX/q1g3bBpNUIeVtzybqSdP++ScvzrX+tOe2UwkLgL
         H287foqFRemYYaGwSVwrVmhqcpjM2ho3PsPe4PbW14pnusDH4JTZk50z6Npp7BMqTLL9
         EAyknFcl6N/xZHDnzGMvPQPQnRgLjUn95DjqwZ1ZQq6WuYcWh2VCM/xRYrNG/5QgEwRa
         tV5WouImRyO4iPGUHpnbgTeIiJXlchlJ6yu2OErN4ysNFcuvB+RW/zRVi3pu0bEXYSlF
         zE7w==
X-Received: by 10.58.181.230 with SMTP id dz6mr1540896vec.35.1383729804944;
 Wed, 06 Nov 2013 01:23:24 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Wed, 6 Nov 2013 01:23:24 -0800 (PST)
In-Reply-To: <20131106.074355.225932577498673677.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237349>

On Wed, Nov 6, 2013 at 7:43 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> Of course in the latter case, a command should probably be specified
> to tell which value should be used with the key.
>
> For example:
>
> [trailer "signoff"]
>          key = "Signed-off-by:"
>          if_missing = append
>          command = echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"'
>
> would append a s-o-b line only if there is no s-o-b already.

Sorry, I realize that I was wrong above.
As the default for "if_exist" is "dont_repeat", the above would append
a s-o-b if there is no s-o-b or if there is one but with a different
value.

To append a s-o-b only if there is no s-o-b already, one would need to use:

[trailer "signoff"]
         key = "Signed-off-by:"
         if_exist = dont_append
         if_missing = append
         command = echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"'

Thanks,
Christian.
