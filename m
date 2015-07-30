From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git pull --upload-pack reversion in git 2.5.0
Date: Thu, 30 Jul 2015 19:17:05 +0200
Message-ID: <vpqvbd1k1ke.fsf@anie.imag.fr>
References: <20150730154523.GA17002@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Thu Jul 30 19:17:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKrSV-0007V8-CI
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 19:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339AbbG3RRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 13:17:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36046 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754617AbbG3RRL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 13:17:11 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6UHH25x003813
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 30 Jul 2015 19:17:02 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6UHH5v2008386;
	Thu, 30 Jul 2015 19:17:05 +0200
In-Reply-To: <20150730154523.GA17002@kitenet.net> (Joey Hess's message of
	"Thu, 30 Jul 2015 11:45:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 30 Jul 2015 19:17:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6UHH25x003813
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438881424.94029@S+LD3YUnfh+PFpQjrV+N5Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275021>

Joey Hess <id@joeyh.name> writes:

> In git 2.1.4, I can run: git pull --upload-pack 'echo --foo'
>
> This also seems to work in 2.4.6, but in 2.5.0, the option parser
> does something weird, apparently looking inside the quoted parameter
> and parsing parameters in there:
>
> error: unknown option `foo'
> usage: git fetch [<options>] [<repository> [<refspec>...]]

This bisects down to:

commit e3b601da2af53cbb9a63e59113d524a8d946ea12 (junio/pt/pull-optparse)
Author: Paul Tan <pyokagan@gmail.com>
Date:   Tue Jun 2 22:22:53 2015 +0800

    pull: use git-rev-parse --parseopt for option parsing
    
    To enable unambiguous parsing of abbreviated options, bundled short
    options, separate form options and to provide consistent usage help, use
    git-rev-parse --parseopt for option parsing. With this, simplify the
    option parsing code.
    
    Signed-off-by: Paul Tan <pyokagan@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

=> Cc-ing Paul.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
