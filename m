From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/9] git-cat-file: Make option parsing a little more flexible
Date: Fri, 26 Oct 2007 13:56:10 -0700
Message-ID: <7vlk9py4r9.fsf@gitster.siamese.dyndns.org>
References: <1193307927-3592-1-git-send-email-aroben@apple.com>
	<1193307927-3592-2-git-send-email-aroben@apple.com>
	<1193307927-3592-3-git-send-email-aroben@apple.com>
	<1193307927-3592-4-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 22:56:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlWEJ-0007t5-0E
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 22:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060AbXJZU4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 16:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753607AbXJZU4Q
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 16:56:16 -0400
Received: from rune.pobox.com ([208.210.124.79]:52667 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788AbXJZU4P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 16:56:15 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 3FE641509FE;
	Fri, 26 Oct 2007 16:56:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A8F3A1509FC;
	Fri, 26 Oct 2007 16:56:33 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62440>

Adam Roben <aroben@apple.com> writes:

> This will make it easier to add newer options later.

A good change in principle.

> diff --git a/builtin-cat-file.c b/builtin-cat-file.c
> index 34a63d1..3a0be4a 100644
> --- a/builtin-cat-file.c
> +++ b/builtin-cat-file.c
> @@ -143,23 +143,41 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>  	return 0;
>  }
>  
> +static const char cat_file_usage[] = "git-cat-file [-t|-s|-e|-p|<type>] <sha1>";
> +
>  int cmd_cat_file(int argc, const char **argv, const char *prefix)
>  {
> -	int opt;
> -	const char *exp_type, *obj_name;
> +	int i, opt = 0;
> +	const char *exp_type = 0, *obj_name = 0;

NULL pointer constants in git sources are spelled "NULL", not
"0".
