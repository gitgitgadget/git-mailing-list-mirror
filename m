From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v1] Git config cache & special querying api utilizing the cache
Date: Wed, 11 Jun 2014 16:01:32 +0200
Message-ID: <vpqr42v35qb.fsf@anie.imag.fr>
References: <1402318146-5062-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Torsten Bogershausen <tboegi@web.de>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 16:02:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wuj6D-0008Jh-Td
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 16:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589AbaFKOBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 10:01:53 -0400
Received: from mx2.imag.fr ([129.88.30.17]:57395 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754908AbaFKOBv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 10:01:51 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s5BE1VBO011272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jun 2014 16:01:31 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5BE1WP2017332;
	Wed, 11 Jun 2014 16:01:32 +0200
In-Reply-To: <1402318146-5062-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 9 Jun 2014 05:49:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 11 Jun 2014 16:01:32 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251369>

Tanay Abhra <tanayabh@gmail.com> writes:

> I have run the tests and debug the code using custom functions and it works
> fine.

I understand that you wrote the custom functions for you, but didn't
include them in the patch, right?

If so, wouldn't it make sense to include these as unit-tests for your
code? See what Git already does with test-*.c, e.g.

$ git grep test-hashmap
.gitignore:/test-hashmap
Documentation/technical/api-hashmap.txt:See test-hashmap.c for an example using arbitrary-length strings as keys.
Makefile:TEST_PROGRAMS_NEED_X += test-hashmap
t/t0011-hashmap.sh:     echo "$1" | test-hashmap $3 > actual &&
t/t0011-hashmap.sh:     cat in | test-hashmap > out &&
test-hashmap.c: * Usage: time echo "perfhashmap method rounds" | test-hashmap

for examples. The resulting binary would be a good candidate for
valgrind --leak-check=full.

The tests are not just for you, they are also:

* For reviewers, to show an example of correct usage of the new API,

* For people of the future, to avoid regressions.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
