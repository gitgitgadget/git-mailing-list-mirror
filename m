From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH/RFC] fmt-merge-msg: add a blank line after people info
Date: Tue, 15 May 2012 19:02:23 -0700
Message-ID: <CA+55aFyX66RpUA2Xh8drGErHB7Wuni20cUAMGawLsqG6MTTohA@mail.gmail.com>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org> <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org> <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org> <20120312071121.GA17269@burratino>
 <7vipi9mfhx.fsf@alter.siamese.dyndns.org> <20120511103122.GA19573@burratino>
 <7vipg2jpzp.fsf@alter.siamese.dyndns.org> <CA+55aFyNqncpHydQJYjLu5d2y+gGLVQVV8zk=2ckZ-LLgRRNWA@mail.gmail.com>
 <7vipfyhaxc.fsf@alter.siamese.dyndns.org> <7v62bxdwgs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 16 04:02:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUTZi-0001zW-TP
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 04:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758212Ab2EPCCq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 May 2012 22:02:46 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:57806 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756993Ab2EPCCp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2012 22:02:45 -0400
Received: by wibhj8 with SMTP id hj8so3427574wib.1
        for <git@vger.kernel.org>; Tue, 15 May 2012 19:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8ACJ7VRLx1cd6ksflCQgsQZ4QubpqwjCFyfCqbB1DdY=;
        b=lKLVbeHt4rIr2NDJNsAP3zJ7rCSsPhfcxqWPdLhfSgDcDaN0JtDpMwKEuDLZDGhXC3
         WNuOcvaSjzMO4z2/AQVHvwbtquBpH5QKVZSxwN7g4R8cXMuSZKXfnctXYxXdPF8wFEjq
         yPUm7aGD6upLou0PotkPmLrl6oHPHGQfX5AVDvg7hhFTMMR/ziUJA0cN5jF2TXpSL7HL
         E8CYGf7kLF7yojam7SLymDGFJ3s/Hmgsot1fC7bPgChtrYRIgvTtFpyk74aTkPe2dGh5
         sgKv0PkEHuWrMBTo1JlbA3N9tdIt8wCmcfUZoCB4xius+X8bRayxDHUcdoGwxWqAQMkb
         BevA==
Received: by 10.180.81.234 with SMTP id d10mr3074750wiy.10.1337133764047; Tue,
 15 May 2012 19:02:44 -0700 (PDT)
Received: by 10.223.2.10 with HTTP; Tue, 15 May 2012 19:02:23 -0700 (PDT)
In-Reply-To: <7v62bxdwgs.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: -ms6XbgHWprXeU80DgLhS8pcx6s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197862>

On Tue, May 15, 2012 at 1:24 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> Now, computing this efficiently may not be trivial, as you would need=
 N^2
> reachability analysis when pulling in N commits. =A0Among 2000 recent=
 merges
> I sampled from the kernel history, 70+ pull in more than 1000 commits=
 (the
> largest one d4bbf7e77 pulls in 21k commits).

So I have to say, for my purposes, it not only might be inefficient,
but it can still be very misleading.

I actually care most about the person I personally pull from. And if
he is a submaintainer who has other submaintainers, it can be that
following the commit history doesn't show him at *all*. He might have
done just a fast-forward merge, but he's still the person *I* want to
credit.

So I'm getting the feeling that the "count authors/committers" may be
cute, but it's not necessarily all that relevant. It's the kind of
information you can see later from the git tree itself.

(Admittedly, so it the shortlog we put in the merge, so that "you can
find it later in the git tree itself" not *that* great of an argument
- the real argument for me is that it doesn't matter what you count,
you'll not necessarily get the actual piece of information I care
about..).

So I think it's somewhat interesting information, and I haven't really
disliked seeing it, but I have mostly edited it away (although I see
that some other maintainers also run modern versions of git and have
left it in place, so we do have those in the kernel).

The one merge commit of mine that has it, I edited it so that the "via
C Committer" was on the same lne as the "By A Author" information.

So I'm not entirely convinced yet. I don't *dislike* the concept, but
I could definitely do without it (or maybe have it in the commented
part of the commit message, so that you'd have to explicitly edit it
to show up).

                       Linus
