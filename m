From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] general style: replaces memcmp() with proper starts_with()
Date: Thu, 13 Mar 2014 07:27:22 +0100
Message-ID: <877g7yipf9.fsf@fencepost.gnu.org>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
	<20140312175624.GA7982@sigill.intra.peff.net>
	<xmqqha73jb6q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Quint Guvernator <quintus.public@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 07:28:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNz7m-0006Df-EQ
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 07:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbaCMG2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 02:28:08 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:50248 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaCMG2H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 02:28:07 -0400
Received: from localhost ([127.0.0.1]:49288 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WNz7d-0006tu-LN; Thu, 13 Mar 2014 02:28:05 -0400
Received: by lola (Postfix, from userid 1000)
	id 06A51DF3D0; Thu, 13 Mar 2014 07:27:22 +0100 (CET)
In-Reply-To: <xmqqha73jb6q.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 12 Mar 2014 15:37:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244022>

Junio C Hamano <gitster@pobox.com> writes:

> Taking two random examples from an early and a late parts of the
> patch:
>
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -82,7 +82,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  				enum object_type type;
>  				unsigned long size;
>  				char *buffer = read_sha1_file(sha1, &type, &size);
> -				if (memcmp(buffer, "object ", 7) ||
> +				if (!starts_with(buffer, "object ") ||

[...]

> The original hunks show that the code knows and relies on magic
> numbers 7 and 8 very clearly and there are rooms for improvement.

Like: what if the file is empty?

-- 
David Kastrup
