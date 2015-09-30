From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase: accept indented comments (fixes regression)
Date: Wed, 30 Sep 2015 21:50:37 +0200
Message-ID: <vpqh9mbhek2.fsf@grenoble-inp.fr>
References: <1443600661-19391-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqd1wz9402.fsf@gitster.mtv.corp.google.com>
	<xmqqy4fn7m2s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Galan =?iso-8859-1?Q?R=E9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 21:50:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhNOs-0005MH-MX
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 21:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbbI3Tur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 15:50:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46299 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932257AbbI3Tuq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 15:50:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8UJoY4g029498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 30 Sep 2015 21:50:34 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8UJobFD017212;
	Wed, 30 Sep 2015 21:50:37 +0200
In-Reply-To: <xmqqy4fn7m2s.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 30 Sep 2015 12:18:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 30 Sep 2015 21:50:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8UJoY4g029498
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444247438.23606@d6Vn+PdDTLUpLIhOGXfgaQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278864>

Junio C Hamano <gitster@pobox.com> writes:

> +		pick|p|drop|d|reword|r|edit|e|squash|s|fixup|f)
> +			if ! check_commit_sha "${rest%% *}" "$lineno" "$1"

This does not pass my "tabs" test, as it parses the sha1 out of the line
assuming it's separated with a space. It's used in other places of the
code, but tabs still seem to work more or less by chance (they are not
parsed properly by transform_todo_ids, but then they are understood by
do_next).

I changed it to

	while read -r command sha1 rest

which is a bit more lazy.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
