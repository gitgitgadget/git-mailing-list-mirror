From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git interpret-trailers with multiple keys
Date: Wed, 06 Apr 2016 18:58:30 +0200
Message-ID: <vpqlh4qbrnt.fsf@anie.imag.fr>
References: <20160406191054-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 18:58:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anqn2-000439-4M
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 18:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbcDFQ6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 12:58:41 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39975 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbcDFQ6k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 12:58:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u36GwSAs002658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 6 Apr 2016 18:58:29 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u36GwUW1015325;
	Wed, 6 Apr 2016 18:58:30 +0200
In-Reply-To: <20160406191054-mutt-send-email-mst@redhat.com> (Michael S.
	Tsirkin's message of "Wed, 6 Apr 2016 19:12:56 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Wed, 06 Apr 2016 18:58:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u36GwSAs002658
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1460566709.83979@uxaundD8YIXoKCUrV1ajdg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290853>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> I have this in .git/config
>
> [trailer "r"]
>         key = Reviewed-by
>         command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
> [trailer "s"]
>         key = Signed-off-by
>         command = "echo \"Michael S. Tsirkin <mst@redhat.com\""
>
> whenever I run git interpret-trailers -t r I see these lines added:
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com
>
> Why is Reviewed-by repeated?  Bug or feature?

The first two lines are added unconditionally:

$ echo | git interpret-trailers 

Reviewed-by: Michael S. Tsirkin <mst@redhat.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com

The last line is added because you've asked for it with --trailer r.

I don't think it's currently possible to get the behavior you seem to
expect, ie. to define trailer tokens fully (key and value) in your
config file but use them only on request.

(BTW, I think you wanted a closing > at the end)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
