From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 3/3] t3700-add: added test for --exclude option
Date: Sun, 15 Mar 2015 19:00:58 +0100
Message-ID: <5505C8DA.2050500@web.de>
References: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com> <1426427437-23370-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 19:01:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXCqc-0005QT-6R
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 19:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbbCOSBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 14:01:06 -0400
Received: from mout.web.de ([212.227.17.12]:51330 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430AbbCOSBE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 14:01:04 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MEmgA-1YnCTp1IKY-00G4d5; Sun, 15 Mar 2015 19:00:59
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1426427437-23370-1-git-send-email-kuleshovmail@gmail.com>
X-Provags-ID: V03:K0:Ih9aVQM9hor3QUxDpjXQ8KPJf59G6xOEGrnExRHj0d0F2NSSQPO
 JTRfFBoR6BS+2YvQH8/FvPelsG7ErNSWibX1o4KEpyFJgh7RIPUEaR/wR0kY/qUAX5FPH8a
 /aTO0251Q7k/4Aowle3xrHxFfFdtlRW5gb6/7YaTDEOs6Q3XLnk3er/XPtRhAknybTnyzkB
 53nl/11Tz2M7eB1TGfLww==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265505>

> +test_expect_success 'Test that "git add --exclude" works' '
> +	touch foo &&
> +	touch bar &&
can be written shorter as
        >foo &&
	>bar &&
> +	git add --exclude="bar" . &&
Side question:
Do we need "" here ?
Or should we test files with white space as well, like this:
        >foo &&
	>bar &&
	>"b a z" &&
    	git add --exclude="bar" --exclude="b a z" . &&
	echo bar >expect &&
	git ls-files >actual &&
	test_cmp expect actual
(Which doesn't use ! grep, but test_cmp, which will give more information when
the test case does not pass)
