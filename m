From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v3 1/4] builtin/verify-tag.c: Ignore SIGPIPE on
 gpg-interface
Date: Sun, 3 Apr 2016 17:46:07 -0400
Message-ID: <20160403214606.GB28933@LykOS>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-2-git-send-email-santiago@nyu.edu>
 <5700BD33.6090602@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 03 23:46:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ampqc-0004H7-7u
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 23:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbcDCVqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 17:46:11 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34328 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbcDCVqK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 17:46:10 -0400
Received: by mail-qk0-f171.google.com with SMTP id r184so21612381qkc.1
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 14:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=REfr1eCVvub2P4tgwjg38evYDSn+WKH1jHjNQ1r0CFY=;
        b=jiRprB+V66Fws56zGusvto2ProOzYVbBeEwrVx4Z/3ZPrDA5C3/ZuGsXeTzklBpxok
         PNswJNzjK/YDf82iru2sJb5LGPnIQ2hO7ySj9epRAtFBvgxJ76Jj368w94MgkHxcfM0o
         mVFV6NaCTB8zeS1A/JWg84c6iCdGOBY/nSDqoqNaWL3QRenxAVLp5l3XiaPy3PWmy/zN
         5x7J6l4svVDrhxJALGAQH5fwg5pfcwl7+KHBDLjXYMmaIdbixlHZYTDXLbabOaBI/2ll
         nfjclFqR6585n66hlfjjS5Viw1GWgTMJOjzSWodonuN4Y7Lwbv2R9tMn1C7fwVAN+exT
         5eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=REfr1eCVvub2P4tgwjg38evYDSn+WKH1jHjNQ1r0CFY=;
        b=AOuaFuhgnehLTKJQh7QImN8lacdBbYce3iZHxLFe+gytHzzvhJ+x/EDhciR1WPpp4x
         0w9rlyIzVs/A97fpNzT3/isZAZRkKRX3QDg+nYYkaX0D6u6KKFz6r7Q6Hx86s3/I1X/w
         yNRs+ZdQ+1nZrRWSLTqQl/K1B1vZXz48krxQGBwcUoHhrGV7D8cntvk/dX7PSNMtPmOT
         hIifNYiF/VYVOaiILPo4wp+GYpV6DxiY0uxAPxiqxicB8NmbF2DGxtaay8mSwdONl7yF
         dFfo5ed3ZTmK8YiFJJoJk/ovEcDZWkmW3pOc2NqieiLXRRfQBSJclTH0RNkABfQquFQF
         Lqsw==
X-Gm-Message-State: AD7BkJJV0GbixrJAqJGrcNEx5gE3Ou0BVXBScxSF+cCh1sgw9fxNZDNJy8nKDZLp13/HVyet
X-Received: by 10.55.215.206 with SMTP id t75mr14884459qkt.87.1459719969073;
        Sun, 03 Apr 2016 14:46:09 -0700 (PDT)
Received: from LykOS (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id c190sm11080451qkb.27.2016.04.03.14.46.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2016 14:46:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5700BD33.6090602@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290657>

On Sun, Apr 03, 2016 at 08:50:27AM +0200, Johannes Sixt wrote:
> Am 03.04.2016 um 01:16 schrieb santiago@nyu.edu:
> > From: Santiago Torres <santiago@nyu.edu>
> > 
> > The verify_signed_buffer comand might cause a SIGPIPE signal when the
> > gpg child process terminates early (due to a bad keyid, for example) and
> > git tries to write to it afterwards. Previously, ignoring SIGPIPE was
> > done on the builtin/gpg-verify.c command to avoid this issue. However,
> > any other caller who wanted to use the verify_signed_buffer command
> > would have to include this signal call.
> > 
> > Instead, we use sigchain_push(SIGPIPE, SIG_IGN) on the
> > verify_signed_buffer call (pretty much like in sign_buffer()) so
> > that any caller is not required to perform this task. This will avoid
> > possible mistakes by further developers using verify_signed_buffer.
> > 
> > Signed-off-by: Santiago Torres <santiago@nyu.edu>
> > ---
> > Notes:
> >   I dropped the multiline comment altogheter.
> > 
> >   builtin/verify-tag.c | 3 ---
> >   gpg-interface.c      | 3 +++
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> > index 00663f6..77f070a 100644
> > --- a/builtin/verify-tag.c
> > +++ b/builtin/verify-tag.c
> > @@ -95,9 +95,6 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
> >   	if (verbose)
> >   		flags |= GPG_VERIFY_VERBOSE;
> > 
> > -	/* sometimes the program was terminated because this signal
> > -	 * was received in the process of writing the gpg input: */
> > -	signal(SIGPIPE, SIG_IGN);
> >   	while (i < argc)
> >   		if (verify_tag(argv[i++], flags))
> >   			had_error = 1;
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index 3dc2fe3..c1f6b2d 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -232,6 +232,8 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
> >   	if (gpg_output)
> >   		gpg.err = -1;
> >   	args_gpg[3] = path;
> > +
> > +	sigchain_push(SIGPIPE, SIG_IGN);
> >   	if (start_command(&gpg)) {
> >   		unlink(path);
> >   		return error(_("could not run gpg."));
> 
> But no sigchain_pop() in the error path that we see here?
> 
> Perhaps you can even defer the sigchain_push() until after start_command()?

Yes, after reviewing where the sigchain_push() call is made on
sign_buffer(), I should put the push call after starting the command in
the same way sign_buffer() does. 

Thanks!
-Santiago.
