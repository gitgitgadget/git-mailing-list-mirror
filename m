From: "Robert Blum" <rob.blum@gmail.com>
Subject: Fwd: [PATCH] git-p4: chdir now properly sets PWD environment variable in msysGit
Date: Mon, 4 Aug 2008 06:04:59 -0700
Message-ID: <bad7471c0808040604p6de570f1k35aa4e76757ca6fd@mail.gmail.com>
References: <bad7471c0808011250v569ffaaby9e20a5ba1f971927@mail.gmail.com>
	 <7v7iaxu7i1.fsf@gitster.siamese.dyndns.org>
	 <bad7471c0808040601y10cceb44idcde5a4a8f415769@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 15:06:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPzlD-0003RQ-UP
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 15:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbYHDNFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 09:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYHDNFB
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 09:05:01 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:40752 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbYHDNFA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 09:05:00 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1159584ywe.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PEL+zKUvnrTiCtjTmBzfcVsQtQYhzsEoMXMRNcAXRio=;
        b=t3F5Mfqi+KXjZ4w0yWRkhqEBcX4dL0o1TIGHJW0YiSwcRcFln/Y73UXYfnxxy2rMLq
         wvIwTMFAkDJUtkemhVmJA99viUs7hOjUGElJFndIMi3qk/BiOGPhVVM/93o7B7NWUPTQ
         hXzMPqdO9uRAlRt2Hx4MLRlJPvODPDKCbwfgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=j8A85UIoZ5iZA+8GP8dVcPH4kWKsMw0a0ifsnWck7t2mndT06uJ4xU8ZDyYvYktS+v
         jKJcXM81W3ipiybtWt7dIKtjxEt388rtKZ724/Z3RCBIRsyk5wPUWVlCz3UFmiTXsZrY
         DvXRhVLlNc+NLA5+hDNLB7DkiQSRC4VKNxfjw=
Received: by 10.150.204.12 with SMTP id b12mr1275726ybg.171.1217855099924;
        Mon, 04 Aug 2008 06:04:59 -0700 (PDT)
Received: by 10.151.143.20 with HTTP; Mon, 4 Aug 2008 06:04:59 -0700 (PDT)
In-Reply-To: <bad7471c0808040601y10cceb44idcde5a4a8f415769@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91348>

Forgot reply-all - forwarding to list....

> Missing full stop at the end of sentence aside, this comment makes me
> wonder if there is an optional way to have it set it, as opposed to the
> inconvenient way it behaves "by defualt".

Not that I'm aware of. My 'by default' comment refers to a default
Python installation, i.e. unpatched. As far as I know, the real
culprit in this is p4. I'd argue it's a bug, since they should be
using getcwd(), not getpwd(). Moot point - I don't want to wait for
git-p4 until I have convinced perforce to fix this and a new p4 rolls
around ;)

>  If there is none, I think your
> patch, even though it looks ugly, is the least evil approach.

Warms the cockles of my heart ;)

> Another way
> might be to wrap callsites of system() by introducing a "run_p4" function,
> like:
>
>        def run_p4(arg):
>                os.environ['PWD'] = os.getcwd() if os.name == 'nt'
>                return system(arg)

Happy to submit a new patch with that, if that's preferred.

> Thanks.  I've been waiting for an Ack from somewhere or success reports
> from p4 users on Windows.

Han-Wen seems OK with it. (BTW: Who *is* the maintainer of git-p4?)
But hold off on applying - I'll resubmit with the run_p4 approach
today.

(Oh, and of course: Works for me ;)

 - Robert
