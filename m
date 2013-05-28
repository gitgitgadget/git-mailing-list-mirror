From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND v2] path: Fix a sparse warning
Date: Tue, 28 May 2013 10:04:33 -0700
Message-ID: <7vhahn2fz2.fsf@alter.siamese.dyndns.org>
References: <51A3B308.6000201@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>, tboegi@web.de
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue May 28 19:04:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhNKD-0006lk-9w
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 19:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934869Ab3E1REh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 13:04:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64884 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934848Ab3E1REg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 13:04:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F37A023D57;
	Tue, 28 May 2013 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=fGYiBlZqUMUifaOBMlZhwN29OGI=; b=Ajyr8KB83wxB7D9Y3tHR
	QuJe7rWFg1zrZIDXvNgY9jtiplIYlORh86AUspcdfJCwIurRngq9029kksO0esXw
	xVQApVPK31ad2aElagDyYl37scStcuwFAzOIhMZQaNzejdmfEPBEScTO4E7KVvRr
	qtVTXH+QoVZz5r3bGDLBRzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=WjoghBs2hbFBvdML825EW+ZCEmsa4G7k+4WqsHEyVWFm20
	77zp/cxgNv2aUCYFDmnb5AVo2kyAFf+lmUPLI7Saz5vyK4NarOQvcXclvvo6gM7w
	ieco2V0MSrEp4hTErkt5pzAixKGHbWJ1/6YnrkCC6d4DMidM/g12jVtAZE9D8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA10623D55;
	Tue, 28 May 2013 17:04:35 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D23DC23D51;
	Tue, 28 May 2013 17:04:34 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC08CBF2-C7B8-11E2-AA62-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225664>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On MinGW, sparse issues an "'get_st_mode_bits' not declared. Should
> it be static?" warning. The MinGW and MSVC builds do not see the
> declaration of this function, within git-compat-util.h, due to its
> placement within an preprocessor conditional.
>
> In order to suppress the warning, we simply move the declaration to
> the top level of the header.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> Hi Junio,
>
> Now that v1.8.3 is out, I note that this patch seems to have been
> dropped (or did I miss something?).
>
> This used to be
>
>     [PATCH 2/6] path: Make the 'get_st_mode_bits' symbol a file static
>
> but the change in implementation required a change in title.
> This version simply moves the declaration so that the MinGW and
> MSVC builds can see it.

Will queue.

Can you tell me what the conclusion on the discussion on your two
other patches on 'pu'?

* rj/mingw-cygwin (2013-05-08) 2 commits
 - cygwin: Remove the CYGWIN_V15_WIN32API build variable
 - mingw: rename WIN32 cpp macro to GIT_WINDOWS_NATIVE

I stopped keeping track of the discussion and my vague recollection
was that it is OK for 1.5 but not verified on 1.7 or something?

>
> ATB,
> Ramsay Jones
>
>  git-compat-util.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index e955bb5..0e5e4f8 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -163,7 +163,6 @@
>  typedef long intptr_t;
>  typedef unsigned long uintptr_t;
>  #endif
> -int get_st_mode_bits(const char *path, int *mode);
>  #if defined(__CYGWIN__)
>  #undef _XOPEN_SOURCE
>  #include <grp.h>
> @@ -176,6 +175,8 @@ int get_st_mode_bits(const char *path, int *mode);
>  #endif
>  #endif
>  
> +extern int get_st_mode_bits(const char *path, int *mode);
> +
>  /* used on Mac OS X */
>  #ifdef PRECOMPOSE_UNICODE
>  #include "compat/precompose_utf8.h"
