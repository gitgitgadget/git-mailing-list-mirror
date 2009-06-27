From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 7/8] gitweb: recognize 'trivial' acks
Date: Sat, 27 Jun 2009 11:04:14 +0200
Message-ID: <cb7bb73a0906270204x6c28b8f2g79e0e9e70451cd00@mail.gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-7-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-8-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vr5x6mqt2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 11:08:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKTtB-0002jy-IJ
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 11:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbZF0JEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Jun 2009 05:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752982AbZF0JEO
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 05:04:14 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:46556 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbZF0JEN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Jun 2009 05:04:13 -0400
Received: by fxm18 with SMTP id 18so113447fxm.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 02:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bNmD86zZrUzANI10H9EoqHiTGvOSPZ1JY6MSnBf16J4=;
        b=rxJTMDD4hW3oEzizQLX1aE7Xum3UULKSej9/AAMkILWg6ParVg0lwz+krgpYxEEwEN
         a0yWqYcW1aDJS9PVPU3XS8QB9+cBw249IpsgRMLa0gJUyNFvx0Zc/XF7KqsdkICEf8fW
         wLEXDTsoc9przW7sXNv7Q+lj20swE6/KXN25U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HZrgDtHN27RWpQteHmztFDZpe+CHDya79Dv6ThPSAnpqyRmI8FrPprHjbE4ZVAAhUj
         +LTRt1mqoufZ/BB3vg3fBCvfofLYLIsaGQtGae8rEEuz3eF7gc5TWG4k4Sh4lPt6lv8v
         MgPi5a3lOKB209OwVMas/Q/uTnv4Y7vLPsrwE=
Received: by 10.204.65.1 with SMTP id g1mr4614273bki.57.1246093454284; Sat, 27 
	Jun 2009 02:04:14 -0700 (PDT)
In-Reply-To: <7vr5x6mqt2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122349>

On Sat, Jun 27, 2009 at 3:03 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> =A0 =A0 =A0 foreach my $line (@$log) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if ($line =3D~ m/^ *(signed[ \-]off[ \-]by=
[ :]|acked[ \-]by[ :]|cc[ :])/i) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ($line =3D~ m/^ *(signed[ \-]off[ \-]by=
[ :]|(?:trivially[ \-])?acked[ \-]by[ :]|cc[ :])/i) {
>
> Wouldn't it make more sense to do something like:
>
> =A0 =A0 =A0 =A0if ($line =3D~ m/^[-a-z]+: (.*)$/i && looks_like_a_nam=
e_and_email($1)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0... do the avatar thing ...
> =A0 =A0 =A0 =A0}
>
> and limit this processing only to the last run of no-blank lines?

I've been thinking about doing something like this, especially since
the next iteration this patch also adds 'Looks-fine-to-me-by' (spearce
really _loves_ customizing its signoffs lines during reviews 8-D).

The main difference between the two sections of the code is that the
original code allows whitespace instead of dashes in the signoff
lead-in, and the lead-in itself is OPTIONALLY terminated by a colon.

If we can lose this, then ^\s*[-a-z]+: followed by what looks like a
name and email can be a detector. An alternative would be to keep the
current signoff detector as-is and ADD the generic one, possibly under
the condition that we are already parsing signoffs.

The idea of accepting those lines as signoffs only at the end of the
commit log is also a good idea, but has the problem of requiring some
form of look-ahead. Two possible logics:

(1) when something that looks like a signoff is met, stash it away,
and keep collecting signoff-lookalikes and empty lines until either a
non-signoff-lookalike (in which case the previous lines are NOT
signoff) or the log end is met (in which case we print them as signoff
lines).

(2) same as before, but two or more consecutive signoff-lookalikes are
a signoff block regardless of what follows them.

Which one should I go with?


--=20
Giuseppe "Oblomov" Bilotta
