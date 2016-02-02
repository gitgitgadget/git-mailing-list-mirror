From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git object-count differs between clones
Date: Tue, 02 Feb 2016 17:09:31 +0100
Message-ID: <vpq7finm6v8.fsf@anie.imag.fr>
References: <2142875754.710575.1454428371555.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andrew Martin <amartin@xes-inc.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 17:09:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQdWP-0000HL-CW
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 17:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408AbcBBQJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 11:09:38 -0500
Received: from mx1.imag.fr ([129.88.30.5]:58152 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755192AbcBBQJh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 11:09:37 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u12G9UNb023281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 2 Feb 2016 17:09:30 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u12G9Vvg013147;
	Tue, 2 Feb 2016 17:09:31 +0100
In-Reply-To: <2142875754.710575.1454428371555.JavaMail.zimbra@xes-inc.com>
	(Andrew Martin's message of "Tue, 2 Feb 2016 09:52:51 -0600 (CST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 02 Feb 2016 17:09:30 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u12G9UNb023281
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1455034172.82028@XZ3XgJmpqUhExliQMWVxhA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285269>

Andrew Martin <amartin@xes-inc.com> writes:

> I ran "git fsck" on both, which reported no problems. Moreover, I ran "git gc"
> and made sure there were no objects pending garbage collection, 

It's not sufficient: you may have objects reachable from your reflog,
hence not candidate for garbage collection. Since the reflog is not
propagated, pushing + cloning will not transfer these objects if the
reflog is the only way to reach them.

You may try expiring your reflog and "git gc" again.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
