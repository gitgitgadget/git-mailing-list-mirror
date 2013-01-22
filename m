From: =?UTF-8?B?SmVhbi1Ob8OrbCBBdmlsYQ==?= <avila.jn@gmail.com>
Subject: Re: [RFC] Instruct git-completion.bash that we are in test mode
Date: Tue, 22 Jan 2013 09:04:04 +0100
Message-ID: <50FE47F4.20104@gmail.com>
References: <201301212330.10824.jn.avila@free.fr> <7v7gn6f6ya.fsf@alter.siamese.dyndns.org> <20130122003954.GA23297@sigill.intra.peff.net> <7vham9dej2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?SmVhbi1Ob8OrbCBBVklMQQ==?= <jn.avila@free.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 09:04:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxYqN-0001vn-H7
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 09:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888Ab3AVIEK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jan 2013 03:04:10 -0500
Received: from mail-bk0-f53.google.com ([209.85.214.53]:51061 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525Ab3AVIEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 03:04:08 -0500
Received: by mail-bk0-f53.google.com with SMTP id je9so950714bkc.12
        for <git@vger.kernel.org>; Tue, 22 Jan 2013 00:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KiVtMOkXNIE0cGfMqR3DYJU//4SxVFgU3aYzw41DvZQ=;
        b=yBNKTIxMgXhDFwaJcv5wfq8qvn1Jn+HFMW2+PAfihmokBa8GeTlZc2IH3AKpYd5hE9
         v7AmmxewYneH/ILRqBcdqjpAMYmo8zk5D9DKO7jk6w31oKsaFVKI88zdJU2xNWDg46D3
         yaf3MU4yRIO7spk6QgSnJsE3TGCkey7ErqUiwd4/AGl5w6SBfKTmrD5+0DzaLyhZlJ6Q
         9rGBc04KVpkFVgr2afoEX11iZ+/vztwj5YMGoIEeERFy26U7xpPv3aLf2lET3FhwgKZL
         26oM279iEgzj0at5IVzQ7Pl/ktiQ+N0OpZx3kWHCrKY2R8c/6hCfsQ6xSas4JVQv+SXH
         Z4Xw==
X-Received: by 10.204.147.145 with SMTP id l17mr1344672bkv.100.1358841847364;
        Tue, 22 Jan 2013 00:04:07 -0800 (PST)
Received: from [192.168.1.48] ([178.21.183.81])
        by mx.google.com with ESMTPS id f24sm10101015bkv.7.2013.01.22.00.04.05
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Jan 2013 00:04:06 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <7vham9dej2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214213>

Le 22/01/2013 05:31, Junio C Hamano a =C3=A9crit :
> Jeff King <peff@peff.net>  writes:
 >
 >> I really hate to suggest this, but should it be more like:
 >>
 >> if test -z "$FAKE_COMMAND_LIST"; then __git_cmdlist() { git help -a
 >> | egrep '^ [a-zA-Z0-9]' } else __git_cmdlist() { printf '%s'
 >> "$FAKE_COMMAND_LIST" } fi
 >>
 >> That gives us a nice predictable starting point for actually
 >> testing the completion code. The downside is that it doesn't let
 >> us test that we remain compatible with the output of "help -a".
 >
 > Yeah, I think this is simpler and more to the point for the test in
 > t9902. If we really want to test something that is the same as, or
 > at least any closer than this approach (or my "help --standard"), to
 > what the real users use, the test has to become inherently flaky, so
 > I think we should go for the simplicity of this patch shows.

Instead of imposing the list of command, we could use the command
list argument to filter the ouput of git help -a. This would ensure tha=
t the
completions we want to test are still present in the installation while
still restricting them to the test case.
