From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH V2 4/5] git-grep: Learn PCRE
Date: Thu, 05 May 2011 08:19:58 +0200
Message-ID: <4DC2418E.4070006@viscovery.net>
References: <1304546421-25439-1-git-send-email-michal.kiedrowicz@gmail.com> <1304546421-25439-5-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>
To: =?UTF-8?B?TWljaGHFgiBLaWVkcm93aWN6?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 08:20:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHruy-0001GW-7e
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 08:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613Ab1EEGUA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 02:20:00 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50491 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1EEGUA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 02:20:00 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QHrup-00018u-5N; Thu, 05 May 2011 08:19:59 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DDB2C1660F;
	Thu,  5 May 2011 08:19:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <1304546421-25439-5-git-send-email-michal.kiedrowicz@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172803>

Am 5/5/2011 0:00, schrieb Micha=C5=82 Kiedrowicz:
> +# Define NO_LIBPCRE if you do not have libpcre installed.  git-grep =
cannot use
> +# Perl-compatible regexes.

=46or what purpose are you adding Perl-regex when git-grep cannot use t=
hem?

=2E..

Oh! You mean to say "..., but git-grep cannot use Perl-compatible regex=
es
_in this case_".

;)

This repeats in patch 5/5.

> +#ifdef NO_LIBPCRE
> +static void compile_pcre_regexp(struct grep_pat *p, struct grep_opt =
*opt)
> +{
> +	die("cannot use Perl-compatible regexes when libpcre is not compile=
d in");

This is such a terminus technicus. Wouldn't it be much easier to read f=
or
Joe User if this were merely:

	die("Perl-compatible regexes not supported");

Also, wouldn't it be nicer to die already when the --perl-regexp option=
 is
detected? Then you could make these functions dummies that behave as if
nothing was matched.

> +}
> +
> +static int pcrematch(struct grep_pat *p, char *line, char *eol,
> +		regmatch_t *match, int eflags)
> +{
> +	die("cannot use Perl-compatible regexes when libpcre is not compile=
d in");
> +}
> +
> +static void free_pcre_regexp(struct grep_pat *p)
> +{
> +	die("cannot use Perl-compatible regexes when libpcre is not compile=
d in");
> +}

-- Hannes
