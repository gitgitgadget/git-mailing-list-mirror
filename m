From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Fri, 26 Mar 2010 19:56:01 -0400
Message-ID: <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com>
References: <20100326215600.GA10910@spearce.org> <20100326222659.GA18369@progeny.tock> 
	<20100326222950.GB10910@spearce.org> <4BAD3C6E.4090604@gmail.com> 
	<20100326230537.GC10910@spearce.org> <7v7hoyabiv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 00:56:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvJOA-0007Ql-4v
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 00:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415Ab0CZX4Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 19:56:24 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55174 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab0CZX4X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 19:56:23 -0400
Received: by gwaa18 with SMTP id a18so2949060gwa.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 16:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zUvOA+i4Dar2I+hA0ILM3UoSw7vnNSvMP/jBdmarFBk=;
        b=eeQ9VqYynfJ/LSou88Mk+ZphUWK9RhLghzw+ogbsPHQmDNy8HCSM2/FuB59AJIDt4N
         ksau6fOXMzn8//wH9BZNDvUAxx+rdIELyXQZEfXxu1WaA3doFHkSM+vsmBNZagHcwsrZ
         eYPKBqv75tvUvUv2luehhLC5c5jWNHHl4JrKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DOF8AfcGrn4UEY4dEmBWuXBZ6X57siypo+zDRfFDb7JgWDybly2rlPWrzVTy6COn7S
         QfPoOec0y01pUG2LK/hej93Od+TYbCqZ1A46US07S2ABdKBJiT2t7HJxo7lHPR5DND1Y
         lFfiEw78FA6nxtm72iwP03zFKahMobVf5qjaw=
Received: by 10.150.148.18 with HTTP; Fri, 26 Mar 2010 16:56:01 -0700 (PDT)
In-Reply-To: <7v7hoyabiv.fsf@alter.siamese.dyndns.org>
Received: by 10.150.183.11 with SMTP id g11mr2202246ybf.66.1269647781111; Fri, 
	26 Mar 2010 16:56:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143303>

On Fri, Mar 26, 2010 at 7:50 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> Scott, please fix that library on GitHub. =A0JGit's fsck has a hard
>> failure on these malformed trees, because the leading '0' mode
>> causes the tree to come up with the wrong SHA-1 hash given its
>> logical content. =A0They shouldn't be created like this.
>
> What is curious is that even though 6407180 (git-fsck-cache: be stric=
ter
> about "tree" objects, 2005-07-27) does talk about zero-padding, it ap=
pears
> that we never had a version of git that padded mode in '0' in the ent=
ire
> history of write-tree (except that "notes tree" one, but even that di=
dn't
> escape the laboratory).

It's apparently an easy mistake to make.  bup did this for a while
until I added a 'git fsck' to its automated tests :)

The problem is that everything in git works perfectly with these
invalid file modes *except* fsck, and there's rarely a need to run
fsck, so this problem can hide for a long time.

Have fun,

Avery
