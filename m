Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032561FE4E
	for <e@80x24.org>; Tue, 21 Jun 2016 06:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbcFUGVq (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 02:21:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55929 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751745AbcFUGVo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 02:21:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u5L6KoYq006474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 21 Jun 2016 08:20:50 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5L6Ko5N032556;
	Tue, 21 Jun 2016 08:20:50 +0200
From:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:	Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Antoine Queru <Antoine.Queru@grenoble-inp.org>,
	git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	rsbecker@nexbridge.com, aaron@schrab.com, peff@peff.net
Subject: Re: [RFC/PATCH] push: deny policy to prevent pushes to unwanted remotes.
References: <20160604145101.21928-1-Antoine.Queru@grenoble-inp.org>
	<998280064.353519.1465213163063.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<2104102670.380496.1465220639026.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<3899461F-44B4-407F-ACCE-793E65486554@gmail.com>
	<1599012395.707458.1466461517473.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Date:	Tue, 21 Jun 2016 08:20:50 +0200
In-Reply-To: <1599012395.707458.1466461517473.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Antoine Queru's message of "Tue, 21 Jun 2016 00:25:17 +0200 (CEST)")
Message-ID: <vpqfus7jc59.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 21 Jun 2016 08:20:51 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5L6KoYq006474
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check:	1467094851.94109@DZjn4MWh5YXUdAgfA5oOVg
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr> writes:

> However, in the last version, if we want to deny an website,
> including all schemes, we can blacklist the url without the
> scheme. For example, "pushBlacklist = github.com". By doing so, this
> remote is not an url anymore, and it can't be differenced with a local
> relative path. It's a problem because these two have a different
> treatement. The choice we made to solve this is to force the user to
> put the scheme "file://" before any local relative path. What do you
> think ?

file:// URL can not be relative (well, you can invent a syntax where
they are, but that would be weird).

I think you can just forbid relative path in whitelist/blacklist, hence
consider that anything that is neither a full URL nor an absolute path
is a protocol-less URL:

* http://github.com = github.com with HTTP protocol

* github.com = github.com with any protocol

* /path/to/file or file:///path/to/file = local path

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
