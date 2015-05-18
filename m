From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 8/8] t5520: check reflog action in fast-forward merge
Date: Mon, 18 May 2015 17:20:32 +0200
Organization: gmx
Message-ID: <8e51ff8168d050cb2f8fedd4464b2f7b@www.dscho.org>
References: <1431955978-17890-1-git-send-email-pyokagan@gmail.com>
 <1431955978-17890-9-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 17:20:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMqS-0002fg-Dt
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbbERPUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:20:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:62910 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255AbbERPUg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:20:36 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LhOvA-1ZY9eT2036-00mZFc; Mon, 18 May 2015 17:20:33
 +0200
In-Reply-To: <1431955978-17890-9-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:x+ANU3WsKmeYefQ7fnlNyd4QZYNP/Hqq8X94OjbCi9arW6nFU2j
 8U69sN56e81UTewcE5VsLc12Ba886nQvNB+4OeRSH4WJepH4MbBBBKkBQ9ci0FEV4bJPx0W
 LnK+bO1eGSW/6VWyEyKzBWr6E+ilCNTpuufDwpkL6Atoos1W8950XBkX76j8UEwO0Kq9EA7
 ADsLrg/EVm4cd4Iu/sTJA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269277>

Hi Paul,

On 2015-05-18 15:32, Paul Tan wrote:

> @@ -95,7 +94,11 @@ test_expect_success 'test . as a remote' '
>  	git checkout copy &&
>  	test "$(cat file)" = file &&
>  	git pull &&
> -	test "$(cat file)" = updated
> +	test "$(cat file)" = updated &&
> +	git reflog -1 >reflog.actual &&
> +	sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&

Actually, let's use "s/^[0-9a-f]*/OBJID/" instead: you only want to replace the first few characters.

> @@ -106,7 +109,11 @@ test_expect_success 'the default remote . should
> not break explicit pull' '
>  	git reset --hard HEAD^ &&
>  	test "$(cat file)" = file &&
>  	git pull . second &&
> -	test "$(cat file)" = modified
> +	test "$(cat file)" = modified &&
> +	git reflog -1 >reflog.actual &&
> +	sed "s/$_x05[0-9a-f]*/OBJID/g" reflog.actual >reflog.fuzzy &&

Same here.

Ciao,
Dscho
