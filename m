From: "Mike.lifeguard" <mike.lifeguard@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 21:00:02 -0300
Message-ID: <4BAD4A82.5070703@gmail.com>
References: <20100326215600.GA10910@spearce.org> <20100326222659.GA18369@progeny.tock> 	<20100326222950.GB10910@spearce.org> <4BAD3C6E.4090604@gmail.com> 	<20100326230537.GC10910@spearce.org> <7v7hoyabiv.fsf@alter.siamese.dyndns.org> <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 01:00:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvJRo-0000gU-0m
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 01:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268Ab0C0AAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 20:00:10 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:37443 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab0C0AAI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 20:00:08 -0400
Received: by yxe29 with SMTP id 29so1003957yxe.4
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 17:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=R7VK7t5RfIlWiSU4AVqG4R0jTMdWmuE2IKPVAT04aI4=;
        b=isn2DA+gGmHTKFO9YzHuxy2/7aRxn3LLy+4mMu7ryNcK7QKnPv5MyI9WjReC9iuENl
         wKg93SH48rBG/DK9bQvSzzx+plUAqkKWTmLUAkvU0tJyyqYECKBsPRR0dhtcJk7iNoaN
         zcWEWtRngMjkRWMFGJW1lVHR2m3SpnXyD1bU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=m1AFOI/rui/dX3SYd9tgwW1XwAUiU/rfL38Sj6xqqnjr3q6hJejrs/0/4RVNON+1oV
         QyInUINS4sNT8WThIPbE1ye1kz0V3tSRAZXA5qKgF1h2IIn5Gm1FdZdlqFDycwWyriRU
         AUuarr/STCQxUBtbpRnH7OaT0NlBuT5FjhDbE=
Received: by 10.101.161.9 with SMTP id n9mr2706950ano.197.1269648007819;
        Fri, 26 Mar 2010 17:00:07 -0700 (PDT)
Received: from [192.168.0.2] (hlfxns0169w-142068217168.pppoe-dynamic.High-Speed.ns.bellaliant.net [142.68.217.168])
        by mx.google.com with ESMTPS id c21sm1227992ibr.10.2010.03.26.17.00.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Mar 2010 17:00:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.0
In-Reply-To: <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com>
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143304>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10-03-26 08:49 PM, Jonathan Nieder wrote:
> git fast-export --all |
> (
> 	cd /empty/repository &&
> 	git init &&
> 	git fast-import
> )

That one did something:
*When I cd-ed into the repo, there were staged changes waiting for me
(O.o) -- the changes would have simply deleted every file in the source
tree.
*git fsck had no warnings
*As predicted, SHA1s changed

On 10-03-26 08:56 PM, Avery Pennarun wrote:
> The problem is that everything in git works perfectly with these
> invalid file modes *except* fsck, and there's rarely a need to run
> fsck, so this problem can hide for a long time.

So, does the error matter or not? If it doesn't matter, then shouldn't
Jgit stop whining? If it does, then whatever-it-is needs to be fixed.

We're still not sure what was done with github to cause this. I've done
nothing with github's web interface, and the project lead can't recall
doing anything prior to this error (only stuff today, but this error
cropped up yesterday). I suspect witchcraft :P

- -Mike
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkutSoIACgkQst0AR/DaKHsblwCcC5j2jDuy95EOjhkK8adfWXl7
ZFEAnRn2bi9glDh6RR3xTwYkjxnMQYqx
=YSTH
-----END PGP SIGNATURE-----
