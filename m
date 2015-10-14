From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: repository corruption when pushing commits to a repository running 'git gc --prune='
Date: Wed, 14 Oct 2015 20:46:51 +0200
Message-ID: <vpqbnc18ezo.fsf@grenoble-inp.fr>
References: <561E5C5B.3090207@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Jan Smets <jan.smets@alcatel-lucent.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:47:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmR4t-00007O-Ez
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 20:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbbJNSrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 14:47:02 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53203 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097AbbJNSrA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 14:47:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t9EIkn4A004300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 14 Oct 2015 20:46:49 +0200
Received: from anie (ensi-vpn-233.imag.fr [129.88.57.233])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9EIkpfc001916;
	Wed, 14 Oct 2015 20:46:51 +0200
In-Reply-To: <561E5C5B.3090207@alcatel-lucent.com> (Jan Smets's message of
	"Wed, 14 Oct 2015 15:44:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 14 Oct 2015 20:46:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9EIkn4A004300
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445453214.35222@aP69B/3m/FvJuVlNYrhYLw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279586>

Jan Smets <jan.smets@alcatel-lucent.com> writes:

> 2)
>
> remote: error: unable to write sha1 filename
> objects/05/cdb51bb0ea3e229734a4b1bddd5ec70fbc65ed: No such file or
> directory
> remote: fatal: failed to write object

If I read correctly, this happens when we move the temp file to its
permanent position.

This looks like a race between deleting objects/05/ and creating
objects/05/cdb51bb0ea3e229734a4b1bddd5ec70fbc65ed.

I don't understand how this is possible, since the temporary file and
the final one are in the same directory, so deleting the directory
should fail.

What am I missing?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
