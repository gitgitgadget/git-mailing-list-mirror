From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] pretty.c: make git_pretty_formats_config return -1 on git_config_string failure
Date: Mon, 04 Aug 2014 23:06:03 +0200
Message-ID: <vpqtx5s7yo4.fsf@anie.imag.fr>
References: <1407163275-3006-1-git-send-email-tanayabh@gmail.com>
	<vpqmwbki7h3.fsf@anie.imag.fr> <20140804203351.GA12898@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 23:06:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEPSV-0003Qc-CH
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 23:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbaHDVGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 17:06:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53521 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbaHDVGO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 17:06:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s74L61gt021009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2014 23:06:01 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s74L63ET006353;
	Mon, 4 Aug 2014 23:06:03 +0200
In-Reply-To: <20140804203351.GA12898@peff.net> (Jeff King's message of "Mon, 4
	Aug 2014 16:33:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Aug 2014 23:06:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s74L61gt021009
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407791162.46171@wKFPBnMlEOHY1kLyHrQkOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254784>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 04, 2014 at 05:45:44PM +0200, Matthieu Moy wrote:
>
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>> > `git_pretty_formats_config()` continues without checking git_config_string's
>> > return value which can lead to a SEGFAULT.
>> 
>> Indeed, without the patch:
>> 
>> $ git -c pretty.my= log --pretty=my                        
>> error: Missing value for 'pretty.my'                         
>> zsh: segmentation fault  git -c pretty.my= log --pretty=my
>
> Hmm. Not related to the original patch, but that really looks like a
> bug. Shouldn't "git -c pretty.my= ..." set pretty.my to the empty string?
>
> I'd expect "git -c pretty.my ..." to set it to NULL (i.e., the "implicit
> true" you get from omitting the "=" in the config files themselves).

Indeed.

strbuf_split_buf() does not seem to distinguish between x= and x. No
time to debug this further, sorry.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
