From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Mon, 12 Oct 2015 22:20:02 +0200
Message-ID: <vpqwpurx2j1.fsf@grenoble-inp.fr>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
	<1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, tboegi@web.de,
	pw@padd.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 12 22:20:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZljZx-0004gi-5M
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 22:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbbJLUUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 16:20:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35759 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbbJLUUK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 16:20:10 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9CKK0Fa007006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 12 Oct 2015 22:20:00 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9CKK2vp019626;
	Mon, 12 Oct 2015 22:20:02 +0200
In-Reply-To: <1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Sun, 11 Oct 2015 10:55:00
	-0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 12 Oct 2015 22:20:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9CKK0Fa007006
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445286003.21386@DJWBh+TtmkweAmVxBfiEmQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279415>

larsxschneider@gmail.com writes:

> --- /dev/null
> +++ b/.travis.yml
> @@ -0,0 +1,46 @@
> +language: c
> +
> +os:
> +  - linux
> +  - osx
> +
> +compiler:
> +  - clang
> +  - gcc
> +
> +before_install:
> +  - >
> +    export GIT_TEST_OPTS=" --quiet";
> +    case "${TRAVIS_OS_NAME:-linux}" in
> +    linux)
> +      wget -q https://package.perforce.com/perforce.pubkey -O - \
> +        | sudo apt-key add -
> +      echo 'deb http://package.perforce.com/apt/ubuntu precise release' \
> +        | sudo tee -a /etc/apt/sources.list
> +      wget -q https://packagecloud.io/gpg.key -O - | sudo apt-key add -
> +      echo 'deb https://packagecloud.io/github/git-lfs/debian/ jessie main' \
> +        | sudo tee -a /etc/apt/sources.list
> +      sudo apt-get update -qq
> +      sudo apt-get install -y apt-transport-https
> +      sudo apt-get install perforce-server git-lfs

Sorry if this has been discussed already, but do you really need these
"sudo" calls?

They trigger builds on the legacy Travis CI infrastructure:

  http://docs.travis-ci.com/user/migrating-from-legacy/?utm_source=legacy-notice&utm_medium=banner&utm_campaign=legacy-upgrade

No big deal, but getting rid of sudo would be cool, and documenting why
it can't easily be done in commit message and/or comments would be nice
otherwise.

Thanks for working on that!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
