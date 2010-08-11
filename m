From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] WIP: Report intra-test progress with TAP subtests
Date: Wed, 11 Aug 2010 08:44:39 +0200
Message-ID: <4C6246D7.6090704@viscovery.net>
References: <1281473829-2102-1-git-send-email-avarab@gmail.com> <20100811004425.GI2099@burratino> <AANLkTi=ygXFpRLR_Z7iEXX3THh+GT7P7X9o+NnaLajqs@mail.gmail.com> <20100811010412.GA2994@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 08:45:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj53Y-0004zR-S6
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 08:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107Ab0HKGon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 02:44:43 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:3113 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab0HKGom (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 02:44:42 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Oj53H-0006b5-Us; Wed, 11 Aug 2010 08:44:40 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A539F1660F;
	Wed, 11 Aug 2010 08:44:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <20100811010412.GA2994@burratino>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153190>

Am 8/11/2010 3:04, schrieb Jonathan Nieder:
> I meant something like this:
> -- 8< --
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index e5523dd..a4bc358 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -368,9 +368,11 @@ test_debug () {
>  
>  test_run_ () {
>  	test_cleanup=:
> +	set -x
>  	eval >&3 2>&4 "$1"
>  	eval_ret=$?
>  	eval >&3 2>&4 "$test_cleanup"
> +	set +x
>  	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"; then
>  		echo ""
>  	fi
> -- >8 --

Heh. I use something like this in my private build. It breaks a number of
tests due to additional output from test_must_fail invocations. I work
around it by adding 'set +x' inside the test case code. See

http://repo.or.cz/w/git/mingw/j6t.git/commitdiff/3943fd12f69da58937ac67a20be440f0ed532f18

-- Hannes
