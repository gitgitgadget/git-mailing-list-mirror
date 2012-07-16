From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] symbolic-ref: check format of given refname
Date: Mon, 16 Jul 2012 15:24:05 +0200
Message-ID: <500415F5.3060600@alum.mit.edu>
References: <1342440781-18816-1-git-send-email-mschub@elegosoft.com> <1342440781-18816-3-git-send-email-mschub@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 15:31:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqlOQ-0003JZ-Hl
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 15:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab2GPNbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 09:31:11 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:45825 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752540Ab2GPNbK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2012 09:31:10 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2012 09:31:09 EDT
X-AuditID: 12074413-b7f2f6d0000008bb-02-500415f76513
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 84.28.02235.7F514005; Mon, 16 Jul 2012 09:24:07 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q6GDO6Cu022599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 16 Jul 2012 09:24:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <1342440781-18816-3-git-send-email-mschub@elegosoft.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1P0uyhJg8OyLnEXXlW4mi6edlQ5M
	Hof+TGH3+LxJLoApitsmKbGkLDgzPU/fLoE7Y91UmYIV3BXXV61lbmB8z9HFyMkhIWAisW7S
	F1YIW0ziwr31bCC2kMBlRommg/FdjFxA9nEmibXTjjCDJHgFtCVOvrvHAmKzCKhKdKydDdbM
	JqArsainmamLkYNDVCBMYvpOdohyQYmTM5+AlYsAtU5cDTKfg4NZQFyi/x8LiCks4CJxqksC
	YmutxJIFZ8A6OQVcJbrW7YKqtpb4trsIJMwsIC+x/e0c5gmMArOQzJ+FUDULSdUCRuZVjHKJ
	OaW5urmJmTnFqcm6xcmJeXmpRbrmermZJXqpKaWbGCGhKbyDcddJuUOMAhyMSjy8J32ZA4RY
	E8uKK3MPMUpyMCmJ8ubxsgQI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHt7AQq501JrKxKLcqH
	SUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8PIDY1BIsCg1PbUiLTOnBCHNxMEJMpxL
	SqQ4NS8ltSixtCQjHhSd8cXA+ARJ8QDtfSUC1M5bXJCYCxSFaD3FqMvx5MutW4xCLHn5ealS
	4rycIDsEQIoySvPgVsAS0StGcaCPhXlFQap4gEkMbtIroCVMQEssS5hAlpQkIqSkGhgb78/x
	FTK972DYucelwvZDzB4px+2twb/519jvSdjaHi/X5h/dlrEowV3pzvsp84MeqN663cl49dn1
	Le/XyHPM2HOXQ5DhYsz38LlfOSYbHDub9VUoW3hzimAm9xqfW03PuHpN0u54zdHZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201518>

On 07/16/2012 02:13 PM, Michael Schubert wrote:
> Currently, it's possible to update HEAD with a nonsense reference since
> no strict validation ist performed. Example:
>
> 	$ git symbolic-ref HEAD 'refs/heads/master
>      >
>      >
>      > '
>
> Fix this by checking the given reference with check_refname_format().
>
> Signed-off-by: Michael Schubert <mschub@elegosoft.com>
> ---
>   builtin/symbolic-ref.c  |  4 +++-
>   t/t1401-symbolic-ref.sh | 10 ++++++++++
>   2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
> index 801d62e..a529541 100644
> --- a/builtin/symbolic-ref.c
> +++ b/builtin/symbolic-ref.c
> @@ -44,13 +44,15 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
>   	git_config(git_default_config, NULL);
>   	argc = parse_options(argc, argv, prefix, options,
>   			     git_symbolic_ref_usage, 0);
> -	if (msg &&!*msg)
> +	if (msg && !*msg)
>   		die("Refusing to perform update with empty message");
>   	switch (argc) {
>   	case 1:
>   		check_symref(argv[0], quiet);
>   		break;
>   	case 2:
> +		if (check_refname_format(argv[1], 0))
> +			die("No valid reference format: '%s'", argv[1]);

The error message is awkward.  I suggest something like

     "Reference name has invalid format: '%s'"

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
