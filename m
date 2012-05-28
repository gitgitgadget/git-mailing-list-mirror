From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v7 0/9] submodule: improve robustness of path handling
Date: Mon, 28 May 2012 22:07:11 +0200
Message-ID: <4FC3DAEF.1070508@web.de>
References: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, phil.hord@gmail.com,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Johannes Sixt <j6t@kdbg.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 22:08:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ6EY-0005qY-Ma
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 22:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016Ab2E1UHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 16:07:39 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:55428 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab2E1UHi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 16:07:38 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate01.web.de (Postfix) with ESMTP id B4DD31AF02771
	for <git@vger.kernel.org>; Mon, 28 May 2012 22:07:14 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.180.110]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MgOQQ-1SMMlF48xC-00NjKR; Mon, 28 May 2012 22:07:13
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1338132851-23497-1-git-send-email-jon.seymour@gmail.com>
X-Provags-ID: V02:K0:Ajwgpj/hGzIDkZM5ywU+5Y8w4Diwau9iwDo0de6B7Ry
 GEoPn8xXaec+RahR6ZsfjAryaMaTgfrKlY/fpaZQbhSRkykc1f
 rnS1iC2x7Yom5V/aOzxv6EhiU+3uwAFQr4sFr0007vV7rZnrFt
 DaUsQXZWVVVxlzVrrkmcrm2ofv9xZOR4r11cFwtRqtera6i3AD
 s7E5JcG8Yk+87evz+0uXA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198719>

Am 27.05.2012 17:34, schrieb Jon Seymour:
> This series improves the robustness of path handling by 'git submodule' by:
> 
> * detecting submodule URLs that will result in non-sensical submodule origin URLs
> 
> * improving handling of various kinds of relative superproject origin URLs
> 
> * improving handling of various kinds of denormalized superproject origin URLs

Hmm, this has become a quite invasive patch series. While I bought the
use case of having a superproject with a relative url and was inclined
to accept that it might even not start "./" or "../" (even though that
is a pretty unusual use and can be easily fixed by prepending a "./"),
I'm not sure the in depth check of URLs is worth the code churn. And
especially the high probability of breaking other peoples use cases in
rather subtle ways worry me (this did happen quite often when the
submodule script was changed in the past; as an example take the
windows path issues Johannes already pointed out in his email). And I
can't remember bug reports that people complained about URL problems
due to the issues you intend to fix here, which makes me think they
might be well intended but possibly unnecessary (but my memory might
server me wrong here).

So I'd vote for just fixing the relative submodule path issues and to
not care about the possible issues with URLs. Opinions?

(And patches 6-8 contain changes to test cases other than just changing
test_expect_failure to test_expect_success which makes reviewing this
series unnecessarily hard)
