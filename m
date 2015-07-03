From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 3/4] log --count: added test
Date: Fri, 03 Jul 2015 09:34:22 +0200
Message-ID: <vpqwpyh4rup.fsf@anie.imag.fr>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
	<1435881011-13879-4-git-send-email-lawrencesiebert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.galan-alfonso@ensimag.grenoble-inp.fr,
	gitster@pobox.com
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 09:34:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAvUX-0003Qc-Oe
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 09:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383AbbGCHe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 03:34:29 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50196 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754382AbbGCHe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 03:34:28 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t637YLte021784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Jul 2015 09:34:21 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t637YMn2022849;
	Fri, 3 Jul 2015 09:34:22 +0200
In-Reply-To: <1435881011-13879-4-git-send-email-lawrencesiebert@gmail.com>
	(Lawrence Siebert's message of "Thu, 2 Jul 2015 16:50:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 03 Jul 2015 09:34:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t637YLte021784
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436513663.66579@waGmxFl/Jwfo2+/LKpzd/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273283>

Lawrence Siebert <lawrencesiebert@gmail.com> writes:

> added test comparing output between git log --count HEAD and
> git rev-list --count HEAD

Unless there is a very long list of tests, I'd rather see this squashed
with PATCH 2/4. As a reviewer I prefer having code and tests in the same
place.

> Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
> ---
>  t/t4202-log.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 1b2e981..35f8d82 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -871,4 +871,11 @@ test_expect_success 'log --graph --no-walk is forbidden' '
>  	test_must_fail git log --graph --no-walk
>  '
>  
> +test_expect_success 'log --count' '
> +	git log --count HEAD > actual &&
> +	git	rev-list --count HEAD > expect &&

The weird space is still there.

Also, we write ">actual", not "> actual" in the Git coding style.

That is actually a rather weak test. rev-list --count interacts with
--left-right, so I guess you want to test --count --left-right.

Also, some revision-limiting options can reduce the count like

git log --grep whatever

and you should check that you actually count the right number here.

(I don't know this part of the code enough, but I'm not sure you
actually deal with this properly)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
