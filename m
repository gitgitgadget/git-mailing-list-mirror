From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH jk/prune-mtime] prune: close directory earlier
 during loose-object directory traversal
Date: Sun, 13 Dec 2015 14:26:07 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512131425300.21630@virtualbox>
References: <55CA5EB0.1000308@kdbg.org> <b9cf9e2168c3b2476bb5bb134a1528be@www.dscho.org> <55CB85A5.5040802@kdbg.org> <20150812175629.GA24964@sigill.intra.peff.net> <xmqqvb84epyl.fsf@gitster.mtv.corp.google.com> <20151211194103.GA5834@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>, 
    Git Mailing List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCZPH74Q5YNRB5PDWWZQKGQEPURPYFY@googlegroups.com Sun Dec 13 14:26:15 2015
Return-path: <msysgit+bncBCZPH74Q5YNRB5PDWWZQKGQEPURPYFY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wm0-f55.google.com ([74.125.82.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB5PDWWZQKGQEPURPYFY@googlegroups.com>)
	id 1a86fG-0006VC-Hx
	for gcvm-msysgit@m.gmane.org; Sun, 13 Dec 2015 14:26:14 +0100
Received: by wmpp66 with SMTP id p66sf3851949wmp.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 13 Dec 2015 05:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=7tDrpIkjAtB9YTWNxppK52BA/VtIWVqkfmHcygGNzpk=;
        b=eEooBNKffX983NoBBXxfuZHSGYurWnC/+RScEYoXzRa2TEQ5Pjtl65v2c33KzV+bV6
         ypz2aVK4UVtpkQhTjUGTms24C0yVm54DakmBNxIGV5pnl6V30XQk6xnSJmuVM6AANTwn
         H5daQUHs0nZ3LXzvAfzDvj9kl96z8W+wO9Ll6KY8hdsnTwvPEaCIiAMD9HT9ntoQJI/M
         ox1kldLXb/6jcYB32pGqUku14tPKeqLAzfGzG6u8w4W3OCWNBZskJjizoKDbMjxQO8pB
         N5ImvXtmhQgFRo+cMiEwOXt4JJ8/s0nQfC7gcTYPb6GZ7GDjRwSOR8i/RCkiUBpmXLwo
         dttA==
X-Received: by 10.28.225.195 with SMTP id y186mr44463wmg.20.1450013174244;
        Sun, 13 Dec 2015 05:26:14 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.28.153.12 with SMTP id b12ls659984wme.15.gmail; Sun, 13 Dec
 2015 05:26:11 -0800 (PST)
X-Received: by 10.28.129.147 with SMTP id c141mr1822232wmd.3.1450013171810;
        Sun, 13 Dec 2015 05:26:11 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id d185si385468wmf.0.2015.12.13.05.26.11
        for <msysgit@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Dec 2015 05:26:11 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from virtualbox ([37.24.143.140]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MCLcP-1ZyzqK3BXF-0097wn; Sun, 13 Dec 2015 14:26:09
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20151211194103.GA5834@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:p66TaJTFDuV9P8SHxT+LL5alAM7SiYjpNgMzghWfM+WIyKuD2kP
 B1ZR6K1FIon5OTTf7vU7MFAjtYrzS95P8xx5erd1t36X6ULyz99r+UN4xdWKCtxYkotI4xE
 XJRT8Vb+vsD6ldgO+vlYf346aEKE+EazEoZX3lbNhnS2Wg1FIdfvGmkHbMmh6lDVY0cDzvb
 IXMlqr7ILwT5E1/f1H89g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9Ne+PujhvXI=:sNxevHcNL2f4iIejOIDDRQ
 h/i9rLQRRNgSV4PFXvvaRkpTqwQQcjAtuRh5PPD/0zOMrPtNf2gxsHF4yvuKkryQ5enC6AuI6
 rzFW5U+lj9KpInQR9kCP7kbYhazYl+gy+e326hkexJ6yp8gat7GnJFh1NS9RKoL3CFlHN9n06
 zg1AHok+Ja5NiCnduzNnAOGorAAPc6cW+WOvSJ44uKltKSsr9nNgN8WwkXznw8KxyGaRx2p1z
 fJHjpegv/3t7wjnO3M2/zj4pxYnVpawTyNQKYOaIqXKSKnOVV7nS1ivMuAt8EVjgehgfjPnyf
 O9yYNarG8d31N6cJcsxusX75tsY1/LspCO637xPSzOjJ+FFwKHMVIMjtjx1UPojOkzDcldmBp
 iJDy6txGmhpdiqqHnxXTRwVRecttG345HOLUB7Sab2BIjIU5VhDLIbQ7HLaWtpPihP3EBfNoA
 VKaQur5Mf36D4eGOs3T6V/Z9Nn3QBlXg07GNmQMeK3bKKvN69InGYIP3OpMjzyfK0N1BFZlQO
 6rN1NP5ZPblMEGHAIqfFvYrJCKUFUTkSj50zqqgSXLgzzhBVM6qCbV/lWdBOBicXeo53M7CaX
 tmbqxnMPwVhxq9lV0M57VMV6waqObVK1HWy/Q2d517MLM7rcK8imMt0zYG8teVP+PXUu7Cpy1
 X4co7+D//9woG22t0kFjyY8uT62jKvr3xn/X3cb22k8gHpVSyec+kiJcv7PJxuPD7rKJuHNB/
 dcGc+yRnVbzQVcU/OBnyYagSCtICt6jov9H+Q4Oed8fkcmt2cSVCP3j+C66ZJfShKCzDPkql 
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as
 permitted sender) smtp.mailfrom=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <https://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <https://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282330>

Hi Junio & Peff,

On Fri, 11 Dec 2015, Jeff King wrote:

> On Fri, Dec 11, 2015 at 11:37:54AM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > On Wed, Aug 12, 2015 at 07:43:01PM +0200, Johannes Sixt wrote:
> > >
> > >> 27e1e22d (prune: factor out loose-object directory traversal, 2014-10-16)
> > >> introduced a new function for_each_loose_file_in_objdir() with a helper
> > >> for_each_file_in_obj_subdir(). The latter calls callbacks for each file
> > >> found during a directory traversal and finally also a callback for the
> > >> directory itself.
> > >> 
> > >> git-prune uses the function to clean up the object directory. In
> > >> particular, in the directory callback it calls rmdir(). On Windows XP,
> > >> this rmdir call fails, because the directory is still open while the
> > >> callback is called. Close the directory before calling the callback.
> > >
> > > Makes sense, and the patch looks good to me. Sorry for breaking things
> > > on Windows.
> > >
> > > Acked-by: Jeff King <peff@peff.net>
> > 
> > Sorry for reviving this old thread, but I noticed that we do not
> > have this patch in our tree yet.  I'll queue to 'pu' for now lest I
> > forget.  If I missed a good argument or concensus against the change
> > please let me know, otherwise I'll fast track the change to 2.7 final
> 
> Ah, thanks for doing that. I noticed it when picking through "git branch
> --no-merged pu" of your workspace a few weeks ago, but forgot to follow
> up. I certainly have no objections.

Git for Windows carries this patch since Git for Windows v2.5.0. So: no
objection from my side, either.

Ciao,
Dscho

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
