From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v6 4/6] t0060: Add tests for prefix_path when path begins
 with work tree
Date: Tue, 04 Feb 2014 21:00:33 +0100
Message-ID: <52F146E1.4000604@web.de>
References: <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com> <1391523920-26946-1-git-send-email-martinerikwerner@gmail.com> <1391523920-26946-5-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: richih@debian.org, tboegi@web.de, gitster@pobox.com,
	pclouds@gmail.com, dak@gnu.org
To: Martin Erik Werner <martinerikwerner@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 21:01:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAmB1-00039N-Mp
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 21:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbaBDUAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 15:00:50 -0500
Received: from mout.web.de ([212.227.15.3]:62114 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755054AbaBDUAr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 15:00:47 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LnSOM-1VbBVW3V9C-00hiLE for <git@vger.kernel.org>;
 Tue, 04 Feb 2014 21:00:44 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1391523920-26946-5-git-send-email-martinerikwerner@gmail.com>
X-Provags-ID: V03:K0:0tvNPDSOu6i8uAwGBowS2anykQLI3BdC4a0WvBcZgbe679xQWvI
 ebTLsVm6uMsqGkxLTahAVdLPhrMP+EM/upRs4DQCXUdlf9q7LIET5b21BSTWXR2aRAPMCNv
 WTXG7MD7lo8FE9nZM3UAUjs/7umg9h1XsIY9falFH+MVWvpncscDhmToVym7eEmKK8OMzPl
 6yaghx2PbCcCA1uhnoEgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241543>

On 2014-02-04 15.25, Martin Erik Werner wrote:

>  t/t0060-path-utils.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
> index b8e92e1..c0a14f6 100755
> --- a/t/t0060-path-utils.sh
> +++ b/t/t0060-path-utils.sh
> @@ -201,6 +201,16 @@ test_expect_success 'prefix_path works with only absolute path to work tree' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'prefix_path rejects absolute path to dir with same beginning as work tree' '
> +	test_must_fail test-path-utils prefix_path prefix "$(pwd)a"
> +'
> +
> +test_expect_success 'prefix_path works with absolute path to a symlink to work tree having  same beginning as work tree' '
> +	git init repo &&
> +	ln -s repo repolink &&
> +	test "a" = "$(cd repo && test-path-utils prefix_path prefix "$(pwd)/../repolink/a")"
> +'
I think we need SYMLINKS here.
