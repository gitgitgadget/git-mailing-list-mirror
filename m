From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 1/2] tests: move code to run completion tests under
 bash into a helper library
Date: Tue, 17 Apr 2012 09:20:24 +0200
Message-ID: <4F8D19B8.1040004@viscovery.net>
References: <20120416160124.GL5813@burratino> <1334614176-2963-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Apr 17 09:20:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK2iM-00027p-KX
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 09:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab2DQHUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 03:20:34 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:63075 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab2DQHUd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 03:20:33 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SK2iR-0003wi-C9; Tue, 17 Apr 2012 09:20:50 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 546FE1660F;
	Tue, 17 Apr 2012 09:20:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <1334614176-2963-1-git-send-email-szeder@ira.uka.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195736>

Am 4/17/2012 0:09, schrieb SZEDER G=C3=A1bor:
> diff --git a/t/lib-completion.sh b/t/lib-completion.sh
> new file mode 100644
> index 00000000..3d85feb2
> --- /dev/null
> +++ b/t/lib-completion.sh
> @@ -0,0 +1,17 @@
> +#!/bin/sh
> +#
> +# Ensures that tests of the completion script are run under Bash.
> +
> +if test -n "$BASH" && test -z "$POSIXLY_CORRECT"; then
> +	# we are in full-on bash mode
> +	true
> +elif type bash >/dev/null 2>&1; then
> +	# execute in full-on bash mode
> +	unset POSIXLY_CORRECT
> +	exec bash "$0" "$@"
> +else
> +	echo '1..0 #SKIP skipping bash completion tests; bash not available=
'
> +	exit 0
> +fi

I wonder what this 'echo...;exit' is about (I do so since I saw it the
first time when Felipe submitted his patch). Shouldn't it be more like:

	skip_all=3D'skipping bash completion tests; bash not available'
	test_done

-- Hannes
