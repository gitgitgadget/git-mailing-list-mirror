From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] mv: Fix spurious warning when moving a file in presence
 of submodules
Date: Thu, 17 Oct 2013 11:24:05 -0700
Message-ID: <20131017182405.GR9464@google.com>
References: <vpq38o7nao9.fsf@anie.imag.fr>
 <52583B00.8040700@web.de>
 <525A8965.3040407@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 17 20:24:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWsF5-0004R5-ER
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 20:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758653Ab3JQSYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 14:24:11 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:45094 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758204Ab3JQSYK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 14:24:10 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so3198515pde.37
        for <git@vger.kernel.org>; Thu, 17 Oct 2013 11:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lH43AmBXZYPfGscEpxMjWhZr4nHZnYRDkPijFYZGL2g=;
        b=ofq87thjigQh0+aUKGjm3k4MS1URVVPPmcbMa/teHovi+27UkvhIym3+A65szwuso3
         QMvCA8A8mDKgZzeLHe5gAmaxgB/oQUWJvXKzkt21wrutV3gDdBhEnm4JAahC9T1IeyPr
         buOF+FkrzDyJJRh/N3jXePlKqVuVcSLsAHsP0nhWVTG5v8ni+w2xAwGtKhuMzM0AbdKM
         KdPdcrX5fyWeCXeeNjd3OsNRh66Es3Rs9kboq96cY/ffcw1nuba4RbYkPLSMmWXrTyOr
         0yg5eCbkuLDnnMMry1ytueHFhk9kDthl0Ac+0tGba6qw5k2HM+dqV/8l26GNMZA88W95
         fxTg==
X-Received: by 10.68.196.138 with SMTP id im10mr9588996pbc.127.1382034249905;
        Thu, 17 Oct 2013 11:24:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ry4sm116246472pab.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 11:24:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <525A8965.3040407@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236305>

Jens Lehmann wrote:

> In commit 0656781fa "git mv" learned to update the submodule path in the
> .gitmodules file when moving a submodule in the work tree. But since that
> commit update_path_in_gitmodules() gets called no matter if we moved a
> submodule or a regular file, which is wrong and leads to a bogus warning
> when moving a regular file in a repo containing a .gitmodules file:
>
>     warning: Could not find section in .gitmodules where path=<filename>
[...]
> Reported-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
[...]
> And this is the fix for it, which I believe is stuff for maint.

Thanks again, and sorry to leave this hanging.  I had some vague ideas
for improvement:

 * style nits: test is a little long, making it hard to take in at a
   glance; tests tend to try to avoid pipelines to avoid losing the
   exit code from git commands; usual style is to use "test" instead
   of "[" consistently

 * would be nice to have another test that makes sure the "move a
   file, not submodule" case keeps working

But those can easily happen as changes on top, and as you mentioned,
it's probably worth someone interested (e.g., me :)) making a pass to
clean up the style of the rest of the script anyway.

The patch as-is is obviously good.  Thanks again for the quick
diagnosis and fix.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
