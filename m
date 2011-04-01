From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 1/4] write_idx_file should use an unsigned nr_objects parameter
Date: Fri, 1 Apr 2011 13:36:09 -0500
Message-ID: <AANLkTi=ZxV5WbDhhZG1SnS9W+MMhwpf-jdoKwdAD=zWN@mail.gmail.com>
References: <1301534674-31981-1-git-send-email-dpmcgee@gmail.com>
	<7vtyehg71w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 20:36:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5jCj-0002MD-At
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 20:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291Ab1DASgM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 14:36:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36366 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab1DASgL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 14:36:11 -0400
Received: by wya21 with SMTP id 21so3199639wya.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MG82axFo8FZ2XdZdzTP1NRaF611HTkdKpwIeJw3pcKs=;
        b=mmVxK9nelBnmVXX2ysrRbMxKRD5ycr6pK3StOw3kSNVUkcezOfbtwvy39vwiSbmIDY
         vY3e7uYq9jOgdGJknHNzRoCTUM7bwBDr0SuzyZI2i8m/zH4NQYT8E4jdB6f5AAX9ktpE
         rbWfpVUidDPZ4Bp4tZFFsii61MTG8exJpI7fU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=blxjZ1LncbxYEkP6zoimWzh/iDa+HDAsUwL7g4uej11oniZbaP+RjdGBspqsuGNgp5
         oRmWsxhKDY85siPCihn0rP2qV97qaYKLSICxNESCcd4HshhDAwIuhoH5vC8WI3dptNmw
         dbAFqcI/AFse8bTp2CqYGSItLlPqRcCp2+qPU=
Received: by 10.227.173.4 with SMTP id n4mr4474314wbz.132.1301682969725; Fri,
 01 Apr 2011 11:36:09 -0700 (PDT)
Received: by 10.227.147.16 with HTTP; Fri, 1 Apr 2011 11:36:09 -0700 (PDT)
In-Reply-To: <7vtyehg71w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170602>

On Fri, Apr 1, 2011 at 1:28 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Dan McGee <dpmcgee@gmail.com> writes:
>
>> This follows the precedent set in the pack-objects code and being
>> adjusted for in index-pack and unpack-objects.
>
> Eh, why? =C2=A0The use of a fixed-width type in the existing code is =
mostly to
> make sure that the on-disk result will fit within the on-disk field. =
=C2=A0The
> variables like iteration counter "i" we use in write_idx_file() need =
to be
> at least as wide but there is no reason to forbid the compiler from u=
sing
> the natural interger type as long as it is more suiable on the platfo=
rm,
> no?

Hmm. when making this patch, I thought it was required due to the
other ones in this sequence or I was seeing compile errors. Reverting
it seems to prove otherwise, as things compile just fine...

Either way, it should at least be an unsigned parameter of at least
int length, no? The current parameter is signed, so 'unsigned' might
make sense here.

-Dan
